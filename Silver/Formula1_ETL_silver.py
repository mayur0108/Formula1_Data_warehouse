import pyodbc
import pandas as pd
from sqlalchemy import create_engine
import urllib
from datetime import datetime
from dateutil.parser import parse
from datetime import time
# -------------------------
# Global transformations functions
# -------------------------
def safe_parse_date(val):
    if pd.isnull(val):
        return pd.NaT
    if isinstance(val, pd.Timestamp):
        return val.date()
    try:
        return parse(val, dayfirst=False, yearfirst=False).date()
    except:
        return pd.NaT

def etl_clean(df, numeric_cols=None, float_cols=None, date_cols=None, string_cols=None, string_cols_upper=None, time_cols=None, hour_cols=None):
    numeric_cols = numeric_cols or []
    float_cols = float_cols or []
    date_cols = date_cols or []
    string_cols = string_cols or []
    string_cols_upper = string_cols_upper or []
    time_cols = time_cols or []
    hour_cols = hour_cols or []

    # Global string cleaning (before specific transformations)
    all_str_cols = df.select_dtypes(include=['object', 'string', 'category']).columns
    for col in all_str_cols:
        df[col] = df[col].astype(str).str.strip().replace({'\\N': pd.NA, '': pd.NA, 'nan': pd.NA})
        df[col] = df[col].astype("string")  # Force to pandas string dtype

    # Numeric columns to nullable Int64
    for col in numeric_cols:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors='coerce').astype('Int64')

    # Float columns to Float64
    for col in float_cols:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors='coerce').astype('Float64')
            df[col] = df[col].apply(lambda x: f"{x:.3f}" if pd.notnull(x) else None) # Round to 2 decimal places

    # Date columns using safe_parse_date
    for col in date_cols:
        if col in df.columns:
            df[col] = df[col].apply(safe_parse_date)

    # Specific string columns to lowercase and trim
    for col in string_cols:
        if col in df.columns:
            df[col] = df[col].astype(str).str.lower().str.strip().replace(r'\\N', None, regex=True)
    
    # Specific string columns to uppercase and trim
    for col in string_cols_upper:
        if col in df.columns:
            df[col] = df[col].astype(str).str.upper().str.strip().replace(r'\\N', None, regex=True)


    # Time columns to datetime
    for col in time_cols:
        if col in df.columns:
            try:
                df[col] = pd.to_datetime(df[col], format='%M:%S.%f', errors='coerce').dt.time
                
            except:
                df[col] = pd.to_datetime(df[col], errors='coerce').dt.time

    for col in hour_cols:
        if col in df.columns:
            try:
                df[col] = pd.to_datetime(df[col], format='%H:%M:%S', errors='coerce').dt.time
            except:
                df[col] = pd.to_datetime(df[col], errors='coerce').dt.time

    


    df.drop_duplicates(inplace=True)
    df['create_time'] = datetime.now()
    df = df.replace({pd.NaT: None, '<na>': None, '<NA>': None})  # Replace NaT with None for SQL compatibility
    
    print(df.isnull().sum())  
    print(df.sample(5))  # Debugging: print first 5 rows of the DataFrame

    return df

# -------------------------
# Table-specific transformations
# -------------------------
def transform_drivers(df_drivers):
    return etl_clean(
        df_drivers,
        numeric_cols=['driverId', 'number'],
        date_cols=['dob'],
        string_cols=['driverRef', 'forename', 'surname', 'nationality'],
        string_cols_upper=['code']
    )

def transform_constructors(df_constructors):
    return etl_clean(
        df_constructors,
        numeric_cols=['constructorId'],
        string_cols=['constructorRef', 'name','nationality']
    )

def transform_constructor_standings(df_constructor_standings):
    return etl_clean(
        df_constructor_standings,
        numeric_cols=['constructorStandingsId', 'raceId','constructorId', 'position','positionText','wins'],
        float_cols=['points']  
    )
    
def transform_constructor_results(df_constructor_results):
    return etl_clean(
        df_constructor_results,
        numeric_cols=['constructorResultsId','raceId','constructorId'],
        float_cols=['points'],
        string_cols=['status']
    )
#-------------------------------------------------------------------------------------------------------------------------
def transform_Constructor_standings(df_Constructors_standings):
    return etl_clean(
        df_Constructors_standings,
        numeric_cols=['constructorstandingId','raceId','position','positionText','wins'],
        float_cols=['points']  
    )

def transform_driver_standings(df_driver_standings):
    return etl_clean(
        df_driver_standings,
        numeric_cols=['driverStandingsId', 'raceId', 'driverId', 'position', 'positionText', 'wins'],
        float_cols=['points']
    )

def transform_circuits(df_circuits):
    return etl_clean(
        df_circuits,
        numeric_cols=['circuit_id', 'alt'],
        string_cols=['circuit_ref', 'name', 'location', 'country'],
        float_cols=['lat', 'lng']
    )

def transform_lap_times(df_lap_times):
    df_lap_times['lap_time_id'] = range(1, len(df_lap_times) + 1)
    df_lap_times.insert(0, 'lap_time_id', df_lap_times.pop('lap_time_id'))

    return etl_clean(
        df_lap_times,
        numeric_cols=['lap_time_id', 'raceId', 'driverId', 'lap', 'position','millisecionds'],
        time_cols=['time']
    )

def trabsform_pit_stops(df_pit_stops):  
    df_pit_stops['pitstopId'] = range(1, len(df_pit_stops) + 1)
    df_pit_stops.insert(0, 'pitstopId', df_pit_stops.pop('pitstopId'))

    return etl_clean(
        df_pit_stops,
        numeric_cols=['pitstopId', 'raceId', 'driverId', 'lap','milliseconds'],
        float_cols=['duration'],
        hour_cols=['time']
    )

def transform_qualifying(df_qualifying):
    return etl_clean(
        df_qualifying,
        numeric_cols=['qualifyId', 'raceId', 'driverId', 'constructorId', 'number', 'position'],
        time_cols=['q1', 'q2', 'q3']
    )
def transform_races(df_races):
    return etl_clean(
        df_races,
        numeric_cols=['raceId', 'year', 'round', 'circuitId'],
        string_cols=['name'],
        date_cols=['date','fp1_date','fp2_date','fp3_date','quali_date','sprint_date'],
        time_cols=['time', 'fp1_time', 'fp2_time', 'fp3_time', 'quali_time', 'sprint_time'],
    )
def transform_seasons(df_season):
    df_season = df_season.sort_values(by=['year'])
    df_season['seasonId'] = range(1, len(df_season) + 1)
    return etl_clean(
        df_season,
        numeric_cols=['seasonId'],
        date_cols=['year']
    )
def transform_status(df_status):
    return etl_clean(
        df_status,
        numeric_cols=['statusId'],
        string_cols=['status']
    )

def transform_results(df_results):
    return etl_clean(
        df_results,
        numeric_cols=['resultId', 'raceId', 'driverId', 'constructorId','number', 'grid', 'position', 'positionOrder', 'laps', 'milliseconds','statusId'],
        string_cols=['positionText','fastestLap','fastestLapSpeed','rank'], 
        float_cols=['points'],      
        time_cols=['time','fastestLapTime']
    )

def transform_sprint_results(df_sprint_results):
    return etl_clean(
        df_sprint_results,
        numeric_cols=['resultId', 'raceId', 'driverId', 'constructorId','number', 'grid', 'position', 'positionOrder', 'laps', 'milliseconds','fastestLap','statusId'],
        string_cols=['positionText'], 
        float_cols=['points'],      
        time_cols=['time','fastestLapTime']
    )


# -------------------------
# Dispatcher function to route transformations
# -------------------------
def transform_table(df, table_name):
    transformations = {
        'drivers': transform_drivers,
        'circuits': transform_circuits,
        'constructors': transform_constructors,
        'constructor_standings': transform_constructor_standings,
        'constructor_results': transform_constructor_results,
        'constructor_standings': transform_Constructor_standings,
        'driver_standings': transform_driver_standings,
        'lap_times': transform_lap_times,
        'pit_stops': trabsform_pit_stops,
        'qualifying': transform_qualifying,
        'races': transform_races,
        'seasons': transform_seasons,
        'status': transform_status,
        'results': transform_results,
        'sprint_results': transform_sprint_results
    }

    if table_name in transformations:
        return transformations[table_name](df)
    else:
        df['create_time'] = datetime.now()
        return df

# -------------------------
# Main migration function (using pyodbc for reading, sqlalchemy for writing)
# -------------------------
def migrate_bronze_to_silver(table_name):
    # Connection string for SQLAlchemy and pyodbc
    connection_str = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=localhost\\SQLEXPRESS;"
        "DATABASE=Formula1;"
        "Trusted_Connection=yes;"
    )
    sqlalchemy_params = urllib.parse.quote_plus(connection_str)

    # Read data using pyodbc
    conn = pyodbc.connect(connection_str)
    query = f"SELECT * FROM bronze.{table_name};"
    df = pd.read_sql(query, conn)
    conn.close()
    print('\n\n\n')
    print(f"✅ Read {len(df)} rows from bronze.{table_name}")

    # Apply transformation
    df = transform_table(df, table_name)
    print(f"✅ Applied transformation for {table_name}")

    # Write using SQLAlchemy
    engine = create_engine(f"mssql+pyodbc:///?odbc_connect={sqlalchemy_params}")
    df.to_sql(table_name, engine, schema='silver', if_exists='replace', index=False)
    print(f"✅ Successfully written {len(df)} rows to silver.{table_name}")

# -------------------------
# Example usage
# -------------------------
migrate_bronze_to_silver('drivers')
migrate_bronze_to_silver('constructors')
migrate_bronze_to_silver('constructor_standings')
migrate_bronze_to_silver('constructor_results')
migrate_bronze_to_silver('constructor_standings')
migrate_bronze_to_silver('driver_standings')
migrate_bronze_to_silver('circuits')
migrate_bronze_to_silver('lap_times')
migrate_bronze_to_silver('pit_stops')
migrate_bronze_to_silver('qualifying')
migrate_bronze_to_silver('races')
migrate_bronze_to_silver('seasons')
migrate_bronze_to_silver('status')
migrate_bronze_to_silver('results')
migrate_bronze_to_silver('sprint_results')

