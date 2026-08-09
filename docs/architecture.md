# System Architecture

## Overview

The Fleet Transportation Data Platform follows a layered architecture
designed to separate ingestion, transformation, and analytical workloads.

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