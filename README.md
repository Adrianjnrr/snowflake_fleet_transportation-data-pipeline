# Fleet Transportation Data Platform

## Project Overview

This project is an end-to-end data engineering platform designed to ingest,
transform, validate, and serve fleet transportation data for analytics.

The platform integrates data from multiple sources, including PostgreSQL,
CSV files, Azure Storage, and a weather API.

The data is ingested using Python-based ingestion pipelines and orchestrated
with Apache Airflow before being transformed in Snowflake using dbt.

The final curated data is consumed through Tableau dashboards for
fleet operations analysis.

## Architecture

```text
PostgreSQL
CSV Files
Azure Storage
Weather API
      │
      ▼
Python Ingestion
      │
      ▼
Apache Airflow
      │
      ▼
Snowflake
      │
      ├── RAW
      │
      ├── STAGING
      │
      ├── INTERMEDIATE
      │
      └── MARTS
             │
             ▼
          Tableau