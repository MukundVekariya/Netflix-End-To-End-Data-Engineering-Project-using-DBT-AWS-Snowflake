# Docker Support for Netflix dbt Project

This document explains how to use Docker with the Netflix dbt project.

## Prerequisites

- Docker and Docker Compose installed
- Snowflake account credentials
- Access to the Netflix dataset

## Quick Start

1. **Set up environment variables:**
   ```bash
   cp env.example .env
   # Edit .env with your Snowflake credentials
   ```

2. **Build and run the project:**
   ```bash
   # Build the Docker image
   docker-compose build
   
   # Run dbt models
   docker-compose up dbt-netflix
   
   # Run dbt tests
   docker-compose up dbt-test
   ```

## Environment Variables

Create a `.env` file in the project root with the following variables:

```bash
SNOWFLAKE_ACCOUNT=your_account_identifier
SNOWFLAKE_USER=your_username
SNOWFLAKE_PASSWORD=your_password
SNOWFLAKE_ROLE=ACCOUNTADMIN
SNOWFLAKE_DATABASE=NETFLIX_DB
SNOWFLAKE_WAREHOUSE=COMPUTE_WH
SNOWFLAKE_SCHEMA=PUBLIC
```

## Available Commands

### Using Docker Compose

```bash
# Run all models
docker-compose up dbt-netflix

# Run tests
docker-compose up dbt-test

# Run specific models
docker-compose run --rm dbt-netflix dbt run --select dim_movies

# Run with specific target
docker-compose run --rm dbt-netflix dbt run --target prod

# Generate documentation
docker-compose run --rm dbt-netflix dbt docs generate

# Serve documentation
docker-compose run --rm -p 8080:8080 dbt-netflix dbt docs serve --host 0.0.0.0
```

### Using Docker directly

```bash
# Build the image
docker build -t dbt-netflix .

# Run with environment variables
docker run --rm \
  -e SNOWFLAKE_ACCOUNT=your_account \
  -e SNOWFLAKE_USER=your_user \
  -e SNOWFLAKE_PASSWORD=your_password \
  -e SNOWFLAKE_ROLE=ACCOUNTADMIN \
  -e SNOWFLAKE_DATABASE=NETFLIX_DB \
  -e SNOWFLAKE_WAREHOUSE=COMPUTE_WH \
  -e SNOWFLAKE_SCHEMA=PUBLIC \
  dbt-netflix dbt run

# Run with mounted profiles
docker run --rm \
  -v $(pwd)/profiles.yml:/root/.dbt/profiles.yml:ro \
  dbt-netflix dbt run
```

## Development Workflow

For development, you can mount the project directory to enable live editing:

```bash
# Run with volume mount for development
docker-compose run --rm -v $(pwd)/netflix:/app/netflix dbt-netflix dbt run
```

## Project Structure

```
.
├── Dockerfile              # Docker image definition
├── docker-compose.yml      # Docker Compose configuration
├── requirements.txt        # Python dependencies
├── profiles.yml           # dbt profiles configuration
├── .dockerignore          # Files to exclude from Docker build
├── env.example            # Example environment variables
├── netflix/               # dbt project directory
│   ├── models/
│   ├── tests/
│   ├── macros/
│   ├── seeds/
│   └── dbt_project.yml
└── README-Docker.md       # This file
```

## Troubleshooting

### Common Issues

1. **Connection errors**: Verify your Snowflake credentials in the `.env` file
2. **Permission errors**: Ensure the mounted volumes have correct permissions
3. **Build failures**: Check that all required files are present and not in `.dockerignore`

### Debugging

```bash
# Run container in interactive mode
docker-compose run --rm dbt-netflix bash

# Check dbt configuration
docker-compose run --rm dbt-netflix dbt debug

# View logs
docker-compose logs dbt-netflix
```

## Security Notes

- Never commit your `.env` file with real credentials
- Use environment variables or Docker secrets for production
- Consider using Snowflake key pair authentication for better security

## Production Deployment

For production, consider:

1. Using Docker secrets for sensitive data
2. Setting up proper logging and monitoring
3. Using a CI/CD pipeline for automated deployments
4. Implementing proper backup and recovery procedures 

docker run -it --rm dbt-netflix bash 