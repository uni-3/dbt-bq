# dbt-bq

This repository contains a dbt (data build tool) project named `main`, which manages data transformations for two main domains: **Blog** and **Pokemon**.

## Project Overview

- **Blog Domain**: Processes blog-related data (content, Google Analytics, Search Console) using **BigQuery**.
- **Pokemon Domain**: Processes Pokemon species and name data using **DuckDB** and **MotherDuck**.

## Prerequisites

- Python 3.12 or higher
- [uv](https://github.com/astral-sh/uv) for dependency management
- Access to BigQuery (for the blog domain)
- Access to MotherDuck (for the pokemon domain, optional for dev)

## Project Structure

- `models/blog/`: Contains dbt models for the blog domain.
  - `sources/`: Source definitions.
  - `staging/`: Initial cleaning and transformation.
  - `intermediate/`: Complex transformations and joins.
  - `marts/`: Final business-ready tables (metrics, search query analysis).
- `models/pokemon/`: Contains dbt models for the pokemon domain.
  - `sources/`: Source definitions.
  - `marts/`: Final analysis tables (Japanese names, counts).

## Setup

1. **Install dependencies**:
   ```bash
   uv sync
   ```

2. **Install dbt packages**:
   ```bash
   uv run dbt deps
   ```

3. **Configure Profiles**:
   Ensure your `~/.dbt/profiles.yml` (or `profiles.yml` in this directory) is correctly configured with the `blog` and `pokemon` profiles. Refer to `profiles.yml` in the root for the required structure.

## Usage

### Run Models
To run all models:
```bash
uv run dbt run
```

To run a specific domain:
```bash
uv run dbt run --select models/blog
# or
uv run dbt run --select models/pokemon
```

### Test Models
```bash
uv run dbt test
```

### Generate Documentation
```bash
uv run dbt docs generate
uv run dbt docs serve
```
