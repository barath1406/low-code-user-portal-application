# Serverless Lambda Function

This directory contains the AWS Lambda function code responsible for processing user data CSV files uploaded to an S3 bucket and inserting the data into an RDS MySQL database.

## Overview

- The Lambda function is triggered by S3 events when a CSV file is uploaded to the `data-sets/` path in the configured S3 bucket.
- It retrieves database credentials securely from AWS Secrets Manager.
- Connects to an Amazon RDS MySQL database using the `pymysql` library.
- Executes the SQL schema defined in `db.sql` to create the `user_portal` database and the `users` table if they do not already exist.
- Inserts user data from the uploaded CSV file into the `users` table.
- The schema includes a default admin user with predefined credentials.

## Environment Variables

The Lambda function expects the following environment variables to be set:

- `DB_HOST`: The hostname of the RDS MySQL instance.
- `DB_USER`: The username to connect to the database.
- `SECRET_NAME`: The name of the AWS Secrets Manager secret containing the database password.
- `AWS_REGION`: The AWS region where the Secrets Manager and S3 bucket are located (default: `us-east-1`).
- `S3_BUCKET`: The name of the S3 bucket where CSV files are uploaded.

## Files

- `import.py`: The main Lambda function code that handles the S3 event, downloads the CSV file, executes the schema, and inserts data.
- `db.sql`: SQL schema file to create the `user_portal` database and `users` table.
- `pymysql/`: A bundled version of the `pymysql` library used for MySQL database connectivity.

## How It Works

1. When a CSV file is uploaded to the `data-sets/` folder in the configured S3 bucket, the Lambda function is triggered.
2. The function downloads the CSV file to a temporary location.
3. It retrieves the database password from AWS Secrets Manager.
4. Connects to the RDS MySQL database.
5. Executes the schema SQL to ensure the database and table exist.
6. Reads the CSV file and inserts each user record into the `users` table.
7. Logs progress and errors for monitoring.

This setup enables automated ingestion of user data into the database via S3 uploads, leveraging serverless architecture for scalability and ease of management.
