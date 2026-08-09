# Source Systems

The Fleet Transportation Data Platform integrates data from four primary
sources.

## 1. PostgreSQL

PostgreSQL is used as a structured operational data source.

Data is extracted from PostgreSQL using Python ingestion scripts and loaded
into Snowflake.

## 2. CSV Files

CSV files provide transportation and operational datasets that are ingested
through Python-based ingestion scripts.

These files contain operational information used throughout the analytical
pipeline.

## 3. Azure Storage

Azure Storage is used as an additional data source for fleet-related data.

The ingestion layer retrieves the required data and loads it into the
Snowflake platform.

## 4. Weather API

Weather data is retrieved from an external weather API.

The API data is ingested using Python and incorporated into the warehouse
alongside transportation data.

## Source Flow

```text
PostgreSQL ──────┐
CSV Files ───────┤
Azure Storage ───┼──► Python Ingestion ──► Snowflake
Weather API ─────┘