SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: trade_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.trade_type AS ENUM (
    'buy',
    'sell'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: etf_constituents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.etf_constituents (
    id bigint NOT NULL,
    name character varying,
    symbol character varying,
    weight numeric(11,8),
    etf_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: etf_constituents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.etf_constituents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: etf_constituents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.etf_constituents_id_seq OWNED BY public.etf_constituents.id;


--
-- Name: etfs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.etfs (
    id bigint NOT NULL,
    name character varying,
    symbol character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: etfs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.etfs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: etfs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.etfs_id_seq OWNED BY public.etfs.id;


--
-- Name: portfolios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.portfolios (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: portfolios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.portfolios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: portfolios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.portfolios_id_seq OWNED BY public.portfolios.id;


--
-- Name: prices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.prices (
    id bigint NOT NULL,
    amount numeric(10,2),
    currency character varying,
    etf_constituent_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: prices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.prices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.prices_id_seq OWNED BY public.prices.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: trackings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trackings (
    etf_id bigint NOT NULL,
    portfolio_id bigint NOT NULL,
    id bigint NOT NULL
);


--
-- Name: trackings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.trackings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trackings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.trackings_id_seq OWNED BY public.trackings.id;


--
-- Name: trades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trades (
    id bigint NOT NULL,
    amount integer,
    type public.trade_type NOT NULL,
    price numeric(10,2),
    currency character varying,
    etf_constituent_id bigint,
    tracking_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: COLUMN trades.amount; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.trades.amount IS 'Number of shares in trade';


--
-- Name: COLUMN trades.type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.trades.type IS 'Type of trade: buy or sell';


--
-- Name: trades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.trades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.trades_id_seq OWNED BY public.trades.id;


--
-- Name: etf_constituents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etf_constituents ALTER COLUMN id SET DEFAULT nextval('public.etf_constituents_id_seq'::regclass);


--
-- Name: etfs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etfs ALTER COLUMN id SET DEFAULT nextval('public.etfs_id_seq'::regclass);


--
-- Name: portfolios id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.portfolios ALTER COLUMN id SET DEFAULT nextval('public.portfolios_id_seq'::regclass);


--
-- Name: prices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prices ALTER COLUMN id SET DEFAULT nextval('public.prices_id_seq'::regclass);


--
-- Name: trackings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trackings ALTER COLUMN id SET DEFAULT nextval('public.trackings_id_seq'::regclass);


--
-- Name: trades id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trades ALTER COLUMN id SET DEFAULT nextval('public.trades_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: etf_constituents etf_constituents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etf_constituents
    ADD CONSTRAINT etf_constituents_pkey PRIMARY KEY (id);


--
-- Name: etfs etfs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etfs
    ADD CONSTRAINT etfs_pkey PRIMARY KEY (id);


--
-- Name: portfolios portfolios_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.portfolios
    ADD CONSTRAINT portfolios_pkey PRIMARY KEY (id);


--
-- Name: prices prices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT prices_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: trackings trackings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trackings
    ADD CONSTRAINT trackings_pkey PRIMARY KEY (id);


--
-- Name: trades trades_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT trades_pkey PRIMARY KEY (id);


--
-- Name: index_etf_constituents_on_etf_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_etf_constituents_on_etf_id ON public.etf_constituents USING btree (etf_id);


--
-- Name: index_etf_constituents_on_symbol; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_etf_constituents_on_symbol ON public.etf_constituents USING btree (symbol);


--
-- Name: index_etfs_on_symbol; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_etfs_on_symbol ON public.etfs USING btree (symbol);


--
-- Name: index_prices_on_etf_constituent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prices_on_etf_constituent_id ON public.prices USING btree (etf_constituent_id);


--
-- Name: index_trackings_on_portfolio_id_and_etf_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_trackings_on_portfolio_id_and_etf_id ON public.trackings USING btree (portfolio_id, etf_id);


--
-- Name: index_trades_on_etf_constituent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_trades_on_etf_constituent_id ON public.trades USING btree (etf_constituent_id);


--
-- Name: index_trades_on_tracking_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_trades_on_tracking_id ON public.trades USING btree (tracking_id);


--
-- Name: prices fk_rails_332cd32f07; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT fk_rails_332cd32f07 FOREIGN KEY (etf_constituent_id) REFERENCES public.etf_constituents(id);


--
-- Name: trades fk_rails_de7ed040ef; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT fk_rails_de7ed040ef FOREIGN KEY (etf_constituent_id) REFERENCES public.etf_constituents(id);


--
-- Name: trades fk_rails_e685b1fb34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT fk_rails_e685b1fb34 FOREIGN KEY (tracking_id) REFERENCES public.trackings(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20180819152922'),
('20180820045830'),
('20180820050239'),
('20180820051447'),
('20180821052707'),
('20180823051017'),
('20180823055127'),
('20180824052440');


