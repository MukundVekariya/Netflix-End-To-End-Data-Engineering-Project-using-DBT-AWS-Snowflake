# Use Python 3.9 slim image as base
FROM python:3.9-slim-bookworm

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y gcc g++ && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements file (will create this next)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy dbt project files
COPY netflix/ ./netflix/

# Create .dbt directory for profiles
RUN mkdir -p ~/.dbt

# Copy default profiles.yml (will create this next)
COPY profiles.yml ~/.dbt/

# Set working directory to dbt project
WORKDIR /app/netflix

# Install dbt packages
RUN dbt deps

# Expose port (if needed for any web interface)
EXPOSE 8080

# Default command
CMD ["dbt", "run"] 