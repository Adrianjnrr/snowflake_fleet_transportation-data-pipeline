# Fleet Transportation Data Platform

## Project Overview

This project is an end-to-end data engineering platform built to ingest,
transform, validate, and serve fleet transportation data for analytics.

The platform integrates data from multiple sources, including PostgreSQL,
CSV files, Azure Storage, and a weather API.

Python is used for data ingestion, Apache Airflow is used for orchestration,
Snowflake is used as the data warehouse, and dbt is used for data
transformation and testing.

The final curated data is consumed through Tableau for fleet operations
analysis.

---

## Architecture

```text
                    DATA SOURCES
                         │
        ┌────────────────┼────────────────┐
        │                │                │
   PostgreSQL        CSV Files      Azure Storage
        │                │                │
        └────────────────┼────────────────┘
                         │
                    Weather API
                         │
                         ▼
                 PYTHON INGESTION
                         │
                         ▼
                APACHE AIRFLOW
                 ORCHESTRATION
                         │
                         ▼
                    SNOWFLAKE
                         │
              ┌──────────┴──────────┐
              │                     │
             RAW                METADATA
              │
              ▼
          STAGING
              │
              ▼
        INTERMEDIATE
              │
              ▼
            MARTS
              │
              ▼
           TABLEAU



## Data Sources

The platform integrates data from four primary sources:

PostgreSQL — structured operational fleet data
CSV Files — fleet and transportation operational data
Azure Storage — additional fleet-related data
Weather API — external weather data used to enrich fleet analysis


Data Ingestion

Python-based ingestion pipelines are used to extract data from the different
source systems and load it into Snowflake.

The ingestion layer is organized into separate modules:
ingestion/
├── api/
├── csv/
├── postgres/
└── utils/
The ingestion layer supports multiple source types while keeping the
source-specific ingestion logic separated and modular.

Airflow Orchestration

Apache Airflow is used to orchestrate the ingestion workflows.

The main DAG is:
fleet_pipeline

The DAG coordinates ingestion tasks for PostgreSQL, CSV sources, and the
weather API.

Each ingestion task receives a pipeline run ID and task name to support
pipeline traceability and debugging.

The general ingestion flow is:
PostgreSQL
     │
     ├── Customers
     ├── Facilities
     ├── Routes
     └── Loads
     │
     ▼
CSV Files
     │
     ├── Drivers
     ├── Trucks
     ├── Trailers
     ├── Trips
     ├── Delivery Events
     ├── Fuel Purchases
     ├── Maintenance Records
     ├── Safety Incidents
     └── Driver Monthly Metrics
     │
     ▼
Weather API
     │
     ▼
Snowflake

Snowflake Data Warehouse

Snowflake is used as the centralized data warehouse.

The warehouse follows a layered architecture:
RAW
  ↓
STAGING
  ↓
INTERMEDIATE
  ↓
MARTS

RAW

The Raw layer contains data loaded from the source systems with minimal
transformation.

STAGING

The Staging layer applies initial cleaning, standardization, and
source-specific transformations.

INTERMEDIATE

The Intermediate layer contains transformation logic used to prepare data
for the final analytical models.

MARTS

The Marts layer contains curated analytical models designed for reporting
and business analysis.

dbt Transformation & Testing

dbt is used to manage SQL transformations within Snowflake.

The dbt project follows the layered warehouse architecture:
STAGING
   ↓
INTERMEDIATE
   ↓
MARTS

Staging and Intermediate models are materialized as views, while the Marts
layer contains curated analytical tables.

The dbt project also includes automated data quality tests.

The project structure includes:

fleet_transformations/
├── models/
│   ├── staging/
│   ├── intermediate/
│   └── marts/
├── tests/
├── macros/
├── seeds/
└── snapshots/

Incremental Loading & Metadata

The platform uses incremental loading to avoid unnecessarily reprocessing
data that has already been ingested.

Metadata tracking is used to provide visibility into pipeline execution and
support traceability and debugging.

A processed-file tracking mechanism is also used to identify files that have
already been processed.

These mechanisms support:

Incremental ingestion
Duplicate processing prevention
Pipeline traceability
Debugging
Data lineage
Operational visibility

Data Quality

Data quality is handled through dbt tests.

The tests validate important assumptions about the transformed data and help
identify invalid or inconsistent records.

The dbt tests are also executed automatically through the CI pipeline.

Continuous Integration

GitHub Actions is used to automatically validate the data platform on every
push to the main branch and on pull requests.

The CI pipeline validates the three main components of the platform.

Python Ingestion
Installs the project's Python dependencies
Compiles the ingestion modules to detect Python syntax errors

Airflow
Installs Apache Airflow
Validates the Airflow DAG for Python syntax errors
dbt
Installs dbt Core and the Snowflake adapter
Creates a temporary Snowflake profile using GitHub Secrets
Runs dbt parse to validate the dbt project
Runs dbt test to validate data quality

Git Push / Pull Request
          │
          ▼
    GitHub Actions
          │
    ┌─────┼─────┐
    ▼     ▼     ▼
 Python Airflow dbt
   CI      CI    CI
    │     │     │
    ▼     ▼     ▼
 Compile  DAG   Parse
 Python  Check  + Tests
    │     │     │
    └─────┼─────┘
          ▼
       CI PASS


       Tableau Analytics

The curated data from the Snowflake Marts layer is consumed through Tableau
for fleet transportation analytics.

The dashboard provides an overview of fleet operations, including metrics
such as:

Total trips
Total distance
Fuel consumption
Average MPG
Trips by month
On-time performance
Trips by origin state
Trailer distribution
Monthly fleet performance

Additional analytical views are being developed for driver and customer
performance analysis.

| Layer           | Technology                                  |
| --------------- | ------------------------------------------- |
| Programming     | Python                                      |
| Source Systems  | PostgreSQL, CSV, Azure Storage, Weather API |
| Orchestration   | Apache Airflow                              |
| Data Warehouse  | Snowflake                                   |
| Transformation  | dbt                                         |
| Data Quality    | dbt Tests                                   |
| CI              | GitHub Actions                              |
| Analytics       | Tableau                                     |
| Version Control | Git / GitHub                                |



snowflake-data-platform/
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── dags/
│   └── fleet_pipeline.py
│
├── docs/
│   ├── architecture.md
│   ├── data_dictionary.md
│   ├── decisions.md
│   ├── pipeline_design.md
│   └── source_systems.md
│
├── ingestion/
│   ├── api/
│   ├── csv/
│   ├── postgres/
│   └── utils/
│
├── fleet_transformations/
│   ├── models/
│   │   ├── staging/
│   │   ├── intermediate/
│   │   └── marts/
│   ├── tests/
│   ├── macros/
│   ├── seeds/
│   ├── snapshots/
│   └── dbt_project.yml
│
├── README.md
└── requirements.txt


