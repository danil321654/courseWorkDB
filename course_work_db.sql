--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.4

-- Started on 2020-11-30 22:40:42

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
-- TOC entry 2983 (class 1262 OID 28230)
-- Name: pharmacy_shop; Type: DATABASE; Schema: -; Owner: postgres
--

--CREATE DATABASE pharmacy_shop WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1252' LC_CTYPE = 'Russian_Russia.1252';


ALTER DATABASE pharmacy_shop OWNER TO postgres;

\connect pharmacy_shop

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
-- TOC entry 241 (class 1255 OID 30027)
-- Name: mytrigondelord(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.mytrigondelord() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        update "Drug" set in_stock = in_stock+OLD.quantity where id = OLD.drug_id;
        return  OLD;
END;
$$;


ALTER FUNCTION public.mytrigondelord() OWNER TO postgres;

--
-- TOC entry 240 (class 1255 OID 30025)
-- Name: mytrigondelord2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.mytrigondelord2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        update "Order" set order_cost = order_cost-OLD.full_price where id = OLD.order_id;
        return  OLD;
END;
$$;


ALTER FUNCTION public.mytrigondelord2() OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 30021)
-- Name: mytrigonneword(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.mytrigonneword() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        update "Drug" set in_stock = in_stock-NEW.quantity where id = new.drug_id;
        return  old;
END;
$$;


ALTER FUNCTION public.mytrigonneword() OWNER TO postgres;

--
-- TOC entry 239 (class 1255 OID 30023)
-- Name: mytrigonneword2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.mytrigonneword2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    new.full_price = (SELECT price FROM "Drug" WHERE NEW.drug_id=id)*NEW.quantity;
        return  new;
END;
$$;


ALTER FUNCTION public.mytrigonneword2() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 29904)
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    parent integer
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 29902)
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Category_id_seq" OWNER TO postgres;

--
-- TOC entry 2986 (class 0 OID 0)
-- Dependencies: 214
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- TOC entry 203 (class 1259 OID 29834)
-- Name: Client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Client" (
    id integer NOT NULL,
    surname character varying(20) NOT NULL,
    name character varying(20) NOT NULL,
    patronymic character varying(20) NOT NULL,
    birth_year integer NOT NULL,
    login character varying(20) NOT NULL,
    email character varying(20) NOT NULL,
    password character varying(32) NOT NULL,
    phone character varying(15) NOT NULL,
    CONSTRAINT checkbirthdate CHECK (((birth_year >= ((date_part('year'::text, CURRENT_DATE))::integer - 120)) AND (birth_year <= ((date_part('year'::text, CURRENT_DATE))::integer - 18))))
);


ALTER TABLE public."Client" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 29832)
-- Name: Client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Client_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Client_id_seq" OWNER TO postgres;

--
-- TOC entry 2987 (class 0 OID 0)
-- Dependencies: 202
-- Name: Client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Client_id_seq" OWNED BY public."Client".id;


--
-- TOC entry 207 (class 1259 OID 29863)
-- Name: Delivery_pharmacy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Delivery_pharmacy" (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    city character varying(20) NOT NULL,
    address character varying(20) NOT NULL,
    schedule text
);


ALTER TABLE public."Delivery_pharmacy" OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 29861)
-- Name: Delivery_pharmacy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Delivery_pharmacy_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Delivery_pharmacy_id_seq" OWNER TO postgres;

--
-- TOC entry 2989 (class 0 OID 0)
-- Dependencies: 206
-- Name: Delivery_pharmacy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Delivery_pharmacy_id_seq" OWNED BY public."Delivery_pharmacy".id;


--
-- TOC entry 221 (class 1259 OID 29928)
-- Name: Drug; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Drug" (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    active_substance character varying(20) NOT NULL,
    description text NOT NULL,
    release_form character varying(20) NOT NULL,
    single_weight numeric NOT NULL,
    prescription boolean NOT NULL,
    manufacturer_id integer,
    category_id integer,
    in_stock integer NOT NULL,
    price numeric NOT NULL
);


ALTER TABLE public."Drug" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 29926)
-- Name: Drug_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Drug_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Drug_id_seq" OWNER TO postgres;

--
-- TOC entry 2991 (class 0 OID 0)
-- Dependencies: 220
-- Name: Drug_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Drug_id_seq" OWNED BY public."Drug".id;


--
-- TOC entry 205 (class 1259 OID 29849)
-- Name: Manager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Manager" (
    id integer NOT NULL,
    surname character varying(20) NOT NULL,
    name character varying(20) NOT NULL,
    patronymic character varying(20) NOT NULL,
    login character varying(20) NOT NULL,
    email character varying(20) NOT NULL,
    password character varying(32) NOT NULL,
    phone character varying(15) NOT NULL
);


ALTER TABLE public."Manager" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 29847)
-- Name: Manager_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Manager_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Manager_id_seq" OWNER TO postgres;

--
-- TOC entry 2992 (class 0 OID 0)
-- Dependencies: 204
-- Name: Manager_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Manager_id_seq" OWNED BY public."Manager".id;


--
-- TOC entry 217 (class 1259 OID 29912)
-- Name: Manufacturer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Manufacturer" (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    country character varying(20) NOT NULL
);


ALTER TABLE public."Manufacturer" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 29910)
-- Name: Manufacturer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Manufacturer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Manufacturer_id_seq" OWNER TO postgres;

--
-- TOC entry 2993 (class 0 OID 0)
-- Dependencies: 216
-- Name: Manufacturer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Manufacturer_id_seq" OWNED BY public."Manufacturer".id;


--
-- TOC entry 211 (class 1259 OID 29882)
-- Name: Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order" (
    id integer NOT NULL,
    client_id integer NOT NULL,
    delivery_pharmacy_id integer,
    status character varying(20) NOT NULL,
    order_cost numeric NOT NULL,
    date date NOT NULL,
    completion_date date,
    manager_id integer,
    stockman_id integer
);


ALTER TABLE public."Order" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 29947)
-- Name: Order_Drug; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order_Drug" (
    id integer NOT NULL,
    order_id integer NOT NULL,
    drug_id integer NOT NULL,
    quantity integer NOT NULL,
    full_price numeric NOT NULL
);


ALTER TABLE public."Order_Drug" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 29945)
-- Name: Order_Drug_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Order_Drug_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Order_Drug_id_seq" OWNER TO postgres;

--
-- TOC entry 2996 (class 0 OID 0)
-- Dependencies: 224
-- Name: Order_Drug_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_Drug_id_seq" OWNED BY public."Order_Drug".id;


--
-- TOC entry 210 (class 1259 OID 29880)
-- Name: Order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Order_id_seq" OWNER TO postgres;

--
-- TOC entry 2997 (class 0 OID 0)
-- Dependencies: 210
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- TOC entry 223 (class 1259 OID 29939)
-- Name: Picture; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Picture" (
    id integer NOT NULL,
    path character varying(50) NOT NULL,
    drug_id integer
);


ALTER TABLE public."Picture" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 29937)
-- Name: Picture_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Picture_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Picture_id_seq" OWNER TO postgres;

--
-- TOC entry 2999 (class 0 OID 0)
-- Dependencies: 222
-- Name: Picture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Picture_id_seq" OWNED BY public."Picture".id;


--
-- TOC entry 219 (class 1259 OID 29920)
-- Name: Prescription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Prescription" (
    id integer NOT NULL,
    form character varying(20) NOT NULL,
    date character varying(20),
    order_id integer NOT NULL
);


ALTER TABLE public."Prescription" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 29918)
-- Name: Prescription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Prescription_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Prescription_id_seq" OWNER TO postgres;

--
-- TOC entry 3001 (class 0 OID 0)
-- Dependencies: 218
-- Name: Prescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Prescription_id_seq" OWNED BY public."Prescription".id;


--
-- TOC entry 213 (class 1259 OID 29893)
-- Name: Receipt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Receipt" (
    id integer NOT NULL,
    order_id integer,
    cash boolean NOT NULL,
    payed numeric NOT NULL,
    date_time timestamp without time zone NOT NULL
);


ALTER TABLE public."Receipt" OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 29891)
-- Name: Receipt_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Receipt_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Receipt_id_seq" OWNER TO postgres;

--
-- TOC entry 3003 (class 0 OID 0)
-- Dependencies: 212
-- Name: Receipt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Receipt_id_seq" OWNED BY public."Receipt".id;


--
-- TOC entry 209 (class 1259 OID 29874)
-- Name: Stockman; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Stockman" (
    id integer NOT NULL,
    surname character varying(20) NOT NULL,
    name character varying(20) NOT NULL,
    patronymic character varying(20) NOT NULL,
    delivery_pharmacy_id integer,
    login character varying(20) NOT NULL,
    email character varying(20) NOT NULL,
    password character varying(32) NOT NULL,
    phone character varying(15) NOT NULL
);


ALTER TABLE public."Stockman" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 29872)
-- Name: Stockman_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Stockman_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Stockman_id_seq" OWNER TO postgres;

--
-- TOC entry 3004 (class 0 OID 0)
-- Dependencies: 208
-- Name: Stockman_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Stockman_id_seq" OWNED BY public."Stockman".id;


--
-- TOC entry 2769 (class 2604 OID 29907)
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- TOC entry 2762 (class 2604 OID 29837)
-- Name: Client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client" ALTER COLUMN id SET DEFAULT nextval('public."Client_id_seq"'::regclass);


--
-- TOC entry 2765 (class 2604 OID 29866)
-- Name: Delivery_pharmacy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delivery_pharmacy" ALTER COLUMN id SET DEFAULT nextval('public."Delivery_pharmacy_id_seq"'::regclass);


--
-- TOC entry 2772 (class 2604 OID 29931)
-- Name: Drug id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Drug" ALTER COLUMN id SET DEFAULT nextval('public."Drug_id_seq"'::regclass);


--
-- TOC entry 2764 (class 2604 OID 29852)
-- Name: Manager id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Manager" ALTER COLUMN id SET DEFAULT nextval('public."Manager_id_seq"'::regclass);


--
-- TOC entry 2770 (class 2604 OID 29915)
-- Name: Manufacturer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Manufacturer" ALTER COLUMN id SET DEFAULT nextval('public."Manufacturer_id_seq"'::regclass);


--
-- TOC entry 2767 (class 2604 OID 29885)
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- TOC entry 2774 (class 2604 OID 29950)
-- Name: Order_Drug id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Drug" ALTER COLUMN id SET DEFAULT nextval('public."Order_Drug_id_seq"'::regclass);


--
-- TOC entry 2773 (class 2604 OID 29942)
-- Name: Picture id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Picture" ALTER COLUMN id SET DEFAULT nextval('public."Picture_id_seq"'::regclass);


--
-- TOC entry 2771 (class 2604 OID 29923)
-- Name: Prescription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Prescription" ALTER COLUMN id SET DEFAULT nextval('public."Prescription_id_seq"'::regclass);


--
-- TOC entry 2768 (class 2604 OID 29896)
-- Name: Receipt id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Receipt" ALTER COLUMN id SET DEFAULT nextval('public."Receipt_id_seq"'::regclass);


--
-- TOC entry 2766 (class 2604 OID 29877)
-- Name: Stockman id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Stockman" ALTER COLUMN id SET DEFAULT nextval('public."Stockman_id_seq"'::regclass);


--
-- TOC entry 2967 (class 0 OID 29904)
-- Dependencies: 215
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Category" (id, name, parent) VALUES (1, 'all', NULL);
INSERT INTO public."Category" (id, name, parent) VALUES (2, 'analgetics', 1);


--
-- TOC entry 2955 (class 0 OID 29834)
-- Dependencies: 203
-- Data for Name: Client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Client" (id, surname, name, patronymic, birth_year, login, email, password, phone) VALUES (1, 'pupkin', 'pupkin', 'pupkin', 2000, 'danya', 'danya@pesya', 'sadasdadsadsd', '+78955555223');


--
-- TOC entry 2959 (class 0 OID 29863)
-- Dependencies: 207
-- Data for Name: Delivery_pharmacy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Delivery_pharmacy" (id, name, city, address, schedule) VALUES (1, 'apteka1', 'Moscow', 'ul. Lermontova 55', NULL);


--
-- TOC entry 2973 (class 0 OID 29928)
-- Dependencies: 221
-- Data for Name: Drug; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Drug" (id, name, active_substance, description, release_form, single_weight, prescription, manufacturer_id, category_id, in_stock, price) VALUES (1, 'aspirin', 'asp', 'bebebe', 'asfsadf', 100, false, 1, 2, 97, 50.50);
INSERT INTO public."Drug" (id, name, active_substance, description, release_form, single_weight, prescription, manufacturer_id, category_id, in_stock, price) VALUES (2, 'paracetamol', 'par', 'bebebe', 'asfsadf', 100, true, 1, 2, 117, 350.50);


--
-- TOC entry 2957 (class 0 OID 29849)
-- Dependencies: 205
-- Data for Name: Manager; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Manager" (id, surname, name, patronymic, login, email, password, phone) VALUES (1, 'pupkin', 'pupkin', 'pupkin', 'danya', 'danya@pesya', 'sadasdadsadsd', '+78955555223');


--
-- TOC entry 2969 (class 0 OID 29912)
-- Dependencies: 217
-- Data for Name: Manufacturer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Manufacturer" (id, name, country) VALUES (1, 'Organika', 'Russia');


--
-- TOC entry 2963 (class 0 OID 29882)
-- Dependencies: 211
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Order" (id, client_id, delivery_pharmacy_id, status, order_cost, date, completion_date, manager_id, stockman_id) VALUES (1, 1, 1, 'bebebe', 0, '2020-11-30', NULL, 1, 1);


--
-- TOC entry 2977 (class 0 OID 29947)
-- Dependencies: 225
-- Data for Name: Order_Drug; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Order_Drug" (id, order_id, drug_id, quantity, full_price) VALUES (1, 1, 1, 3, 151.50);
INSERT INTO public."Order_Drug" (id, order_id, drug_id, quantity, full_price) VALUES (2, 1, 2, 3, 1051.50);


--
-- TOC entry 2975 (class 0 OID 29939)
-- Dependencies: 223
-- Data for Name: Picture; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Picture" (id, path, drug_id) VALUES (1, '/pictures/aspirin.jpg', 1);
INSERT INTO public."Picture" (id, path, drug_id) VALUES (2, '/pictures/paracetamol.jpg', 2);


--
-- TOC entry 2971 (class 0 OID 29920)
-- Dependencies: 219
-- Data for Name: Prescription; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Prescription" (id, form, date, order_id) VALUES (1, '0-86y', '2020-11-30', 1);


--
-- TOC entry 2965 (class 0 OID 29893)
-- Dependencies: 213
-- Data for Name: Receipt; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Receipt" (id, order_id, cash, payed, date_time) VALUES (1, 1, true, 1300, '2020-11-30 19:13:11.674837');


--
-- TOC entry 2961 (class 0 OID 29874)
-- Dependencies: 209
-- Data for Name: Stockman; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Stockman" (id, surname, name, patronymic, delivery_pharmacy_id, login, email, password, phone) VALUES (1, 'pupkin', 'pupkin', 'pupkin', 1, 'danya', 'danya@pesya', 'sadasdadsadsd', '+78955555223');


--
-- TOC entry 3005 (class 0 OID 0)
-- Dependencies: 214
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Category_id_seq"', 1, false);


--
-- TOC entry 3006 (class 0 OID 0)
-- Dependencies: 202
-- Name: Client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Client_id_seq"', 1, false);


--
-- TOC entry 3007 (class 0 OID 0)
-- Dependencies: 206
-- Name: Delivery_pharmacy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Delivery_pharmacy_id_seq"', 1, false);


--
-- TOC entry 3008 (class 0 OID 0)
-- Dependencies: 220
-- Name: Drug_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Drug_id_seq"', 1, false);


--
-- TOC entry 3009 (class 0 OID 0)
-- Dependencies: 204
-- Name: Manager_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Manager_id_seq"', 1, false);


--
-- TOC entry 3010 (class 0 OID 0)
-- Dependencies: 216
-- Name: Manufacturer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Manufacturer_id_seq"', 1, false);


--
-- TOC entry 3011 (class 0 OID 0)
-- Dependencies: 224
-- Name: Order_Drug_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_Drug_id_seq"', 1, false);


--
-- TOC entry 3012 (class 0 OID 0)
-- Dependencies: 210
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 1, false);


--
-- TOC entry 3013 (class 0 OID 0)
-- Dependencies: 222
-- Name: Picture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Picture_id_seq"', 1, false);


--
-- TOC entry 3014 (class 0 OID 0)
-- Dependencies: 218
-- Name: Prescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Prescription_id_seq"', 1, false);


--
-- TOC entry 3015 (class 0 OID 0)
-- Dependencies: 212
-- Name: Receipt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Receipt_id_seq"', 1, false);


--
-- TOC entry 3016 (class 0 OID 0)
-- Dependencies: 208
-- Name: Stockman_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Stockman_id_seq"', 1, false);


--
-- TOC entry 2800 (class 2606 OID 29909)
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- TOC entry 2776 (class 2606 OID 29840)
-- Name: Client Client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (id);


--
-- TOC entry 2792 (class 2606 OID 29871)
-- Name: Delivery_pharmacy Delivery_pharmacy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delivery_pharmacy"
    ADD CONSTRAINT "Delivery_pharmacy_pkey" PRIMARY KEY (id);


--
-- TOC entry 2806 (class 2606 OID 29936)
-- Name: Drug Drug_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Drug"
    ADD CONSTRAINT "Drug_pkey" PRIMARY KEY (id);


--
-- TOC entry 2784 (class 2606 OID 29854)
-- Name: Manager Manager_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Manager"
    ADD CONSTRAINT "Manager_pkey" PRIMARY KEY (id);


--
-- TOC entry 2802 (class 2606 OID 29917)
-- Name: Manufacturer Manufacturer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Manufacturer"
    ADD CONSTRAINT "Manufacturer_pkey" PRIMARY KEY (id);


--
-- TOC entry 2810 (class 2606 OID 29955)
-- Name: Order_Drug Order_Drug_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Drug"
    ADD CONSTRAINT "Order_Drug_pkey" PRIMARY KEY (id);


--
-- TOC entry 2796 (class 2606 OID 29890)
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- TOC entry 2808 (class 2606 OID 29944)
-- Name: Picture Picture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Picture"
    ADD CONSTRAINT "Picture_pkey" PRIMARY KEY (id);


--
-- TOC entry 2804 (class 2606 OID 29925)
-- Name: Prescription Prescription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Prescription"
    ADD CONSTRAINT "Prescription_pkey" PRIMARY KEY (id);


--
-- TOC entry 2798 (class 2606 OID 29901)
-- Name: Receipt Receipt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Receipt"
    ADD CONSTRAINT "Receipt_pkey" PRIMARY KEY (id);


--
-- TOC entry 2794 (class 2606 OID 29879)
-- Name: Stockman Stockman_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Stockman"
    ADD CONSTRAINT "Stockman_pkey" PRIMARY KEY (id);


--
-- TOC entry 2786 (class 2606 OID 29858)
-- Name: Manager email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Manager"
    ADD CONSTRAINT email_unique UNIQUE (email);


--
-- TOC entry 2778 (class 2606 OID 29844)
-- Name: Client email_unique1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT email_unique1 UNIQUE (email);


--
-- TOC entry 2788 (class 2606 OID 29856)
-- Name: Manager login_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Manager"
    ADD CONSTRAINT login_unique UNIQUE (login);


--
-- TOC entry 2780 (class 2606 OID 29842)
-- Name: Client login_unique1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT login_unique1 UNIQUE (login);


--
-- TOC entry 2790 (class 2606 OID 29860)
-- Name: Manager phone_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Manager"
    ADD CONSTRAINT phone_unique UNIQUE (phone);


--
-- TOC entry 2782 (class 2606 OID 29846)
-- Name: Client phone_unique1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT phone_unique1 UNIQUE (phone);


--
-- TOC entry 2827 (class 2620 OID 30028)
-- Name: Order_Drug drug_after_delete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER drug_after_delete BEFORE DELETE ON public."Order_Drug" FOR EACH ROW EXECUTE PROCEDURE public.mytrigondelord();


--
-- TOC entry 2824 (class 2620 OID 30022)
-- Name: Order_Drug drug_after_insert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER drug_after_insert AFTER INSERT ON public."Order_Drug" FOR EACH ROW EXECUTE PROCEDURE public.mytrigonneword();


--
-- TOC entry 2826 (class 2620 OID 30026)
-- Name: Order_Drug order_after_delete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER order_after_delete BEFORE DELETE ON public."Order_Drug" FOR EACH ROW EXECUTE PROCEDURE public.mytrigondelord2();


--
-- TOC entry 2825 (class 2620 OID 30024)
-- Name: Order_Drug sumpartoforder; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER sumpartoforder BEFORE INSERT ON public."Order_Drug" FOR EACH ROW EXECUTE PROCEDURE public.mytrigonneword2();


--
-- TOC entry 2817 (class 2606 OID 29986)
-- Name: Category Category_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_parent_fkey" FOREIGN KEY (parent) REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2820 (class 2606 OID 29996)
-- Name: Drug Drug_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Drug"
    ADD CONSTRAINT "Drug_category_id_fkey" FOREIGN KEY (category_id) REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2819 (class 2606 OID 29991)
-- Name: Drug Drug_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Drug"
    ADD CONSTRAINT "Drug_manufacturer_id_fkey" FOREIGN KEY (manufacturer_id) REFERENCES public."Manufacturer"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2823 (class 2606 OID 30016)
-- Name: Order_Drug Order_Drug_drug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Drug"
    ADD CONSTRAINT "Order_Drug_drug_id_fkey" FOREIGN KEY (drug_id) REFERENCES public."Drug"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2822 (class 2606 OID 30011)
-- Name: Order_Drug Order_Drug_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Drug"
    ADD CONSTRAINT "Order_Drug_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2812 (class 2606 OID 29956)
-- Name: Order Order_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_client_id_fkey" FOREIGN KEY (client_id) REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2813 (class 2606 OID 29961)
-- Name: Order Order_delivery_pharmacy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_delivery_pharmacy_id_fkey" FOREIGN KEY (delivery_pharmacy_id) REFERENCES public."Delivery_pharmacy"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2814 (class 2606 OID 29971)
-- Name: Order Order_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_manager_id_fkey" FOREIGN KEY (manager_id) REFERENCES public."Manager"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2815 (class 2606 OID 29976)
-- Name: Order Order_stockman_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_stockman_id_fkey" FOREIGN KEY (stockman_id) REFERENCES public."Stockman"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2821 (class 2606 OID 30006)
-- Name: Picture Picture_drug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Picture"
    ADD CONSTRAINT "Picture_drug_id_fkey" FOREIGN KEY (drug_id) REFERENCES public."Drug"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2818 (class 2606 OID 30001)
-- Name: Prescription Prescription_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Prescription"
    ADD CONSTRAINT "Prescription_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2816 (class 2606 OID 29981)
-- Name: Receipt Receipt_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Receipt"
    ADD CONSTRAINT "Receipt_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2811 (class 2606 OID 29966)
-- Name: Stockman Stockman_delivery_pharmacy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Stockman"
    ADD CONSTRAINT "Stockman_delivery_pharmacy_id_fkey" FOREIGN KEY (delivery_pharmacy_id) REFERENCES public."Delivery_pharmacy"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2984 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

create role admin with password 'admin' login;

create role client with password 'client' login;

create role manager with password 'manager' login;

create role stockman with password 'stockman' login;


GRANT ALL ON ALL TABLES IN SCHEMA public TO admin;


--
-- TOC entry 2985 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE "Category"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Category" TO manager;
GRANT SELECT ON TABLE public."Category" TO client;


--
-- TOC entry 2988 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE "Delivery_pharmacy"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Delivery_pharmacy" TO manager;
GRANT SELECT ON TABLE public."Delivery_pharmacy" TO client;


--
-- TOC entry 2990 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE "Drug"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Drug" TO manager;
GRANT SELECT ON TABLE public."Drug" TO client;


--
-- TOC entry 2994 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE "Order"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Order" TO manager;
GRANT ALL ON TABLE public."Order" TO stockman;
GRANT SELECT ON TABLE public."Order" TO client;


--
-- TOC entry 2995 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE "Order_Drug"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Order_Drug" TO manager;
GRANT ALL ON TABLE public."Order_Drug" TO stockman;
GRANT SELECT ON TABLE public."Order_Drug" TO client;


--
-- TOC entry 2998 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE "Picture"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Picture" TO manager;
GRANT SELECT ON TABLE public."Picture" TO client;


--
-- TOC entry 3000 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE "Prescription"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Prescription" TO manager;
GRANT ALL ON TABLE public."Prescription" TO stockman;
GRANT SELECT ON TABLE public."Prescription" TO client;


--
-- TOC entry 3002 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE "Receipt"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Receipt" TO manager;
GRANT ALL ON TABLE public."Receipt" TO stockman;
GRANT SELECT ON TABLE public."Receipt" TO client;


-- Completed on 2020-11-30 22:40:43

--
-- PostgreSQL database dump complete
--

