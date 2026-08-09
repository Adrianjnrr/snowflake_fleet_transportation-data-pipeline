# Engineering Decisions

## Snowflake

Snowflake was selected as the analytical data warehouse because it provides
a scalable cloud-based environment for storing and querying analytical
data.

## dbt

dbt is used to manage SQL transformations and organize the warehouse into
clear transformation layers.

This also provides a structured approach to testing and documenting data
models.

## Apache Airflow

Apache Airflow is used to orchestrate ingestion workflows and provide a
centralized way to manage pipeline execution.

## Layered Warehouse Architecture

The warehouse is separated into RAW, STAGING, INTERMEDIATE, and MARTS
layers.

This separation improves maintainability and makes the transformation
process easier to understand and debug.

## Incremental Loading

Incremental loading was implemented to avoid unnecessarily reprocessing
data that has already been loaded.

## Metadata Tracking

Metadata tracking was implemented to improve traceability and support
pipeline debugging.

## Processed File Tracking

Processed-file tracking helps identify which files have already been
processed and reduces the risk of duplicate ingestion.

## Data Quality

dbt tests are used to validate data quality and ensure that important
assumptions about the data remain valid.

## Future Improvements

Potential future improvements include:

- Integrating dbt execution into the Airflow DAG
- Adding pipeline alerts
- Expanding monitoring and observability
- Implementing CI/CD
- Improving automated data quality reporting