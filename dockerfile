# Use an official Python runtime as a parent image
FROM python:3.8-slim-buster

# Set environment variables
ENV AIRFLOW_HOME=/opt/airflow
ENV AIRFLOW_VERSION=2.9.1
ENV PYTHON_VERSION=3.8
ENV CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc \
        libc-dev \
        libffi-dev \
        libssl-dev \
        make \
        wget \
        vim \
        curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Airflow using the constraints to avoid dependency conflicts
RUN pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

# Install additional packages required for your environment
RUN pip install pandas polars pyarrow duckdb requests dremio-simple-query

# Set the working directory to the Airflow home directory
WORKDIR $AIRFLOW_HOME

# Expose ports (8080 for webserver)
EXPOSE 8080

RUN echo "Hello World 4"

# Copy the script into the container at /opt/airflow
COPY ./init/ /opt/airflow/init/

# Make sure the script is executable
RUN chmod +x /opt/airflow/init/schedulerinit.bash

# Make sure the script is executable
RUN chmod +x /opt/airflow/init/webserverinit.bash