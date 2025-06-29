.PHONY: help build run test clean docs deps debug shell

# Default target
help:
	@echo "Available commands:"
	@echo "  build    - Build Docker image"
	@echo "  run      - Run dbt models"
	@echo "  test     - Run dbt tests"
	@echo "  clean    - Clean dbt artifacts"
	@echo "  docs     - Generate and serve dbt docs"
	@echo "  deps     - Install dbt dependencies"
	@echo "  debug    - Run dbt debug"
	@echo "  shell    - Open shell in container"

# Build Docker image
build:
	docker-compose build

# Run dbt models
run:
	docker-compose up dbt-netflix

# Run dbt tests
test:
	docker-compose up dbt-test

# Clean dbt artifacts
clean:
	docker-compose run --rm dbt-netflix dbt clean

# Generate and serve dbt docs
docs:
	docker-compose run --rm -p 8080:8080 dbt-netflix sh -c "dbt docs generate && dbt docs serve --host 0.0.0.0"

# Install dbt dependencies
deps:
	docker-compose run --rm dbt-netflix dbt deps

# Run dbt debug
debug:
	docker-compose run --rm dbt-netflix dbt debug

# Open shell in container
shell:
	docker-compose run --rm dbt-netflix bash

# Run specific model
run-model:
	@if [ -z "$(MODEL)" ]; then \
		echo "Usage: make run-model MODEL=model_name"; \
		exit 1; \
	fi
	docker-compose run --rm dbt-netflix dbt run --select $(MODEL)

# Run with specific target
run-target:
	@if [ -z "$(TARGET)" ]; then \
		echo "Usage: make run-target TARGET=prod"; \
		exit 1; \
	fi
	docker-compose run --rm dbt-netflix dbt run --target $(TARGET)

# Full pipeline (deps, run, test)
pipeline: deps run test

# Development mode with volume mount
dev:
	docker-compose run --rm -v $(PWD)/netflix:/app/netflix dbt-netflix bash 