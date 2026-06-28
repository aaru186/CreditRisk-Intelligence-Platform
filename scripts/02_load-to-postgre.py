import pandas as pd
from sqlalchemy import create_engine
from urllib.parse import quote_plus


# Load cleaned file
df = pd.read_csv("data/processed/loans_cleaned.csv")


password = quote_plus("Aaru@0618")

engine = create_engine(
    f"postgresql+psycopg2://postgres:{password}@localhost:5432/creditriskdb"
)

# Load into PostgreSQL
df.to_sql(
    "stg_loans",
    engine,
    if_exists="replace",
    index=False
)

print("Data loaded successfully!")