--
-- This SQL file can be used to initialize tables in a test database.
-- The commands in this file were generated by running ./fetch_sql_test_schema.sh.
-- Whenever the tables change, these commands should be updated by running that script again.
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

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
-- Name: dev; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA dev;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: boundingbox; Type: TABLE; Schema: dev; Owner: -
--

CREATE TABLE dev.boundingbox (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    entity_id integer NOT NULL,
    source text NOT NULL,
    page integer NOT NULL,
    "left" real NOT NULL,
    top real NOT NULL,
    width real NOT NULL,
    height real NOT NULL
);


--
-- Name: boundingbox_id_seq; Type: SEQUENCE; Schema: dev; Owner: -
--

CREATE SEQUENCE dev.boundingbox_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: boundingbox_id_seq; Type: SEQUENCE OWNED BY; Schema: dev; Owner: -
--

ALTER SEQUENCE dev.boundingbox_id_seq OWNED BY dev.boundingbox.id;


--
-- Name: entity; Type: TABLE; Schema: dev; Owner: -
--

CREATE TABLE dev.entity (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    paper_id character varying(255) NOT NULL,
    version integer NOT NULL,
    type text NOT NULL,
    within_paper_id text NOT NULL,
    source text NOT NULL
);


--
-- Name: entity_id_seq; Type: SEQUENCE; Schema: dev; Owner: -
--

CREATE SEQUENCE dev.entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: entity_id_seq; Type: SEQUENCE OWNED BY; Schema: dev; Owner: -
--

ALTER SEQUENCE dev.entity_id_seq OWNED BY dev.entity.id;


--
-- Name: entitydata; Type: TABLE; Schema: dev; Owner: -
--

CREATE TABLE dev.entitydata (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    entity_id integer NOT NULL,
    source text NOT NULL,
    type text NOT NULL,
    key text NOT NULL,
    value text NOT NULL
);


--
-- Name: entitydata_id_seq; Type: SEQUENCE; Schema: dev; Owner: -
--

CREATE SEQUENCE dev.entitydata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: entitydata_id_seq; Type: SEQUENCE OWNED BY; Schema: dev; Owner: -
--

ALTER SEQUENCE dev.entitydata_id_seq OWNED BY dev.entitydata.id;


--
-- Name: paper; Type: TABLE; Schema: dev; Owner: -
--

CREATE TABLE dev.paper (
    s2_id character varying(255) NOT NULL,
    arxiv_id character varying(255)
);


--
-- Name: summary; Type: TABLE; Schema: dev; Owner: -
--

CREATE TABLE dev.summary (
    id integer NOT NULL,
    paper_id character varying(255) NOT NULL,
    title text NOT NULL,
    authors text NOT NULL,
    doi text,
    venue text,
    year integer,
    abstract text
);


--
-- Name: summary_id_seq; Type: SEQUENCE; Schema: dev; Owner: -
--

CREATE SEQUENCE dev.summary_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: summary_id_seq; Type: SEQUENCE OWNED BY; Schema: dev; Owner: -
--

ALTER SEQUENCE dev.summary_id_seq OWNED BY dev.summary.id;


--
-- Name: version; Type: TABLE; Schema: dev; Owner: -
--

CREATE TABLE dev.version (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    paper_id character varying(255) NOT NULL,
    index integer NOT NULL,
    session_id text NOT NULL
);


--
-- Name: version_id_seq; Type: SEQUENCE; Schema: dev; Owner: -
--

CREATE SEQUENCE dev.version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: version_id_seq; Type: SEQUENCE OWNED BY; Schema: dev; Owner: -
--

ALTER SEQUENCE dev.version_id_seq OWNED BY dev.version.id;


--
-- Name: boundingbox id; Type: DEFAULT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.boundingbox ALTER COLUMN id SET DEFAULT nextval('dev.boundingbox_id_seq'::regclass);


--
-- Name: entity id; Type: DEFAULT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.entity ALTER COLUMN id SET DEFAULT nextval('dev.entity_id_seq'::regclass);


--
-- Name: entitydata id; Type: DEFAULT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.entitydata ALTER COLUMN id SET DEFAULT nextval('dev.entitydata_id_seq'::regclass);


--
-- Name: summary id; Type: DEFAULT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.summary ALTER COLUMN id SET DEFAULT nextval('dev.summary_id_seq'::regclass);


--
-- Name: version id; Type: DEFAULT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.version ALTER COLUMN id SET DEFAULT nextval('dev.version_id_seq'::regclass);


--
-- Name: boundingbox boundingbox_pkey; Type: CONSTRAINT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.boundingbox
    ADD CONSTRAINT boundingbox_pkey PRIMARY KEY (id);


--
-- Name: entity entity_pkey; Type: CONSTRAINT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.entity
    ADD CONSTRAINT entity_pkey PRIMARY KEY (id);


--
-- Name: entitydata entitydata_pkey; Type: CONSTRAINT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.entitydata
    ADD CONSTRAINT entitydata_pkey PRIMARY KEY (id);


--
-- Name: paper paper_pkey; Type: CONSTRAINT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.paper
    ADD CONSTRAINT paper_pkey PRIMARY KEY (s2_id);


--
-- Name: summary summary_pkey; Type: CONSTRAINT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.summary
    ADD CONSTRAINT summary_pkey PRIMARY KEY (id);


--
-- Name: version version_pkey; Type: CONSTRAINT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.version
    ADD CONSTRAINT version_pkey PRIMARY KEY (id);


--
-- Name: boundingbox_entity_id; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX boundingbox_entity_id ON dev.boundingbox USING btree (entity_id);


--
-- Name: boundingbox_source; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX boundingbox_source ON dev.boundingbox USING btree (source);


--
-- Name: entity_paper_id; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX entity_paper_id ON dev.entity USING btree (paper_id);


--
-- Name: entity_paper_id_version_type_within_paper_id; Type: INDEX; Schema: dev; Owner: -
--

CREATE UNIQUE INDEX entity_paper_id_version_type_within_paper_id ON dev.entity USING btree (paper_id, version, type, within_paper_id);


--
-- Name: entity_source; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX entity_source ON dev.entity USING btree (source);


--
-- Name: entity_type; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX entity_type ON dev.entity USING btree (type);


--
-- Name: entity_version; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX entity_version ON dev.entity USING btree (version);


--
-- Name: entity_within_paper_id; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX entity_within_paper_id ON dev.entity USING btree (within_paper_id);


--
-- Name: entitydata_entity_id; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX entitydata_entity_id ON dev.entitydata USING btree (entity_id);


--
-- Name: entitydata_key; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX entitydata_key ON dev.entitydata USING btree (key);


--
-- Name: entitydata_source; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX entitydata_source ON dev.entitydata USING btree (source);


--
-- Name: entitydata_type; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX entitydata_type ON dev.entitydata USING btree (type);


--
-- Name: paper_arxiv_id; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX paper_arxiv_id ON dev.paper USING btree (arxiv_id);


--
-- Name: summary_paper_id; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX summary_paper_id ON dev.summary USING btree (paper_id);


--
-- Name: summary_venue; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX summary_venue ON dev.summary USING btree (venue);


--
-- Name: summary_year; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX summary_year ON dev.summary USING btree (year);


--
-- Name: version_index; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX version_index ON dev.version USING btree (index);


--
-- Name: version_paper_id; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX version_paper_id ON dev.version USING btree (paper_id);


--
-- Name: version_paper_id_index; Type: INDEX; Schema: dev; Owner: -
--

CREATE UNIQUE INDEX version_paper_id_index ON dev.version USING btree (paper_id, index);


--
-- Name: version_paper_id_session_id; Type: INDEX; Schema: dev; Owner: -
--

CREATE UNIQUE INDEX version_paper_id_session_id ON dev.version USING btree (paper_id, session_id);


--
-- Name: version_session_id; Type: INDEX; Schema: dev; Owner: -
--

CREATE INDEX version_session_id ON dev.version USING btree (session_id);


--
-- Name: entity entity_paper_id_fkey; Type: FK CONSTRAINT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.entity
    ADD CONSTRAINT entity_paper_id_fkey FOREIGN KEY (paper_id) REFERENCES dev.paper(s2_id) ON DELETE CASCADE;


--
-- Name: summary summary_paper_id_fkey; Type: FK CONSTRAINT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.summary
    ADD CONSTRAINT summary_paper_id_fkey FOREIGN KEY (paper_id) REFERENCES dev.paper(s2_id) ON DELETE CASCADE;


--
-- Name: version version_paper_id_fkey; Type: FK CONSTRAINT; Schema: dev; Owner: -
--

ALTER TABLE ONLY dev.version
    ADD CONSTRAINT version_paper_id_fkey FOREIGN KEY (paper_id) REFERENCES dev.paper(s2_id);


--
-- PostgreSQL database dump complete
--

ALTER SCHEMA dev RENAME TO test;
