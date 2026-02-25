--
-- PostgreSQL database cluster dump
--

-- Started on 2026-02-25 21:05:39

\restrict vSGTivqle0zqWBM5gtRycwlmpSLzqkDcbxCgZky8NSxNE6YYhKdxZm6M5ChErvd

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:/ioxMLlem8iWVmRP/uuJcQ==$fM64PfRWkE2cL1s1MD42v9ohxiO3vhjsvLGlZaVr8S4=:wQKQiu6uvfeTrp2pyZ8pXtYxiQ06XrwDuapYw38Az70=';

--
-- User Configurations
--








\unrestrict vSGTivqle0zqWBM5gtRycwlmpSLzqkDcbxCgZky8NSxNE6YYhKdxZm6M5ChErvd

--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

\restrict pTtcMTElyXjUu0A7cCGMefkEdBS9gyIvly1bJcnBvd39FZjkav8hChrfAdefwJG

-- Dumped from database version 17.4
-- Dumped by pg_dump version 18.1

-- Started on 2026-02-25 21:05:39

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

-- Completed on 2026-02-25 21:05:40

--
-- PostgreSQL database dump complete
--

\unrestrict pTtcMTElyXjUu0A7cCGMefkEdBS9gyIvly1bJcnBvd39FZjkav8hChrfAdefwJG

--
-- Database "headset" dump
--

--
-- PostgreSQL database dump
--

\restrict hHp6nULCLgPB7tLX2KfMeJRWdgEdBBfMP6O4558c5cyO0dNPizpAn8cdyz3aHaA

-- Dumped from database version 17.4
-- Dumped by pg_dump version 18.1

-- Started on 2026-02-25 21:05:40

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
-- TOC entry 4945 (class 1262 OID 525676)
-- Name: headset; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE headset WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'ru-RU';


ALTER DATABASE headset OWNER TO postgres;

\unrestrict hHp6nULCLgPB7tLX2KfMeJRWdgEdBBfMP6O4558c5cyO0dNPizpAn8cdyz3aHaA
\connect headset
\restrict hHp6nULCLgPB7tLX2KfMeJRWdgEdBBfMP6O4558c5cyO0dNPizpAn8cdyz3aHaA

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 525688)
-- Name: headsets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.headsets (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    brand character varying(100) NOT NULL,
    price numeric(10,2) NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    description text,
    is_wireless boolean DEFAULT false NOT NULL,
    CONSTRAINT headsets_price_check CHECK ((price >= (0)::numeric)),
    CONSTRAINT headsets_stock_check CHECK ((stock >= 0))
);


ALTER TABLE public.headsets OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 525687)
-- Name: headsets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.headsets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.headsets_id_seq OWNER TO postgres;

--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 219
-- Name: headsets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.headsets_id_seq OWNED BY public.headsets.id;


--
-- TOC entry 224 (class 1259 OID 525716)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    headset_id integer NOT NULL,
    quantity integer NOT NULL,
    price_at_moment numeric(10,2) NOT NULL,
    CONSTRAINT order_items_price_at_moment_check CHECK ((price_at_moment >= (0)::numeric)),
    CONSTRAINT order_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 525715)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 223
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- TOC entry 222 (class 1259 OID 525701)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id integer NOT NULL,
    status character varying(20) DEFAULT 'new'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY ((ARRAY['new'::character varying, 'processing'::character varying, 'done'::character varying])::text[])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 525700)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 221
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 218 (class 1259 OID 525678)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(150) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(20) NOT NULL,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['client'::character varying, 'manager'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 525677)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4758 (class 2604 OID 525691)
-- Name: headsets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.headsets ALTER COLUMN id SET DEFAULT nextval('public.headsets_id_seq'::regclass);


--
-- TOC entry 4764 (class 2604 OID 525719)
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- TOC entry 4761 (class 2604 OID 525704)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 4757 (class 2604 OID 525681)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4935 (class 0 OID 525688)
-- Dependencies: 220
-- Data for Name: headsets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.headsets (id, name, brand, price, stock, description, is_wireless) FROM stdin;
\.


--
-- TOC entry 4939 (class 0 OID 525716)
-- Dependencies: 224
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, headset_id, quantity, price_at_moment) FROM stdin;
\.


--
-- TOC entry 4937 (class 0 OID 525701)
-- Dependencies: 222
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, user_id, status, created_at) FROM stdin;
\.


--
-- TOC entry 4933 (class 0 OID 525678)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password, role) FROM stdin;
\.


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 219
-- Name: headsets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.headsets_id_seq', 1, false);


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 223
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 1, false);


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 221
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 4776 (class 2606 OID 525699)
-- Name: headsets headsets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.headsets
    ADD CONSTRAINT headsets_pkey PRIMARY KEY (id);


--
-- TOC entry 4783 (class 2606 OID 525723)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4779 (class 2606 OID 525709)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4772 (class 2606 OID 525684)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4774 (class 2606 OID 525686)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4780 (class 1259 OID 525736)
-- Name: idx_order_items_headset_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_items_headset_id ON public.order_items USING btree (headset_id);


--
-- TOC entry 4781 (class 1259 OID 525735)
-- Name: idx_order_items_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_items_order_id ON public.order_items USING btree (order_id);


--
-- TOC entry 4777 (class 1259 OID 525734)
-- Name: idx_orders_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_user_id ON public.orders USING btree (user_id);


--
-- TOC entry 4785 (class 2606 OID 525729)
-- Name: order_items fk_order_items_headset; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_order_items_headset FOREIGN KEY (headset_id) REFERENCES public.headsets(id) ON DELETE RESTRICT;


--
-- TOC entry 4786 (class 2606 OID 525724)
-- Name: order_items fk_order_items_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- TOC entry 4784 (class 2606 OID 525710)
-- Name: orders fk_orders_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2026-02-25 21:05:40

--
-- PostgreSQL database dump complete
--

\unrestrict hHp6nULCLgPB7tLX2KfMeJRWdgEdBBfMP6O4558c5cyO0dNPizpAn8cdyz3aHaA

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict juYH0XtFUxiAyk6oMzeeqGmhTbc99DVVLYdoGFUfF6lBROs1IugnOPhbthlLs77

-- Dumped from database version 17.4
-- Dumped by pg_dump version 18.1

-- Started on 2026-02-25 21:05:40

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
-- TOC entry 7 (class 2615 OID 16388)
-- Name: pgagent; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pgagent;


ALTER SCHEMA pgagent OWNER TO postgres;

--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA pgagent; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA pgagent IS 'pgAgent system tables';


--
-- TOC entry 2 (class 3079 OID 16389)
-- Name: pgagent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgagent WITH SCHEMA pgagent;


--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgagent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgagent IS 'A PostgreSQL job scheduler';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 243 (class 1259 OID 517342)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 517341)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 242
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 257 (class 1259 OID 517467)
-- Name: import_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.import_orders (
    order_id integer,
    items_raw text,
    order_date date,
    delivery_date date,
    pickup_point_id integer,
    client_full_name character varying(150),
    receive_code integer,
    status_name character varying(50)
);


ALTER TABLE public.import_orders OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 517459)
-- Name: import_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.import_products (
    article character varying(20),
    product_name character varying(200),
    unit character varying(20),
    price integer,
    supplier_name character varying(100),
    manufacturer_name character varying(100),
    category_name character varying(100),
    discount integer,
    stock_qty integer,
    description text,
    photo character varying(100)
);


ALTER TABLE public.import_products OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 517464)
-- Name: import_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.import_users (
    role_name character varying(50),
    full_name character varying(150),
    login character varying(100),
    password character varying(50)
);


ALTER TABLE public.import_users OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 517360)
-- Name: manufacturers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manufacturers (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.manufacturers OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 517359)
-- Name: manufacturers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manufacturers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manufacturers_id_seq OWNER TO postgres;

--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 246
-- Name: manufacturers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manufacturers_id_seq OWNED BY public.manufacturers.id;


--
-- TOC entry 254 (class 1259 OID 517425)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_article character varying(20) NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT order_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 517424)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 253
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- TOC entry 251 (class 1259 OID 517396)
-- Name: order_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_statuses (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.order_statuses OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 517395)
-- Name: order_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_statuses_id_seq OWNER TO postgres;

--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 250
-- Name: order_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_statuses_id_seq OWNED BY public.order_statuses.id;


--
-- TOC entry 252 (class 1259 OID 517404)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    order_date date NOT NULL,
    delivery_date date NOT NULL,
    pickup_point_id integer NOT NULL,
    client_id integer NOT NULL,
    receive_code integer NOT NULL,
    status_id integer NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 517390)
-- Name: pickup_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickup_points (
    id integer NOT NULL,
    zip_code character varying(10),
    city character varying(50),
    street character varying(200)
);


ALTER TABLE public.pickup_points OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 517368)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    article character varying(20) NOT NULL,
    name character varying(200) NOT NULL,
    unit character varying(20) NOT NULL,
    price integer NOT NULL,
    supplier_id integer NOT NULL,
    manufacturer_id integer NOT NULL,
    category_id integer NOT NULL,
    discount integer NOT NULL,
    stock_qty integer NOT NULL,
    description text,
    photo character varying(100)
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 517319)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 517318)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 238
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 245 (class 1259 OID 517351)
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 517350)
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.suppliers_id_seq OWNER TO postgres;

--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 244
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- TOC entry 241 (class 1259 OID 517328)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    full_name character varying(150) NOT NULL,
    login character varying(100) NOT NULL,
    password character varying(50) NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 517327)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 240
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4879 (class 2604 OID 517345)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4881 (class 2604 OID 517363)
-- Name: manufacturers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers ALTER COLUMN id SET DEFAULT nextval('public.manufacturers_id_seq'::regclass);


--
-- TOC entry 4883 (class 2604 OID 517428)
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- TOC entry 4882 (class 2604 OID 517399)
-- Name: order_statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses ALTER COLUMN id SET DEFAULT nextval('public.order_statuses_id_seq'::regclass);


--
-- TOC entry 4877 (class 2604 OID 517322)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4880 (class 2604 OID 517354)
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- TOC entry 4878 (class 2604 OID 517331)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4839 (class 0 OID 16390)
-- Dependencies: 223
-- Data for Name: pga_jobagent; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobagent (jagpid, jaglogintime, jagstation) FROM stdin;
9708	2026-02-25 17:19:53.096498+05	DESKTOP-OSM70AB
\.


--
-- TOC entry 4840 (class 0 OID 16399)
-- Dependencies: 225
-- Data for Name: pga_jobclass; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobclass (jclid, jclname) FROM stdin;
\.


--
-- TOC entry 4841 (class 0 OID 16409)
-- Dependencies: 227
-- Data for Name: pga_job; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_job (jobid, jobjclid, jobname, jobdesc, jobhostagent, jobenabled, jobcreated, jobchanged, jobagentid, jobnextrun, joblastrun) FROM stdin;
\.


--
-- TOC entry 4843 (class 0 OID 16457)
-- Dependencies: 231
-- Data for Name: pga_schedule; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_schedule (jscid, jscjobid, jscname, jscdesc, jscenabled, jscstart, jscend, jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths) FROM stdin;
\.


--
-- TOC entry 4844 (class 0 OID 16485)
-- Dependencies: 233
-- Data for Name: pga_exception; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_exception (jexid, jexscid, jexdate, jextime) FROM stdin;
\.


--
-- TOC entry 4845 (class 0 OID 16499)
-- Dependencies: 235
-- Data for Name: pga_joblog; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_joblog (jlgid, jlgjobid, jlgstatus, jlgstart, jlgduration) FROM stdin;
\.


--
-- TOC entry 4842 (class 0 OID 16433)
-- Dependencies: 229
-- Data for Name: pga_jobstep; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobstep (jstid, jstjobid, jstname, jstdesc, jstenabled, jstkind, jstcode, jstconnstr, jstdbname, jstonerror, jscnextrun) FROM stdin;
\.


--
-- TOC entry 4846 (class 0 OID 16515)
-- Dependencies: 237
-- Data for Name: pga_jobsteplog; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobsteplog (jslid, jsljlgid, jsljstid, jslstatus, jslresult, jslstart, jslduration, jsloutput) FROM stdin;
\.


--
-- TOC entry 5112 (class 0 OID 517342)
-- Dependencies: 243
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name) FROM stdin;
\.


--
-- TOC entry 5126 (class 0 OID 517467)
-- Dependencies: 257
-- Data for Name: import_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.import_orders (order_id, items_raw, order_date, delivery_date, pickup_point_id, client_full_name, receive_code, status_name) FROM stdin;
\.


--
-- TOC entry 5124 (class 0 OID 517459)
-- Dependencies: 255
-- Data for Name: import_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.import_products (article, product_name, unit, price, supplier_name, manufacturer_name, category_name, discount, stock_qty, description, photo) FROM stdin;
\.


--
-- TOC entry 5125 (class 0 OID 517464)
-- Dependencies: 256
-- Data for Name: import_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.import_users (role_name, full_name, login, password) FROM stdin;
\.


--
-- TOC entry 5116 (class 0 OID 517360)
-- Dependencies: 247
-- Data for Name: manufacturers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.manufacturers (id, name) FROM stdin;
\.


--
-- TOC entry 5123 (class 0 OID 517425)
-- Dependencies: 254
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_article, quantity) FROM stdin;
\.


--
-- TOC entry 5120 (class 0 OID 517396)
-- Dependencies: 251
-- Data for Name: order_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_statuses (id, name) FROM stdin;
\.


--
-- TOC entry 5121 (class 0 OID 517404)
-- Dependencies: 252
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, order_date, delivery_date, pickup_point_id, client_id, receive_code, status_id) FROM stdin;
\.


--
-- TOC entry 5118 (class 0 OID 517390)
-- Dependencies: 249
-- Data for Name: pickup_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pickup_points (id, zip_code, city, street) FROM stdin;
\.


--
-- TOC entry 5117 (class 0 OID 517368)
-- Dependencies: 248
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (article, name, unit, price, supplier_id, manufacturer_id, category_id, discount, stock_qty, description, photo) FROM stdin;
\.


--
-- TOC entry 5108 (class 0 OID 517319)
-- Dependencies: 239
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name) FROM stdin;
\.


--
-- TOC entry 5114 (class 0 OID 517351)
-- Dependencies: 245
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, name) FROM stdin;
\.


--
-- TOC entry 5110 (class 0 OID 517328)
-- Dependencies: 241
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, full_name, login, password, role_id) FROM stdin;
\.


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 242
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 246
-- Name: manufacturers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manufacturers_id_seq', 1, false);


--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 253
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 1, false);


--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 250
-- Name: order_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_statuses_id_seq', 1, false);


--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 238
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 244
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 1, false);


--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 240
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 4928 (class 2606 OID 517349)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 4930 (class 2606 OID 517347)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4936 (class 2606 OID 517367)
-- Name: manufacturers manufacturers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_name_key UNIQUE (name);


--
-- TOC entry 4938 (class 2606 OID 517365)
-- Name: manufacturers manufacturers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_pkey PRIMARY KEY (id);


--
-- TOC entry 4950 (class 2606 OID 517433)
-- Name: order_items order_items_order_id_product_article_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_product_article_key UNIQUE (order_id, product_article);


--
-- TOC entry 4952 (class 2606 OID 517431)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4944 (class 2606 OID 517403)
-- Name: order_statuses order_statuses_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_name_key UNIQUE (name);


--
-- TOC entry 4946 (class 2606 OID 517401)
-- Name: order_statuses order_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 4948 (class 2606 OID 517408)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4942 (class 2606 OID 517394)
-- Name: pickup_points pickup_points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_pkey PRIMARY KEY (id);


--
-- TOC entry 4940 (class 2606 OID 517374)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (article);


--
-- TOC entry 4920 (class 2606 OID 517326)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 4922 (class 2606 OID 517324)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4932 (class 2606 OID 517358)
-- Name: suppliers suppliers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_name_key UNIQUE (name);


--
-- TOC entry 4934 (class 2606 OID 517356)
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- TOC entry 4924 (class 2606 OID 517335)
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- TOC entry 4926 (class 2606 OID 517333)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4960 (class 2606 OID 517434)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- TOC entry 4961 (class 2606 OID 517439)
-- Name: order_items order_items_product_article_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_article_fkey FOREIGN KEY (product_article) REFERENCES public.products(article);


--
-- TOC entry 4957 (class 2606 OID 517414)
-- Name: orders orders_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.users(id);


--
-- TOC entry 4958 (class 2606 OID 517409)
-- Name: orders orders_pickup_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pickup_point_id_fkey FOREIGN KEY (pickup_point_id) REFERENCES public.pickup_points(id);


--
-- TOC entry 4959 (class 2606 OID 517419)
-- Name: orders orders_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.order_statuses(id);


--
-- TOC entry 4954 (class 2606 OID 517385)
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- TOC entry 4955 (class 2606 OID 517380)
-- Name: products products_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturers(id);


--
-- TOC entry 4956 (class 2606 OID 517375)
-- Name: products products_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- TOC entry 4953 (class 2606 OID 517336)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


-- Completed on 2026-02-25 21:05:40

--
-- PostgreSQL database dump complete
--

\unrestrict juYH0XtFUxiAyk6oMzeeqGmhTbc99DVVLYdoGFUfF6lBROs1IugnOPhbthlLs77

-- Completed on 2026-02-25 21:05:40

--
-- PostgreSQL database cluster dump complete
--

