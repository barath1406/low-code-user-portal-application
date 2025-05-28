# User Management Portal

This is a minimal web application written using Python Flask, demonstrating a micro-service running in a containerized environment. The application provides user management functionality including login, user dashboard, and admin user management features.

## Overview

The User Management Portal allows users to log in, view a list of users, and for administrators to add or delete users. The application securely fetches database credentials from AWS Secrets Manager and connects to a MySQL database to manage user data.

## How to run locally

```bash
cd app
pip install -r requirements.txt
python app.py
```

## How to build and push Docker images

To containerize the application and push the Docker image to a container registry, use the following commands:

```bash
cd ../../app
docker build --platform linux/amd64 -t user-portal:0.0.1 .
docker build --platform linux/amd64 -t barath1406/user-portal:0.0.1 .
docker push barath1406/user-portal:0.0.1
```

## File Descriptions

- **Dockerfile**: Defines the container image build process. It uses a lightweight Python 3.7 Alpine base image, copies the application code and dependencies, installs required Python packages, exposes port 5000, and sets the container to run the Flask app (`app.py`).

- **app.py**: The main Flask application file. It defines routes for user login, logout, user dashboard, admin user management, and error handlers for common HTTP errors. It uses functions from `db.py` to interact with the database.

- **config.py**: Contains application configuration settings. It includes logic to securely fetch database credentials from AWS Secrets Manager using the `boto3` library.

- **db.py**: Handles database connections and operations. It connects to a MySQL database using credentials from `config.py` and provides functions to list users, verify credentials, add users, and delete users.

- **requirements.txt**: Lists the Python dependencies required by the application.

- **static/**: Directory containing static assets such as CSS, JavaScript, and image files used by the web application.

- **templates/**: Directory containing HTML template files used by Flask to render the web pages.

- **README.md**: This documentation file.

## Application Endpoints

- `/users` - Displays a list of users from the database (accessible after login).
- `/admin` - Allows the admin user to add or manage users.
- `/logout` - Logs out the current user.
- `/login` - Handles user login.

## Testing

For Administrator access, use the credentials `admin:admin` after running the `db.sql` file located in the `schema` folder.