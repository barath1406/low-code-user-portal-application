import json
import os
import csv
import urllib.parse

import boto3
import pymysql

# Environment variables for RDS connection
RDS_HOST = os.environ.get('DB_HOST')
RDS_USER = os.environ.get('DB_USER')
SECRET_NAME = os.environ.get('SECRET_NAME')
REGION_NAME = os.environ.get('AWS_REGION', 'us-east-1')

# Environment variable for the S3 bucket name
S3_BUCKET = os.environ.get('S3_BUCKET')

# Local paths used by the Lambda function
SCHEMA_FILE_PATH = './db.sql'
DATASET_FILE_PATH = '/tmp/test.csv'

def get_secret():
    """Retrieve the RDS password from AWS Secrets Manager."""
    print("Starting get_secret function")
    session = boto3.session.Session()
    client = session.client(service_name='secretsmanager', region_name=REGION_NAME)

    try:
        print(f"Attempting to retrieve secret: {SECRET_NAME} in region: {REGION_NAME}")
        get_secret_value_response = client.get_secret_value(SecretId=SECRET_NAME)
        secret = get_secret_value_response['SecretString']
        secret_dict = json.loads(secret)
        print("Secret retrieved successfully")
        return secret_dict['password']
    except Exception as e:
        print(f"Error retrieving secret: {e}")
        raise

def execute_schema(cursor):
    """Read and execute SQL statements from the schema file to create DB structure."""
    print(f"Starting execute_schema function using file: {SCHEMA_FILE_PATH}")
    try:
        with open(SCHEMA_FILE_PATH, 'r') as f:
            schema_sql = f.read()
            print(f"Schema file loaded, size: {len(schema_sql)} characters")

        statements = schema_sql.split(';')
        print(f"Found {len(statements)} SQL statements to execute")

        for idx, statement in enumerate(statements):
            stmt = statement.strip()
            if stmt:
                print(f"Executing SQL statement {idx + 1}/{len(statements)}")
                # For statements that might return results like SHOW TABLES
                cursor.execute(stmt)
                if stmt.upper().startswith('SHOW'):
                    result = cursor.fetchall()
                    print(f"Query result: {result}")
        print("Schema executed successfully")
    except Exception as e:
        print(f"Error executing schema: {e}")
        raise

def download_file_from_s3(bucket, key):
    """Download a file from S3 and save it to the /tmp directory inside Lambda."""
    print(f"Starting download_file_from_s3 function. Bucket: {bucket}, Key: {key}")
    s3 = boto3.client('s3')
    try:
        s3.download_file(bucket, key, DATASET_FILE_PATH)
        print(f"Downloaded {key} from bucket {bucket} to {DATASET_FILE_PATH}")
        
        if os.path.exists(DATASET_FILE_PATH):
            file_size = os.path.getsize(DATASET_FILE_PATH)
            print(f"File downloaded successfully. Size: {file_size} bytes")
        else:
            print(f"Warning: File not found at {DATASET_FILE_PATH} after download")
    except Exception as e:
        print(f"Error downloading file from S3: {e}")
        raise

def insert_data(cursor):
    """Read data from the CSV file and insert it into the user_portal.users table using ON DUPLICATE KEY UPDATE."""
    print(f"Starting insert_data function using file: {DATASET_FILE_PATH}")
    
    # Track statistics for reporting
    stats = {
        'total': 0,
        'processed': 0,
        'errors': 0
    }
    
    try:
        with open(DATASET_FILE_PATH, 'r') as csvfile:
            reader = csv.DictReader(csvfile)
            rows = list(reader)
            print(f"CSV file loaded, found {len(rows)} rows to process")
            stats['total'] = len(rows)

            for idx, row in enumerate(rows):
                username = row.get('Username', '')
                print(f"Processing row {idx + 1}/{len(rows)}: Username={username}")
                
                try:
                    # Using MySQL's ON DUPLICATE KEY UPDATE syntax
                    # This automatically handles both insert and update in one query
                    cursor.execute(
                        """
                        INSERT INTO user_portal.users
                        (title, firstname, lastname, status, username, password, age)
                        VALUES (%s, %s, %s, %s, %s, %s, %s)
                        ON DUPLICATE KEY UPDATE
                        title = VALUES(title),
                        firstname = VALUES(firstname),
                        lastname = VALUES(lastname),
                        status = VALUES(status),
                        password = VALUES(password),
                        age = VALUES(age)
                        """,
                        (
                            row.get('Title', ''),
                            row.get('First Name', ''),
                            row.get('Last Name', ''),
                            int(row.get('Status', 0)),
                            username,
                            row.get('Password', ''),
                            int(row.get('Age', 0))
                        )
                    )
                    stats['processed'] += 1
                        
                except Exception as e:
                    print(f"Error processing row for username {username}: {e}")
                    stats['errors'] += 1
                    
        print(f"Data processing complete. Stats: {json.dumps(stats)}")
        return stats
    except Exception as e:
        print(f"Error inserting data: {e}")
        raise

def lambda_handler(event, context):
    """Main Lambda function handler triggered by S3 file upload events."""
    print("Lambda function started")
    print(f"Received event: {json.dumps(event)}")

    # Extract bucket and object key from S3 event
    try:
        s3_event = event['Records'][0]['s3']
        bucket = s3_event['bucket']['name']
        key = urllib.parse.unquote_plus(s3_event['object']['key'])

        print(f"Triggered by file upload: s3://{bucket}/{key}")

        # Ignore non-CSV files
        if not key.lower().endswith('.csv'):
            print(f"Ignoring non-CSV file: {key}")
            return {'statusCode': 200, 'body': json.dumps('Ignored non-CSV file.')}

        # Ensure file is in the expected prefix
        if not key.startswith('data-sets/'):
            print(f"File not in expected path: {key}")
            return {'statusCode': 200, 'body': json.dumps('File not in expected path, ignoring.')}

    except Exception as e:
        print(f"Error parsing S3 event: {e}")
        return {'statusCode': 400, 'body': json.dumps('Error parsing S3 event.')}

    print(f"Environment variables: RDS_HOST={RDS_HOST}, RDS_USER={RDS_USER}, SECRET_NAME={SECRET_NAME}")

    try:
        print("Retrieving DB credentials from Secrets Manager")
        password = get_secret()

        print("Connecting to the RDS database")
        connection = pymysql.connect(
            host=RDS_HOST,
            user=RDS_USER,
            password=password,
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor,
            autocommit=True
        )
        print("Database connection established")

        try:
            print("Downloading file from S3")
            download_file_from_s3(bucket, key)

            print("Opening database cursor for schema and data insertion")
            with connection.cursor() as cursor:
                print("Executing schema setup")
                execute_schema(cursor)

                print("Inserting/updating CSV data in the database")
                stats = insert_data(cursor)

            print("Lambda function completed successfully")
            return {
                'statusCode': 200, 
                'body': json.dumps({
                    'message': 'Schema created and data processed successfully.',
                    'stats': stats,
                    'file_processed': key
                })
            }

        except Exception as e:
            print(f"Error during DB operations: {e}")
            return {'statusCode': 500, 'body': json.dumps(f"Error: {str(e)}")}

        finally:
            print("Closing DB connection")
            connection.close()

    except Exception as e:
        print(f"Fatal error in Lambda function: {e}")
        return {'statusCode': 500, 'body': json.dumps(f"Fatal error: {str(e)}")}