# Formula1_Data_warehouse

# 🏁 Formula 1 Data Warehouse Project

This project implements a star-schema-based **data warehouse** for analyzing Formula 1 race and sprint results. It features structured ETL pipelines, a layered architecture (Bronze → Silver → Gold), and optimized SQL views for efficient analytics.




---

## 🏗️ Layered Architecture

### 🥉 Bronze Layer
- **Raw data** collected from [Kaggle](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020/data).
- Data loading strategies:
  - Batch processing
  - Full load
  - Truncate and insert

---

### ⚙️ Silver Layer (ETL & Transformations)

Intermediate, cleansed data used to build the final star schema.

**ETL Process**:
- **ODBC**: To import raw data into Python (VS Code).
- **Pandas / NumPy**: For data cleansing, feature engineering, enrichment, and normalization.
- **SQLAlchemy**: To write transformed datasets into SQL Server (`silver` schema).

---

### 🥇 Gold Layer (Star Schema)

Ready-for-analysis views based on fact-dimension modeling.

**Key Views**:
- `fact_race_results` – Traditional race metrics
- `fact_sprint_results` – Sprint race metrics
- Dimension tables:
  - `dim_drivers`
  - `dim_constructors`
  - `dim_circuits`
  - `dim_races`

**Transformations**:
- Joins, aggregations, derived fields
- Business logic for analytics

---

## 🧩 Star Schema Diagrams

- ✅ [Race Results Schema]
- ✅ [Sprint Results Schema]

---
## 🧰 Technologies Used

| Tool             | Purpose                        |
| ---------------- | ------------------------------ |
| Kaggle           | Data source                    |
| ODBC             | Data extraction to Python      |
| Pandas, NumPy    | Data wrangling and enrichment  |
| SQLAlchemy       | Load transformed data to SQL   |
| SQL Server       | Star schema modeling & queries |
| Power BI, Looker | Data visualization             |


## 📊 Visualization

- Supports integration with:
  - **Power BI**
  - **Looker Studio**

Example dashboard: Points by Driver, Race Performance by Country, Sprint vs Race Stats

🧾 License
Licensed under the MIT License.

