# Pipeline Design

## Overview

The ingestion layer is responsible for extracting data from multiple
sources and loading it into Snowflake.

Python is used for the individual ingestion processes, while Apache Airflow
is used to orchestrate the pipeline.

## Ingestion Components

The ingestion code is organized into separate modules:

```text
ingestion/
├── api/
├── csv/
├── postgres/
└── utils/