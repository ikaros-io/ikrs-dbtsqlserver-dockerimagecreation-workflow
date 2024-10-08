# Use the base image
FROM python:3.8.1-slim-buster

# Set environment variables
ENV ACCEPT_EULA=Y

# Install required packages
RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
    git make ca-certificates libpq-dev libicu-dev pkg-config \
    gcc build-essential curl gnupg unixodbc-dev && \
    apt-get update && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    apt-get install -y msodbcsql18 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install dbt-sqlserver
RUN pip install dbt-sqlserver

# Set the entrypoint to bash
ENTRYPOINT ["/bin/bash"] 
