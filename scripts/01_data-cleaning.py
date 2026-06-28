import pandas as pd
import numpy as np
 
# ── LOAD ──────────────────────────────────────────────────────────────────────
df = pd.read_csv(
    "data/raw data/loans_full_schema.csv",
    low_memory=False
)
 
print("Raw shape:", df.shape)
print("\nloan_status value counts:")
print(df['loan_status'].value_counts())
print("\ndtypes:")
print(df.dtypes)
 
# ── 1. RENAME surrogate key col ───────────────────────────────────────────────
# The dataset's first column is an index — rename it to loan_id
df = df.rename(columns={'Unnamed: 0': 'loan_id'})
 
# ── 2. DROP rows missing critical fields ──────────────────────────────────────
df = df.dropna(subset=[
    'loan_status', 'annual_income', 'grade',
    'debt_to_income', 'interest_rate', 'loan_amount'
])
 
# ── 3. DEFAULT FLAG ───────────────────────────────────────────────────────────
# 'Charged Off', 'Late (31-120 days)' are clear defaults
# 'Late (16-30 days)' and 'In Grace Period' are early warning signals — included
default_statuses = ['Charged Off', 'Late (31-120 days)', 'Late (16-30 days)', 'In Grace Period']
df['is_default'] = df['loan_status'].isin(default_statuses).astype(int)
 
# ── 4. FRAUD FLAG (multi-signal composite) ────────────────────────────────────
# Signal: high loan + high DTI + recent delinquency + unverified income
df['fraud_risk_score'] = (
    (df['loan_amount'] > 20000).astype(int)
    + (df['debt_to_income'] > 30).astype(int)
    + (df['delinq_2y'] > 0).astype(int)
    + (df['verified_income'] == 'Not Verified').astype(int)
    + (df['public_record_bankrupt'] > 0).astype(int)
)

df['fraud_flag'] = (
    df['fraud_risk_score'] >= 3
).astype(int)
 
# ── 5. RISK TIER from grade ───────────────────────────────────────────────────
risk_map = {
    'A': 'Low',      'B': 'Low',
    'C': 'Medium',   'D': 'Medium',
    'E': 'High',     'F': 'Very High', 'G': 'Very High'
}
df['risk_tier'] = df['grade'].map(risk_map)
 
# ── 6. PARSE issue_month (format: "Mar-2018") ─────────────────────────────────
df['issue_date']      = pd.to_datetime(df['issue_month'], format='%b-%Y')
df['issue_year']      = df['issue_date'].dt.year
df['issue_quarter']   = df['issue_date'].dt.quarter
df['issue_month_num'] = df['issue_date'].dt.month
 
# ── 7. emp_length is already numeric (0–10) ───────────────────────────────────
# No mapping needed — rename for clarity
df = df.rename(columns={'emp_length': 'emp_length_num'})
 
# ── 8. ALERT LEVEL (for watchlist) ───────────────────────────────────────────
def alert_level(row):
    if row['fraud_flag'] == 1 and row['is_default'] == 1:
        return 'CRITICAL'
    elif row['fraud_flag'] == 1 or row['is_default'] == 1:
        return 'HIGH'
    else:
        return 'MONITOR'
 
df['alert_level'] = df.apply(alert_level, axis=1)
 
#── 9. CREDIT UTILIZATION (%) ────────────────────────────────────────────────
df['credit_utilization_pct'] = np.where(
    df['total_credit_limit'] > 0,
    (df['total_credit_utilized'] /
     df['total_credit_limit']) * 100,
    0
)

#── 10. REPAYMENT PERCENTAGE (%) ───────────────────────────────────────────────
df['repayment_pct'] = np.where(
    df['loan_amount'] > 0,
    (df['paid_total'] /
     df['loan_amount']) * 100,
    0
)

# ── 11. EXPORT ─────────────────────────────────────────────────────────────────
df.to_csv(
    'data/processed/loans_cleaned.csv',
    index=False
)
 
print("\n── DONE ──────────────────────────────────────────")
print("Clean shape:", df.shape)
print("Defaults:", df['is_default'].sum())
print("Fraud flags:", df['fraud_flag'].sum())
print("Alert levels:\n", df['alert_level'].value_counts())