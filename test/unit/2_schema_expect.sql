--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1 (Debian 14.1-1.pgdg110+1)
-- Dumped by pg_dump version 14.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth_sender; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA auth_sender;


--
-- Name: audr_delete(text, json); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: audr_insert(text, json); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: audr_update(text, json, json); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_attachment_audit(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_audit(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_history_event_audit(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_insurance_task_audit(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_mapping_history_and_tasks_audit(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_procedure_code_audit(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_status_audit(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_status_message_audit(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: cron_job_audit(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: increment_version(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: prework_hold_condition_audit(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: prework_hold_condition_department_audit(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: prework_hold_condition_provider_audit(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


--
-- Name: procedure_code_audit(); Type: FUNCTION; Schema: auth_sender; Owner: -
--


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: authorization_order; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.authorization_order (
    id uuid NOT NULL
    , order_ext_id integer
    , context_ext_id integer
    , primary_insurance_ext_id integer
    , secondary_insurance_ext_id integer
    , length_of_stay character varying(15)
    , inpatient_length integer
    , date_of_service date
    , ordering_provider_ext_id integer
    , clinical_provider_ext_id integer
    , department_ext_id integer
    , clinical_order_type_ext_id integer
    , clinical_order_type_name character varying(4000)
    , clinical_order_type_group_name character varying(4000)
    , needs_client_prework_review_yn character varying(1)
    , procedure_codes_defaulted_yn character varying(1)
    , patient_ext_id integer
    , canceled_reason character varying(50)
    , snapshot_time timestamp with time zone
    , use_old_workflow_date timestamp with time zone
    , use_old_workflow_reason character varying(20)
    , signed timestamp with time zone
    , version_index integer DEFAULT 1
    , primary_insurance_category character varying(20)
    , secondary_insurance_category character varying(20)
    , need_inspection_case_policyyn character varying(5)
    , sent_authops timestamp with time zone
    , send_for_cpt_match_yn character varying(1)
    , authops_update_index integer
    , authorization_order_status_id character varying(50)
    , ack_denial_yn character varying(1)
    , last_action_status character varying(30)
    , rar_reason character varying(50)
    , place_of_service character varying(50)
    , assigned_to character varying(60)
    , requested_visits integer
    , ordering_provider_type character varying(20)
    , requesting_provider_ext_id integer
    , direct_ref_complete_yn character varying(1)
    , paused_date timestamp with time zone
    , paused_by character varying(30)
    , primary_insurance_information jsonb
    , secondary_insurance_information jsonb
    , enterprise_ext_id integer
);


--
-- Name: authorization_order_attachment; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.authorization_order_attachment (
    id uuid NOT NULL
    , authorization_order_id uuid
    , attachment_date timestamp with time zone
    , file_name character varying(200)
    , file_type character varying(100)
    , file_origin character varying(25)
    , document_ext_id integer
    , display_name character varying(100)
    , display_file_type character varying(100)
);


--
-- Name: authorization_order_attachment_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.authorization_order_attachment_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorization_order_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.authorization_order_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorization_order_history_event; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.authorization_order_history_event (
    id uuid NOT NULL
    , authorization_order_id uuid
    , authorization_order_status_id character varying(100)
    , ordering integer
    , note character varying(4000)
    , insurance_ext_id integer
    , insurance_sequence_number integer
    , insurance_task_group_status character varying(30)
    , event_time timestamp with time zone
    , event_source character varying(30)
    , status_reason_id character varying(50)
    , call_reference_number character varying(50)
    , effective_date_from date
    , effective_date_to date
    , cert_length integer
    , authorization_number character varying(50)
    , cert_length_type character varying(50)
    , rar_reason character varying(50)
    , case_number character varying(255)
);


--
-- Name: authorization_order_history_event_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.authorization_order_history_event_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorization_order_insurance_task; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.authorization_order_insurance_task (
    id uuid NOT NULL
    , authorization_order_id uuid
    , insurance_ext_id integer
    , sequence_number integer
    , procedure_code character varying(15)
    , status character varying(15)
    , status_origin character varying(30)
    , authorization_order_procedure_code_id uuid
    , most_recent_history_event_id uuid
);


--
-- Name: authorization_order_insurance_task_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.authorization_order_insurance_task_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorization_order_mapping_history_and_tasks; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.authorization_order_mapping_history_and_tasks (
    id uuid NOT NULL
    , history_event_id uuid
    , insurance_task_id uuid
);


--
-- Name: authorization_order_mapping_history_and_tasks_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.authorization_order_mapping_history_and_tasks_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorization_order_procedure_code; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.authorization_order_procedure_code (
    id uuid NOT NULL
    , procedure_code character varying(15)
    , authorization_order_id uuid
);


--
-- Name: authorization_order_procedure_code_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.authorization_order_procedure_code_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorization_order_rules_event; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.authorization_order_rules_event (
    id uuid NOT NULL
    , authorization_order_id uuid
    , rule_type character varying(20)
);


--
-- Name: authorization_order_rules_event_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.authorization_order_rules_event_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorization_order_rules_event_result; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.authorization_order_rules_event_result (
    id uuid NOT NULL
    , authorization_order_rules_event_id uuid
    , authorization_order_insurance_task_id uuid
    , result_status_action character varying(50)
    , environment character varying(4000)
);


--
-- Name: authorization_order_rules_event_result_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.authorization_order_rules_event_result_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorization_order_rules_event_result_scrubdata; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.authorization_order_rules_event_result_scrubdata (
    id uuid NOT NULL
    , authorization_order_rules_event_result_id uuid
    , rule_ext_id integer
    , rule_condition_systemkey character varying(50)
    , rule_status_action character varying(50)
);


--
-- Name: authorization_order_rules_event_result_scrubdata_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.authorization_order_rules_event_result_scrubdata_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorization_order_status; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.authorization_order_status (
    id character varying(50) NOT NULL
    , description character varying(250)
);


--
-- Name: authorization_order_status_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.authorization_order_status_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorization_order_status_message; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.authorization_order_status_message (
    id integer NOT NULL
    , authorization_order_status_id character varying(50)
    , long_status character varying(200)
    , short_status character varying(200)
    , long_status_detail character varying(200)
    , short_status_detail character varying(200)
);


--
-- Name: authorization_order_status_message_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.authorization_order_status_message_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorization_order_status_message_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.authorization_order_status_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorization_order_status_message_id_seq; Type: SEQUENCE OWNED BY; Schema: auth_sender; Owner: -
--



--
-- Name: cron_job; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.cron_job (
    id uuid NOT NULL
    , job_run character varying(50) NOT NULL
    , started_at timestamp with time zone
    , started_on_host character varying(100)
    , finished_at timestamp with time zone
    , error character varying(5000)
);


--
-- Name: cron_job_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.cron_job_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: message_outbox; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.message_outbox (
    id uuid NOT NULL
    , authorization_order_id uuid NOT NULL
    , message jsonb NOT NULL
    , status character varying(20)
);


--
-- Name: prework_hold_condition; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.prework_hold_condition (
    id integer NOT NULL
    , clinical_order_type_group_ext_id integer
    , clinical_order_genus_ext_id integer
    , clinical_order_type_ext_id integer
    , context_ext_id integer
);


--
-- Name: prework_hold_condition_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.prework_hold_condition_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prework_hold_condition_department; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.prework_hold_condition_department (
    id uuid NOT NULL
    , prework_hold_condition_id integer
    , department_ext_id integer
);


--
-- Name: prework_hold_condition_department_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.prework_hold_condition_department_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prework_hold_condition_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.prework_hold_condition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prework_hold_condition_id_seq; Type: SEQUENCE OWNED BY; Schema: auth_sender; Owner: -
--



--
-- Name: prework_hold_condition_provider; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.prework_hold_condition_provider (
    id uuid NOT NULL
    , prework_hold_condition_id integer
    , provider_ext_id integer
);


--
-- Name: prework_hold_condition_provider_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.prework_hold_condition_provider_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: procedure_code; Type: TABLE; Schema: auth_sender; Owner: -
--

CREATE TABLE auth_sender.procedure_code (
    id uuid NOT NULL
    , procedure_code character varying(20) NOT NULL
    , remote_created date
    , remote_updated date
    , description character varying(500)
    , common_description character varying(100)
    , type_of_service character varying(10)
);


--
-- Name: procedure_code_audr_id_seq; Type: SEQUENCE; Schema: auth_sender; Owner: -
--

CREATE SEQUENCE auth_sender.procedure_code_audr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorization_order_status_message id; Type: DEFAULT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_status_message ALTER COLUMN id SET DEFAULT nextval('auth_sender.authorization_order_status_message_id_seq'::regclass);


--
-- Name: prework_hold_condition id; Type: DEFAULT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.prework_hold_condition ALTER COLUMN id SET DEFAULT nextval('auth_sender.prework_hold_condition_id_seq'::regclass);


--
-- Name: authorization_order_attachment authorization_order_attachment_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_attachment
    ADD CONSTRAINT authorization_order_attachment_pkey PRIMARY KEY (id);


--
-- Name: authorization_order_history_event authorization_order_history_event_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_history_event
    ADD CONSTRAINT authorization_order_history_event_pkey PRIMARY KEY (id);


--
-- Name: authorization_order_insurance_task authorization_order_insurance_task_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_insurance_task
    ADD CONSTRAINT authorization_order_insurance_task_pkey PRIMARY KEY (id);


--
-- Name: authorization_order_mapping_history_and_tasks authorization_order_mapping_history_and_tasks_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_mapping_history_and_tasks
    ADD CONSTRAINT authorization_order_mapping_history_and_tasks_pkey PRIMARY KEY (id);


--
-- Name: authorization_order authorization_order_order_ext_id_context_ext_id_key; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order
    ADD CONSTRAINT authorization_order_order_ext_id_context_ext_id_key UNIQUE (order_ext_id, context_ext_id);


--
-- Name: authorization_order authorization_order_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order
    ADD CONSTRAINT authorization_order_pkey PRIMARY KEY (id);


--
-- Name: authorization_order_procedure_code authorization_order_procedure_code_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_procedure_code
    ADD CONSTRAINT authorization_order_procedure_code_pkey PRIMARY KEY (id);


--
-- Name: authorization_order_rules_event authorization_order_rules_event_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_rules_event
    ADD CONSTRAINT authorization_order_rules_event_pkey PRIMARY KEY (id);


--
-- Name: authorization_order_rules_event_result authorization_order_rules_event_result_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_rules_event_result
    ADD CONSTRAINT authorization_order_rules_event_result_pkey PRIMARY KEY (id);


--
-- Name: authorization_order_rules_event_result_scrubdata authorization_order_rules_event_result_scrubdata_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_rules_event_result_scrubdata
    ADD CONSTRAINT authorization_order_rules_event_result_scrubdata_pkey PRIMARY KEY (id);


--
-- Name: authorization_order_status_message authorization_order_status_message_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_status_message
    ADD CONSTRAINT authorization_order_status_message_pkey PRIMARY KEY (id);


--
-- Name: authorization_order_status authorization_order_status_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_status
    ADD CONSTRAINT authorization_order_status_pkey PRIMARY KEY (id);


--
-- Name: cron_job cron_job_job_run_key; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.cron_job
    ADD CONSTRAINT cron_job_job_run_key UNIQUE (job_run);


--
-- Name: cron_job cron_job_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.cron_job
    ADD CONSTRAINT cron_job_pkey PRIMARY KEY (id);


--
-- Name: message_outbox message_outbox_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.message_outbox
    ADD CONSTRAINT message_outbox_pkey PRIMARY KEY (id);


--
-- Name: prework_hold_condition_department prework_hold_condition_department_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.prework_hold_condition_department
    ADD CONSTRAINT prework_hold_condition_department_pkey PRIMARY KEY (id);


--
-- Name: prework_hold_condition prework_hold_condition_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.prework_hold_condition
    ADD CONSTRAINT prework_hold_condition_pkey PRIMARY KEY (id);


--
-- Name: prework_hold_condition_provider prework_hold_condition_provider_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.prework_hold_condition_provider
    ADD CONSTRAINT prework_hold_condition_provider_pkey PRIMARY KEY (id);


--
-- Name: procedure_code procedure_code_pkey; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.procedure_code
    ADD CONSTRAINT procedure_code_pkey PRIMARY KEY (id);


--
-- Name: procedure_code procedure_code_procedure_code_key; Type: CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.procedure_code
    ADD CONSTRAINT procedure_code_procedure_code_key UNIQUE (procedure_code);


--
-- Name: idx_authorderattach_authorization_order_id; Type: INDEX; Schema: auth_sender; Owner: -
--


--
-- Name: idx_historyevent_authorization_order_id; Type: INDEX; Schema: auth_sender; Owner: -
--


--
-- Name: idx_insurancetask_authorization_order_id; Type: INDEX; Schema: auth_sender; Owner: -
--


--
-- Name: idx_mappinghistorytask_history_event_id; Type: INDEX; Schema: auth_sender; Owner: -
--


--
-- Name: idx_mappinghistorytask_insurance_task_id; Type: INDEX; Schema: auth_sender; Owner: -
--


--
-- Name: idx_procedurecode_authorization_order_id; Type: INDEX; Schema: auth_sender; Owner: -
--


--
-- Name: idx_rulesevent_authorization_order_id; Type: INDEX; Schema: auth_sender; Owner: -
--


--
-- Name: idx_ruleseventresult_rules_event_id; Type: INDEX; Schema: auth_sender; Owner: -
--


--
-- Name: idx_ruleseventresultscrubdata_rules_event_result_id; Type: INDEX; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_attachment authorization_order_attachment_delete_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_attachment authorization_order_attachment_insert_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_attachment authorization_order_attachment_update_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order authorization_order_delete_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_history_event authorization_order_history_event_delete_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_history_event authorization_order_history_event_insert_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_history_event authorization_order_history_event_update_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order authorization_order_insert_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_insurance_task authorization_order_insurance_task_delete_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_insurance_task authorization_order_insurance_task_insert_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_insurance_task authorization_order_insurance_task_update_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_mapping_history_and_tasks authorization_order_mapping_history_and_tasks_delete_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_mapping_history_and_tasks authorization_order_mapping_history_and_tasks_insert_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_mapping_history_and_tasks authorization_order_mapping_history_and_tasks_update_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_procedure_code authorization_order_procedure_code_delete_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_procedure_code authorization_order_procedure_code_insert_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_procedure_code authorization_order_procedure_code_update_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_status authorization_order_status_delete_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_status authorization_order_status_insert_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_status_message authorization_order_status_message_delete_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_status_message authorization_order_status_message_insert_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_status_message authorization_order_status_message_update_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_status authorization_order_status_update_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order authorization_order_update_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: cron_job cron_job_delete_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: cron_job cron_job_insert_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: cron_job cron_job_update_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: prework_hold_condition prework_hold_condition_delete_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: prework_hold_condition_department prework_hold_condition_department_delete_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: prework_hold_condition_department prework_hold_condition_department_insert_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: prework_hold_condition_department prework_hold_condition_department_update_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: prework_hold_condition prework_hold_condition_insert_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: prework_hold_condition_provider prework_hold_condition_provider_delete_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: prework_hold_condition_provider prework_hold_condition_provider_insert_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: prework_hold_condition_provider prework_hold_condition_provider_update_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: prework_hold_condition prework_hold_condition_update_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: procedure_code procedure_code_delete_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: procedure_code procedure_code_insert_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: procedure_code procedure_code_update_trigger; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order update_version; Type: TRIGGER; Schema: auth_sender; Owner: -
--


--
-- Name: authorization_order_attachment authorization_order_attachment_authorization_order_id_fkey; Type: FK CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_attachment
    ADD CONSTRAINT authorization_order_attachment_authorization_order_id_fkey FOREIGN KEY (authorization_order_id) REFERENCES auth_sender.authorization_order(id);


--
-- Name: authorization_order authorization_order_authorization_order_status_id_fkey; Type: FK CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order
    ADD CONSTRAINT authorization_order_authorization_order_status_id_fkey FOREIGN KEY (authorization_order_status_id) REFERENCES auth_sender.authorization_order_status(id);


--
-- Name: authorization_order_history_event authorization_order_history_e_authorization_order_status_i_fkey; Type: FK CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_history_event
    ADD CONSTRAINT authorization_order_history_e_authorization_order_status_i_fkey FOREIGN KEY (authorization_order_status_id) REFERENCES auth_sender.authorization_order_status(id);


--
-- Name: authorization_order_history_event authorization_order_history_event_authorization_order_id_fkey; Type: FK CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_history_event
    ADD CONSTRAINT authorization_order_history_event_authorization_order_id_fkey FOREIGN KEY (authorization_order_id) REFERENCES auth_sender.authorization_order(id);


--
-- Name: authorization_order_insurance_task authorization_order_insurance_task_auth_order_procedure_code_id; Type: FK CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_insurance_task
    ADD CONSTRAINT authorization_order_insurance_task_auth_order_procedure_code_id FOREIGN KEY (authorization_order_procedure_code_id) REFERENCES auth_sender.authorization_order_procedure_code(id);


--
-- Name: authorization_order_insurance_task authorization_order_insurance_task_authorization_order_id_fk; Type: FK CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_insurance_task
    ADD CONSTRAINT authorization_order_insurance_task_authorization_order_id_fk FOREIGN KEY (authorization_order_id) REFERENCES auth_sender.authorization_order(id);


--
-- Name: authorization_order_status_message authorization_order_message_authorization_order_id_fk; Type: FK CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_status_message
    ADD CONSTRAINT authorization_order_message_authorization_order_id_fk FOREIGN KEY (authorization_order_status_id) REFERENCES auth_sender.authorization_order_status(id);


--
-- Name: authorization_order_procedure_code authorization_order_procedure_code_authorization_order_id_fk; Type: FK CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_procedure_code
    ADD CONSTRAINT authorization_order_procedure_code_authorization_order_id_fk FOREIGN KEY (authorization_order_id) REFERENCES auth_sender.authorization_order(id);


--
-- Name: authorization_order_rules_event_result authorization_order_rules_event_authorization_order_rules_event; Type: FK CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_rules_event_result
    ADD CONSTRAINT authorization_order_rules_event_authorization_order_rules_event FOREIGN KEY (authorization_order_rules_event_id) REFERENCES auth_sender.authorization_order_rules_event(id);


--
-- Name: authorization_order_rules_event_result_scrubdata authorization_order_rules_event_result_authorization_order_rule; Type: FK CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.authorization_order_rules_event_result_scrubdata
    ADD CONSTRAINT authorization_order_rules_event_result_authorization_order_rule FOREIGN KEY (authorization_order_rules_event_result_id) REFERENCES auth_sender.authorization_order_rules_event_result(id);


--
-- Name: prework_hold_condition_department prework_hold_condition_department_prework_hold_condition_id_fk; Type: FK CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.prework_hold_condition_department
    ADD CONSTRAINT prework_hold_condition_department_prework_hold_condition_id_fk FOREIGN KEY (prework_hold_condition_id) REFERENCES auth_sender.prework_hold_condition(id);


--
-- Name: prework_hold_condition_provider prework_hold_condition_provider_prework_hold_condition_id_fk; Type: FK CONSTRAINT; Schema: auth_sender; Owner: -
--

ALTER TABLE ONLY auth_sender.prework_hold_condition_provider
    ADD CONSTRAINT prework_hold_condition_provider_prework_hold_condition_id_fk FOREIGN KEY (prework_hold_condition_id) REFERENCES auth_sender.prework_hold_condition(id);


--
-- PostgreSQL database dump complete
--
