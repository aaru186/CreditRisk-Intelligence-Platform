--
-- PostgreSQL database dump
--

\restrict LqcXB7QmtBthgNU3cT7Zp1gtUMiM3hyYuZ9y5XCJtu6DWXKPlXxaxY3mBRcbdX3

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-06-28 16:59:09

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 41039)
-- Name: dim_borrower; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_borrower (
    borrower_id integer NOT NULL,
    emp_title text,
    emp_length_num numeric,
    state character varying(5),
    homeownership character varying(20),
    verified_income character varying(30),
    application_type character varying(30)
);


ALTER TABLE public.dim_borrower OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 41038)
-- Name: dim_borrower_borrower_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_borrower_borrower_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_borrower_borrower_id_seq OWNER TO postgres;

--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 222
-- Name: dim_borrower_borrower_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_borrower_borrower_id_seq OWNED BY public.dim_borrower.borrower_id;


--
-- TOC entry 221 (class 1259 OID 41029)
-- Name: dim_grade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_grade (
    grade_id integer NOT NULL,
    grade character varying(2),
    sub_grade character varying(3),
    risk_tier character varying(20)
);


ALTER TABLE public.dim_grade OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 41028)
-- Name: dim_grade_grade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_grade_grade_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_grade_grade_id_seq OWNER TO postgres;

--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 220
-- Name: dim_grade_grade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_grade_grade_id_seq OWNED BY public.dim_grade.grade_id;


--
-- TOC entry 225 (class 1259 OID 41049)
-- Name: dim_time; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_time (
    time_id integer NOT NULL,
    issue_date date,
    issue_month integer,
    issue_quarter integer,
    issue_year integer
);


ALTER TABLE public.dim_time OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 41048)
-- Name: dim_time_time_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_time_time_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_time_time_id_seq OWNER TO postgres;

--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 224
-- Name: dim_time_time_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_time_time_id_seq OWNED BY public.dim_time.time_id;


--
-- TOC entry 226 (class 1259 OID 41058)
-- Name: fact_loans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_loans (
    loan_id integer NOT NULL,
    borrower_id integer,
    grade_id integer,
    time_id integer,
    loan_amount numeric(12,2),
    term integer,
    interest_rate double precision,
    installment numeric(10,2),
    loan_purpose character varying(50),
    loan_status character varying(50),
    initial_listing_status character varying(10),
    disbursement_method character varying(20),
    annual_income numeric(15,2),
    annual_income_joint numeric(15,2),
    debt_to_income double precision,
    debt_to_income_joint double precision,
    total_credit_limit numeric(15,2),
    total_credit_utilized numeric(15,2),
    total_debit_limit numeric(15,2),
    delinq_2y integer,
    months_since_last_delinq double precision,
    earliest_credit_line integer,
    inquiries_last_12m integer,
    total_credit_lines integer,
    open_credit_lines integer,
    num_collections_last_12m integer,
    num_historical_failed_to_pay integer,
    months_since_90d_late double precision,
    current_accounts_delinq integer,
    total_collection_amount_ever numeric(15,2),
    num_accounts_120d_past_due double precision,
    num_accounts_30d_past_due integer,
    num_active_debit_accounts integer,
    num_total_cc_accounts integer,
    num_open_cc_accounts integer,
    num_cc_carrying_balance integer,
    num_mort_accounts integer,
    account_never_delinq_percent double precision,
    accounts_opened_24m integer,
    current_installment_accounts integer,
    num_satisfactory_accounts integer,
    months_since_last_credit_inquiry integer,
    tax_liens integer,
    public_record_bankrupt integer,
    balance numeric(12,2),
    paid_total numeric(12,2),
    paid_principal numeric(12,2),
    paid_interest numeric(12,2),
    paid_late_fees numeric(12,2),
    is_default boolean,
    fraud_flag boolean,
    alert_level character varying(10)
);


ALTER TABLE public.fact_loans OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 40966)
-- Name: stg_loans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stg_loans (
    loan_id bigint,
    emp_title text,
    emp_length_num double precision,
    state text,
    homeownership text,
    annual_income double precision,
    verified_income text,
    debt_to_income double precision,
    annual_income_joint double precision,
    verification_income_joint text,
    debt_to_income_joint double precision,
    delinq_2y bigint,
    months_since_last_delinq double precision,
    earliest_credit_line bigint,
    inquiries_last_12m bigint,
    total_credit_lines bigint,
    open_credit_lines bigint,
    total_credit_limit bigint,
    total_credit_utilized bigint,
    num_collections_last_12m bigint,
    num_historical_failed_to_pay bigint,
    months_since_90d_late double precision,
    current_accounts_delinq bigint,
    total_collection_amount_ever bigint,
    current_installment_accounts bigint,
    accounts_opened_24m bigint,
    months_since_last_credit_inquiry double precision,
    num_satisfactory_accounts bigint,
    num_accounts_120d_past_due double precision,
    num_accounts_30d_past_due bigint,
    num_active_debit_accounts bigint,
    total_debit_limit bigint,
    num_total_cc_accounts bigint,
    num_open_cc_accounts bigint,
    num_cc_carrying_balance bigint,
    num_mort_accounts bigint,
    account_never_delinq_percent double precision,
    tax_liens bigint,
    public_record_bankrupt bigint,
    loan_purpose text,
    application_type text,
    loan_amount bigint,
    term bigint,
    interest_rate double precision,
    installment double precision,
    grade text,
    sub_grade text,
    issue_month text,
    loan_status text,
    initial_listing_status text,
    disbursement_method text,
    balance double precision,
    paid_total double precision,
    paid_principal double precision,
    paid_interest double precision,
    paid_late_fees double precision,
    is_default bigint,
    fraud_risk_score bigint,
    fraud_flag bigint,
    risk_tier text,
    issue_date text,
    issue_year bigint,
    issue_quarter bigint,
    issue_month_num bigint,
    alert_level text,
    credit_utilization_pct double precision,
    repayment_pct double precision
);


ALTER TABLE public.stg_loans OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 41080)
-- Name: vw_default_by_risk_tier; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_default_by_risk_tier AS
 WITH base AS (
         SELECT g.risk_tier,
            g.grade,
            t.issue_year,
            f.loan_purpose,
            count(*) AS total_loans,
            sum(
                CASE
                    WHEN f.is_default THEN 1
                    ELSE 0
                END) AS total_defaults,
            sum(f.loan_amount) AS total_exposure,
            sum(
                CASE
                    WHEN f.is_default THEN f.loan_amount
                    ELSE (0)::numeric
                END) AS defaulted_exposure,
            avg(f.interest_rate) AS avg_interest_rate,
            avg(f.debt_to_income) AS avg_dti
           FROM ((public.fact_loans f
             JOIN public.dim_grade g ON ((f.grade_id = g.grade_id)))
             JOIN public.dim_time t ON ((f.time_id = t.time_id)))
          GROUP BY g.risk_tier, g.grade, t.issue_year, f.loan_purpose
        )
 SELECT risk_tier,
    grade,
    issue_year,
    loan_purpose,
    total_loans,
    total_defaults,
    total_exposure,
    defaulted_exposure,
    avg_interest_rate,
    avg_dti,
    round((((total_defaults)::numeric / (NULLIF(total_loans, 0))::numeric) * (100)::numeric), 2) AS default_rate_pct,
    round(((defaulted_exposure / NULLIF(total_exposure, (0)::numeric)) * (100)::numeric), 2) AS exposure_at_risk_pct
   FROM base;


ALTER VIEW public.vw_default_by_risk_tier OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 41090)
-- Name: vw_fraud_signals; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_fraud_signals AS
 SELECT b.state,
    b.homeownership,
    b.verified_income,
    f.loan_purpose,
    g.risk_tier,
    count(*) AS total_loans,
    sum(
        CASE
            WHEN f.fraud_flag THEN 1
            ELSE 0
        END) AS flagged_loans,
    round((((sum(
        CASE
            WHEN f.fraud_flag THEN 1
            ELSE 0
        END))::numeric / (NULLIF(count(*), 0))::numeric) * (100)::numeric), 2) AS flag_rate_pct,
    round(avg(f.loan_amount), 2) AS avg_loan_amount,
    round((avg(f.debt_to_income))::numeric, 2) AS avg_dti,
    sum(f.paid_late_fees) AS total_late_fees
   FROM ((public.fact_loans f
     JOIN public.dim_borrower b ON ((f.borrower_id = b.borrower_id)))
     JOIN public.dim_grade g ON ((f.grade_id = g.grade_id)))
  GROUP BY b.state, b.homeownership, b.verified_income, f.loan_purpose, g.risk_tier;


ALTER VIEW public.vw_fraud_signals OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 41095)
-- Name: vw_high_risk_watchlist; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_high_risk_watchlist AS
 SELECT f.loan_id,
    b.emp_title,
    b.state,
    b.homeownership,
    b.verified_income,
    g.grade,
    g.risk_tier,
    f.loan_amount,
    f.debt_to_income,
    f.interest_rate,
    f.delinq_2y,
    f.num_collections_last_12m,
    f.public_record_bankrupt,
    f.balance,
    f.paid_late_fees,
    f.loan_status,
    f.is_default,
    f.fraud_flag,
    f.alert_level
   FROM ((public.fact_loans f
     JOIN public.dim_borrower b ON ((f.borrower_id = b.borrower_id)))
     JOIN public.dim_grade g ON ((f.grade_id = g.grade_id)))
  WHERE (((g.risk_tier)::text = ANY ((ARRAY['High'::character varying, 'Very High'::character varying])::text[])) OR (f.fraud_flag = true));


ALTER VIEW public.vw_high_risk_watchlist OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 41100)
-- Name: vw_repayment_health; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_repayment_health AS
 SELECT g.grade,
    g.risk_tier,
    b.homeownership,
    f.loan_purpose,
    count(*) AS total_loans,
    round(avg(((f.paid_total / NULLIF(f.loan_amount, (0)::numeric)) * (100)::numeric)), 2) AS avg_repayment_pct,
    round(avg(f.balance), 2) AS avg_outstanding_balance,
    sum(f.paid_interest) AS total_interest_collected,
    sum(f.paid_late_fees) AS total_late_fees_collected,
    round(((sum(f.paid_late_fees) / NULLIF(sum(f.paid_total), (0)::numeric)) * (100)::numeric), 2) AS late_fee_as_pct_of_payments
   FROM ((public.fact_loans f
     JOIN public.dim_grade g ON ((f.grade_id = g.grade_id)))
     JOIN public.dim_borrower b ON ((f.borrower_id = b.borrower_id)))
  GROUP BY g.grade, g.risk_tier, b.homeownership, f.loan_purpose;


ALTER VIEW public.vw_repayment_health OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 41085)
-- Name: vw_rolling_default_trend; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_rolling_default_trend AS
 SELECT issue_year,
    issue_month,
    monthly_loans,
    monthly_defaults,
    monthly_volume,
    round(avg((((monthly_defaults)::numeric / (NULLIF(monthly_loans, 0))::numeric) * (100)::numeric)) OVER (ORDER BY issue_year, issue_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_3m_default_rate
   FROM ( SELECT t.issue_year,
            t.issue_month,
            count(*) AS monthly_loans,
            sum(
                CASE
                    WHEN f.is_default THEN 1
                    ELSE 0
                END) AS monthly_defaults,
            sum(f.loan_amount) AS monthly_volume
           FROM (public.fact_loans f
             JOIN public.dim_time t ON ((f.time_id = t.time_id)))
          GROUP BY t.issue_year, t.issue_month) monthly_agg;


ALTER VIEW public.vw_rolling_default_trend OWNER TO postgres;

--
-- TOC entry 4849 (class 2604 OID 41042)
-- Name: dim_borrower borrower_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_borrower ALTER COLUMN borrower_id SET DEFAULT nextval('public.dim_borrower_borrower_id_seq'::regclass);


--
-- TOC entry 4848 (class 2604 OID 41032)
-- Name: dim_grade grade_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_grade ALTER COLUMN grade_id SET DEFAULT nextval('public.dim_grade_grade_id_seq'::regclass);


--
-- TOC entry 4850 (class 2604 OID 41052)
-- Name: dim_time time_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_time ALTER COLUMN time_id SET DEFAULT nextval('public.dim_time_time_id_seq'::regclass);


--
-- TOC entry 4856 (class 2606 OID 41047)
-- Name: dim_borrower dim_borrower_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_borrower
    ADD CONSTRAINT dim_borrower_pkey PRIMARY KEY (borrower_id);


--
-- TOC entry 4852 (class 2606 OID 41037)
-- Name: dim_grade dim_grade_grade_sub_grade_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_grade
    ADD CONSTRAINT dim_grade_grade_sub_grade_key UNIQUE (grade, sub_grade);


--
-- TOC entry 4854 (class 2606 OID 41035)
-- Name: dim_grade dim_grade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_grade
    ADD CONSTRAINT dim_grade_pkey PRIMARY KEY (grade_id);


--
-- TOC entry 4858 (class 2606 OID 41057)
-- Name: dim_time dim_time_issue_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_time
    ADD CONSTRAINT dim_time_issue_date_key UNIQUE (issue_date);


--
-- TOC entry 4860 (class 2606 OID 41055)
-- Name: dim_time dim_time_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_time
    ADD CONSTRAINT dim_time_pkey PRIMARY KEY (time_id);


--
-- TOC entry 4862 (class 2606 OID 41063)
-- Name: fact_loans fact_loans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_loans
    ADD CONSTRAINT fact_loans_pkey PRIMARY KEY (loan_id);


--
-- TOC entry 4863 (class 2606 OID 41064)
-- Name: fact_loans fact_loans_borrower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_loans
    ADD CONSTRAINT fact_loans_borrower_id_fkey FOREIGN KEY (borrower_id) REFERENCES public.dim_borrower(borrower_id);


--
-- TOC entry 4864 (class 2606 OID 41069)
-- Name: fact_loans fact_loans_grade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_loans
    ADD CONSTRAINT fact_loans_grade_id_fkey FOREIGN KEY (grade_id) REFERENCES public.dim_grade(grade_id);


--
-- TOC entry 4865 (class 2606 OID 41074)
-- Name: fact_loans fact_loans_time_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_loans
    ADD CONSTRAINT fact_loans_time_id_fkey FOREIGN KEY (time_id) REFERENCES public.dim_time(time_id);


-- Completed on 2026-06-28 16:59:09

--
-- PostgreSQL database dump complete
--

\unrestrict LqcXB7QmtBthgNU3cT7Zp1gtUMiM3hyYuZ9y5XCJtu6DWXKPlXxaxY3mBRcbdX3

