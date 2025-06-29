# Netflix dbt Project

This repository contains a dbt (data build tool) project for analyzing Netflix data. It is fully containerized with Docker for easy setup, development, and deployment.

---

## 📊 Data Pipeline Architecture

![Netflix Data Pipeline Architecture](./pipeline-architecture.jpg)

**Explanation:**
- **Extract:** Netflix data is exported as CSV files.
- **Load:**
  - The CSV files are uploaded to AWS S3 (cloud storage).
  - From S3, the data is loaded into Snowflake (cloud data warehouse).
- **Transform:**
  - In Snowflake, the data is organized into staging and development schemas.
  - dbt (data build tool) is used for:
    1. **Data Transformation:** Cleans, joins, and models the raw data into analytics-ready tables.
    2. **Testing:** Ensures data quality and correctness.
    3. **Orchestration:** Manages dependencies and execution order of transformations.
- **Visualize:**
  - The transformed data is then available for BI tools like Tableau and Power BI for reporting and analytics.

---

## 🚀 Project Overview
- **dbt**: Analytics engineering framework for transforming data in your warehouse
- **Warehouse**: Snowflake (configurable)
- **Dockerized**: Run anywhere, no local Python setup required

---

## 📦 Project Structure
```
.
├── Dockerfile              # Docker image definition
├── docker-compose.yml      # Docker Compose configuration
├── requirements.txt        # Python dependencies
├── profiles.yml            # dbt profiles configuration (Snowflake)
├── .dockerignore           # Files to exclude from Docker build
├── env.example             # Example environment variables
├── netflix/                # dbt project directory
│   ├── models/
│   ├── tests/
│   ├── macros/
│   ├── seeds/
│   └── dbt_project.yml
└── README.md               # This file
```

---

## 🏁 Quick Start

### 1. Clone the repository
```sh
git clone <repo-url>
cd Netflix-proj-1
```

### 2. Set up environment variables
```sh
cp env.example .env
# Edit .env with your Snowflake credentials
```

### 3. Build and run with Docker Compose
```sh
docker-compose build
docker-compose up dbt-netflix
```

### 4. Run dbt commands
- Run all models: `docker-compose up dbt-netflix`
- Run tests: `docker-compose up dbt-test`
- Run specific model: `docker-compose run --rm dbt-netflix dbt run --select <model_name>`
- Open shell: `docker-compose run --rm dbt-netflix bash`

---

## ⚙️ Configuration
- **Snowflake credentials**: Set in your `.env` file
- **dbt profiles**: Configured in `profiles.yml` (uses environment variables for secrets)
- **dbt packages**: Managed in `netflix/packages.yml` (e.g., dbt-utils)

---

## 🐳 Docker Usage
- All dbt commands can be run inside the container
- For development, mount your project directory for live editing
- See `README-Docker.md` for advanced Docker usage

---

## 🧪 Testing
Run dbt tests:
```sh
docker-compose up dbt-test
```

---

## 📝 Documentation
- [dbt Documentation](https://docs.getdbt.com/)
- [Snowflake Setup](https://docs.snowflake.com/en/)
- See `README-Docker.md` for more Docker tips

---

## 🛡️ Security
- **Never commit real credentials** in `.env` or `profiles.yml`
- Use environment variables or Docker secrets for production

---

## 🤝 Contributing
Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

---
