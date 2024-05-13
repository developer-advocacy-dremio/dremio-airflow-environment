#!/bin/bash

# Apply database migrations
airflow db migrate

# Create the default user if not already created
airflow users create --username admin --password password --firstname Admin --lastname User --role Admin --email example@example.com

# Start the webserver
airflow webserver