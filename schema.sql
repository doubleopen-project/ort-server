--
-- PostgreSQL database dump
--

\restrict mbBaDeHXbbhM7BbteO02fV2n2JEXH7qcIlfTyy0i6Uu483dAHFK2GAKZEqgRGfE

-- Dumped from database version 17.6 (Debian 17.6-1.pgdg13+1)
-- Dumped by pg_dump version 17.6 (Ubuntu 17.6-1.pgdg24.04+1)

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
-- Name: ort_server; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA ort_server;


ALTER SCHEMA ort_server OWNER TO postgres;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA ort_server;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: advisor_configuration_options; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.advisor_configuration_options (
    id bigint NOT NULL,
    advisor text NOT NULL,
    option text NOT NULL,
    value text NOT NULL
);


ALTER TABLE ort_server.advisor_configuration_options OWNER TO postgres;

--
-- Name: advisor_configuration_options_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.advisor_configuration_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.advisor_configuration_options_id_seq OWNER TO postgres;

--
-- Name: advisor_configuration_options_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.advisor_configuration_options_id_seq OWNED BY ort_server.advisor_configuration_options.id;


--
-- Name: advisor_configuration_secrets; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.advisor_configuration_secrets (
    id bigint NOT NULL,
    advisor text NOT NULL,
    secret text NOT NULL,
    value text NOT NULL
);


ALTER TABLE ort_server.advisor_configuration_secrets OWNER TO postgres;

--
-- Name: advisor_configuration_secrets_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.advisor_configuration_secrets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.advisor_configuration_secrets_id_seq OWNER TO postgres;

--
-- Name: advisor_configuration_secrets_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.advisor_configuration_secrets_id_seq OWNED BY ort_server.advisor_configuration_secrets.id;


--
-- Name: advisor_configurations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.advisor_configurations (
    id bigint NOT NULL,
    advisor_run_id bigint NOT NULL
);


ALTER TABLE ort_server.advisor_configurations OWNER TO postgres;

--
-- Name: advisor_configurations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.advisor_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.advisor_configurations_id_seq OWNER TO postgres;

--
-- Name: advisor_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.advisor_configurations_id_seq OWNED BY ort_server.advisor_configurations.id;


--
-- Name: advisor_configurations_options; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.advisor_configurations_options (
    advisor_configuration_id bigint NOT NULL,
    advisor_configuration_option_id bigint NOT NULL
);


ALTER TABLE ort_server.advisor_configurations_options OWNER TO postgres;

--
-- Name: advisor_configurations_secrets; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.advisor_configurations_secrets (
    advisor_configuration_id bigint NOT NULL,
    advisor_configuration_secret_id bigint NOT NULL
);


ALTER TABLE ort_server.advisor_configurations_secrets OWNER TO postgres;

--
-- Name: advisor_jobs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.advisor_jobs (
    id bigint NOT NULL,
    ort_run_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    configuration jsonb NOT NULL,
    status text NOT NULL,
    error_message text
);


ALTER TABLE ort_server.advisor_jobs OWNER TO postgres;

--
-- Name: advisor_jobs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.advisor_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.advisor_jobs_id_seq OWNER TO postgres;

--
-- Name: advisor_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.advisor_jobs_id_seq OWNED BY ort_server.advisor_jobs.id;


--
-- Name: advisor_results; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.advisor_results (
    id bigint NOT NULL,
    advisor_run_identifier_id bigint NOT NULL,
    advisor_name text NOT NULL,
    capabilities text NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL
);


ALTER TABLE ort_server.advisor_results OWNER TO postgres;

--
-- Name: advisor_results_defects; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.advisor_results_defects (
    advisor_result_id bigint NOT NULL,
    defect_id bigint NOT NULL
);


ALTER TABLE ort_server.advisor_results_defects OWNER TO postgres;

--
-- Name: advisor_results_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.advisor_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.advisor_results_id_seq OWNER TO postgres;

--
-- Name: advisor_results_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.advisor_results_id_seq OWNED BY ort_server.advisor_results.id;


--
-- Name: advisor_results_vulnerabilities; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.advisor_results_vulnerabilities (
    advisor_result_id bigint NOT NULL,
    vulnerability_id bigint NOT NULL
);


ALTER TABLE ort_server.advisor_results_vulnerabilities OWNER TO postgres;

--
-- Name: advisor_runs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.advisor_runs (
    id bigint NOT NULL,
    advisor_job_id bigint NOT NULL,
    environment_id bigint NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL
);


ALTER TABLE ort_server.advisor_runs OWNER TO postgres;

--
-- Name: advisor_runs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.advisor_runs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.advisor_runs_id_seq OWNER TO postgres;

--
-- Name: advisor_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.advisor_runs_id_seq OWNED BY ort_server.advisor_runs.id;


--
-- Name: advisor_runs_identifiers; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.advisor_runs_identifiers (
    id bigint NOT NULL,
    advisor_run_id bigint NOT NULL,
    identifier_id bigint NOT NULL
);


ALTER TABLE ort_server.advisor_runs_identifiers OWNER TO postgres;

--
-- Name: advisor_runs_identifiers_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.advisor_runs_identifiers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.advisor_runs_identifiers_id_seq OWNER TO postgres;

--
-- Name: advisor_runs_identifiers_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.advisor_runs_identifiers_id_seq OWNED BY ort_server.advisor_runs_identifiers.id;


--
-- Name: analyzer_configurations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.analyzer_configurations (
    id bigint NOT NULL,
    analyzer_run_id bigint NOT NULL,
    allow_dynamic_versions boolean NOT NULL,
    enabled_package_managers text,
    disabled_package_managers text,
    skip_excluded boolean DEFAULT false NOT NULL
);


ALTER TABLE ort_server.analyzer_configurations OWNER TO postgres;

--
-- Name: analyzer_configurations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.analyzer_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.analyzer_configurations_id_seq OWNER TO postgres;

--
-- Name: analyzer_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.analyzer_configurations_id_seq OWNED BY ort_server.analyzer_configurations.id;


--
-- Name: analyzer_configurations_package_manager_configurations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.analyzer_configurations_package_manager_configurations (
    analyzer_configuration_id bigint NOT NULL,
    package_manager_configuration_id bigint NOT NULL
);


ALTER TABLE ort_server.analyzer_configurations_package_manager_configurations OWNER TO postgres;

--
-- Name: analyzer_jobs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.analyzer_jobs (
    id bigint NOT NULL,
    ort_run_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    configuration jsonb NOT NULL,
    status text NOT NULL,
    error_message text
);


ALTER TABLE ort_server.analyzer_jobs OWNER TO postgres;

--
-- Name: analyzer_jobs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.analyzer_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.analyzer_jobs_id_seq OWNER TO postgres;

--
-- Name: analyzer_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.analyzer_jobs_id_seq OWNED BY ort_server.analyzer_jobs.id;


--
-- Name: analyzer_runs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.analyzer_runs (
    id bigint NOT NULL,
    analyzer_job_id bigint NOT NULL,
    environment_id bigint NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    dependency_graphs jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE ort_server.analyzer_runs OWNER TO postgres;

--
-- Name: analyzer_runs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.analyzer_runs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.analyzer_runs_id_seq OWNER TO postgres;

--
-- Name: analyzer_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.analyzer_runs_id_seq OWNED BY ort_server.analyzer_runs.id;


--
-- Name: authors; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.authors (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE ort_server.authors OWNER TO postgres;

--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.authors_id_seq OWNER TO postgres;

--
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.authors_id_seq OWNED BY ort_server.authors.id;


--
-- Name: config_table; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.config_table (
    key text NOT NULL,
    value text NOT NULL,
    is_enabled boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE ort_server.config_table OWNER TO postgres;

--
-- Name: content_management_sections; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.content_management_sections (
    id text NOT NULL,
    is_enabled boolean DEFAULT false NOT NULL,
    markdown text NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ort_server.content_management_sections OWNER TO postgres;

--
-- Name: copyright_findings; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.copyright_findings (
    id bigint NOT NULL,
    statement text NOT NULL,
    path text NOT NULL,
    start_line integer NOT NULL,
    end_line integer NOT NULL,
    scan_summary_id bigint NOT NULL
);


ALTER TABLE ort_server.copyright_findings OWNER TO postgres;

--
-- Name: copyright_findings_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.copyright_findings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.copyright_findings_id_seq OWNER TO postgres;

--
-- Name: copyright_findings_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.copyright_findings_id_seq OWNED BY ort_server.copyright_findings.id;


--
-- Name: declared_license_mappings; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.declared_license_mappings (
    id bigint NOT NULL,
    license text NOT NULL,
    spdx_license text NOT NULL
);


ALTER TABLE ort_server.declared_license_mappings OWNER TO postgres;

--
-- Name: declared_license_mappings_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.declared_license_mappings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.declared_license_mappings_id_seq OWNER TO postgres;

--
-- Name: declared_license_mappings_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.declared_license_mappings_id_seq OWNED BY ort_server.declared_license_mappings.id;


--
-- Name: declared_licenses; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.declared_licenses (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE ort_server.declared_licenses OWNER TO postgres;

--
-- Name: declared_licenses_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.declared_licenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.declared_licenses_id_seq OWNER TO postgres;

--
-- Name: declared_licenses_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.declared_licenses_id_seq OWNED BY ort_server.declared_licenses.id;


--
-- Name: defect_labels; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.defect_labels (
    id bigint NOT NULL,
    defect_id bigint NOT NULL,
    key text NOT NULL,
    value text NOT NULL
);


ALTER TABLE ort_server.defect_labels OWNER TO postgres;

--
-- Name: defect_labels_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.defect_labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.defect_labels_id_seq OWNER TO postgres;

--
-- Name: defect_labels_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.defect_labels_id_seq OWNED BY ort_server.defect_labels.id;


--
-- Name: defects; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.defects (
    id bigint NOT NULL,
    external_id text NOT NULL,
    url text NOT NULL,
    title text,
    state text,
    severity text,
    description text,
    creation_time timestamp without time zone,
    modification_time timestamp without time zone,
    closing_time timestamp without time zone,
    fix_release_version text,
    fix_release_url text
);


ALTER TABLE ort_server.defects OWNER TO postgres;

--
-- Name: defects_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.defects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.defects_id_seq OWNER TO postgres;

--
-- Name: defects_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.defects_id_seq OWNED BY ort_server.defects.id;


--
-- Name: detected_license_mappings; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.detected_license_mappings (
    id bigint NOT NULL,
    license text NOT NULL,
    spdx_license text NOT NULL
);


ALTER TABLE ort_server.detected_license_mappings OWNER TO postgres;

--
-- Name: detected_license_mappings_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.detected_license_mappings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.detected_license_mappings_id_seq OWNER TO postgres;

--
-- Name: detected_license_mappings_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.detected_license_mappings_id_seq OWNED BY ort_server.detected_license_mappings.id;


--
-- Name: environments; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.environments (
    id bigint NOT NULL,
    ort_version text NOT NULL,
    java_version text NOT NULL,
    os text NOT NULL,
    processors integer NOT NULL,
    max_memory bigint NOT NULL
);


ALTER TABLE ort_server.environments OWNER TO postgres;

--
-- Name: environments_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.environments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.environments_id_seq OWNER TO postgres;

--
-- Name: environments_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.environments_id_seq OWNED BY ort_server.environments.id;


--
-- Name: environments_variables; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.environments_variables (
    environment_id bigint NOT NULL,
    variable_id bigint NOT NULL
);


ALTER TABLE ort_server.environments_variables OWNER TO postgres;

--
-- Name: evaluator_jobs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.evaluator_jobs (
    id bigint NOT NULL,
    ort_run_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    configuration jsonb NOT NULL,
    status text NOT NULL,
    error_message text
);


ALTER TABLE ort_server.evaluator_jobs OWNER TO postgres;

--
-- Name: evaluator_jobs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.evaluator_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.evaluator_jobs_id_seq OWNER TO postgres;

--
-- Name: evaluator_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.evaluator_jobs_id_seq OWNED BY ort_server.evaluator_jobs.id;


--
-- Name: evaluator_runs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.evaluator_runs (
    id bigint NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    evaluator_job_id bigint NOT NULL
);


ALTER TABLE ort_server.evaluator_runs OWNER TO postgres;

--
-- Name: evaluator_runs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.evaluator_runs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.evaluator_runs_id_seq OWNER TO postgres;

--
-- Name: evaluator_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.evaluator_runs_id_seq OWNED BY ort_server.evaluator_runs.id;


--
-- Name: evaluator_runs_rule_violations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.evaluator_runs_rule_violations (
    evaluator_run_id bigint NOT NULL,
    rule_violation_id bigint NOT NULL
);


ALTER TABLE ort_server.evaluator_runs_rule_violations OWNER TO postgres;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE ort_server.flyway_schema_history OWNER TO postgres;

--
-- Name: identifiers; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.identifiers (
    id bigint NOT NULL,
    type text NOT NULL,
    namespace text NOT NULL,
    name text NOT NULL,
    version text NOT NULL
);


ALTER TABLE ort_server.identifiers OWNER TO postgres;

--
-- Name: identifiers_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.identifiers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.identifiers_id_seq OWNER TO postgres;

--
-- Name: identifiers_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.identifiers_id_seq OWNED BY ort_server.identifiers.id;


--
-- Name: identifiers_issues; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.identifiers_issues (
    id bigint NOT NULL,
    identifier_id bigint NOT NULL,
    issue_id bigint NOT NULL
);


ALTER TABLE ort_server.identifiers_issues OWNER TO postgres;

--
-- Name: identifiers_issues_hashes; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.identifiers_issues_hashes (
    identifier_id bigint NOT NULL,
    issue_hash text NOT NULL
);


ALTER TABLE ort_server.identifiers_issues_hashes OWNER TO postgres;

--
-- Name: identifiers_ort_issues_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.identifiers_ort_issues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.identifiers_ort_issues_id_seq OWNER TO postgres;

--
-- Name: identifiers_ort_issues_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.identifiers_ort_issues_id_seq OWNED BY ort_server.identifiers_issues.id;


--
-- Name: infrastructure_service_declarations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.infrastructure_service_declarations (
    id bigint NOT NULL,
    name text NOT NULL,
    url text NOT NULL,
    description text,
    credentials_type text,
    username_secret text NOT NULL,
    password_secret text NOT NULL
);


ALTER TABLE ort_server.infrastructure_service_declarations OWNER TO postgres;

--
-- Name: infrastructure_service_declarations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.infrastructure_service_declarations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.infrastructure_service_declarations_id_seq OWNER TO postgres;

--
-- Name: infrastructure_service_declarations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.infrastructure_service_declarations_id_seq OWNED BY ort_server.infrastructure_service_declarations.id;


--
-- Name: infrastructure_service_declarations_ort_runs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.infrastructure_service_declarations_ort_runs (
    infrastructure_service_declaration_id bigint NOT NULL,
    ort_run_id bigint NOT NULL
);


ALTER TABLE ort_server.infrastructure_service_declarations_ort_runs OWNER TO postgres;

--
-- Name: infrastructure_services; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.infrastructure_services (
    id bigint NOT NULL,
    name text NOT NULL,
    url text NOT NULL,
    description text,
    username_secret_id bigint NOT NULL,
    password_secret_id bigint NOT NULL,
    organization_id bigint,
    product_id bigint,
    credentials_type text,
    repository_id bigint,
    CONSTRAINT infrastructure_services_references_check CHECK ((((((organization_id IS NOT NULL))::integer + ((product_id IS NOT NULL))::integer) + ((repository_id IS NOT NULL))::integer) <= 1))
);


ALTER TABLE ort_server.infrastructure_services OWNER TO postgres;

--
-- Name: infrastructure_services_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.infrastructure_services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.infrastructure_services_id_seq OWNER TO postgres;

--
-- Name: infrastructure_services_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.infrastructure_services_id_seq OWNED BY ort_server.infrastructure_services.id;


--
-- Name: issue_resolutions; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.issue_resolutions (
    id bigint NOT NULL,
    message text NOT NULL,
    reason text NOT NULL,
    comment text NOT NULL
);


ALTER TABLE ort_server.issue_resolutions OWNER TO postgres;

--
-- Name: issue_resolutions_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.issue_resolutions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.issue_resolutions_id_seq OWNER TO postgres;

--
-- Name: issue_resolutions_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.issue_resolutions_id_seq OWNED BY ort_server.issue_resolutions.id;


--
-- Name: issues; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.issues (
    id bigint NOT NULL,
    source text NOT NULL,
    message text NOT NULL,
    severity text NOT NULL,
    affected_path text
);


ALTER TABLE ort_server.issues OWNER TO postgres;

--
-- Name: labels; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.labels (
    id bigint NOT NULL,
    key text NOT NULL,
    value text NOT NULL
);


ALTER TABLE ort_server.labels OWNER TO postgres;

--
-- Name: labels_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.labels_id_seq OWNER TO postgres;

--
-- Name: labels_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.labels_id_seq OWNED BY ort_server.labels.id;


--
-- Name: license_finding_curations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.license_finding_curations (
    id bigint NOT NULL,
    path text NOT NULL,
    start_lines text,
    line_count integer,
    detected_license text,
    concluded_license text NOT NULL,
    reason text NOT NULL,
    comment text NOT NULL
);


ALTER TABLE ort_server.license_finding_curations OWNER TO postgres;

--
-- Name: license_finding_curations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.license_finding_curations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.license_finding_curations_id_seq OWNER TO postgres;

--
-- Name: license_finding_curations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.license_finding_curations_id_seq OWNED BY ort_server.license_finding_curations.id;


--
-- Name: license_findings; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.license_findings (
    id bigint NOT NULL,
    license text NOT NULL,
    path text NOT NULL,
    start_line integer NOT NULL,
    end_line integer NOT NULL,
    score real,
    scan_summary_id bigint NOT NULL
);


ALTER TABLE ort_server.license_findings OWNER TO postgres;

--
-- Name: license_findings_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.license_findings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.license_findings_id_seq OWNER TO postgres;

--
-- Name: license_findings_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.license_findings_id_seq OWNED BY ort_server.license_findings.id;


--
-- Name: mapped_declared_licenses; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.mapped_declared_licenses (
    id bigint NOT NULL,
    declared_license text NOT NULL,
    mapped_license text NOT NULL
);


ALTER TABLE ort_server.mapped_declared_licenses OWNER TO postgres;

--
-- Name: mapped_declared_licenses_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.mapped_declared_licenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.mapped_declared_licenses_id_seq OWNER TO postgres;

--
-- Name: mapped_declared_licenses_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.mapped_declared_licenses_id_seq OWNED BY ort_server.mapped_declared_licenses.id;


--
-- Name: nested_provenance_sub_repositories; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.nested_provenance_sub_repositories (
    id bigint NOT NULL,
    nested_provenance_id bigint NOT NULL,
    vcs_id bigint NOT NULL,
    resolved_revision text NOT NULL,
    path text NOT NULL
);


ALTER TABLE ort_server.nested_provenance_sub_repositories OWNER TO postgres;

--
-- Name: nested_provenance_sub_repositories_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.nested_provenance_sub_repositories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.nested_provenance_sub_repositories_id_seq OWNER TO postgres;

--
-- Name: nested_provenance_sub_repositories_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.nested_provenance_sub_repositories_id_seq OWNED BY ort_server.nested_provenance_sub_repositories.id;


--
-- Name: nested_provenances; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.nested_provenances (
    id bigint NOT NULL,
    root_vcs_id bigint NOT NULL,
    root_resolved_revision text NOT NULL,
    has_only_fixed_revisions boolean NOT NULL,
    vcs_plugin_configs text
);


ALTER TABLE ort_server.nested_provenances OWNER TO postgres;

--
-- Name: nested_provenances_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.nested_provenances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.nested_provenances_id_seq OWNER TO postgres;

--
-- Name: nested_provenances_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.nested_provenances_id_seq OWNED BY ort_server.nested_provenances.id;


--
-- Name: nested_repositories; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.nested_repositories (
    id bigint NOT NULL,
    ort_run_id bigint NOT NULL,
    vcs_id bigint NOT NULL,
    path text NOT NULL
);


ALTER TABLE ort_server.nested_repositories OWNER TO postgres;

--
-- Name: nested_repositories_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.nested_repositories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.nested_repositories_id_seq OWNER TO postgres;

--
-- Name: nested_repositories_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.nested_repositories_id_seq OWNED BY ort_server.nested_repositories.id;


--
-- Name: notifier_jobs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.notifier_jobs (
    id bigint NOT NULL,
    ort_run_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    configuration jsonb NOT NULL,
    status text NOT NULL,
    error_message text
);


ALTER TABLE ort_server.notifier_jobs OWNER TO postgres;

--
-- Name: notifier_jobs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.notifier_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.notifier_jobs_id_seq OWNER TO postgres;

--
-- Name: notifier_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.notifier_jobs_id_seq OWNED BY ort_server.notifier_jobs.id;


--
-- Name: notifier_runs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.notifier_runs (
    id bigint NOT NULL,
    notifier_job_id bigint NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL
);


ALTER TABLE ort_server.notifier_runs OWNER TO postgres;

--
-- Name: notifier_runs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.notifier_runs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.notifier_runs_id_seq OWNER TO postgres;

--
-- Name: notifier_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.notifier_runs_id_seq OWNED BY ort_server.notifier_runs.id;


--
-- Name: organizations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.organizations (
    id bigint NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE ort_server.organizations OWNER TO postgres;

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.organizations_id_seq OWNER TO postgres;

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.organizations_id_seq OWNED BY ort_server.organizations.id;


--
-- Name: ort_issues_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.ort_issues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.ort_issues_id_seq OWNER TO postgres;

--
-- Name: ort_issues_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.ort_issues_id_seq OWNED BY ort_server.issues.id;


--
-- Name: ort_runs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.ort_runs (
    id bigint NOT NULL,
    index integer NOT NULL,
    repository_id bigint NOT NULL,
    revision text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    job_configs jsonb NOT NULL,
    status text NOT NULL,
    vcs_id bigint,
    vcs_processed_id bigint,
    resolved_job_configs jsonb,
    job_config_context text,
    resolved_job_config_context text,
    finished_at timestamp without time zone,
    path text,
    trace_id text,
    environment_config_path text,
    resolved_revision text,
    user_id character varying(40)
);


ALTER TABLE ort_server.ort_runs OWNER TO postgres;

--
-- Name: ort_runs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.ort_runs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.ort_runs_id_seq OWNER TO postgres;

--
-- Name: ort_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.ort_runs_id_seq OWNED BY ort_server.ort_runs.id;


--
-- Name: ort_runs_issues; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.ort_runs_issues (
    id bigint NOT NULL,
    ort_run_id bigint NOT NULL,
    issue_id bigint NOT NULL,
    identifier_id bigint,
    worker text,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE ort_server.ort_runs_issues OWNER TO postgres;

--
-- Name: ort_runs_issues2_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.ort_runs_issues2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.ort_runs_issues2_id_seq OWNER TO postgres;

--
-- Name: ort_runs_issues2_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.ort_runs_issues2_id_seq OWNED BY ort_server.ort_runs_issues.id;


--
-- Name: ort_runs_labels; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.ort_runs_labels (
    ort_run_id bigint NOT NULL,
    label_id bigint NOT NULL
);


ALTER TABLE ort_server.ort_runs_labels OWNER TO postgres;

--
-- Name: package_configurations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.package_configurations (
    id bigint NOT NULL,
    identifier_id bigint NOT NULL,
    vcs_matcher_id bigint,
    source_artifact_url text
);


ALTER TABLE ort_server.package_configurations OWNER TO postgres;

--
-- Name: package_configurations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.package_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.package_configurations_id_seq OWNER TO postgres;

--
-- Name: package_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.package_configurations_id_seq OWNED BY ort_server.package_configurations.id;


--
-- Name: package_configurations_license_finding_curations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.package_configurations_license_finding_curations (
    package_configuration_id bigint NOT NULL,
    license_finding_curation_id bigint NOT NULL
);


ALTER TABLE ort_server.package_configurations_license_finding_curations OWNER TO postgres;

--
-- Name: package_configurations_path_excludes; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.package_configurations_path_excludes (
    package_configuration_id bigint NOT NULL,
    path_exclude_id bigint NOT NULL
);


ALTER TABLE ort_server.package_configurations_path_excludes OWNER TO postgres;

--
-- Name: package_curation_data; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.package_curation_data (
    id bigint NOT NULL,
    binary_artifact_id bigint,
    source_artifact_id bigint,
    vcs_info_curation_data_id bigint,
    comment text,
    purl text,
    cpe text,
    concluded_license text,
    description text,
    homepage_url text,
    is_metadata_only boolean,
    is_modified boolean,
    has_authors boolean DEFAULT true NOT NULL
);


ALTER TABLE ort_server.package_curation_data OWNER TO postgres;

--
-- Name: package_curation_data_authors; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.package_curation_data_authors (
    author_id bigint NOT NULL,
    package_curation_data_id bigint NOT NULL
);


ALTER TABLE ort_server.package_curation_data_authors OWNER TO postgres;

--
-- Name: package_curation_data_declared_license_mappings; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.package_curation_data_declared_license_mappings (
    package_curation_data_id bigint NOT NULL,
    declared_license_mapping_id bigint NOT NULL
);


ALTER TABLE ort_server.package_curation_data_declared_license_mappings OWNER TO postgres;

--
-- Name: package_curation_data_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.package_curation_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.package_curation_data_id_seq OWNER TO postgres;

--
-- Name: package_curation_data_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.package_curation_data_id_seq OWNED BY ort_server.package_curation_data.id;


--
-- Name: package_curation_provider_configs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.package_curation_provider_configs (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE ort_server.package_curation_provider_configs OWNER TO postgres;

--
-- Name: package_curation_provider_configs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.package_curation_provider_configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.package_curation_provider_configs_id_seq OWNER TO postgres;

--
-- Name: package_curation_provider_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.package_curation_provider_configs_id_seq OWNED BY ort_server.package_curation_provider_configs.id;


--
-- Name: package_curations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.package_curations (
    id bigint NOT NULL,
    identifier_id bigint NOT NULL,
    package_curation_data_id bigint NOT NULL
);


ALTER TABLE ort_server.package_curations OWNER TO postgres;

--
-- Name: package_curations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.package_curations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.package_curations_id_seq OWNER TO postgres;

--
-- Name: package_curations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.package_curations_id_seq OWNED BY ort_server.package_curations.id;


--
-- Name: package_license_choices; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.package_license_choices (
    id bigint NOT NULL,
    identifier_id bigint NOT NULL
);


ALTER TABLE ort_server.package_license_choices OWNER TO postgres;

--
-- Name: package_license_choices_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.package_license_choices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.package_license_choices_id_seq OWNER TO postgres;

--
-- Name: package_license_choices_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.package_license_choices_id_seq OWNED BY ort_server.package_license_choices.id;


--
-- Name: package_license_choices_spdx_license_choices; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.package_license_choices_spdx_license_choices (
    package_license_choice_id bigint NOT NULL,
    spdx_license_choice_id bigint NOT NULL
);


ALTER TABLE ort_server.package_license_choices_spdx_license_choices OWNER TO postgres;

--
-- Name: package_manager_configuration_options; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.package_manager_configuration_options (
    id bigint NOT NULL,
    package_manager_configuration_id bigint NOT NULL,
    name text NOT NULL,
    value text NOT NULL
);


ALTER TABLE ort_server.package_manager_configuration_options OWNER TO postgres;

--
-- Name: package_manager_configuration_options_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.package_manager_configuration_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.package_manager_configuration_options_id_seq OWNER TO postgres;

--
-- Name: package_manager_configuration_options_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.package_manager_configuration_options_id_seq OWNED BY ort_server.package_manager_configuration_options.id;


--
-- Name: package_manager_configurations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.package_manager_configurations (
    id bigint NOT NULL,
    name text NOT NULL,
    must_run_after text,
    has_options boolean DEFAULT true NOT NULL
);


ALTER TABLE ort_server.package_manager_configurations OWNER TO postgres;

--
-- Name: package_manager_configurations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.package_manager_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.package_manager_configurations_id_seq OWNER TO postgres;

--
-- Name: package_manager_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.package_manager_configurations_id_seq OWNED BY ort_server.package_manager_configurations.id;


--
-- Name: package_provenances; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.package_provenances (
    id bigint NOT NULL,
    identifier_id bigint NOT NULL,
    artifact_id bigint,
    vcs_id bigint,
    is_fixed_revision boolean,
    resolved_revision text,
    cloned_revision text,
    error_message text,
    nested_provenance_id bigint
);


ALTER TABLE ort_server.package_provenances OWNER TO postgres;

--
-- Name: package_provenances_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.package_provenances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.package_provenances_id_seq OWNER TO postgres;

--
-- Name: package_provenances_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.package_provenances_id_seq OWNED BY ort_server.package_provenances.id;


--
-- Name: packages; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.packages (
    id bigint NOT NULL,
    identifier_id bigint NOT NULL,
    vcs_id bigint NOT NULL,
    vcs_processed_id bigint NOT NULL,
    binary_artifact_id bigint NOT NULL,
    source_artifact_id bigint NOT NULL,
    purl text NOT NULL,
    cpe text,
    description text NOT NULL,
    homepage_url text NOT NULL,
    is_metadata_only boolean DEFAULT false NOT NULL,
    is_modified boolean DEFAULT false NOT NULL
);


ALTER TABLE ort_server.packages OWNER TO postgres;

--
-- Name: packages_analyzer_runs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.packages_analyzer_runs (
    package_id bigint NOT NULL,
    analyzer_run_id bigint NOT NULL
);


ALTER TABLE ort_server.packages_analyzer_runs OWNER TO postgres;

--
-- Name: packages_authors; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.packages_authors (
    author_id bigint NOT NULL,
    package_id bigint NOT NULL
);


ALTER TABLE ort_server.packages_authors OWNER TO postgres;

--
-- Name: packages_declared_licenses; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.packages_declared_licenses (
    package_id bigint NOT NULL,
    declared_license_id bigint NOT NULL
);


ALTER TABLE ort_server.packages_declared_licenses OWNER TO postgres;

--
-- Name: packages_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.packages_id_seq OWNER TO postgres;

--
-- Name: packages_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.packages_id_seq OWNED BY ort_server.packages.id;


--
-- Name: path_excludes; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.path_excludes (
    id bigint NOT NULL,
    pattern text NOT NULL,
    reason text NOT NULL,
    comment text NOT NULL
);


ALTER TABLE ort_server.path_excludes OWNER TO postgres;

--
-- Name: path_excludes_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.path_excludes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.path_excludes_id_seq OWNER TO postgres;

--
-- Name: path_excludes_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.path_excludes_id_seq OWNED BY ort_server.path_excludes.id;


--
-- Name: path_includes; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.path_includes (
    id bigint NOT NULL,
    pattern text NOT NULL,
    reason text NOT NULL,
    comment text NOT NULL
);


ALTER TABLE ort_server.path_includes OWNER TO postgres;

--
-- Name: path_includes_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.path_includes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.path_includes_id_seq OWNER TO postgres;

--
-- Name: path_includes_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.path_includes_id_seq OWNED BY ort_server.path_includes.id;


--
-- Name: plugin_events; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.plugin_events (
    plugin_type text NOT NULL,
    plugin_id text NOT NULL,
    version bigint NOT NULL,
    payload jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by text NOT NULL
);


ALTER TABLE ort_server.plugin_events OWNER TO postgres;

--
-- Name: plugin_template_events; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.plugin_template_events (
    name text NOT NULL,
    plugin_type text NOT NULL,
    plugin_id text NOT NULL,
    version bigint NOT NULL,
    payload jsonb NOT NULL,
    created_by text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE ort_server.plugin_template_events OWNER TO postgres;

--
-- Name: plugin_template_organization_assignments; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.plugin_template_organization_assignments (
    plugin_type text NOT NULL,
    plugin_id text NOT NULL,
    organization_id bigint NOT NULL,
    template_name text NOT NULL
);


ALTER TABLE ort_server.plugin_template_organization_assignments OWNER TO postgres;

--
-- Name: plugin_templates_read_model; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.plugin_templates_read_model (
    name text NOT NULL,
    plugin_type text NOT NULL,
    plugin_id text NOT NULL,
    options jsonb NOT NULL,
    is_global boolean DEFAULT false NOT NULL,
    organization_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL
);


ALTER TABLE ort_server.plugin_templates_read_model OWNER TO postgres;

--
-- Name: plugins_read_model; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.plugins_read_model (
    plugin_type text NOT NULL,
    plugin_id text NOT NULL,
    enabled boolean NOT NULL
);


ALTER TABLE ort_server.plugins_read_model OWNER TO postgres;

--
-- Name: processed_declared_licenses; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.processed_declared_licenses (
    id bigint NOT NULL,
    package_id bigint,
    project_id bigint,
    spdx_expression text
);


ALTER TABLE ort_server.processed_declared_licenses OWNER TO postgres;

--
-- Name: processed_declared_licenses_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.processed_declared_licenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.processed_declared_licenses_id_seq OWNER TO postgres;

--
-- Name: processed_declared_licenses_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.processed_declared_licenses_id_seq OWNED BY ort_server.processed_declared_licenses.id;


--
-- Name: processed_declared_licenses_mapped_declared_licenses; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.processed_declared_licenses_mapped_declared_licenses (
    processed_declared_license_id bigint NOT NULL,
    mapped_declared_license_id bigint NOT NULL
);


ALTER TABLE ort_server.processed_declared_licenses_mapped_declared_licenses OWNER TO postgres;

--
-- Name: processed_declared_licenses_unmapped_declared_licenses; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.processed_declared_licenses_unmapped_declared_licenses (
    processed_declared_license_id bigint NOT NULL,
    unmapped_declared_license_id bigint NOT NULL
);


ALTER TABLE ort_server.processed_declared_licenses_unmapped_declared_licenses OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.products (
    id bigint NOT NULL,
    name text NOT NULL,
    description text,
    organization_id bigint NOT NULL
);


ALTER TABLE ort_server.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.products_id_seq OWNED BY ort_server.products.id;


--
-- Name: project_scopes; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.project_scopes (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE ort_server.project_scopes OWNER TO postgres;

--
-- Name: project_scopes_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.project_scopes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.project_scopes_id_seq OWNER TO postgres;

--
-- Name: project_scopes_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.project_scopes_id_seq OWNED BY ort_server.project_scopes.id;


--
-- Name: projects; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.projects (
    id bigint NOT NULL,
    identifier_id bigint NOT NULL,
    vcs_id bigint NOT NULL,
    vcs_processed_id bigint NOT NULL,
    homepage_url text NOT NULL,
    definition_file_path text NOT NULL,
    cpe text,
    description text DEFAULT ''::text NOT NULL
);


ALTER TABLE ort_server.projects OWNER TO postgres;

--
-- Name: projects_analyzer_runs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.projects_analyzer_runs (
    project_id bigint NOT NULL,
    analyzer_run_id bigint NOT NULL
);


ALTER TABLE ort_server.projects_analyzer_runs OWNER TO postgres;

--
-- Name: projects_authors; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.projects_authors (
    author_id bigint NOT NULL,
    project_id bigint NOT NULL
);


ALTER TABLE ort_server.projects_authors OWNER TO postgres;

--
-- Name: projects_declared_licenses; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.projects_declared_licenses (
    project_id bigint NOT NULL,
    declared_license_id bigint NOT NULL
);


ALTER TABLE ort_server.projects_declared_licenses OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.projects_id_seq OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.projects_id_seq OWNED BY ort_server.projects.id;


--
-- Name: provenance_snippet_choices; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.provenance_snippet_choices (
    id bigint NOT NULL,
    provenance text NOT NULL
);


ALTER TABLE ort_server.provenance_snippet_choices OWNER TO postgres;

--
-- Name: provenance_snippet_choices_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.provenance_snippet_choices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.provenance_snippet_choices_id_seq OWNER TO postgres;

--
-- Name: provenance_snippet_choices_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.provenance_snippet_choices_id_seq OWNED BY ort_server.provenance_snippet_choices.id;


--
-- Name: provenance_snippet_choices_snippet_choices; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.provenance_snippet_choices_snippet_choices (
    provenance_snippet_choices_id bigint NOT NULL,
    snippet_choices_id bigint NOT NULL
);


ALTER TABLE ort_server.provenance_snippet_choices_snippet_choices OWNER TO postgres;

--
-- Name: remote_artifacts; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.remote_artifacts (
    id bigint NOT NULL,
    url text NOT NULL,
    hash_value text NOT NULL,
    hash_algorithm text NOT NULL
);


ALTER TABLE ort_server.remote_artifacts OWNER TO postgres;

--
-- Name: remote_artifacts_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.remote_artifacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.remote_artifacts_id_seq OWNER TO postgres;

--
-- Name: remote_artifacts_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.remote_artifacts_id_seq OWNED BY ort_server.remote_artifacts.id;


--
-- Name: reporter_jobs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.reporter_jobs (
    id bigint NOT NULL,
    ort_run_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    configuration jsonb NOT NULL,
    status text NOT NULL,
    error_message text
);


ALTER TABLE ort_server.reporter_jobs OWNER TO postgres;

--
-- Name: reporter_jobs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.reporter_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.reporter_jobs_id_seq OWNER TO postgres;

--
-- Name: reporter_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.reporter_jobs_id_seq OWNED BY ort_server.reporter_jobs.id;


--
-- Name: reporter_runs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.reporter_runs (
    id bigint NOT NULL,
    reporter_job_id bigint NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL
);


ALTER TABLE ort_server.reporter_runs OWNER TO postgres;

--
-- Name: reporter_runs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.reporter_runs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.reporter_runs_id_seq OWNER TO postgres;

--
-- Name: reporter_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.reporter_runs_id_seq OWNED BY ort_server.reporter_runs.id;


--
-- Name: reporter_runs_reports; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.reporter_runs_reports (
    reporter_run_id bigint NOT NULL,
    report_id bigint NOT NULL
);


ALTER TABLE ort_server.reporter_runs_reports OWNER TO postgres;

--
-- Name: reports; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.reports (
    id bigint NOT NULL,
    report_filename text NOT NULL,
    download_link text DEFAULT ''::text NOT NULL,
    download_token_expiry_date timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE ort_server.reports OWNER TO postgres;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.reports_id_seq OWNER TO postgres;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.reports_id_seq OWNED BY ort_server.reports.id;


--
-- Name: repositories; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repositories (
    id bigint NOT NULL,
    type text NOT NULL,
    url text NOT NULL,
    product_id bigint NOT NULL,
    description text
);


ALTER TABLE ort_server.repositories OWNER TO postgres;

--
-- Name: repositories_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.repositories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.repositories_id_seq OWNER TO postgres;

--
-- Name: repositories_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.repositories_id_seq OWNED BY ort_server.repositories.id;


--
-- Name: repository_analyzer_configurations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_analyzer_configurations (
    id bigint NOT NULL,
    allow_dynamic_versions boolean,
    enabled_package_managers text,
    disabled_package_managers text,
    skip_excluded boolean
);


ALTER TABLE ort_server.repository_analyzer_configurations OWNER TO postgres;

--
-- Name: repository_analyzer_configurations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.repository_analyzer_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.repository_analyzer_configurations_id_seq OWNER TO postgres;

--
-- Name: repository_analyzer_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.repository_analyzer_configurations_id_seq OWNED BY ort_server.repository_analyzer_configurations.id;


--
-- Name: repository_analyzer_configurations_package_manager_configuratio; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_analyzer_configurations_package_manager_configuratio (
    repository_analyzer_configuration_id bigint NOT NULL,
    package_manager_configuration_id bigint NOT NULL
);


ALTER TABLE ort_server.repository_analyzer_configurations_package_manager_configuratio OWNER TO postgres;

--
-- Name: repository_configurations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_configurations (
    id bigint NOT NULL,
    ort_run_id bigint NOT NULL,
    repository_analyzer_configuration_id bigint
);


ALTER TABLE ort_server.repository_configurations OWNER TO postgres;

--
-- Name: repository_configurations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.repository_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.repository_configurations_id_seq OWNER TO postgres;

--
-- Name: repository_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.repository_configurations_id_seq OWNED BY ort_server.repository_configurations.id;


--
-- Name: repository_configurations_issue_resolutions; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_configurations_issue_resolutions (
    repository_configuration_id bigint NOT NULL,
    issue_resolution_id bigint NOT NULL
);


ALTER TABLE ort_server.repository_configurations_issue_resolutions OWNER TO postgres;

--
-- Name: repository_configurations_license_finding_curations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_configurations_license_finding_curations (
    repository_configuration_id bigint NOT NULL,
    license_finding_curation_id bigint NOT NULL
);


ALTER TABLE ort_server.repository_configurations_license_finding_curations OWNER TO postgres;

--
-- Name: repository_configurations_package_configurations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_configurations_package_configurations (
    repository_configuration_id bigint NOT NULL,
    package_configuration_id bigint NOT NULL
);


ALTER TABLE ort_server.repository_configurations_package_configurations OWNER TO postgres;

--
-- Name: repository_configurations_package_curations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_configurations_package_curations (
    repository_configuration_id bigint NOT NULL,
    package_curation_id bigint NOT NULL
);


ALTER TABLE ort_server.repository_configurations_package_curations OWNER TO postgres;

--
-- Name: repository_configurations_package_license_choices; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_configurations_package_license_choices (
    repository_configuration_id bigint NOT NULL,
    package_license_choice_id bigint NOT NULL
);


ALTER TABLE ort_server.repository_configurations_package_license_choices OWNER TO postgres;

--
-- Name: repository_configurations_path_excludes; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_configurations_path_excludes (
    repository_configuration_id bigint NOT NULL,
    path_exclude_id bigint NOT NULL
);


ALTER TABLE ort_server.repository_configurations_path_excludes OWNER TO postgres;

--
-- Name: repository_configurations_path_includes; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_configurations_path_includes (
    repository_configuration_id bigint NOT NULL,
    path_include_id bigint NOT NULL
);


ALTER TABLE ort_server.repository_configurations_path_includes OWNER TO postgres;

--
-- Name: repository_configurations_provenance_snippet_choices; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_configurations_provenance_snippet_choices (
    repository_configuration_id bigint NOT NULL,
    provenance_snippet_choices_id bigint NOT NULL
);


ALTER TABLE ort_server.repository_configurations_provenance_snippet_choices OWNER TO postgres;

--
-- Name: repository_configurations_rule_violation_resolutions; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_configurations_rule_violation_resolutions (
    repository_configuration_id bigint NOT NULL,
    rule_violation_resolution_id bigint NOT NULL
);


ALTER TABLE ort_server.repository_configurations_rule_violation_resolutions OWNER TO postgres;

--
-- Name: repository_configurations_scope_excludes; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_configurations_scope_excludes (
    repository_configuration_id bigint NOT NULL,
    scope_exclude_id bigint NOT NULL
);


ALTER TABLE ort_server.repository_configurations_scope_excludes OWNER TO postgres;

--
-- Name: repository_configurations_spdx_license_choices; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_configurations_spdx_license_choices (
    repository_configuration_id bigint NOT NULL,
    spdx_license_choice bigint NOT NULL
);


ALTER TABLE ort_server.repository_configurations_spdx_license_choices OWNER TO postgres;

--
-- Name: repository_configurations_vulnerability_resolutions; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.repository_configurations_vulnerability_resolutions (
    repository_configuration_id bigint NOT NULL,
    vulnerability_resolution_id bigint NOT NULL
);


ALTER TABLE ort_server.repository_configurations_vulnerability_resolutions OWNER TO postgres;

--
-- Name: resolved_configurations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.resolved_configurations (
    id bigint NOT NULL,
    ort_run_id bigint NOT NULL
);


ALTER TABLE ort_server.resolved_configurations OWNER TO postgres;

--
-- Name: resolved_configurations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.resolved_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.resolved_configurations_id_seq OWNER TO postgres;

--
-- Name: resolved_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.resolved_configurations_id_seq OWNED BY ort_server.resolved_configurations.id;


--
-- Name: resolved_configurations_issue_resolutions; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.resolved_configurations_issue_resolutions (
    resolved_configuration_id bigint NOT NULL,
    issue_resolution_id bigint NOT NULL
);


ALTER TABLE ort_server.resolved_configurations_issue_resolutions OWNER TO postgres;

--
-- Name: resolved_configurations_package_configurations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.resolved_configurations_package_configurations (
    resolved_configuration_id bigint NOT NULL,
    package_configuration_id bigint NOT NULL
);


ALTER TABLE ort_server.resolved_configurations_package_configurations OWNER TO postgres;

--
-- Name: resolved_configurations_rule_violation_resolutions; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.resolved_configurations_rule_violation_resolutions (
    resolved_configuration_id bigint NOT NULL,
    rule_violation_resolution_id bigint NOT NULL
);


ALTER TABLE ort_server.resolved_configurations_rule_violation_resolutions OWNER TO postgres;

--
-- Name: resolved_configurations_vulnerability_resolutions; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.resolved_configurations_vulnerability_resolutions (
    resolved_configuration_id bigint NOT NULL,
    vulnerability_resolution_id bigint NOT NULL
);


ALTER TABLE ort_server.resolved_configurations_vulnerability_resolutions OWNER TO postgres;

--
-- Name: resolved_package_curation_providers; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.resolved_package_curation_providers (
    id bigint NOT NULL,
    resolved_configuration_id bigint NOT NULL,
    package_curation_provider_config_id bigint NOT NULL,
    rank integer NOT NULL
);


ALTER TABLE ort_server.resolved_package_curation_providers OWNER TO postgres;

--
-- Name: resolved_package_curation_providers_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.resolved_package_curation_providers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.resolved_package_curation_providers_id_seq OWNER TO postgres;

--
-- Name: resolved_package_curation_providers_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.resolved_package_curation_providers_id_seq OWNED BY ort_server.resolved_package_curation_providers.id;


--
-- Name: resolved_package_curations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.resolved_package_curations (
    id bigint NOT NULL,
    resolved_package_curation_provider_id bigint NOT NULL,
    package_curation_id bigint NOT NULL,
    rank integer NOT NULL
);


ALTER TABLE ort_server.resolved_package_curations OWNER TO postgres;

--
-- Name: resolved_package_curations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.resolved_package_curations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.resolved_package_curations_id_seq OWNER TO postgres;

--
-- Name: resolved_package_curations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.resolved_package_curations_id_seq OWNED BY ort_server.resolved_package_curations.id;


--
-- Name: rule_violation_resolutions; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.rule_violation_resolutions (
    id bigint NOT NULL,
    message text NOT NULL,
    reason text NOT NULL,
    comment text NOT NULL
);


ALTER TABLE ort_server.rule_violation_resolutions OWNER TO postgres;

--
-- Name: rule_violation_resolutions_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.rule_violation_resolutions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.rule_violation_resolutions_id_seq OWNER TO postgres;

--
-- Name: rule_violation_resolutions_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.rule_violation_resolutions_id_seq OWNED BY ort_server.rule_violation_resolutions.id;


--
-- Name: rule_violations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.rule_violations (
    id bigint NOT NULL,
    rule text NOT NULL,
    identifier_id bigint,
    license text,
    license_source text,
    severity text NOT NULL,
    message text NOT NULL,
    how_to_fix text NOT NULL
);


ALTER TABLE ort_server.rule_violations OWNER TO postgres;

--
-- Name: rule_violations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.rule_violations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.rule_violations_id_seq OWNER TO postgres;

--
-- Name: rule_violations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.rule_violations_id_seq OWNED BY ort_server.rule_violations.id;


--
-- Name: scan_results; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scan_results (
    id bigint NOT NULL,
    scan_summary_id bigint NOT NULL,
    artifact_url text,
    artifact_hash text,
    vcs_type text,
    vcs_url text,
    vcs_revision text,
    scanner_name text NOT NULL,
    scanner_version text NOT NULL,
    scanner_configuration text NOT NULL,
    additional_data jsonb,
    artifact_hash_algorithm text
);


ALTER TABLE ort_server.scan_results OWNER TO postgres;

--
-- Name: scan_results_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.scan_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.scan_results_id_seq OWNER TO postgres;

--
-- Name: scan_results_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.scan_results_id_seq OWNED BY ort_server.scan_results.id;


--
-- Name: scan_summaries; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scan_summaries (
    id bigint NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    hash text DEFAULT ''::text NOT NULL
);


ALTER TABLE ort_server.scan_summaries OWNER TO postgres;

--
-- Name: scan_summaries_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.scan_summaries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.scan_summaries_id_seq OWNER TO postgres;

--
-- Name: scan_summaries_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.scan_summaries_id_seq OWNED BY ort_server.scan_summaries.id;


--
-- Name: scan_summaries_issues; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scan_summaries_issues (
    id bigint NOT NULL,
    scan_summary_id bigint NOT NULL,
    issue_id bigint NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE ort_server.scan_summaries_issues OWNER TO postgres;

--
-- Name: scan_summaries_issues_with_timestamps_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.scan_summaries_issues_with_timestamps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.scan_summaries_issues_with_timestamps_id_seq OWNER TO postgres;

--
-- Name: scan_summaries_issues_with_timestamps_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.scan_summaries_issues_with_timestamps_id_seq OWNED BY ort_server.scan_summaries_issues.id;


--
-- Name: scanner_configuration_options; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scanner_configuration_options (
    id bigint NOT NULL,
    scanner text NOT NULL,
    option text NOT NULL,
    value text NOT NULL
);


ALTER TABLE ort_server.scanner_configuration_options OWNER TO postgres;

--
-- Name: scanner_configuration_options_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.scanner_configuration_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.scanner_configuration_options_id_seq OWNER TO postgres;

--
-- Name: scanner_configuration_options_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.scanner_configuration_options_id_seq OWNED BY ort_server.scanner_configuration_options.id;


--
-- Name: scanner_configuration_secrets; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scanner_configuration_secrets (
    id bigint NOT NULL,
    scanner text NOT NULL,
    secret text NOT NULL,
    value text NOT NULL
);


ALTER TABLE ort_server.scanner_configuration_secrets OWNER TO postgres;

--
-- Name: scanner_configuration_secrets_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.scanner_configuration_secrets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.scanner_configuration_secrets_id_seq OWNER TO postgres;

--
-- Name: scanner_configuration_secrets_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.scanner_configuration_secrets_id_seq OWNED BY ort_server.scanner_configuration_secrets.id;


--
-- Name: scanner_configurations; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scanner_configurations (
    id bigint NOT NULL,
    scanner_run_id bigint NOT NULL,
    skip_concluded boolean DEFAULT false NOT NULL,
    ignore_patterns text,
    skip_excluded boolean DEFAULT false NOT NULL
);


ALTER TABLE ort_server.scanner_configurations OWNER TO postgres;

--
-- Name: scanner_configurations_detected_license_mappings; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scanner_configurations_detected_license_mappings (
    scanner_configuration_id bigint NOT NULL,
    detected_license_mapping_id bigint NOT NULL
);


ALTER TABLE ort_server.scanner_configurations_detected_license_mappings OWNER TO postgres;

--
-- Name: scanner_configurations_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.scanner_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.scanner_configurations_id_seq OWNER TO postgres;

--
-- Name: scanner_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.scanner_configurations_id_seq OWNED BY ort_server.scanner_configurations.id;


--
-- Name: scanner_configurations_options; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scanner_configurations_options (
    scanner_configuration_id bigint NOT NULL,
    scanner_configuration_option_id bigint NOT NULL
);


ALTER TABLE ort_server.scanner_configurations_options OWNER TO postgres;

--
-- Name: scanner_configurations_secrets; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scanner_configurations_secrets (
    scanner_configuration_id bigint NOT NULL,
    scanner_configuration_secret_id bigint NOT NULL
);


ALTER TABLE ort_server.scanner_configurations_secrets OWNER TO postgres;

--
-- Name: scanner_jobs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scanner_jobs (
    id bigint NOT NULL,
    ort_run_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    configuration jsonb NOT NULL,
    status text NOT NULL,
    error_message text
);


ALTER TABLE ort_server.scanner_jobs OWNER TO postgres;

--
-- Name: scanner_jobs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.scanner_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.scanner_jobs_id_seq OWNER TO postgres;

--
-- Name: scanner_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.scanner_jobs_id_seq OWNED BY ort_server.scanner_jobs.id;


--
-- Name: scanner_runs; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scanner_runs (
    id bigint NOT NULL,
    scanner_job_id bigint NOT NULL,
    environment_id bigint,
    start_time timestamp without time zone,
    end_time timestamp without time zone
);


ALTER TABLE ort_server.scanner_runs OWNER TO postgres;

--
-- Name: scanner_runs_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.scanner_runs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.scanner_runs_id_seq OWNER TO postgres;

--
-- Name: scanner_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.scanner_runs_id_seq OWNED BY ort_server.scanner_runs.id;


--
-- Name: scanner_runs_package_provenances; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scanner_runs_package_provenances (
    scanner_run_id bigint NOT NULL,
    package_provenance_id bigint NOT NULL
);


ALTER TABLE ort_server.scanner_runs_package_provenances OWNER TO postgres;

--
-- Name: scanner_runs_scan_results; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scanner_runs_scan_results (
    scanner_run_id bigint NOT NULL,
    scan_result_id bigint NOT NULL
);


ALTER TABLE ort_server.scanner_runs_scan_results OWNER TO postgres;

--
-- Name: scanner_runs_scanners; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scanner_runs_scanners (
    id bigint NOT NULL,
    scanner_run_id bigint NOT NULL,
    identifier_id bigint NOT NULL,
    scanner_name text NOT NULL
);


ALTER TABLE ort_server.scanner_runs_scanners OWNER TO postgres;

--
-- Name: scanner_runs_scanners_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.scanner_runs_scanners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.scanner_runs_scanners_id_seq OWNER TO postgres;

--
-- Name: scanner_runs_scanners_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.scanner_runs_scanners_id_seq OWNED BY ort_server.scanner_runs_scanners.id;


--
-- Name: scope_excludes; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.scope_excludes (
    id bigint NOT NULL,
    pattern text NOT NULL,
    reason text NOT NULL,
    comment text NOT NULL
);


ALTER TABLE ort_server.scope_excludes OWNER TO postgres;

--
-- Name: scope_excludes_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.scope_excludes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.scope_excludes_id_seq OWNER TO postgres;

--
-- Name: scope_excludes_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.scope_excludes_id_seq OWNED BY ort_server.scope_excludes.id;


--
-- Name: secrets; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.secrets (
    id bigint NOT NULL,
    path text NOT NULL,
    name text NOT NULL,
    description text,
    organization_id bigint,
    product_id bigint,
    repository_id bigint,
    CONSTRAINT secrets_type_check CHECK ((((((organization_id IS NOT NULL))::integer + ((product_id IS NOT NULL))::integer) + ((repository_id IS NOT NULL))::integer) = 1))
);


ALTER TABLE ort_server.secrets OWNER TO postgres;

--
-- Name: secrets_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.secrets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.secrets_id_seq OWNER TO postgres;

--
-- Name: secrets_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.secrets_id_seq OWNED BY ort_server.secrets.id;


--
-- Name: shortest_dependency_paths; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.shortest_dependency_paths (
    id bigint NOT NULL,
    package_id bigint NOT NULL,
    analyzer_run_id bigint NOT NULL,
    project_id bigint NOT NULL,
    scope text NOT NULL,
    path jsonb NOT NULL
);


ALTER TABLE ort_server.shortest_dependency_paths OWNER TO postgres;

--
-- Name: shortest_dependency_paths_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.shortest_dependency_paths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.shortest_dependency_paths_id_seq OWNER TO postgres;

--
-- Name: shortest_dependency_paths_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.shortest_dependency_paths_id_seq OWNED BY ort_server.shortest_dependency_paths.id;


--
-- Name: snippet_choices; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.snippet_choices (
    id bigint NOT NULL,
    given_location_start_line integer,
    given_location_end_line integer,
    given_location_path text NOT NULL,
    choice_purl text,
    choice_reason text NOT NULL,
    choice_comment text
);


ALTER TABLE ort_server.snippet_choices OWNER TO postgres;

--
-- Name: snippet_choices_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.snippet_choices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.snippet_choices_id_seq OWNER TO postgres;

--
-- Name: snippet_choices_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.snippet_choices_id_seq OWNED BY ort_server.snippet_choices.id;


--
-- Name: snippet_findings; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.snippet_findings (
    id bigint NOT NULL,
    path text NOT NULL,
    start_line integer NOT NULL,
    end_line integer NOT NULL,
    scan_summary_id bigint NOT NULL
);


ALTER TABLE ort_server.snippet_findings OWNER TO postgres;

--
-- Name: snippet_findings_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.snippet_findings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.snippet_findings_id_seq OWNER TO postgres;

--
-- Name: snippet_findings_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.snippet_findings_id_seq OWNED BY ort_server.snippet_findings.id;


--
-- Name: snippet_findings_snippets; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.snippet_findings_snippets (
    snippet_finding_id bigint NOT NULL,
    snippet_id bigint NOT NULL
);


ALTER TABLE ort_server.snippet_findings_snippets OWNER TO postgres;

--
-- Name: snippets; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.snippets (
    id bigint NOT NULL,
    purl text NOT NULL,
    artifact_id bigint,
    vcs_id bigint,
    path text NOT NULL,
    start_line integer NOT NULL,
    end_line integer NOT NULL,
    license text NOT NULL,
    score real NOT NULL,
    additional_data jsonb
);


ALTER TABLE ort_server.snippets OWNER TO postgres;

--
-- Name: snippets_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.snippets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.snippets_id_seq OWNER TO postgres;

--
-- Name: snippets_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.snippets_id_seq OWNED BY ort_server.snippets.id;


--
-- Name: spdx_license_choices; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.spdx_license_choices (
    id bigint NOT NULL,
    given text,
    choice text NOT NULL
);


ALTER TABLE ort_server.spdx_license_choices OWNER TO postgres;

--
-- Name: spdx_license_choices_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.spdx_license_choices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.spdx_license_choices_id_seq OWNER TO postgres;

--
-- Name: spdx_license_choices_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.spdx_license_choices_id_seq OWNED BY ort_server.spdx_license_choices.id;


--
-- Name: storage; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.storage (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    namespace text NOT NULL,
    key text NOT NULL,
    content_type text,
    size integer NOT NULL,
    data oid NOT NULL
);


ALTER TABLE ort_server.storage OWNER TO postgres;

--
-- Name: storage_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.storage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.storage_id_seq OWNER TO postgres;

--
-- Name: storage_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.storage_id_seq OWNED BY ort_server.storage.id;


--
-- Name: unmapped_declared_licenses; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.unmapped_declared_licenses (
    id bigint NOT NULL,
    unmapped_license text NOT NULL
);


ALTER TABLE ort_server.unmapped_declared_licenses OWNER TO postgres;

--
-- Name: unmapped_declared_licenses_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.unmapped_declared_licenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.unmapped_declared_licenses_id_seq OWNER TO postgres;

--
-- Name: unmapped_declared_licenses_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.unmapped_declared_licenses_id_seq OWNED BY ort_server.unmapped_declared_licenses.id;


--
-- Name: user_display_names; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.user_display_names (
    user_id character varying(40) NOT NULL,
    username text NOT NULL,
    full_name text,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE ort_server.user_display_names OWNER TO postgres;

--
-- Name: variables; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.variables (
    id bigint NOT NULL,
    name text NOT NULL,
    value text NOT NULL
);


ALTER TABLE ort_server.variables OWNER TO postgres;

--
-- Name: variables_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.variables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.variables_id_seq OWNER TO postgres;

--
-- Name: variables_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.variables_id_seq OWNED BY ort_server.variables.id;


--
-- Name: vcs_info; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.vcs_info (
    id bigint NOT NULL,
    type text NOT NULL,
    url text NOT NULL,
    revision text NOT NULL,
    path text NOT NULL
);


ALTER TABLE ort_server.vcs_info OWNER TO postgres;

--
-- Name: vcs_info_curation_data; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.vcs_info_curation_data (
    id bigint NOT NULL,
    type text,
    url text,
    revision text,
    path text
);


ALTER TABLE ort_server.vcs_info_curation_data OWNER TO postgres;

--
-- Name: vcs_info_curation_data_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.vcs_info_curation_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.vcs_info_curation_data_id_seq OWNER TO postgres;

--
-- Name: vcs_info_curation_data_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.vcs_info_curation_data_id_seq OWNED BY ort_server.vcs_info_curation_data.id;


--
-- Name: vcs_info_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.vcs_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.vcs_info_id_seq OWNER TO postgres;

--
-- Name: vcs_info_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.vcs_info_id_seq OWNED BY ort_server.vcs_info.id;


--
-- Name: vcs_matchers; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.vcs_matchers (
    id bigint NOT NULL,
    type text NOT NULL,
    url text NOT NULL,
    revision text
);


ALTER TABLE ort_server.vcs_matchers OWNER TO postgres;

--
-- Name: vcs_matchers_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.vcs_matchers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.vcs_matchers_id_seq OWNER TO postgres;

--
-- Name: vcs_matchers_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.vcs_matchers_id_seq OWNED BY ort_server.vcs_matchers.id;


--
-- Name: vulnerabilities; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.vulnerabilities (
    id bigint NOT NULL,
    external_id text NOT NULL,
    summary text,
    description text
);


ALTER TABLE ort_server.vulnerabilities OWNER TO postgres;

--
-- Name: vulnerabilities_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.vulnerabilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.vulnerabilities_id_seq OWNER TO postgres;

--
-- Name: vulnerabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.vulnerabilities_id_seq OWNED BY ort_server.vulnerabilities.id;


--
-- Name: vulnerability_references; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.vulnerability_references (
    id bigint NOT NULL,
    vulnerability_id bigint NOT NULL,
    url text NOT NULL,
    scoring_system text,
    severity text,
    score double precision,
    vector text
);


ALTER TABLE ort_server.vulnerability_references OWNER TO postgres;

--
-- Name: vulnerability_references_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.vulnerability_references_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.vulnerability_references_id_seq OWNER TO postgres;

--
-- Name: vulnerability_references_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.vulnerability_references_id_seq OWNED BY ort_server.vulnerability_references.id;


--
-- Name: vulnerability_resolutions; Type: TABLE; Schema: ort_server; Owner: postgres
--

CREATE TABLE ort_server.vulnerability_resolutions (
    id bigint NOT NULL,
    external_id text NOT NULL,
    reason text NOT NULL,
    comment text NOT NULL
);


ALTER TABLE ort_server.vulnerability_resolutions OWNER TO postgres;

--
-- Name: vulnerability_resolutions_id_seq; Type: SEQUENCE; Schema: ort_server; Owner: postgres
--

CREATE SEQUENCE ort_server.vulnerability_resolutions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ort_server.vulnerability_resolutions_id_seq OWNER TO postgres;

--
-- Name: vulnerability_resolutions_id_seq; Type: SEQUENCE OWNED BY; Schema: ort_server; Owner: postgres
--

ALTER SEQUENCE ort_server.vulnerability_resolutions_id_seq OWNED BY ort_server.vulnerability_resolutions.id;


--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer,
    version integer DEFAULT 0
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL,
    description character varying(255)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: org; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO postgres;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: server_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.server_config (
    server_config_key character varying(255) NOT NULL,
    value text NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.server_config OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Name: advisor_configuration_options id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configuration_options ALTER COLUMN id SET DEFAULT nextval('ort_server.advisor_configuration_options_id_seq'::regclass);


--
-- Name: advisor_configuration_secrets id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configuration_secrets ALTER COLUMN id SET DEFAULT nextval('ort_server.advisor_configuration_secrets_id_seq'::regclass);


--
-- Name: advisor_configurations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configurations ALTER COLUMN id SET DEFAULT nextval('ort_server.advisor_configurations_id_seq'::regclass);


--
-- Name: advisor_jobs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_jobs ALTER COLUMN id SET DEFAULT nextval('ort_server.advisor_jobs_id_seq'::regclass);


--
-- Name: advisor_results id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_results ALTER COLUMN id SET DEFAULT nextval('ort_server.advisor_results_id_seq'::regclass);


--
-- Name: advisor_runs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_runs ALTER COLUMN id SET DEFAULT nextval('ort_server.advisor_runs_id_seq'::regclass);


--
-- Name: advisor_runs_identifiers id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_runs_identifiers ALTER COLUMN id SET DEFAULT nextval('ort_server.advisor_runs_identifiers_id_seq'::regclass);


--
-- Name: analyzer_configurations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_configurations ALTER COLUMN id SET DEFAULT nextval('ort_server.analyzer_configurations_id_seq'::regclass);


--
-- Name: analyzer_jobs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_jobs ALTER COLUMN id SET DEFAULT nextval('ort_server.analyzer_jobs_id_seq'::regclass);


--
-- Name: analyzer_runs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_runs ALTER COLUMN id SET DEFAULT nextval('ort_server.analyzer_runs_id_seq'::regclass);


--
-- Name: authors id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.authors ALTER COLUMN id SET DEFAULT nextval('ort_server.authors_id_seq'::regclass);


--
-- Name: copyright_findings id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.copyright_findings ALTER COLUMN id SET DEFAULT nextval('ort_server.copyright_findings_id_seq'::regclass);


--
-- Name: declared_license_mappings id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.declared_license_mappings ALTER COLUMN id SET DEFAULT nextval('ort_server.declared_license_mappings_id_seq'::regclass);


--
-- Name: declared_licenses id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.declared_licenses ALTER COLUMN id SET DEFAULT nextval('ort_server.declared_licenses_id_seq'::regclass);


--
-- Name: defect_labels id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.defect_labels ALTER COLUMN id SET DEFAULT nextval('ort_server.defect_labels_id_seq'::regclass);


--
-- Name: defects id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.defects ALTER COLUMN id SET DEFAULT nextval('ort_server.defects_id_seq'::regclass);


--
-- Name: detected_license_mappings id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.detected_license_mappings ALTER COLUMN id SET DEFAULT nextval('ort_server.detected_license_mappings_id_seq'::regclass);


--
-- Name: environments id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.environments ALTER COLUMN id SET DEFAULT nextval('ort_server.environments_id_seq'::regclass);


--
-- Name: evaluator_jobs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.evaluator_jobs ALTER COLUMN id SET DEFAULT nextval('ort_server.evaluator_jobs_id_seq'::regclass);


--
-- Name: evaluator_runs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.evaluator_runs ALTER COLUMN id SET DEFAULT nextval('ort_server.evaluator_runs_id_seq'::regclass);


--
-- Name: identifiers id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.identifiers ALTER COLUMN id SET DEFAULT nextval('ort_server.identifiers_id_seq'::regclass);


--
-- Name: identifiers_issues id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.identifiers_issues ALTER COLUMN id SET DEFAULT nextval('ort_server.identifiers_ort_issues_id_seq'::regclass);


--
-- Name: infrastructure_service_declarations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.infrastructure_service_declarations ALTER COLUMN id SET DEFAULT nextval('ort_server.infrastructure_service_declarations_id_seq'::regclass);


--
-- Name: infrastructure_services id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.infrastructure_services ALTER COLUMN id SET DEFAULT nextval('ort_server.infrastructure_services_id_seq'::regclass);


--
-- Name: issue_resolutions id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.issue_resolutions ALTER COLUMN id SET DEFAULT nextval('ort_server.issue_resolutions_id_seq'::regclass);


--
-- Name: issues id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.issues ALTER COLUMN id SET DEFAULT nextval('ort_server.ort_issues_id_seq'::regclass);


--
-- Name: labels id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.labels ALTER COLUMN id SET DEFAULT nextval('ort_server.labels_id_seq'::regclass);


--
-- Name: license_finding_curations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.license_finding_curations ALTER COLUMN id SET DEFAULT nextval('ort_server.license_finding_curations_id_seq'::regclass);


--
-- Name: license_findings id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.license_findings ALTER COLUMN id SET DEFAULT nextval('ort_server.license_findings_id_seq'::regclass);


--
-- Name: mapped_declared_licenses id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.mapped_declared_licenses ALTER COLUMN id SET DEFAULT nextval('ort_server.mapped_declared_licenses_id_seq'::regclass);


--
-- Name: nested_provenance_sub_repositories id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.nested_provenance_sub_repositories ALTER COLUMN id SET DEFAULT nextval('ort_server.nested_provenance_sub_repositories_id_seq'::regclass);


--
-- Name: nested_provenances id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.nested_provenances ALTER COLUMN id SET DEFAULT nextval('ort_server.nested_provenances_id_seq'::regclass);


--
-- Name: nested_repositories id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.nested_repositories ALTER COLUMN id SET DEFAULT nextval('ort_server.nested_repositories_id_seq'::regclass);


--
-- Name: notifier_jobs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.notifier_jobs ALTER COLUMN id SET DEFAULT nextval('ort_server.notifier_jobs_id_seq'::regclass);


--
-- Name: notifier_runs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.notifier_runs ALTER COLUMN id SET DEFAULT nextval('ort_server.notifier_runs_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.organizations ALTER COLUMN id SET DEFAULT nextval('ort_server.organizations_id_seq'::regclass);


--
-- Name: ort_runs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs ALTER COLUMN id SET DEFAULT nextval('ort_server.ort_runs_id_seq'::regclass);


--
-- Name: ort_runs_issues id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs_issues ALTER COLUMN id SET DEFAULT nextval('ort_server.ort_runs_issues2_id_seq'::regclass);


--
-- Name: package_configurations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_configurations ALTER COLUMN id SET DEFAULT nextval('ort_server.package_configurations_id_seq'::regclass);


--
-- Name: package_curation_data id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_data ALTER COLUMN id SET DEFAULT nextval('ort_server.package_curation_data_id_seq'::regclass);


--
-- Name: package_curation_provider_configs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_provider_configs ALTER COLUMN id SET DEFAULT nextval('ort_server.package_curation_provider_configs_id_seq'::regclass);


--
-- Name: package_curations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curations ALTER COLUMN id SET DEFAULT nextval('ort_server.package_curations_id_seq'::regclass);


--
-- Name: package_license_choices id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_license_choices ALTER COLUMN id SET DEFAULT nextval('ort_server.package_license_choices_id_seq'::regclass);


--
-- Name: package_manager_configuration_options id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_manager_configuration_options ALTER COLUMN id SET DEFAULT nextval('ort_server.package_manager_configuration_options_id_seq'::regclass);


--
-- Name: package_manager_configurations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_manager_configurations ALTER COLUMN id SET DEFAULT nextval('ort_server.package_manager_configurations_id_seq'::regclass);


--
-- Name: package_provenances id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_provenances ALTER COLUMN id SET DEFAULT nextval('ort_server.package_provenances_id_seq'::regclass);


--
-- Name: packages id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages ALTER COLUMN id SET DEFAULT nextval('ort_server.packages_id_seq'::regclass);


--
-- Name: path_excludes id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.path_excludes ALTER COLUMN id SET DEFAULT nextval('ort_server.path_excludes_id_seq'::regclass);


--
-- Name: path_includes id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.path_includes ALTER COLUMN id SET DEFAULT nextval('ort_server.path_includes_id_seq'::regclass);


--
-- Name: processed_declared_licenses id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.processed_declared_licenses ALTER COLUMN id SET DEFAULT nextval('ort_server.processed_declared_licenses_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.products ALTER COLUMN id SET DEFAULT nextval('ort_server.products_id_seq'::regclass);


--
-- Name: project_scopes id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.project_scopes ALTER COLUMN id SET DEFAULT nextval('ort_server.project_scopes_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects ALTER COLUMN id SET DEFAULT nextval('ort_server.projects_id_seq'::regclass);


--
-- Name: provenance_snippet_choices id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.provenance_snippet_choices ALTER COLUMN id SET DEFAULT nextval('ort_server.provenance_snippet_choices_id_seq'::regclass);


--
-- Name: remote_artifacts id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.remote_artifacts ALTER COLUMN id SET DEFAULT nextval('ort_server.remote_artifacts_id_seq'::regclass);


--
-- Name: reporter_jobs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.reporter_jobs ALTER COLUMN id SET DEFAULT nextval('ort_server.reporter_jobs_id_seq'::regclass);


--
-- Name: reporter_runs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.reporter_runs ALTER COLUMN id SET DEFAULT nextval('ort_server.reporter_runs_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.reports ALTER COLUMN id SET DEFAULT nextval('ort_server.reports_id_seq'::regclass);


--
-- Name: repositories id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repositories ALTER COLUMN id SET DEFAULT nextval('ort_server.repositories_id_seq'::regclass);


--
-- Name: repository_analyzer_configurations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_analyzer_configurations ALTER COLUMN id SET DEFAULT nextval('ort_server.repository_analyzer_configurations_id_seq'::regclass);


--
-- Name: repository_configurations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations ALTER COLUMN id SET DEFAULT nextval('ort_server.repository_configurations_id_seq'::regclass);


--
-- Name: resolved_configurations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations ALTER COLUMN id SET DEFAULT nextval('ort_server.resolved_configurations_id_seq'::regclass);


--
-- Name: resolved_package_curation_providers id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_package_curation_providers ALTER COLUMN id SET DEFAULT nextval('ort_server.resolved_package_curation_providers_id_seq'::regclass);


--
-- Name: resolved_package_curations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_package_curations ALTER COLUMN id SET DEFAULT nextval('ort_server.resolved_package_curations_id_seq'::regclass);


--
-- Name: rule_violation_resolutions id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.rule_violation_resolutions ALTER COLUMN id SET DEFAULT nextval('ort_server.rule_violation_resolutions_id_seq'::regclass);


--
-- Name: rule_violations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.rule_violations ALTER COLUMN id SET DEFAULT nextval('ort_server.rule_violations_id_seq'::regclass);


--
-- Name: scan_results id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scan_results ALTER COLUMN id SET DEFAULT nextval('ort_server.scan_results_id_seq'::regclass);


--
-- Name: scan_summaries id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scan_summaries ALTER COLUMN id SET DEFAULT nextval('ort_server.scan_summaries_id_seq'::regclass);


--
-- Name: scan_summaries_issues id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scan_summaries_issues ALTER COLUMN id SET DEFAULT nextval('ort_server.scan_summaries_issues_with_timestamps_id_seq'::regclass);


--
-- Name: scanner_configuration_options id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configuration_options ALTER COLUMN id SET DEFAULT nextval('ort_server.scanner_configuration_options_id_seq'::regclass);


--
-- Name: scanner_configuration_secrets id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configuration_secrets ALTER COLUMN id SET DEFAULT nextval('ort_server.scanner_configuration_secrets_id_seq'::regclass);


--
-- Name: scanner_configurations id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configurations ALTER COLUMN id SET DEFAULT nextval('ort_server.scanner_configurations_id_seq'::regclass);


--
-- Name: scanner_jobs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_jobs ALTER COLUMN id SET DEFAULT nextval('ort_server.scanner_jobs_id_seq'::regclass);


--
-- Name: scanner_runs id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs ALTER COLUMN id SET DEFAULT nextval('ort_server.scanner_runs_id_seq'::regclass);


--
-- Name: scanner_runs_scanners id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs_scanners ALTER COLUMN id SET DEFAULT nextval('ort_server.scanner_runs_scanners_id_seq'::regclass);


--
-- Name: scope_excludes id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scope_excludes ALTER COLUMN id SET DEFAULT nextval('ort_server.scope_excludes_id_seq'::regclass);


--
-- Name: secrets id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.secrets ALTER COLUMN id SET DEFAULT nextval('ort_server.secrets_id_seq'::regclass);


--
-- Name: shortest_dependency_paths id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.shortest_dependency_paths ALTER COLUMN id SET DEFAULT nextval('ort_server.shortest_dependency_paths_id_seq'::regclass);


--
-- Name: snippet_choices id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.snippet_choices ALTER COLUMN id SET DEFAULT nextval('ort_server.snippet_choices_id_seq'::regclass);


--
-- Name: snippet_findings id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.snippet_findings ALTER COLUMN id SET DEFAULT nextval('ort_server.snippet_findings_id_seq'::regclass);


--
-- Name: snippets id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.snippets ALTER COLUMN id SET DEFAULT nextval('ort_server.snippets_id_seq'::regclass);


--
-- Name: spdx_license_choices id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.spdx_license_choices ALTER COLUMN id SET DEFAULT nextval('ort_server.spdx_license_choices_id_seq'::regclass);


--
-- Name: storage id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.storage ALTER COLUMN id SET DEFAULT nextval('ort_server.storage_id_seq'::regclass);


--
-- Name: unmapped_declared_licenses id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.unmapped_declared_licenses ALTER COLUMN id SET DEFAULT nextval('ort_server.unmapped_declared_licenses_id_seq'::regclass);


--
-- Name: variables id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.variables ALTER COLUMN id SET DEFAULT nextval('ort_server.variables_id_seq'::regclass);


--
-- Name: vcs_info id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vcs_info ALTER COLUMN id SET DEFAULT nextval('ort_server.vcs_info_id_seq'::regclass);


--
-- Name: vcs_info_curation_data id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vcs_info_curation_data ALTER COLUMN id SET DEFAULT nextval('ort_server.vcs_info_curation_data_id_seq'::regclass);


--
-- Name: vcs_matchers id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vcs_matchers ALTER COLUMN id SET DEFAULT nextval('ort_server.vcs_matchers_id_seq'::regclass);


--
-- Name: vulnerabilities id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vulnerabilities ALTER COLUMN id SET DEFAULT nextval('ort_server.vulnerabilities_id_seq'::regclass);


--
-- Name: vulnerability_references id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vulnerability_references ALTER COLUMN id SET DEFAULT nextval('ort_server.vulnerability_references_id_seq'::regclass);


--
-- Name: vulnerability_resolutions id; Type: DEFAULT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vulnerability_resolutions ALTER COLUMN id SET DEFAULT nextval('ort_server.vulnerability_resolutions_id_seq'::regclass);


--
-- Name: advisor_configuration_options advisor_configuration_options_advisor_option_value_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configuration_options
    ADD CONSTRAINT advisor_configuration_options_advisor_option_value_key UNIQUE (advisor, option, value);


--
-- Name: advisor_configuration_options advisor_configuration_options_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configuration_options
    ADD CONSTRAINT advisor_configuration_options_pkey PRIMARY KEY (id);


--
-- Name: advisor_configuration_secrets advisor_configuration_secrets_advisor_secret_value_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configuration_secrets
    ADD CONSTRAINT advisor_configuration_secrets_advisor_secret_value_key UNIQUE (advisor, secret, value);


--
-- Name: advisor_configuration_secrets advisor_configuration_secrets_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configuration_secrets
    ADD CONSTRAINT advisor_configuration_secrets_pkey PRIMARY KEY (id);


--
-- Name: advisor_configurations_options advisor_configurations_options_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configurations_options
    ADD CONSTRAINT advisor_configurations_options_pkey PRIMARY KEY (advisor_configuration_id, advisor_configuration_option_id);


--
-- Name: advisor_configurations advisor_configurations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configurations
    ADD CONSTRAINT advisor_configurations_pkey PRIMARY KEY (id);


--
-- Name: advisor_configurations_secrets advisor_configurations_secrets_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configurations_secrets
    ADD CONSTRAINT advisor_configurations_secrets_pkey PRIMARY KEY (advisor_configuration_id, advisor_configuration_secret_id);


--
-- Name: advisor_jobs advisor_jobs_ort_run_id_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_jobs
    ADD CONSTRAINT advisor_jobs_ort_run_id_key UNIQUE (ort_run_id);


--
-- Name: advisor_jobs advisor_jobs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_jobs
    ADD CONSTRAINT advisor_jobs_pkey PRIMARY KEY (id);


--
-- Name: advisor_results_defects advisor_results_defects_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_results_defects
    ADD CONSTRAINT advisor_results_defects_pkey PRIMARY KEY (advisor_result_id, defect_id);


--
-- Name: advisor_results advisor_results_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_results
    ADD CONSTRAINT advisor_results_pkey PRIMARY KEY (id);


--
-- Name: advisor_results_vulnerabilities advisor_results_vulnerabilities_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_results_vulnerabilities
    ADD CONSTRAINT advisor_results_vulnerabilities_pkey PRIMARY KEY (advisor_result_id, vulnerability_id);


--
-- Name: advisor_runs_identifiers advisor_runs_identifiers_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_runs_identifiers
    ADD CONSTRAINT advisor_runs_identifiers_pkey PRIMARY KEY (id);


--
-- Name: advisor_runs advisor_runs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_runs
    ADD CONSTRAINT advisor_runs_pkey PRIMARY KEY (id);


--
-- Name: analyzer_configurations_package_manager_configurations analyzer_configurations_package_manager_configurations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_configurations_package_manager_configurations
    ADD CONSTRAINT analyzer_configurations_package_manager_configurations_pkey PRIMARY KEY (analyzer_configuration_id, package_manager_configuration_id);


--
-- Name: analyzer_configurations analyzer_configurations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_configurations
    ADD CONSTRAINT analyzer_configurations_pkey PRIMARY KEY (id);


--
-- Name: analyzer_jobs analyzer_jobs_ort_run_id_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_jobs
    ADD CONSTRAINT analyzer_jobs_ort_run_id_key UNIQUE (ort_run_id);


--
-- Name: analyzer_jobs analyzer_jobs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_jobs
    ADD CONSTRAINT analyzer_jobs_pkey PRIMARY KEY (id);


--
-- Name: analyzer_runs analyzer_runs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_runs
    ADD CONSTRAINT analyzer_runs_pkey PRIMARY KEY (id);


--
-- Name: authors authors_name_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.authors
    ADD CONSTRAINT authors_name_key UNIQUE (name);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: config_table config_table_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.config_table
    ADD CONSTRAINT config_table_pkey PRIMARY KEY (key);


--
-- Name: content_management_sections content_management_sections_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.content_management_sections
    ADD CONSTRAINT content_management_sections_pkey PRIMARY KEY (id);


--
-- Name: copyright_findings copyright_findings_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.copyright_findings
    ADD CONSTRAINT copyright_findings_pkey PRIMARY KEY (id);


--
-- Name: declared_license_mappings declared_license_mappings_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.declared_license_mappings
    ADD CONSTRAINT declared_license_mappings_pkey PRIMARY KEY (id);


--
-- Name: declared_licenses declared_licenses_name_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.declared_licenses
    ADD CONSTRAINT declared_licenses_name_key UNIQUE (name);


--
-- Name: declared_licenses declared_licenses_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.declared_licenses
    ADD CONSTRAINT declared_licenses_pkey PRIMARY KEY (id);


--
-- Name: defect_labels defect_labels_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.defect_labels
    ADD CONSTRAINT defect_labels_pkey PRIMARY KEY (id);


--
-- Name: defects defects_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.defects
    ADD CONSTRAINT defects_pkey PRIMARY KEY (id);


--
-- Name: detected_license_mappings detected_license_mappings_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.detected_license_mappings
    ADD CONSTRAINT detected_license_mappings_pkey PRIMARY KEY (id);


--
-- Name: environments environments_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.environments
    ADD CONSTRAINT environments_pkey PRIMARY KEY (id);


--
-- Name: environments_variables environments_variables_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.environments_variables
    ADD CONSTRAINT environments_variables_pkey PRIMARY KEY (environment_id, variable_id);


--
-- Name: evaluator_jobs evaluator_jobs_ort_run_id_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.evaluator_jobs
    ADD CONSTRAINT evaluator_jobs_ort_run_id_key UNIQUE (ort_run_id);


--
-- Name: evaluator_jobs evaluator_jobs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.evaluator_jobs
    ADD CONSTRAINT evaluator_jobs_pkey PRIMARY KEY (id);


--
-- Name: evaluator_runs evaluator_runs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.evaluator_runs
    ADD CONSTRAINT evaluator_runs_pkey PRIMARY KEY (id);


--
-- Name: evaluator_runs_rule_violations evaluator_runs_rule_violations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.evaluator_runs_rule_violations
    ADD CONSTRAINT evaluator_runs_rule_violations_pkey PRIMARY KEY (evaluator_run_id, rule_violation_id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: identifiers_issues identifiers_ort_issues_identifier_id_ort_issue_id_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.identifiers_issues
    ADD CONSTRAINT identifiers_ort_issues_identifier_id_ort_issue_id_key UNIQUE (identifier_id, issue_id);


--
-- Name: identifiers_issues identifiers_ort_issues_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.identifiers_issues
    ADD CONSTRAINT identifiers_ort_issues_pkey PRIMARY KEY (id);


--
-- Name: identifiers identifiers_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.identifiers
    ADD CONSTRAINT identifiers_pkey PRIMARY KEY (id);


--
-- Name: identifiers identifiers_type_namespace_name_version_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.identifiers
    ADD CONSTRAINT identifiers_type_namespace_name_version_key UNIQUE (type, namespace, name, version);


--
-- Name: infrastructure_service_declarations_ort_runs infrastructure_service_declarations_ort_runs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.infrastructure_service_declarations_ort_runs
    ADD CONSTRAINT infrastructure_service_declarations_ort_runs_pkey PRIMARY KEY (infrastructure_service_declaration_id, ort_run_id);


--
-- Name: infrastructure_service_declarations infrastructure_service_declarations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.infrastructure_service_declarations
    ADD CONSTRAINT infrastructure_service_declarations_pkey PRIMARY KEY (id);


--
-- Name: infrastructure_services infrastructure_services_name_organization_id_product_id_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.infrastructure_services
    ADD CONSTRAINT infrastructure_services_name_organization_id_product_id_key UNIQUE (name, organization_id, product_id);


--
-- Name: infrastructure_services infrastructure_services_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.infrastructure_services
    ADD CONSTRAINT infrastructure_services_pkey PRIMARY KEY (id);


--
-- Name: issue_resolutions issue_resolutions_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.issue_resolutions
    ADD CONSTRAINT issue_resolutions_pkey PRIMARY KEY (id);


--
-- Name: labels labels_key_value_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.labels
    ADD CONSTRAINT labels_key_value_key UNIQUE (key, value);


--
-- Name: labels labels_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.labels
    ADD CONSTRAINT labels_pkey PRIMARY KEY (id);


--
-- Name: license_finding_curations license_finding_curations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.license_finding_curations
    ADD CONSTRAINT license_finding_curations_pkey PRIMARY KEY (id);


--
-- Name: license_findings license_findings_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.license_findings
    ADD CONSTRAINT license_findings_pkey PRIMARY KEY (id);


--
-- Name: mapped_declared_licenses mapped_declared_licenses_declared_license_mapped_license_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.mapped_declared_licenses
    ADD CONSTRAINT mapped_declared_licenses_declared_license_mapped_license_key UNIQUE (declared_license, mapped_license);


--
-- Name: mapped_declared_licenses mapped_declared_licenses_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.mapped_declared_licenses
    ADD CONSTRAINT mapped_declared_licenses_pkey PRIMARY KEY (id);


--
-- Name: nested_provenance_sub_repositories nested_provenance_sub_repositor_id_vcs_id_resolved_revision_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.nested_provenance_sub_repositories
    ADD CONSTRAINT nested_provenance_sub_repositor_id_vcs_id_resolved_revision_key UNIQUE (id, vcs_id, resolved_revision);


--
-- Name: nested_provenance_sub_repositories nested_provenance_sub_repositories_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.nested_provenance_sub_repositories
    ADD CONSTRAINT nested_provenance_sub_repositories_pkey PRIMARY KEY (id);


--
-- Name: nested_provenances nested_provenances_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.nested_provenances
    ADD CONSTRAINT nested_provenances_pkey PRIMARY KEY (id);


--
-- Name: nested_repositories nested_repositories_ort_run_id_vcs_id_path_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.nested_repositories
    ADD CONSTRAINT nested_repositories_ort_run_id_vcs_id_path_key UNIQUE (ort_run_id, vcs_id, path);


--
-- Name: nested_repositories nested_repositories_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.nested_repositories
    ADD CONSTRAINT nested_repositories_pkey PRIMARY KEY (id);


--
-- Name: notifier_jobs notifier_jobs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.notifier_jobs
    ADD CONSTRAINT notifier_jobs_pkey PRIMARY KEY (id);


--
-- Name: notifier_runs notifier_runs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.notifier_runs
    ADD CONSTRAINT notifier_runs_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_name_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.organizations
    ADD CONSTRAINT organizations_name_key UNIQUE (name);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: issues ort_issues_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.issues
    ADD CONSTRAINT ort_issues_pkey PRIMARY KEY (id);


--
-- Name: ort_runs ort_runs_index_repository_id_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs
    ADD CONSTRAINT ort_runs_index_repository_id_key UNIQUE (index, repository_id);


--
-- Name: ort_runs_issues ort_runs_issues2_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs_issues
    ADD CONSTRAINT ort_runs_issues2_pkey PRIMARY KEY (id);


--
-- Name: ort_runs_labels ort_runs_labels_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs_labels
    ADD CONSTRAINT ort_runs_labels_pkey PRIMARY KEY (ort_run_id, label_id);


--
-- Name: ort_runs ort_runs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs
    ADD CONSTRAINT ort_runs_pkey PRIMARY KEY (id);


--
-- Name: package_configurations_license_finding_curations package_configurations_license_finding_curations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_configurations_license_finding_curations
    ADD CONSTRAINT package_configurations_license_finding_curations_pkey PRIMARY KEY (package_configuration_id, license_finding_curation_id);


--
-- Name: package_configurations_path_excludes package_configurations_path_excludes_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_configurations_path_excludes
    ADD CONSTRAINT package_configurations_path_excludes_pkey PRIMARY KEY (package_configuration_id, path_exclude_id);


--
-- Name: package_configurations package_configurations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_configurations
    ADD CONSTRAINT package_configurations_pkey PRIMARY KEY (id);


--
-- Name: package_curation_data_authors package_curation_data_authors_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_data_authors
    ADD CONSTRAINT package_curation_data_authors_pkey PRIMARY KEY (author_id, package_curation_data_id);


--
-- Name: package_curation_data_declared_license_mappings package_curation_data_declared_license_mappings_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_data_declared_license_mappings
    ADD CONSTRAINT package_curation_data_declared_license_mappings_pkey PRIMARY KEY (package_curation_data_id, declared_license_mapping_id);


--
-- Name: package_curation_data package_curation_data_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_data
    ADD CONSTRAINT package_curation_data_pkey PRIMARY KEY (id);


--
-- Name: package_curation_provider_configs package_curation_provider_configs_name_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_provider_configs
    ADD CONSTRAINT package_curation_provider_configs_name_key UNIQUE (name);


--
-- Name: package_curation_provider_configs package_curation_provider_configs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_provider_configs
    ADD CONSTRAINT package_curation_provider_configs_pkey PRIMARY KEY (id);


--
-- Name: package_curations package_curations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curations
    ADD CONSTRAINT package_curations_pkey PRIMARY KEY (id);


--
-- Name: package_license_choices package_license_choices_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_license_choices
    ADD CONSTRAINT package_license_choices_pkey PRIMARY KEY (id);


--
-- Name: package_license_choices_spdx_license_choices package_license_choices_spdx_license_choices_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_license_choices_spdx_license_choices
    ADD CONSTRAINT package_license_choices_spdx_license_choices_pkey PRIMARY KEY (package_license_choice_id, spdx_license_choice_id);


--
-- Name: package_manager_configuration_options package_manager_configuration_options_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_manager_configuration_options
    ADD CONSTRAINT package_manager_configuration_options_pkey PRIMARY KEY (id);


--
-- Name: package_manager_configurations package_manager_configurations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_manager_configurations
    ADD CONSTRAINT package_manager_configurations_pkey PRIMARY KEY (id);


--
-- Name: package_provenances package_provenances_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_provenances
    ADD CONSTRAINT package_provenances_pkey PRIMARY KEY (id);


--
-- Name: packages_analyzer_runs packages_analyzer_runs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages_analyzer_runs
    ADD CONSTRAINT packages_analyzer_runs_pkey PRIMARY KEY (package_id, analyzer_run_id);


--
-- Name: packages_authors packages_authors_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages_authors
    ADD CONSTRAINT packages_authors_pkey PRIMARY KEY (author_id, package_id);


--
-- Name: packages_declared_licenses packages_declared_licenses_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages_declared_licenses
    ADD CONSTRAINT packages_declared_licenses_pkey PRIMARY KEY (package_id, declared_license_id);


--
-- Name: packages packages_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (id);


--
-- Name: path_excludes path_excludes_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.path_excludes
    ADD CONSTRAINT path_excludes_pkey PRIMARY KEY (id);


--
-- Name: path_includes path_includes_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.path_includes
    ADD CONSTRAINT path_includes_pkey PRIMARY KEY (id);


--
-- Name: plugin_events plugin_events_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.plugin_events
    ADD CONSTRAINT plugin_events_pkey PRIMARY KEY (plugin_type, plugin_id, version);


--
-- Name: plugin_template_events plugin_template_events_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.plugin_template_events
    ADD CONSTRAINT plugin_template_events_pkey PRIMARY KEY (name, plugin_type, plugin_id, version);


--
-- Name: plugin_template_organization_assignments plugin_template_organization_assignments_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.plugin_template_organization_assignments
    ADD CONSTRAINT plugin_template_organization_assignments_pkey PRIMARY KEY (plugin_type, plugin_id, organization_id);


--
-- Name: plugin_templates_read_model plugin_templates_read_model_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.plugin_templates_read_model
    ADD CONSTRAINT plugin_templates_read_model_pkey PRIMARY KEY (name, plugin_type, plugin_id);


--
-- Name: plugins_read_model plugins_read_model_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.plugins_read_model
    ADD CONSTRAINT plugins_read_model_pkey PRIMARY KEY (plugin_type, plugin_id);


--
-- Name: processed_declared_licenses processed_declared_licenses_id_package_id_spdx_expression_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.processed_declared_licenses
    ADD CONSTRAINT processed_declared_licenses_id_package_id_spdx_expression_key UNIQUE (id, package_id, spdx_expression);


--
-- Name: processed_declared_licenses_mapped_declared_licenses processed_declared_licenses_mapped_declared_licenses_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.processed_declared_licenses_mapped_declared_licenses
    ADD CONSTRAINT processed_declared_licenses_mapped_declared_licenses_pkey PRIMARY KEY (processed_declared_license_id, mapped_declared_license_id);


--
-- Name: processed_declared_licenses processed_declared_licenses_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.processed_declared_licenses
    ADD CONSTRAINT processed_declared_licenses_pkey PRIMARY KEY (id);


--
-- Name: processed_declared_licenses_unmapped_declared_licenses processed_declared_licenses_unmapped_declared_licenses_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.processed_declared_licenses_unmapped_declared_licenses
    ADD CONSTRAINT processed_declared_licenses_unmapped_declared_licenses_pkey PRIMARY KEY (processed_declared_license_id, unmapped_declared_license_id);


--
-- Name: products products_name_organization_id_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.products
    ADD CONSTRAINT products_name_organization_id_key UNIQUE (name, organization_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: project_scopes project_scopes_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.project_scopes
    ADD CONSTRAINT project_scopes_pkey PRIMARY KEY (id);


--
-- Name: projects_analyzer_runs projects_analyzer_runs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects_analyzer_runs
    ADD CONSTRAINT projects_analyzer_runs_pkey PRIMARY KEY (project_id, analyzer_run_id);


--
-- Name: projects_authors projects_authors_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects_authors
    ADD CONSTRAINT projects_authors_pkey PRIMARY KEY (author_id, project_id);


--
-- Name: projects_declared_licenses projects_declared_licenses_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects_declared_licenses
    ADD CONSTRAINT projects_declared_licenses_pkey PRIMARY KEY (project_id, declared_license_id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: provenance_snippet_choices provenance_snippet_choices_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.provenance_snippet_choices
    ADD CONSTRAINT provenance_snippet_choices_pkey PRIMARY KEY (id);


--
-- Name: provenance_snippet_choices_snippet_choices provenance_snippet_choices_snippet_choices_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.provenance_snippet_choices_snippet_choices
    ADD CONSTRAINT provenance_snippet_choices_snippet_choices_pkey PRIMARY KEY (provenance_snippet_choices_id, snippet_choices_id);


--
-- Name: remote_artifacts remote_artifacts_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.remote_artifacts
    ADD CONSTRAINT remote_artifacts_pkey PRIMARY KEY (id);


--
-- Name: remote_artifacts remote_artifacts_url_hash_value_hash_algorithm_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.remote_artifacts
    ADD CONSTRAINT remote_artifacts_url_hash_value_hash_algorithm_key UNIQUE (url, hash_value, hash_algorithm);


--
-- Name: reporter_jobs reporter_jobs_ort_run_id_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.reporter_jobs
    ADD CONSTRAINT reporter_jobs_ort_run_id_key UNIQUE (ort_run_id);


--
-- Name: reporter_jobs reporter_jobs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.reporter_jobs
    ADD CONSTRAINT reporter_jobs_pkey PRIMARY KEY (id);


--
-- Name: reporter_runs reporter_runs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.reporter_runs
    ADD CONSTRAINT reporter_runs_pkey PRIMARY KEY (id);


--
-- Name: reporter_runs_reports reporter_runs_reports_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.reporter_runs_reports
    ADD CONSTRAINT reporter_runs_reports_pkey PRIMARY KEY (reporter_run_id, report_id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: repositories repositories_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repositories
    ADD CONSTRAINT repositories_pkey PRIMARY KEY (id);


--
-- Name: repositories repositories_url_product_id_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repositories
    ADD CONSTRAINT repositories_url_product_id_key UNIQUE (url, product_id);


--
-- Name: repository_analyzer_configurations_package_manager_configuratio repository_analyzer_configurations_package_manager_configu_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_analyzer_configurations_package_manager_configuratio
    ADD CONSTRAINT repository_analyzer_configurations_package_manager_configu_pkey PRIMARY KEY (repository_analyzer_configuration_id, package_manager_configuration_id);


--
-- Name: repository_analyzer_configurations repository_analyzer_configurations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_analyzer_configurations
    ADD CONSTRAINT repository_analyzer_configurations_pkey PRIMARY KEY (id);


--
-- Name: repository_configurations_issue_resolutions repository_configurations_issue_resolutions_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_issue_resolutions
    ADD CONSTRAINT repository_configurations_issue_resolutions_pkey PRIMARY KEY (repository_configuration_id, issue_resolution_id);


--
-- Name: repository_configurations_license_finding_curations repository_configurations_license_finding_curations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_license_finding_curations
    ADD CONSTRAINT repository_configurations_license_finding_curations_pkey PRIMARY KEY (repository_configuration_id, license_finding_curation_id);


--
-- Name: repository_configurations_package_configurations repository_configurations_package_configurations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_package_configurations
    ADD CONSTRAINT repository_configurations_package_configurations_pkey PRIMARY KEY (repository_configuration_id, package_configuration_id);


--
-- Name: repository_configurations_package_curations repository_configurations_package_curations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_package_curations
    ADD CONSTRAINT repository_configurations_package_curations_pkey PRIMARY KEY (repository_configuration_id, package_curation_id);


--
-- Name: repository_configurations_package_license_choices repository_configurations_package_license_choices_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_package_license_choices
    ADD CONSTRAINT repository_configurations_package_license_choices_pkey PRIMARY KEY (repository_configuration_id, package_license_choice_id);


--
-- Name: repository_configurations_path_excludes repository_configurations_path_excludes_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_path_excludes
    ADD CONSTRAINT repository_configurations_path_excludes_pkey PRIMARY KEY (repository_configuration_id, path_exclude_id);


--
-- Name: repository_configurations_path_includes repository_configurations_path_includes_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_path_includes
    ADD CONSTRAINT repository_configurations_path_includes_pkey PRIMARY KEY (repository_configuration_id, path_include_id);


--
-- Name: repository_configurations repository_configurations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations
    ADD CONSTRAINT repository_configurations_pkey PRIMARY KEY (id);


--
-- Name: repository_configurations_provenance_snippet_choices repository_configurations_provenance_snippet_choices_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_provenance_snippet_choices
    ADD CONSTRAINT repository_configurations_provenance_snippet_choices_pkey PRIMARY KEY (repository_configuration_id, provenance_snippet_choices_id);


--
-- Name: repository_configurations_rule_violation_resolutions repository_configurations_rule_violation_resolutions_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_rule_violation_resolutions
    ADD CONSTRAINT repository_configurations_rule_violation_resolutions_pkey PRIMARY KEY (repository_configuration_id, rule_violation_resolution_id);


--
-- Name: repository_configurations_scope_excludes repository_configurations_scope_excludes_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_scope_excludes
    ADD CONSTRAINT repository_configurations_scope_excludes_pkey PRIMARY KEY (repository_configuration_id, scope_exclude_id);


--
-- Name: repository_configurations_spdx_license_choices repository_configurations_spdx_license_choices_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_spdx_license_choices
    ADD CONSTRAINT repository_configurations_spdx_license_choices_pkey PRIMARY KEY (repository_configuration_id, spdx_license_choice);


--
-- Name: repository_configurations_vulnerability_resolutions repository_configurations_vulnerability_resolutions_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_vulnerability_resolutions
    ADD CONSTRAINT repository_configurations_vulnerability_resolutions_pkey PRIMARY KEY (repository_configuration_id, vulnerability_resolution_id);


--
-- Name: resolved_configurations_issue_resolutions resolved_configurations_issue_resolutions_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations_issue_resolutions
    ADD CONSTRAINT resolved_configurations_issue_resolutions_pkey PRIMARY KEY (resolved_configuration_id, issue_resolution_id);


--
-- Name: resolved_configurations_package_configurations resolved_configurations_package_configurations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations_package_configurations
    ADD CONSTRAINT resolved_configurations_package_configurations_pkey PRIMARY KEY (resolved_configuration_id, package_configuration_id);


--
-- Name: resolved_configurations resolved_configurations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations
    ADD CONSTRAINT resolved_configurations_pkey PRIMARY KEY (id);


--
-- Name: resolved_configurations_rule_violation_resolutions resolved_configurations_rule_violation_resolutions_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations_rule_violation_resolutions
    ADD CONSTRAINT resolved_configurations_rule_violation_resolutions_pkey PRIMARY KEY (resolved_configuration_id, rule_violation_resolution_id);


--
-- Name: resolved_configurations_vulnerability_resolutions resolved_configurations_vulnerability_resolutions_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations_vulnerability_resolutions
    ADD CONSTRAINT resolved_configurations_vulnerability_resolutions_pkey PRIMARY KEY (resolved_configuration_id, vulnerability_resolution_id);


--
-- Name: resolved_package_curation_providers resolved_package_curation_pro_resolved_configuration_id_pac_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_package_curation_providers
    ADD CONSTRAINT resolved_package_curation_pro_resolved_configuration_id_pac_key UNIQUE (resolved_configuration_id, package_curation_provider_config_id);


--
-- Name: resolved_package_curation_providers resolved_package_curation_pro_resolved_configuration_id_ran_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_package_curation_providers
    ADD CONSTRAINT resolved_package_curation_pro_resolved_configuration_id_ran_key UNIQUE (resolved_configuration_id, rank);


--
-- Name: resolved_package_curation_providers resolved_package_curation_providers_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_package_curation_providers
    ADD CONSTRAINT resolved_package_curation_providers_pkey PRIMARY KEY (id);


--
-- Name: resolved_package_curations resolved_package_curations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_package_curations
    ADD CONSTRAINT resolved_package_curations_pkey PRIMARY KEY (id);


--
-- Name: resolved_package_curations resolved_package_curations_resolved_package_curation_provi_key1; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_package_curations
    ADD CONSTRAINT resolved_package_curations_resolved_package_curation_provi_key1 UNIQUE (resolved_package_curation_provider_id, rank);


--
-- Name: resolved_package_curations resolved_package_curations_resolved_package_curation_provid_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_package_curations
    ADD CONSTRAINT resolved_package_curations_resolved_package_curation_provid_key UNIQUE (resolved_package_curation_provider_id, package_curation_id);


--
-- Name: rule_violation_resolutions rule_violation_resolutions_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.rule_violation_resolutions
    ADD CONSTRAINT rule_violation_resolutions_pkey PRIMARY KEY (id);


--
-- Name: rule_violations rule_violations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.rule_violations
    ADD CONSTRAINT rule_violations_pkey PRIMARY KEY (id);


--
-- Name: scan_results scan_results_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scan_results
    ADD CONSTRAINT scan_results_pkey PRIMARY KEY (id);


--
-- Name: scan_summaries_issues scan_summaries_issues_with_timestamps_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scan_summaries_issues
    ADD CONSTRAINT scan_summaries_issues_with_timestamps_pkey PRIMARY KEY (id);


--
-- Name: scan_summaries scan_summaries_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scan_summaries
    ADD CONSTRAINT scan_summaries_pkey PRIMARY KEY (id);


--
-- Name: scanner_configuration_options scanner_configuration_options_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configuration_options
    ADD CONSTRAINT scanner_configuration_options_pkey PRIMARY KEY (id);


--
-- Name: scanner_configuration_options scanner_configuration_options_scanner_option_value_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configuration_options
    ADD CONSTRAINT scanner_configuration_options_scanner_option_value_key UNIQUE (scanner, option, value);


--
-- Name: scanner_configuration_secrets scanner_configuration_secrets_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configuration_secrets
    ADD CONSTRAINT scanner_configuration_secrets_pkey PRIMARY KEY (id);


--
-- Name: scanner_configuration_secrets scanner_configuration_secrets_scanner_secret_value_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configuration_secrets
    ADD CONSTRAINT scanner_configuration_secrets_scanner_secret_value_key UNIQUE (scanner, secret, value);


--
-- Name: scanner_configurations_detected_license_mappings scanner_configurations_detected_license_mappings_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configurations_detected_license_mappings
    ADD CONSTRAINT scanner_configurations_detected_license_mappings_pkey PRIMARY KEY (scanner_configuration_id, detected_license_mapping_id);


--
-- Name: scanner_configurations_options scanner_configurations_options_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configurations_options
    ADD CONSTRAINT scanner_configurations_options_pkey PRIMARY KEY (scanner_configuration_id, scanner_configuration_option_id);


--
-- Name: scanner_configurations scanner_configurations_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configurations
    ADD CONSTRAINT scanner_configurations_pkey PRIMARY KEY (id);


--
-- Name: scanner_configurations_secrets scanner_configurations_secrets_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configurations_secrets
    ADD CONSTRAINT scanner_configurations_secrets_pkey PRIMARY KEY (scanner_configuration_id, scanner_configuration_secret_id);


--
-- Name: scanner_jobs scanner_jobs_ort_run_id_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_jobs
    ADD CONSTRAINT scanner_jobs_ort_run_id_key UNIQUE (ort_run_id);


--
-- Name: scanner_jobs scanner_jobs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_jobs
    ADD CONSTRAINT scanner_jobs_pkey PRIMARY KEY (id);


--
-- Name: scanner_runs_package_provenances scanner_runs_package_provenances_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs_package_provenances
    ADD CONSTRAINT scanner_runs_package_provenances_pkey PRIMARY KEY (scanner_run_id, package_provenance_id);


--
-- Name: scanner_runs scanner_runs_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs
    ADD CONSTRAINT scanner_runs_pkey PRIMARY KEY (id);


--
-- Name: scanner_runs_scan_results scanner_runs_scan_results_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs_scan_results
    ADD CONSTRAINT scanner_runs_scan_results_pkey PRIMARY KEY (scanner_run_id, scan_result_id);


--
-- Name: scanner_runs_scanners scanner_runs_scanners_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs_scanners
    ADD CONSTRAINT scanner_runs_scanners_pkey PRIMARY KEY (id);


--
-- Name: scanner_runs_scanners scanner_runs_scanners_scanner_run_id_identifier_id_scanner__key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs_scanners
    ADD CONSTRAINT scanner_runs_scanners_scanner_run_id_identifier_id_scanner__key UNIQUE (scanner_run_id, identifier_id, scanner_name);


--
-- Name: scope_excludes scope_excludes_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scope_excludes
    ADD CONSTRAINT scope_excludes_pkey PRIMARY KEY (id);


--
-- Name: secrets secrets_name_organization_id_product_id_repository_id_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.secrets
    ADD CONSTRAINT secrets_name_organization_id_product_id_repository_id_key UNIQUE (name, organization_id, product_id, repository_id);


--
-- Name: secrets secrets_path_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.secrets
    ADD CONSTRAINT secrets_path_key UNIQUE (path);


--
-- Name: secrets secrets_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.secrets
    ADD CONSTRAINT secrets_pkey PRIMARY KEY (id);


--
-- Name: shortest_dependency_paths shortest_dependency_paths_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.shortest_dependency_paths
    ADD CONSTRAINT shortest_dependency_paths_pkey PRIMARY KEY (id);


--
-- Name: snippet_choices snippet_choices_given_location_start_line_given_location_en_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.snippet_choices
    ADD CONSTRAINT snippet_choices_given_location_start_line_given_location_en_key UNIQUE (given_location_start_line, given_location_end_line, given_location_path, choice_purl, choice_reason, choice_comment);


--
-- Name: snippet_choices snippet_choices_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.snippet_choices
    ADD CONSTRAINT snippet_choices_pkey PRIMARY KEY (id);


--
-- Name: snippet_findings snippet_findings_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.snippet_findings
    ADD CONSTRAINT snippet_findings_pkey PRIMARY KEY (id);


--
-- Name: snippet_findings_snippets snippet_findings_snippets_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.snippet_findings_snippets
    ADD CONSTRAINT snippet_findings_snippets_pkey PRIMARY KEY (snippet_finding_id, snippet_id);


--
-- Name: snippets snippets_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.snippets
    ADD CONSTRAINT snippets_pkey PRIMARY KEY (id);


--
-- Name: spdx_license_choices spdx_license_choices_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.spdx_license_choices
    ADD CONSTRAINT spdx_license_choices_pkey PRIMARY KEY (id);


--
-- Name: storage storage_namespace_key_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.storage
    ADD CONSTRAINT storage_namespace_key_key UNIQUE (namespace, key);


--
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (id);


--
-- Name: unmapped_declared_licenses unmapped_declared_licenses_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.unmapped_declared_licenses
    ADD CONSTRAINT unmapped_declared_licenses_pkey PRIMARY KEY (id);


--
-- Name: unmapped_declared_licenses unmapped_declared_licenses_unmapped_license_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.unmapped_declared_licenses
    ADD CONSTRAINT unmapped_declared_licenses_unmapped_license_key UNIQUE (unmapped_license);


--
-- Name: user_display_names user_display_names_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.user_display_names
    ADD CONSTRAINT user_display_names_pkey PRIMARY KEY (user_id);


--
-- Name: user_display_names user_display_names_username_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.user_display_names
    ADD CONSTRAINT user_display_names_username_key UNIQUE (username);


--
-- Name: variables variables_name_value_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.variables
    ADD CONSTRAINT variables_name_value_key UNIQUE (name, value);


--
-- Name: variables variables_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.variables
    ADD CONSTRAINT variables_pkey PRIMARY KEY (id);


--
-- Name: vcs_info_curation_data vcs_info_curation_data_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vcs_info_curation_data
    ADD CONSTRAINT vcs_info_curation_data_pkey PRIMARY KEY (id);


--
-- Name: vcs_info vcs_info_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vcs_info
    ADD CONSTRAINT vcs_info_pkey PRIMARY KEY (id);


--
-- Name: vcs_info vcs_info_type_url_revision_path_key; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vcs_info
    ADD CONSTRAINT vcs_info_type_url_revision_path_key UNIQUE (type, url, revision, path);


--
-- Name: vcs_matchers vcs_matchers_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vcs_matchers
    ADD CONSTRAINT vcs_matchers_pkey PRIMARY KEY (id);


--
-- Name: vulnerabilities vulnerabilities_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vulnerabilities
    ADD CONSTRAINT vulnerabilities_pkey PRIMARY KEY (id);


--
-- Name: vulnerability_references vulnerability_references_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vulnerability_references
    ADD CONSTRAINT vulnerability_references_pkey PRIMARY KEY (id);


--
-- Name: vulnerability_resolutions vulnerability_resolutions_pkey; Type: CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vulnerability_resolutions
    ADD CONSTRAINT vulnerability_resolutions_pkey PRIMARY KEY (id);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: server_config SERVER_CONFIG_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server_config
    ADD CONSTRAINT "SERVER_CONFIG_pkey" PRIMARY KEY (server_config_key);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: migration_model uk_migration_update_time; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_update_time UNIQUE (update_time);


--
-- Name: migration_model uk_migration_version; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_version UNIQUE (version);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: advisor_jobs_durations; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX advisor_jobs_durations ON ort_server.advisor_jobs USING btree (status, started_at, finished_at);


--
-- Name: advisor_results_advisor_run_identifier_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX advisor_results_advisor_run_identifier_id ON ort_server.advisor_results USING btree (advisor_run_identifier_id);


--
-- Name: advisor_runs_advisor_job_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX advisor_runs_advisor_job_id ON ort_server.advisor_runs USING btree (advisor_job_id);


--
-- Name: advisor_runs_identifiers_advisor_run_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX advisor_runs_identifiers_advisor_run_id ON ort_server.advisor_runs_identifiers USING btree (advisor_run_id);


--
-- Name: analyzer_jobs_durations; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX analyzer_jobs_durations ON ort_server.analyzer_jobs USING btree (status, started_at, finished_at);


--
-- Name: analyzer_runs_analyzer_job_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX analyzer_runs_analyzer_job_id ON ort_server.analyzer_runs USING btree (analyzer_job_id);


--
-- Name: copyright_findings_scan_summary_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX copyright_findings_scan_summary_id ON ort_server.copyright_findings USING btree (scan_summary_id);


--
-- Name: declared_license_mappings_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX declared_license_mappings_all_value_columns ON ort_server.declared_license_mappings USING btree (license, spdx_license);


--
-- Name: defects_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX defects_all_value_columns ON ort_server.defects USING btree (external_id, url, title, state, severity, creation_time, modification_time, closing_time, fix_release_version, fix_release_url);


--
-- Name: environments_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX environments_all_value_columns ON ort_server.environments USING btree (ort_version, java_version, os, processors, max_memory);


--
-- Name: evaluator_jobs_durations; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX evaluator_jobs_durations ON ort_server.evaluator_jobs USING btree (status, started_at, finished_at);


--
-- Name: evaluator_runs_evaluator_job_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX evaluator_runs_evaluator_job_id ON ort_server.evaluator_runs USING btree (evaluator_job_id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON ort_server.flyway_schema_history USING btree (success);


--
-- Name: idx_path_includes_compound; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX idx_path_includes_compound ON ort_server.path_includes USING btree (pattern, reason, comment);


--
-- Name: infrastructure_service_declarations_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX infrastructure_service_declarations_all_value_columns ON ort_server.infrastructure_service_declarations USING btree (name, url, description, credentials_type, username_secret, password_secret);


--
-- Name: infrastructure_service_declarations_name; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX infrastructure_service_declarations_name ON ort_server.infrastructure_service_declarations USING btree (name);


--
-- Name: infrastructure_services_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX infrastructure_services_all_value_columns ON ort_server.infrastructure_services USING btree (name, url, description, username_secret_id, password_secret_id, credentials_type, organization_id, product_id, repository_id);


--
-- Name: issue_resolutions_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX issue_resolutions_all_value_columns ON ort_server.issue_resolutions USING btree (message, reason, comment);


--
-- Name: issues_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE UNIQUE INDEX issues_all_value_columns ON ort_server.issues USING btree (source, severity, affected_path, ort_server.digest(message, 'sha256'::text));


--
-- Name: license_finding_curations_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX license_finding_curations_all_value_columns ON ort_server.license_finding_curations USING btree (path, start_lines, line_count, detected_license, concluded_license, reason, comment);


--
-- Name: license_findings_scan_summary_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX license_findings_scan_summary_id ON ort_server.license_findings USING btree (scan_summary_id);


--
-- Name: notifier_jobs_durations; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX notifier_jobs_durations ON ort_server.notifier_jobs USING btree (status, started_at, finished_at);


--
-- Name: notifier_runs_notifier_job_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX notifier_runs_notifier_job_id ON ort_server.notifier_runs USING btree (notifier_job_id);


--
-- Name: organizations_name; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX organizations_name ON ort_server.organizations USING btree (name);


--
-- Name: ort_runs_created_at; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX ort_runs_created_at ON ort_server.ort_runs USING btree (created_at);


--
-- Name: ort_runs_durations; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX ort_runs_durations ON ort_server.ort_runs USING btree (status, finished_at);


--
-- Name: ort_runs_issues_fkey; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX ort_runs_issues_fkey ON ort_server.ort_runs_issues USING btree (issue_id);


--
-- Name: ort_runs_issues_ort_run_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX ort_runs_issues_ort_run_id ON ort_server.ort_runs_issues USING btree (ort_run_id);


--
-- Name: ort_runs_revision; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX ort_runs_revision ON ort_server.ort_runs USING btree (revision);


--
-- Name: package_configurations_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX package_configurations_all_value_columns ON ort_server.package_configurations USING btree (identifier_id, vcs_matcher_id, source_artifact_url);


--
-- Name: package_curation_data_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX package_curation_data_all_value_columns ON ort_server.package_curation_data USING btree (comment, purl, cpe, concluded_license, description, homepage_url, is_metadata_only, is_modified);


--
-- Name: package_provenances_identifier_id_artifact_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX package_provenances_identifier_id_artifact_id ON ort_server.package_provenances USING btree (identifier_id, artifact_id);


--
-- Name: package_provenances_identifier_id_vcs_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX package_provenances_identifier_id_vcs_id ON ort_server.package_provenances USING btree (identifier_id, vcs_id);


--
-- Name: package_provenances_vcs_id_resolved_revision_has_only_fixed_rev; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX package_provenances_vcs_id_resolved_revision_has_only_fixed_rev ON ort_server.nested_provenances USING btree (root_vcs_id, root_resolved_revision, has_only_fixed_revisions);


--
-- Name: packages_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX packages_all_value_columns ON ort_server.packages USING btree (purl, cpe, description, homepage_url, is_metadata_only, is_modified);


--
-- Name: packages_analyzer_runs_analyzer_run_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX packages_analyzer_runs_analyzer_run_id ON ort_server.packages_analyzer_runs USING btree (analyzer_run_id);


--
-- Name: packages_analyzer_runs_analyzer_run_id_package_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX packages_analyzer_runs_analyzer_run_id_package_id ON ort_server.packages_analyzer_runs USING btree (analyzer_run_id, package_id);


--
-- Name: packages_analyzer_runs_package_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX packages_analyzer_runs_package_id ON ort_server.packages_analyzer_runs USING btree (package_id);


--
-- Name: packages_authors_package_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX packages_authors_package_id ON ort_server.packages_authors USING btree (package_id);


--
-- Name: packages_declared_licenses_package_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX packages_declared_licenses_package_id ON ort_server.packages_declared_licenses USING btree (package_id);


--
-- Name: path_excludes_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX path_excludes_all_value_columns ON ort_server.path_excludes USING btree (pattern, reason, comment);


--
-- Name: processed_declared_licenses_package_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX processed_declared_licenses_package_id ON ort_server.processed_declared_licenses USING btree (package_id);


--
-- Name: processed_declared_licenses_project_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX processed_declared_licenses_project_id ON ort_server.processed_declared_licenses USING btree (project_id);


--
-- Name: products_name; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX products_name ON ort_server.products USING btree (name);


--
-- Name: project_scopes_project_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX project_scopes_project_id ON ort_server.project_scopes USING btree (project_id);


--
-- Name: projects_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX projects_all_value_columns ON ort_server.projects USING btree (homepage_url, definition_file_path, cpe);


--
-- Name: projects_analyzer_runs_analyzer_run_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX projects_analyzer_runs_analyzer_run_id ON ort_server.projects_analyzer_runs USING btree (analyzer_run_id);


--
-- Name: projects_analyzer_runs_package_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX projects_analyzer_runs_package_id ON ort_server.projects_analyzer_runs USING btree (project_id);


--
-- Name: projects_authors_project_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX projects_authors_project_id ON ort_server.projects_authors USING btree (project_id);


--
-- Name: projects_declared_licenses_project_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX projects_declared_licenses_project_id ON ort_server.projects_declared_licenses USING btree (project_id);


--
-- Name: provenance_snippet_choices_idx; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX provenance_snippet_choices_idx ON ort_server.provenance_snippet_choices USING btree (provenance);


--
-- Name: reporter_jobs_durations; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX reporter_jobs_durations ON ort_server.reporter_jobs USING btree (status, started_at, finished_at);


--
-- Name: reporter_runs_reporter_job_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX reporter_runs_reporter_job_id ON ort_server.reporter_runs USING btree (reporter_job_id);


--
-- Name: repositories_type; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX repositories_type ON ort_server.repositories USING btree (type);


--
-- Name: repositories_url; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX repositories_url ON ort_server.repositories USING btree (url);


--
-- Name: repository_analyzer_configurations_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX repository_analyzer_configurations_all_value_columns ON ort_server.repository_analyzer_configurations USING btree (allow_dynamic_versions, enabled_package_managers, disabled_package_managers, skip_excluded);


--
-- Name: rule_violation_resolutions_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX rule_violation_resolutions_all_value_columns ON ort_server.rule_violation_resolutions USING btree (message, reason, comment);


--
-- Name: rule_violations_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX rule_violations_all_value_columns ON ort_server.rule_violations USING btree (rule, identifier_id, license, license_source, severity);


--
-- Name: scan_results_artifact_url_artifact_hash_artifact_hash_algor_idx; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE UNIQUE INDEX scan_results_artifact_url_artifact_hash_artifact_hash_algor_idx ON ort_server.scan_results USING btree (artifact_url, artifact_hash, artifact_hash_algorithm, scanner_name, scanner_version, scanner_configuration, jsonb_hash_extended(additional_data, (0)::bigint));


--
-- Name: scan_results_vcs_type_vcs_url_vcs_revision_scanner_name_sca_idx; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE UNIQUE INDEX scan_results_vcs_type_vcs_url_vcs_revision_scanner_name_sca_idx ON ort_server.scan_results USING btree (vcs_type, vcs_url, vcs_revision, scanner_name, scanner_version, scanner_configuration, jsonb_hash_extended(additional_data, (0)::bigint));


--
-- Name: scan_results_with_artifact_provenance; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX scan_results_with_artifact_provenance ON ort_server.scan_results USING btree (artifact_url, artifact_hash, scanner_name, scanner_version, scanner_configuration);


--
-- Name: scan_results_with_repository_provenance; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX scan_results_with_repository_provenance ON ort_server.scan_results USING btree (vcs_type, vcs_url, vcs_revision, scanner_name, scanner_version, scanner_configuration);


--
-- Name: scan_summaries_issues_fkey; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX scan_summaries_issues_fkey ON ort_server.scan_summaries_issues USING btree (issue_id);


--
-- Name: scan_summaries_issues_scan_summary_id_idx; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX scan_summaries_issues_scan_summary_id_idx ON ort_server.scan_summaries_issues USING btree (scan_summary_id);


--
-- Name: scanner_jobs_durations; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX scanner_jobs_durations ON ort_server.scanner_jobs USING btree (status, started_at, finished_at);


--
-- Name: scanner_runs_scanner_job_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX scanner_runs_scanner_job_id ON ort_server.scanner_runs USING btree (scanner_job_id);


--
-- Name: scanner_runs_scanners_run_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX scanner_runs_scanners_run_id ON ort_server.scanner_runs_scanners USING btree (scanner_run_id);


--
-- Name: scope_excludes_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX scope_excludes_all_value_columns ON ort_server.scope_excludes USING btree (pattern, reason, comment);


--
-- Name: secrets_name; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX secrets_name ON ort_server.secrets USING btree (name);


--
-- Name: shortest_dependency_paths_analyzer_run_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX shortest_dependency_paths_analyzer_run_id ON ort_server.shortest_dependency_paths USING btree (analyzer_run_id);


--
-- Name: shortest_dependency_paths_package_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX shortest_dependency_paths_package_id ON ort_server.shortest_dependency_paths USING btree (package_id);


--
-- Name: shortest_dependency_paths_project_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX shortest_dependency_paths_project_id ON ort_server.shortest_dependency_paths USING btree (project_id);


--
-- Name: snippet_findings_scan_summary_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX snippet_findings_scan_summary_id ON ort_server.snippet_findings USING btree (scan_summary_id);


--
-- Name: snippet_findings_snippets_snippet_finding_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX snippet_findings_snippets_snippet_finding_id ON ort_server.snippet_findings_snippets USING btree (snippet_finding_id);


--
-- Name: snippet_findings_snippets_snippet_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX snippet_findings_snippets_snippet_id ON ort_server.snippet_findings_snippets USING btree (snippet_id);


--
-- Name: spdx_license_choices_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX spdx_license_choices_all_value_columns ON ort_server.spdx_license_choices USING btree (given, choice);


--
-- Name: vcs_info_curation_data_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX vcs_info_curation_data_all_value_columns ON ort_server.vcs_info_curation_data USING btree (type, url, revision, path);


--
-- Name: vcs_matchers_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX vcs_matchers_all_value_columns ON ort_server.vcs_matchers USING btree (type, url, revision);


--
-- Name: vulnerabilities_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX vulnerabilities_all_value_columns ON ort_server.vulnerabilities USING btree (external_id, summary);


--
-- Name: vulnerability_references_vulnerability_id; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX vulnerability_references_vulnerability_id ON ort_server.vulnerability_references USING btree (vulnerability_id);


--
-- Name: vulnerability_resolutions_all_value_columns; Type: INDEX; Schema: ort_server; Owner: postgres
--

CREATE INDEX vulnerability_resolutions_all_value_columns ON ort_server.vulnerability_resolutions USING btree (external_id, reason, comment);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: advisor_configurations advisor_configurations_advisor_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configurations
    ADD CONSTRAINT advisor_configurations_advisor_run_id_fkey FOREIGN KEY (advisor_run_id) REFERENCES ort_server.advisor_runs(id) ON DELETE CASCADE;


--
-- Name: advisor_configurations_options advisor_configurations_option_advisor_configuration_option_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configurations_options
    ADD CONSTRAINT advisor_configurations_option_advisor_configuration_option_fkey FOREIGN KEY (advisor_configuration_option_id) REFERENCES ort_server.advisor_configuration_options(id);


--
-- Name: advisor_configurations_options advisor_configurations_options_advisor_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configurations_options
    ADD CONSTRAINT advisor_configurations_options_advisor_configuration_id_fkey FOREIGN KEY (advisor_configuration_id) REFERENCES ort_server.advisor_configurations(id) ON DELETE CASCADE;


--
-- Name: advisor_configurations_secrets advisor_configurations_secret_advisor_configuration_secret_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configurations_secrets
    ADD CONSTRAINT advisor_configurations_secret_advisor_configuration_secret_fkey FOREIGN KEY (advisor_configuration_secret_id) REFERENCES ort_server.advisor_configuration_secrets(id);


--
-- Name: advisor_configurations_secrets advisor_configurations_secrets_advisor_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_configurations_secrets
    ADD CONSTRAINT advisor_configurations_secrets_advisor_configuration_id_fkey FOREIGN KEY (advisor_configuration_id) REFERENCES ort_server.advisor_configurations(id) ON DELETE CASCADE;


--
-- Name: advisor_jobs advisor_jobs_ort_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_jobs
    ADD CONSTRAINT advisor_jobs_ort_run_id_fkey FOREIGN KEY (ort_run_id) REFERENCES ort_server.ort_runs(id) ON DELETE CASCADE;


--
-- Name: advisor_results advisor_results_advisor_run_identifier_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_results
    ADD CONSTRAINT advisor_results_advisor_run_identifier_id_fkey FOREIGN KEY (advisor_run_identifier_id) REFERENCES ort_server.advisor_runs_identifiers(id) ON DELETE CASCADE;


--
-- Name: advisor_results_defects advisor_results_defects_advisor_result_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_results_defects
    ADD CONSTRAINT advisor_results_defects_advisor_result_id_fkey FOREIGN KEY (advisor_result_id) REFERENCES ort_server.advisor_results(id) ON DELETE CASCADE;


--
-- Name: advisor_results_defects advisor_results_defects_defect_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_results_defects
    ADD CONSTRAINT advisor_results_defects_defect_id_fkey FOREIGN KEY (defect_id) REFERENCES ort_server.defects(id);


--
-- Name: advisor_results_vulnerabilities advisor_results_vulnerabilities_advisor_result_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_results_vulnerabilities
    ADD CONSTRAINT advisor_results_vulnerabilities_advisor_result_id_fkey FOREIGN KEY (advisor_result_id) REFERENCES ort_server.advisor_results(id) ON DELETE CASCADE;


--
-- Name: advisor_results_vulnerabilities advisor_results_vulnerabilities_vulnerability_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_results_vulnerabilities
    ADD CONSTRAINT advisor_results_vulnerabilities_vulnerability_id_fkey FOREIGN KEY (vulnerability_id) REFERENCES ort_server.vulnerabilities(id);


--
-- Name: advisor_runs advisor_runs_advisor_job_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_runs
    ADD CONSTRAINT advisor_runs_advisor_job_id_fkey FOREIGN KEY (advisor_job_id) REFERENCES ort_server.advisor_jobs(id) ON DELETE CASCADE;


--
-- Name: advisor_runs advisor_runs_environment_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_runs
    ADD CONSTRAINT advisor_runs_environment_id_fkey FOREIGN KEY (environment_id) REFERENCES ort_server.environments(id);


--
-- Name: advisor_runs_identifiers advisor_runs_identifiers_advisor_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_runs_identifiers
    ADD CONSTRAINT advisor_runs_identifiers_advisor_run_id_fkey FOREIGN KEY (advisor_run_id) REFERENCES ort_server.advisor_runs(id) ON DELETE CASCADE;


--
-- Name: advisor_runs_identifiers advisor_runs_identifiers_identifier_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.advisor_runs_identifiers
    ADD CONSTRAINT advisor_runs_identifiers_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES ort_server.identifiers(id);


--
-- Name: analyzer_configurations analyzer_configurations_analyzer_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_configurations
    ADD CONSTRAINT analyzer_configurations_analyzer_run_id_fkey FOREIGN KEY (analyzer_run_id) REFERENCES ort_server.analyzer_runs(id) ON DELETE CASCADE;


--
-- Name: analyzer_configurations_package_manager_configurations analyzer_configurations_packa_package_manager_configuratio_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_configurations_package_manager_configurations
    ADD CONSTRAINT analyzer_configurations_packa_package_manager_configuratio_fkey FOREIGN KEY (package_manager_configuration_id) REFERENCES ort_server.package_manager_configurations(id);


--
-- Name: analyzer_configurations_package_manager_configurations analyzer_configurations_package__analyzer_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_configurations_package_manager_configurations
    ADD CONSTRAINT analyzer_configurations_package__analyzer_configuration_id_fkey FOREIGN KEY (analyzer_configuration_id) REFERENCES ort_server.analyzer_configurations(id) ON DELETE CASCADE;


--
-- Name: analyzer_jobs analyzer_jobs_ort_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_jobs
    ADD CONSTRAINT analyzer_jobs_ort_run_id_fkey FOREIGN KEY (ort_run_id) REFERENCES ort_server.ort_runs(id) ON DELETE CASCADE;


--
-- Name: analyzer_runs analyzer_runs_analyzer_job_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_runs
    ADD CONSTRAINT analyzer_runs_analyzer_job_id_fkey FOREIGN KEY (analyzer_job_id) REFERENCES ort_server.analyzer_jobs(id) ON DELETE CASCADE;


--
-- Name: analyzer_runs analyzer_runs_environment_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.analyzer_runs
    ADD CONSTRAINT analyzer_runs_environment_id_fkey FOREIGN KEY (environment_id) REFERENCES ort_server.environments(id);


--
-- Name: copyright_findings copyright_findings_scan_summary_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.copyright_findings
    ADD CONSTRAINT copyright_findings_scan_summary_id_fkey FOREIGN KEY (scan_summary_id) REFERENCES ort_server.scan_summaries(id);


--
-- Name: defect_labels defect_labels_defect_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.defect_labels
    ADD CONSTRAINT defect_labels_defect_id_fkey FOREIGN KEY (defect_id) REFERENCES ort_server.defects(id);


--
-- Name: environments_variables environments_variables_environment_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.environments_variables
    ADD CONSTRAINT environments_variables_environment_id_fkey FOREIGN KEY (environment_id) REFERENCES ort_server.environments(id);


--
-- Name: environments_variables environments_variables_variable_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.environments_variables
    ADD CONSTRAINT environments_variables_variable_id_fkey FOREIGN KEY (variable_id) REFERENCES ort_server.variables(id);


--
-- Name: evaluator_jobs evaluator_jobs_ort_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.evaluator_jobs
    ADD CONSTRAINT evaluator_jobs_ort_run_id_fkey FOREIGN KEY (ort_run_id) REFERENCES ort_server.ort_runs(id) ON DELETE CASCADE;


--
-- Name: evaluator_runs evaluator_runs_evaluator_job_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.evaluator_runs
    ADD CONSTRAINT evaluator_runs_evaluator_job_id_fkey FOREIGN KEY (evaluator_job_id) REFERENCES ort_server.evaluator_jobs(id) ON DELETE CASCADE;


--
-- Name: evaluator_runs_rule_violations evaluator_runs_rule_violations_evaluator_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.evaluator_runs_rule_violations
    ADD CONSTRAINT evaluator_runs_rule_violations_evaluator_run_id_fkey FOREIGN KEY (evaluator_run_id) REFERENCES ort_server.evaluator_runs(id) ON DELETE CASCADE;


--
-- Name: evaluator_runs_rule_violations evaluator_runs_rule_violations_rule_violation_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.evaluator_runs_rule_violations
    ADD CONSTRAINT evaluator_runs_rule_violations_rule_violation_id_fkey FOREIGN KEY (rule_violation_id) REFERENCES ort_server.rule_violations(id);


--
-- Name: repository_configurations_path_includes fk_repository_configurations_path_includes_config_id; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_path_includes
    ADD CONSTRAINT fk_repository_configurations_path_includes_config_id FOREIGN KEY (repository_configuration_id) REFERENCES ort_server.repository_configurations(id);


--
-- Name: repository_configurations_path_includes fk_repository_configurations_path_includes_include_id; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_path_includes
    ADD CONSTRAINT fk_repository_configurations_path_includes_include_id FOREIGN KEY (path_include_id) REFERENCES ort_server.path_includes(id);


--
-- Name: identifiers_issues_hashes identifiers_issues_hashes_identifier_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.identifiers_issues_hashes
    ADD CONSTRAINT identifiers_issues_hashes_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES ort_server.identifiers(id);


--
-- Name: identifiers_issues identifiers_ort_issues_identifier_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.identifiers_issues
    ADD CONSTRAINT identifiers_ort_issues_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES ort_server.identifiers(id);


--
-- Name: identifiers_issues identifiers_ort_issues_ort_issue_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.identifiers_issues
    ADD CONSTRAINT identifiers_ort_issues_ort_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES ort_server.issues(id);


--
-- Name: infrastructure_service_declarations_ort_runs infrastructure_service_declar_infrastructure_service_decla_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.infrastructure_service_declarations_ort_runs
    ADD CONSTRAINT infrastructure_service_declar_infrastructure_service_decla_fkey FOREIGN KEY (infrastructure_service_declaration_id) REFERENCES ort_server.infrastructure_service_declarations(id);


--
-- Name: infrastructure_service_declarations_ort_runs infrastructure_service_declarations_ort_runs_ort_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.infrastructure_service_declarations_ort_runs
    ADD CONSTRAINT infrastructure_service_declarations_ort_runs_ort_run_id_fkey FOREIGN KEY (ort_run_id) REFERENCES ort_server.ort_runs(id);


--
-- Name: infrastructure_services infrastructure_services_organization_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.infrastructure_services
    ADD CONSTRAINT infrastructure_services_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES ort_server.organizations(id);


--
-- Name: infrastructure_services infrastructure_services_password_secret_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.infrastructure_services
    ADD CONSTRAINT infrastructure_services_password_secret_id_fkey FOREIGN KEY (password_secret_id) REFERENCES ort_server.secrets(id);


--
-- Name: infrastructure_services infrastructure_services_product_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.infrastructure_services
    ADD CONSTRAINT infrastructure_services_product_id_fkey FOREIGN KEY (product_id) REFERENCES ort_server.products(id);


--
-- Name: infrastructure_services infrastructure_services_repository_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.infrastructure_services
    ADD CONSTRAINT infrastructure_services_repository_id_fkey FOREIGN KEY (repository_id) REFERENCES ort_server.repositories(id);


--
-- Name: infrastructure_services infrastructure_services_username_secret_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.infrastructure_services
    ADD CONSTRAINT infrastructure_services_username_secret_id_fkey FOREIGN KEY (username_secret_id) REFERENCES ort_server.secrets(id);


--
-- Name: license_findings license_findings_scan_summary_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.license_findings
    ADD CONSTRAINT license_findings_scan_summary_id_fkey FOREIGN KEY (scan_summary_id) REFERENCES ort_server.scan_summaries(id);


--
-- Name: nested_provenance_sub_repositories nested_provenance_sub_repositories_nested_provenance_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.nested_provenance_sub_repositories
    ADD CONSTRAINT nested_provenance_sub_repositories_nested_provenance_id_fkey FOREIGN KEY (nested_provenance_id) REFERENCES ort_server.nested_provenances(id);


--
-- Name: nested_provenance_sub_repositories nested_provenance_sub_repositories_vcs_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.nested_provenance_sub_repositories
    ADD CONSTRAINT nested_provenance_sub_repositories_vcs_id_fkey FOREIGN KEY (vcs_id) REFERENCES ort_server.vcs_info(id);


--
-- Name: nested_provenances nested_provenances_root_vcs_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.nested_provenances
    ADD CONSTRAINT nested_provenances_root_vcs_id_fkey FOREIGN KEY (root_vcs_id) REFERENCES ort_server.vcs_info(id);


--
-- Name: nested_repositories nested_repositories_ort_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.nested_repositories
    ADD CONSTRAINT nested_repositories_ort_run_id_fkey FOREIGN KEY (ort_run_id) REFERENCES ort_server.ort_runs(id) ON DELETE CASCADE;


--
-- Name: nested_repositories nested_repositories_vcs_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.nested_repositories
    ADD CONSTRAINT nested_repositories_vcs_id_fkey FOREIGN KEY (vcs_id) REFERENCES ort_server.vcs_info(id);


--
-- Name: notifier_jobs notifier_jobs_ort_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.notifier_jobs
    ADD CONSTRAINT notifier_jobs_ort_run_id_fkey FOREIGN KEY (ort_run_id) REFERENCES ort_server.ort_runs(id) ON DELETE CASCADE;


--
-- Name: notifier_runs notifier_runs_notifier_job_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.notifier_runs
    ADD CONSTRAINT notifier_runs_notifier_job_id_fkey FOREIGN KEY (notifier_job_id) REFERENCES ort_server.notifier_jobs(id) ON DELETE CASCADE;


--
-- Name: ort_runs_issues ort_runs_issues2_identifier_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs_issues
    ADD CONSTRAINT ort_runs_issues2_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES ort_server.identifiers(id);


--
-- Name: ort_runs_issues ort_runs_issues2_issue_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs_issues
    ADD CONSTRAINT ort_runs_issues2_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES ort_server.issues(id);


--
-- Name: ort_runs_issues ort_runs_issues2_ort_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs_issues
    ADD CONSTRAINT ort_runs_issues2_ort_run_id_fkey FOREIGN KEY (ort_run_id) REFERENCES ort_server.ort_runs(id) ON DELETE CASCADE;


--
-- Name: ort_runs_labels ort_runs_labels_label_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs_labels
    ADD CONSTRAINT ort_runs_labels_label_id_fkey FOREIGN KEY (label_id) REFERENCES ort_server.labels(id);


--
-- Name: ort_runs_labels ort_runs_labels_ort_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs_labels
    ADD CONSTRAINT ort_runs_labels_ort_run_id_fkey FOREIGN KEY (ort_run_id) REFERENCES ort_server.ort_runs(id) ON DELETE CASCADE;


--
-- Name: ort_runs ort_runs_repository_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs
    ADD CONSTRAINT ort_runs_repository_id_fkey FOREIGN KEY (repository_id) REFERENCES ort_server.repositories(id);


--
-- Name: ort_runs ort_runs_vcs_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs
    ADD CONSTRAINT ort_runs_vcs_id_fkey FOREIGN KEY (vcs_id) REFERENCES ort_server.vcs_info(id);


--
-- Name: ort_runs ort_runs_vcs_processed_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.ort_runs
    ADD CONSTRAINT ort_runs_vcs_processed_id_fkey FOREIGN KEY (vcs_processed_id) REFERENCES ort_server.vcs_info(id);


--
-- Name: package_configurations package_configurations_identifier_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_configurations
    ADD CONSTRAINT package_configurations_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES ort_server.identifiers(id);


--
-- Name: package_configurations_license_finding_curations package_configurations_license_fi_package_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_configurations_license_finding_curations
    ADD CONSTRAINT package_configurations_license_fi_package_configuration_id_fkey FOREIGN KEY (package_configuration_id) REFERENCES ort_server.package_configurations(id);


--
-- Name: package_configurations_license_finding_curations package_configurations_license_license_finding_curation_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_configurations_license_finding_curations
    ADD CONSTRAINT package_configurations_license_license_finding_curation_id_fkey FOREIGN KEY (license_finding_curation_id) REFERENCES ort_server.license_finding_curations(id);


--
-- Name: package_configurations_path_excludes package_configurations_path_exclu_package_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_configurations_path_excludes
    ADD CONSTRAINT package_configurations_path_exclu_package_configuration_id_fkey FOREIGN KEY (package_configuration_id) REFERENCES ort_server.package_configurations(id);


--
-- Name: package_configurations_path_excludes package_configurations_path_excludes_path_exclude_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_configurations_path_excludes
    ADD CONSTRAINT package_configurations_path_excludes_path_exclude_id_fkey FOREIGN KEY (path_exclude_id) REFERENCES ort_server.path_excludes(id);


--
-- Name: package_configurations package_configurations_vcs_matcher_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_configurations
    ADD CONSTRAINT package_configurations_vcs_matcher_id_fkey FOREIGN KEY (vcs_matcher_id) REFERENCES ort_server.vcs_matchers(id);


--
-- Name: package_curation_data_authors package_curation_data_authors_author_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_data_authors
    ADD CONSTRAINT package_curation_data_authors_author_id_fkey FOREIGN KEY (author_id) REFERENCES ort_server.authors(id);


--
-- Name: package_curation_data_authors package_curation_data_authors_package_curation_data_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_data_authors
    ADD CONSTRAINT package_curation_data_authors_package_curation_data_id_fkey FOREIGN KEY (package_curation_data_id) REFERENCES ort_server.package_curation_data(id);


--
-- Name: package_curation_data package_curation_data_binary_artifact_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_data
    ADD CONSTRAINT package_curation_data_binary_artifact_id_fkey FOREIGN KEY (binary_artifact_id) REFERENCES ort_server.remote_artifacts(id);


--
-- Name: package_curation_data_declared_license_mappings package_curation_data_declared_declared_license_mapping_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_data_declared_license_mappings
    ADD CONSTRAINT package_curation_data_declared_declared_license_mapping_id_fkey FOREIGN KEY (declared_license_mapping_id) REFERENCES ort_server.declared_license_mappings(id);


--
-- Name: package_curation_data_declared_license_mappings package_curation_data_declared_li_package_curation_data_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_data_declared_license_mappings
    ADD CONSTRAINT package_curation_data_declared_li_package_curation_data_id_fkey FOREIGN KEY (package_curation_data_id) REFERENCES ort_server.package_curation_data(id);


--
-- Name: package_curation_data package_curation_data_source_artifact_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_data
    ADD CONSTRAINT package_curation_data_source_artifact_id_fkey FOREIGN KEY (source_artifact_id) REFERENCES ort_server.remote_artifacts(id);


--
-- Name: package_curation_data package_curation_data_vcs_info_curation_data_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curation_data
    ADD CONSTRAINT package_curation_data_vcs_info_curation_data_id_fkey FOREIGN KEY (vcs_info_curation_data_id) REFERENCES ort_server.vcs_info_curation_data(id);


--
-- Name: package_curations package_curations_identifier_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curations
    ADD CONSTRAINT package_curations_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES ort_server.identifiers(id);


--
-- Name: package_curations package_curations_package_curation_data_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_curations
    ADD CONSTRAINT package_curations_package_curation_data_id_fkey FOREIGN KEY (package_curation_data_id) REFERENCES ort_server.package_curation_data(id);


--
-- Name: package_license_choices package_license_choices_identifier_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_license_choices
    ADD CONSTRAINT package_license_choices_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES ort_server.identifiers(id);


--
-- Name: package_license_choices_spdx_license_choices package_license_choices_spdx_lic_package_license_choice_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_license_choices_spdx_license_choices
    ADD CONSTRAINT package_license_choices_spdx_lic_package_license_choice_id_fkey FOREIGN KEY (package_license_choice_id) REFERENCES ort_server.package_license_choices(id);


--
-- Name: package_license_choices_spdx_license_choices package_license_choices_spdx_licens_spdx_license_choice_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_license_choices_spdx_license_choices
    ADD CONSTRAINT package_license_choices_spdx_licens_spdx_license_choice_id_fkey FOREIGN KEY (spdx_license_choice_id) REFERENCES ort_server.spdx_license_choices(id);


--
-- Name: package_manager_configuration_options package_manager_configuration_package_manager_configuratio_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_manager_configuration_options
    ADD CONSTRAINT package_manager_configuration_package_manager_configuratio_fkey FOREIGN KEY (package_manager_configuration_id) REFERENCES ort_server.package_manager_configurations(id);


--
-- Name: package_provenances package_provenances_artifact_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_provenances
    ADD CONSTRAINT package_provenances_artifact_id_fkey FOREIGN KEY (artifact_id) REFERENCES ort_server.remote_artifacts(id);


--
-- Name: package_provenances package_provenances_identifier_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_provenances
    ADD CONSTRAINT package_provenances_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES ort_server.identifiers(id);


--
-- Name: package_provenances package_provenances_nested_provenance_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_provenances
    ADD CONSTRAINT package_provenances_nested_provenance_id_fkey FOREIGN KEY (nested_provenance_id) REFERENCES ort_server.nested_provenances(id);


--
-- Name: package_provenances package_provenances_vcs_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.package_provenances
    ADD CONSTRAINT package_provenances_vcs_id_fkey FOREIGN KEY (vcs_id) REFERENCES ort_server.vcs_info(id);


--
-- Name: packages_analyzer_runs packages_analyzer_runs_analyzer_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages_analyzer_runs
    ADD CONSTRAINT packages_analyzer_runs_analyzer_run_id_fkey FOREIGN KEY (analyzer_run_id) REFERENCES ort_server.analyzer_runs(id) ON DELETE CASCADE;


--
-- Name: packages_analyzer_runs packages_analyzer_runs_package_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages_analyzer_runs
    ADD CONSTRAINT packages_analyzer_runs_package_id_fkey FOREIGN KEY (package_id) REFERENCES ort_server.packages(id);


--
-- Name: packages_authors packages_authors_author_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages_authors
    ADD CONSTRAINT packages_authors_author_id_fkey FOREIGN KEY (author_id) REFERENCES ort_server.authors(id);


--
-- Name: packages_authors packages_authors_package_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages_authors
    ADD CONSTRAINT packages_authors_package_id_fkey FOREIGN KEY (package_id) REFERENCES ort_server.packages(id) ON DELETE CASCADE;


--
-- Name: packages packages_binary_artifact_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages
    ADD CONSTRAINT packages_binary_artifact_id_fkey FOREIGN KEY (binary_artifact_id) REFERENCES ort_server.remote_artifacts(id);


--
-- Name: packages_declared_licenses packages_declared_licenses_declared_license_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages_declared_licenses
    ADD CONSTRAINT packages_declared_licenses_declared_license_id_fkey FOREIGN KEY (declared_license_id) REFERENCES ort_server.declared_licenses(id);


--
-- Name: packages_declared_licenses packages_declared_licenses_package_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages_declared_licenses
    ADD CONSTRAINT packages_declared_licenses_package_id_fkey FOREIGN KEY (package_id) REFERENCES ort_server.packages(id) ON DELETE CASCADE;


--
-- Name: packages packages_identifier_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages
    ADD CONSTRAINT packages_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES ort_server.identifiers(id);


--
-- Name: packages packages_source_artifact_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages
    ADD CONSTRAINT packages_source_artifact_id_fkey FOREIGN KEY (source_artifact_id) REFERENCES ort_server.remote_artifacts(id);


--
-- Name: packages packages_vcs_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages
    ADD CONSTRAINT packages_vcs_id_fkey FOREIGN KEY (vcs_id) REFERENCES ort_server.vcs_info(id);


--
-- Name: packages packages_vcs_processed_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.packages
    ADD CONSTRAINT packages_vcs_processed_id_fkey FOREIGN KEY (vcs_processed_id) REFERENCES ort_server.vcs_info(id);


--
-- Name: processed_declared_licenses_mapped_declared_licenses processed_declared_licenses_m_processed_declared_license_i_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.processed_declared_licenses_mapped_declared_licenses
    ADD CONSTRAINT processed_declared_licenses_m_processed_declared_license_i_fkey FOREIGN KEY (processed_declared_license_id) REFERENCES ort_server.processed_declared_licenses(id) ON DELETE CASCADE;


--
-- Name: processed_declared_licenses_mapped_declared_licenses processed_declared_licenses_map_mapped_declared_license_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.processed_declared_licenses_mapped_declared_licenses
    ADD CONSTRAINT processed_declared_licenses_map_mapped_declared_license_id_fkey FOREIGN KEY (mapped_declared_license_id) REFERENCES ort_server.mapped_declared_licenses(id);


--
-- Name: processed_declared_licenses processed_declared_licenses_package_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.processed_declared_licenses
    ADD CONSTRAINT processed_declared_licenses_package_id_fkey FOREIGN KEY (package_id) REFERENCES ort_server.packages(id) ON DELETE CASCADE;


--
-- Name: processed_declared_licenses processed_declared_licenses_project_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.processed_declared_licenses
    ADD CONSTRAINT processed_declared_licenses_project_id_fkey FOREIGN KEY (project_id) REFERENCES ort_server.projects(id) ON DELETE CASCADE;


--
-- Name: processed_declared_licenses_unmapped_declared_licenses processed_declared_licenses_u_processed_declared_license_i_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.processed_declared_licenses_unmapped_declared_licenses
    ADD CONSTRAINT processed_declared_licenses_u_processed_declared_license_i_fkey FOREIGN KEY (processed_declared_license_id) REFERENCES ort_server.processed_declared_licenses(id) ON DELETE CASCADE;


--
-- Name: processed_declared_licenses_unmapped_declared_licenses processed_declared_licenses_u_unmapped_declared_license_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.processed_declared_licenses_unmapped_declared_licenses
    ADD CONSTRAINT processed_declared_licenses_u_unmapped_declared_license_id_fkey FOREIGN KEY (unmapped_declared_license_id) REFERENCES ort_server.unmapped_declared_licenses(id);


--
-- Name: products products_organization_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.products
    ADD CONSTRAINT products_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES ort_server.organizations(id);


--
-- Name: project_scopes project_scopes_project_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.project_scopes
    ADD CONSTRAINT project_scopes_project_id_fkey FOREIGN KEY (project_id) REFERENCES ort_server.projects(id) ON DELETE CASCADE;


--
-- Name: projects_analyzer_runs projects_analyzer_runs_analyzer_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects_analyzer_runs
    ADD CONSTRAINT projects_analyzer_runs_analyzer_run_id_fkey FOREIGN KEY (analyzer_run_id) REFERENCES ort_server.analyzer_runs(id) ON DELETE CASCADE;


--
-- Name: projects_analyzer_runs projects_analyzer_runs_project_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects_analyzer_runs
    ADD CONSTRAINT projects_analyzer_runs_project_id_fkey FOREIGN KEY (project_id) REFERENCES ort_server.projects(id);


--
-- Name: projects_authors projects_authors_author_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects_authors
    ADD CONSTRAINT projects_authors_author_id_fkey FOREIGN KEY (author_id) REFERENCES ort_server.authors(id);


--
-- Name: projects_authors projects_authors_project_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects_authors
    ADD CONSTRAINT projects_authors_project_id_fkey FOREIGN KEY (project_id) REFERENCES ort_server.projects(id) ON DELETE CASCADE;


--
-- Name: projects_declared_licenses projects_declared_licenses_declared_license_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects_declared_licenses
    ADD CONSTRAINT projects_declared_licenses_declared_license_id_fkey FOREIGN KEY (declared_license_id) REFERENCES ort_server.declared_licenses(id);


--
-- Name: projects_declared_licenses projects_declared_licenses_project_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects_declared_licenses
    ADD CONSTRAINT projects_declared_licenses_project_id_fkey FOREIGN KEY (project_id) REFERENCES ort_server.projects(id) ON DELETE CASCADE;


--
-- Name: projects projects_identifier_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects
    ADD CONSTRAINT projects_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES ort_server.identifiers(id);


--
-- Name: projects projects_vcs_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects
    ADD CONSTRAINT projects_vcs_id_fkey FOREIGN KEY (vcs_id) REFERENCES ort_server.vcs_info(id);


--
-- Name: projects projects_vcs_processed_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.projects
    ADD CONSTRAINT projects_vcs_processed_id_fkey FOREIGN KEY (vcs_processed_id) REFERENCES ort_server.vcs_info(id);


--
-- Name: provenance_snippet_choices_snippet_choices provenance_snippet_choices_sn_provenance_snippet_choices_i_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.provenance_snippet_choices_snippet_choices
    ADD CONSTRAINT provenance_snippet_choices_sn_provenance_snippet_choices_i_fkey FOREIGN KEY (provenance_snippet_choices_id) REFERENCES ort_server.provenance_snippet_choices(id);


--
-- Name: provenance_snippet_choices_snippet_choices provenance_snippet_choices_snippet_choi_snippet_choices_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.provenance_snippet_choices_snippet_choices
    ADD CONSTRAINT provenance_snippet_choices_snippet_choi_snippet_choices_id_fkey FOREIGN KEY (snippet_choices_id) REFERENCES ort_server.snippet_choices(id);


--
-- Name: reporter_jobs reporter_jobs_ort_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.reporter_jobs
    ADD CONSTRAINT reporter_jobs_ort_run_id_fkey FOREIGN KEY (ort_run_id) REFERENCES ort_server.ort_runs(id) ON DELETE CASCADE;


--
-- Name: reporter_runs reporter_runs_reporter_job_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.reporter_runs
    ADD CONSTRAINT reporter_runs_reporter_job_id_fkey FOREIGN KEY (reporter_job_id) REFERENCES ort_server.reporter_jobs(id) ON DELETE CASCADE;


--
-- Name: reporter_runs_reports reporter_runs_reports_report_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.reporter_runs_reports
    ADD CONSTRAINT reporter_runs_reports_report_id_fkey FOREIGN KEY (report_id) REFERENCES ort_server.reports(id);


--
-- Name: reporter_runs_reports reporter_runs_reports_reporter_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.reporter_runs_reports
    ADD CONSTRAINT reporter_runs_reports_reporter_run_id_fkey FOREIGN KEY (reporter_run_id) REFERENCES ort_server.reporter_runs(id) ON DELETE CASCADE;


--
-- Name: repositories repositories_product_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repositories
    ADD CONSTRAINT repositories_product_id_fkey FOREIGN KEY (product_id) REFERENCES ort_server.products(id);


--
-- Name: repository_analyzer_configurations_package_manager_configuratio repository_analyzer_configura_package_manager_configuratio_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_analyzer_configurations_package_manager_configuratio
    ADD CONSTRAINT repository_analyzer_configura_package_manager_configuratio_fkey FOREIGN KEY (package_manager_configuration_id) REFERENCES ort_server.package_manager_configurations(id);


--
-- Name: repository_analyzer_configurations_package_manager_configuratio repository_analyzer_configura_repository_analyzer_configur_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_analyzer_configurations_package_manager_configuratio
    ADD CONSTRAINT repository_analyzer_configura_repository_analyzer_configur_fkey FOREIGN KEY (repository_analyzer_configuration_id) REFERENCES ort_server.repository_analyzer_configurations(id);


--
-- Name: repository_configurations_issue_resolutions repository_configurations_issu_repository_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_issue_resolutions
    ADD CONSTRAINT repository_configurations_issu_repository_configuration_id_fkey FOREIGN KEY (repository_configuration_id) REFERENCES ort_server.repository_configurations(id) ON DELETE CASCADE;


--
-- Name: repository_configurations_issue_resolutions repository_configurations_issue_resolu_issue_resolution_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_issue_resolutions
    ADD CONSTRAINT repository_configurations_issue_resolu_issue_resolution_id_fkey FOREIGN KEY (issue_resolution_id) REFERENCES ort_server.issue_resolutions(id);


--
-- Name: repository_configurations_license_finding_curations repository_configurations_lice_license_finding_curation_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_license_finding_curations
    ADD CONSTRAINT repository_configurations_lice_license_finding_curation_id_fkey FOREIGN KEY (license_finding_curation_id) REFERENCES ort_server.license_finding_curations(id);


--
-- Name: repository_configurations_license_finding_curations repository_configurations_lice_repository_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_license_finding_curations
    ADD CONSTRAINT repository_configurations_lice_repository_configuration_id_fkey FOREIGN KEY (repository_configuration_id) REFERENCES ort_server.repository_configurations(id) ON DELETE CASCADE;


--
-- Name: repository_configurations repository_configurations_ort_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations
    ADD CONSTRAINT repository_configurations_ort_run_id_fkey FOREIGN KEY (ort_run_id) REFERENCES ort_server.ort_runs(id) ON DELETE CASCADE;


--
-- Name: repository_configurations_package_license_choices repository_configurations_pac_license_choices_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_package_license_choices
    ADD CONSTRAINT repository_configurations_pac_license_choices_id_fkey FOREIGN KEY (repository_configuration_id) REFERENCES ort_server.repository_configurations(id) ON DELETE CASCADE;


--
-- Name: repository_configurations_package_configurations repository_configurations_pac_repository_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_package_configurations
    ADD CONSTRAINT repository_configurations_pac_repository_configuration_id_fkey FOREIGN KEY (repository_configuration_id) REFERENCES ort_server.repository_configurations(id) ON DELETE CASCADE;


--
-- Name: repository_configurations_package_curations repository_configurations_pack_repository_curation_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_package_curations
    ADD CONSTRAINT repository_configurations_pack_repository_curation_id_fkey FOREIGN KEY (repository_configuration_id) REFERENCES ort_server.repository_configurations(id) ON DELETE CASCADE;


--
-- Name: repository_configurations_package_license_choices repository_configurations_packag_package_license_choice_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_package_license_choices
    ADD CONSTRAINT repository_configurations_packag_package_license_choice_id_fkey FOREIGN KEY (package_license_choice_id) REFERENCES ort_server.package_license_choices(id);


--
-- Name: repository_configurations_package_curations repository_configurations_package_cura_package_curation_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_package_curations
    ADD CONSTRAINT repository_configurations_package_cura_package_curation_id_fkey FOREIGN KEY (package_curation_id) REFERENCES ort_server.package_curations(id);


--
-- Name: repository_configurations_package_configurations repository_configurations_package_package_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_package_configurations
    ADD CONSTRAINT repository_configurations_package_package_configuration_id_fkey FOREIGN KEY (package_configuration_id) REFERENCES ort_server.package_configurations(id);


--
-- Name: repository_configurations_path_excludes repository_configurations_path_excludes_path_exclude_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_path_excludes
    ADD CONSTRAINT repository_configurations_path_excludes_path_exclude_id_fkey FOREIGN KEY (path_exclude_id) REFERENCES ort_server.path_excludes(id);


--
-- Name: repository_configurations_path_excludes repository_configurations_path_repository_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_path_excludes
    ADD CONSTRAINT repository_configurations_path_repository_configuration_id_fkey FOREIGN KEY (repository_configuration_id) REFERENCES ort_server.repository_configurations(id) ON DELETE CASCADE;


--
-- Name: repository_configurations_provenance_snippet_choices repository_configurations_pro_provenance_snippet_choices_i_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_provenance_snippet_choices
    ADD CONSTRAINT repository_configurations_pro_provenance_snippet_choices_i_fkey FOREIGN KEY (provenance_snippet_choices_id) REFERENCES ort_server.provenance_snippet_choices(id);


--
-- Name: repository_configurations_provenance_snippet_choices repository_configurations_prov_repository_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_provenance_snippet_choices
    ADD CONSTRAINT repository_configurations_prov_repository_configuration_id_fkey FOREIGN KEY (repository_configuration_id) REFERENCES ort_server.repository_configurations(id) ON DELETE CASCADE;


--
-- Name: repository_configurations repository_configurations_repository_analyzer_configuratio_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations
    ADD CONSTRAINT repository_configurations_repository_analyzer_configuratio_fkey FOREIGN KEY (repository_analyzer_configuration_id) REFERENCES ort_server.repository_analyzer_configurations(id);


--
-- Name: repository_configurations_rule_violation_resolutions repository_configurations_rul_rule_violation_resolution_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_rule_violation_resolutions
    ADD CONSTRAINT repository_configurations_rul_rule_violation_resolution_id_fkey FOREIGN KEY (rule_violation_resolution_id) REFERENCES ort_server.rule_violation_resolutions(id);


--
-- Name: repository_configurations_rule_violation_resolutions repository_configurations_rule_repository_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_rule_violation_resolutions
    ADD CONSTRAINT repository_configurations_rule_repository_configuration_id_fkey FOREIGN KEY (repository_configuration_id) REFERENCES ort_server.repository_configurations(id) ON DELETE CASCADE;


--
-- Name: repository_configurations_scope_excludes repository_configurations_scop_repository_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_scope_excludes
    ADD CONSTRAINT repository_configurations_scop_repository_configuration_id_fkey FOREIGN KEY (repository_configuration_id) REFERENCES ort_server.repository_configurations(id) ON DELETE CASCADE;


--
-- Name: repository_configurations_scope_excludes repository_configurations_scope_excludes_scope_exclude_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_scope_excludes
    ADD CONSTRAINT repository_configurations_scope_excludes_scope_exclude_id_fkey FOREIGN KEY (scope_exclude_id) REFERENCES ort_server.scope_excludes(id);


--
-- Name: repository_configurations_spdx_license_choices repository_configurations_spdx_license_spdx_license_choice_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_spdx_license_choices
    ADD CONSTRAINT repository_configurations_spdx_license_spdx_license_choice_fkey FOREIGN KEY (spdx_license_choice) REFERENCES ort_server.spdx_license_choices(id);


--
-- Name: repository_configurations_spdx_license_choices repository_configurations_spdx_repository_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_spdx_license_choices
    ADD CONSTRAINT repository_configurations_spdx_repository_configuration_id_fkey FOREIGN KEY (repository_configuration_id) REFERENCES ort_server.repository_configurations(id) ON DELETE CASCADE;


--
-- Name: repository_configurations_vulnerability_resolutions repository_configurations_vuln_repository_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_vulnerability_resolutions
    ADD CONSTRAINT repository_configurations_vuln_repository_configuration_id_fkey FOREIGN KEY (repository_configuration_id) REFERENCES ort_server.repository_configurations(id) ON DELETE CASCADE;


--
-- Name: repository_configurations_vulnerability_resolutions repository_configurations_vuln_vulnerability_resolution_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.repository_configurations_vulnerability_resolutions
    ADD CONSTRAINT repository_configurations_vuln_vulnerability_resolution_id_fkey FOREIGN KEY (vulnerability_resolution_id) REFERENCES ort_server.vulnerability_resolutions(id);


--
-- Name: resolved_configurations_issue_resolutions resolved_configurations_issue_re_resolved_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations_issue_resolutions
    ADD CONSTRAINT resolved_configurations_issue_re_resolved_configuration_id_fkey FOREIGN KEY (resolved_configuration_id) REFERENCES ort_server.resolved_configurations(id) ON DELETE CASCADE;


--
-- Name: resolved_configurations_issue_resolutions resolved_configurations_issue_resoluti_issue_resolution_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations_issue_resolutions
    ADD CONSTRAINT resolved_configurations_issue_resoluti_issue_resolution_id_fkey FOREIGN KEY (issue_resolution_id) REFERENCES ort_server.issue_resolutions(id);


--
-- Name: resolved_configurations resolved_configurations_ort_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations
    ADD CONSTRAINT resolved_configurations_ort_run_id_fkey FOREIGN KEY (ort_run_id) REFERENCES ort_server.ort_runs(id) ON DELETE CASCADE;


--
-- Name: resolved_configurations_package_configurations resolved_configurations_package__resolved_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations_package_configurations
    ADD CONSTRAINT resolved_configurations_package__resolved_configuration_id_fkey FOREIGN KEY (resolved_configuration_id) REFERENCES ort_server.resolved_configurations(id) ON DELETE CASCADE;


--
-- Name: resolved_configurations_package_configurations resolved_configurations_package_c_package_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations_package_configurations
    ADD CONSTRAINT resolved_configurations_package_c_package_configuration_id_fkey FOREIGN KEY (package_configuration_id) REFERENCES ort_server.package_configurations(id);


--
-- Name: resolved_configurations_rule_violation_resolutions resolved_configurations_rule__rule_violation_resolution_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations_rule_violation_resolutions
    ADD CONSTRAINT resolved_configurations_rule__rule_violation_resolution_id_fkey FOREIGN KEY (rule_violation_resolution_id) REFERENCES ort_server.rule_violation_resolutions(id);


--
-- Name: resolved_configurations_rule_violation_resolutions resolved_configurations_rule_vio_resolved_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations_rule_violation_resolutions
    ADD CONSTRAINT resolved_configurations_rule_vio_resolved_configuration_id_fkey FOREIGN KEY (resolved_configuration_id) REFERENCES ort_server.resolved_configurations(id) ON DELETE CASCADE;


--
-- Name: resolved_configurations_vulnerability_resolutions resolved_configurations_vulner_vulnerability_resolution_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations_vulnerability_resolutions
    ADD CONSTRAINT resolved_configurations_vulner_vulnerability_resolution_id_fkey FOREIGN KEY (vulnerability_resolution_id) REFERENCES ort_server.vulnerability_resolutions(id);


--
-- Name: resolved_configurations_vulnerability_resolutions resolved_configurations_vulnerab_resolved_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_configurations_vulnerability_resolutions
    ADD CONSTRAINT resolved_configurations_vulnerab_resolved_configuration_id_fkey FOREIGN KEY (resolved_configuration_id) REFERENCES ort_server.resolved_configurations(id) ON DELETE CASCADE;


--
-- Name: resolved_package_curation_providers resolved_package_curation_pro_package_curation_provider_co_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_package_curation_providers
    ADD CONSTRAINT resolved_package_curation_pro_package_curation_provider_co_fkey FOREIGN KEY (package_curation_provider_config_id) REFERENCES ort_server.package_curation_provider_configs(id);


--
-- Name: resolved_package_curation_providers resolved_package_curation_provid_resolved_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_package_curation_providers
    ADD CONSTRAINT resolved_package_curation_provid_resolved_configuration_id_fkey FOREIGN KEY (resolved_configuration_id) REFERENCES ort_server.resolved_configurations(id) ON DELETE CASCADE;


--
-- Name: resolved_package_curations resolved_package_curations_package_curation_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_package_curations
    ADD CONSTRAINT resolved_package_curations_package_curation_id_fkey FOREIGN KEY (package_curation_id) REFERENCES ort_server.package_curations(id);


--
-- Name: resolved_package_curations resolved_package_curations_resolved_package_curation_provi_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.resolved_package_curations
    ADD CONSTRAINT resolved_package_curations_resolved_package_curation_provi_fkey FOREIGN KEY (resolved_package_curation_provider_id) REFERENCES ort_server.resolved_package_curation_providers(id) ON DELETE CASCADE;


--
-- Name: rule_violations rule_violations_package_identifier_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.rule_violations
    ADD CONSTRAINT rule_violations_package_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES ort_server.identifiers(id);


--
-- Name: scan_results scan_results_scan_summary_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scan_results
    ADD CONSTRAINT scan_results_scan_summary_id_fkey FOREIGN KEY (scan_summary_id) REFERENCES ort_server.scan_summaries(id);


--
-- Name: scan_summaries_issues scan_summaries_issues_with_timestamps_issue_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scan_summaries_issues
    ADD CONSTRAINT scan_summaries_issues_with_timestamps_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES ort_server.issues(id);


--
-- Name: scan_summaries_issues scan_summaries_issues_with_timestamps_scan_summary_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scan_summaries_issues
    ADD CONSTRAINT scan_summaries_issues_with_timestamps_scan_summary_id_fkey FOREIGN KEY (scan_summary_id) REFERENCES ort_server.scan_summaries(id);


--
-- Name: scanner_configurations_detected_license_mappings scanner_configurations_detecte_detected_license_mapping_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configurations_detected_license_mappings
    ADD CONSTRAINT scanner_configurations_detecte_detected_license_mapping_id_fkey FOREIGN KEY (detected_license_mapping_id) REFERENCES ort_server.detected_license_mappings(id);


--
-- Name: scanner_configurations_detected_license_mappings scanner_configurations_detected_l_scanner_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configurations_detected_license_mappings
    ADD CONSTRAINT scanner_configurations_detected_l_scanner_configuration_id_fkey FOREIGN KEY (scanner_configuration_id) REFERENCES ort_server.scanner_configurations(id) ON DELETE CASCADE;


--
-- Name: scanner_configurations_options scanner_configurations_option_scanner_configuration_option_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configurations_options
    ADD CONSTRAINT scanner_configurations_option_scanner_configuration_option_fkey FOREIGN KEY (scanner_configuration_option_id) REFERENCES ort_server.scanner_configuration_options(id);


--
-- Name: scanner_configurations_options scanner_configurations_options_scanner_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configurations_options
    ADD CONSTRAINT scanner_configurations_options_scanner_configuration_id_fkey FOREIGN KEY (scanner_configuration_id) REFERENCES ort_server.scanner_configurations(id) ON DELETE CASCADE;


--
-- Name: scanner_configurations scanner_configurations_scanner_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configurations
    ADD CONSTRAINT scanner_configurations_scanner_run_id_fkey FOREIGN KEY (scanner_run_id) REFERENCES ort_server.scanner_runs(id) ON DELETE CASCADE;


--
-- Name: scanner_configurations_secrets scanner_configurations_secret_scanner_configuration_secret_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configurations_secrets
    ADD CONSTRAINT scanner_configurations_secret_scanner_configuration_secret_fkey FOREIGN KEY (scanner_configuration_secret_id) REFERENCES ort_server.scanner_configuration_secrets(id);


--
-- Name: scanner_configurations_secrets scanner_configurations_secrets_scanner_configuration_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_configurations_secrets
    ADD CONSTRAINT scanner_configurations_secrets_scanner_configuration_id_fkey FOREIGN KEY (scanner_configuration_id) REFERENCES ort_server.scanner_configurations(id) ON DELETE CASCADE;


--
-- Name: scanner_jobs scanner_jobs_ort_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_jobs
    ADD CONSTRAINT scanner_jobs_ort_run_id_fkey FOREIGN KEY (ort_run_id) REFERENCES ort_server.ort_runs(id) ON DELETE CASCADE;


--
-- Name: scanner_runs scanner_runs_environment_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs
    ADD CONSTRAINT scanner_runs_environment_id_fkey FOREIGN KEY (environment_id) REFERENCES ort_server.environments(id);


--
-- Name: scanner_runs_package_provenances scanner_runs_package_provenances_package_provenance_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs_package_provenances
    ADD CONSTRAINT scanner_runs_package_provenances_package_provenance_id_fkey FOREIGN KEY (package_provenance_id) REFERENCES ort_server.package_provenances(id);


--
-- Name: scanner_runs_package_provenances scanner_runs_package_provenances_scanner_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs_package_provenances
    ADD CONSTRAINT scanner_runs_package_provenances_scanner_run_id_fkey FOREIGN KEY (scanner_run_id) REFERENCES ort_server.scanner_runs(id) ON DELETE CASCADE;


--
-- Name: scanner_runs_scan_results scanner_runs_scan_results_scan_result_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs_scan_results
    ADD CONSTRAINT scanner_runs_scan_results_scan_result_id_fkey FOREIGN KEY (scan_result_id) REFERENCES ort_server.scan_results(id);


--
-- Name: scanner_runs_scan_results scanner_runs_scan_results_scanner_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs_scan_results
    ADD CONSTRAINT scanner_runs_scan_results_scanner_run_id_fkey FOREIGN KEY (scanner_run_id) REFERENCES ort_server.scanner_runs(id) ON DELETE CASCADE;


--
-- Name: scanner_runs scanner_runs_scanner_job_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs
    ADD CONSTRAINT scanner_runs_scanner_job_id_fkey FOREIGN KEY (scanner_job_id) REFERENCES ort_server.scanner_jobs(id) ON DELETE CASCADE;


--
-- Name: scanner_runs_scanners scanner_runs_scanners_identifier_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs_scanners
    ADD CONSTRAINT scanner_runs_scanners_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES ort_server.identifiers(id);


--
-- Name: scanner_runs_scanners scanner_runs_scanners_scanner_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.scanner_runs_scanners
    ADD CONSTRAINT scanner_runs_scanners_scanner_run_id_fkey FOREIGN KEY (scanner_run_id) REFERENCES ort_server.scanner_runs(id) ON DELETE CASCADE;


--
-- Name: secrets secrets_organization_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.secrets
    ADD CONSTRAINT secrets_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES ort_server.organizations(id);


--
-- Name: secrets secrets_product_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.secrets
    ADD CONSTRAINT secrets_product_id_fkey FOREIGN KEY (product_id) REFERENCES ort_server.products(id);


--
-- Name: secrets secrets_repository_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.secrets
    ADD CONSTRAINT secrets_repository_id_fkey FOREIGN KEY (repository_id) REFERENCES ort_server.repositories(id);


--
-- Name: shortest_dependency_paths shortest_dependency_paths_analyzer_run_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.shortest_dependency_paths
    ADD CONSTRAINT shortest_dependency_paths_analyzer_run_id_fkey FOREIGN KEY (analyzer_run_id) REFERENCES ort_server.analyzer_runs(id) ON DELETE CASCADE;


--
-- Name: shortest_dependency_paths shortest_dependency_paths_package_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.shortest_dependency_paths
    ADD CONSTRAINT shortest_dependency_paths_package_id_fkey FOREIGN KEY (package_id) REFERENCES ort_server.packages(id);


--
-- Name: shortest_dependency_paths shortest_dependency_paths_project_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.shortest_dependency_paths
    ADD CONSTRAINT shortest_dependency_paths_project_id_fkey FOREIGN KEY (project_id) REFERENCES ort_server.projects(id);


--
-- Name: snippet_findings snippet_findings_scan_summary_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.snippet_findings
    ADD CONSTRAINT snippet_findings_scan_summary_id_fkey FOREIGN KEY (scan_summary_id) REFERENCES ort_server.scan_summaries(id);


--
-- Name: snippet_findings_snippets snippet_findings_snippets_snippet_finding_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.snippet_findings_snippets
    ADD CONSTRAINT snippet_findings_snippets_snippet_finding_id_fkey FOREIGN KEY (snippet_finding_id) REFERENCES ort_server.snippet_findings(id);


--
-- Name: snippet_findings_snippets snippet_findings_snippets_snippet_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.snippet_findings_snippets
    ADD CONSTRAINT snippet_findings_snippets_snippet_id_fkey FOREIGN KEY (snippet_id) REFERENCES ort_server.snippets(id);


--
-- Name: snippets snippets_artifact_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.snippets
    ADD CONSTRAINT snippets_artifact_id_fkey FOREIGN KEY (artifact_id) REFERENCES ort_server.remote_artifacts(id);


--
-- Name: snippets snippets_vcs_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.snippets
    ADD CONSTRAINT snippets_vcs_id_fkey FOREIGN KEY (vcs_id) REFERENCES ort_server.vcs_info(id);


--
-- Name: vulnerability_references vulnerability_references_vulnerability_id_fkey; Type: FK CONSTRAINT; Schema: ort_server; Owner: postgres
--

ALTER TABLE ONLY ort_server.vulnerability_references
    ADD CONSTRAINT vulnerability_references_vulnerability_id_fkey FOREIGN KEY (vulnerability_id) REFERENCES ort_server.vulnerabilities(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

\unrestrict mbBaDeHXbbhM7BbteO02fV2n2JEXH7qcIlfTyy0i6Uu483dAHFK2GAKZEqgRGfE

