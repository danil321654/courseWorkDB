--
-- PostgreSQL database dump
--

-- Dumped from database version 10.14 (Ubuntu 10.14-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.14 (Ubuntu 10.14-0ubuntu0.18.04.1)

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: add_admin_backup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.add_admin_backup() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
        current_row RECORD;
    BEGIN
        IF (TG_OP = 'INSERT'  ) THEN
            current_row := NEW;
        ELSIF (TG_OP = 'DELETE'OR TG_OP = 'UPDATE' ) THEN
            current_row := OLD;
        END IF;

        INSERT INTO "Admin_backup" ( type, old_id, client_id, change_time) VALUES (TG_OP, current_row.id, current_row.client_id,  now());

        IF (TG_OP = 'INSERT'  OR TG_OP = 'UPDATE') THEN
            RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            RETURN OLD;
        END IF;

    END;


$$;


ALTER FUNCTION public.add_admin_backup() OWNER TO admin;

--
-- Name: add_category_backup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.add_category_backup() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
        current_row RECORD;
    BEGIN
        IF (TG_OP = 'INSERT'  ) THEN
            current_row := NEW;
        ELSIF (TG_OP = 'DELETE'OR TG_OP = 'UPDATE' ) THEN
            current_row := OLD;
        END IF;

        INSERT INTO "Category_backup" ( type, old_id, name, parent, change_time) VALUES (TG_OP, current_row.id, current_row.name, current_row.parent,  now());

        IF (TG_OP = 'INSERT'  OR TG_OP = 'UPDATE') THEN
            RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            RETURN OLD;
        END IF;

    END;


$$;


ALTER FUNCTION public.add_category_backup() OWNER TO admin;

--
-- Name: add_client_backup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.add_client_backup() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
        current_row RECORD;
    BEGIN
        IF (TG_OP = 'INSERT'  ) THEN
            current_row := NEW;
        ELSIF (TG_OP = 'DELETE'OR TG_OP = 'UPDATE' ) THEN
            current_row := OLD;
        END IF;

        INSERT INTO "Client_backup" ( type, old_id, surname, name, patronymic, birth_year, login, email, password, phone, change_time)
        VALUES (TG_OP, current_row.id, current_row.surname, current_row.name, current_row.patronymic, current_row.birth_year, current_row.login, current_row.email, current_row.password, current_row.phone,  now());

        IF (TG_OP = 'INSERT'  OR TG_OP = 'UPDATE') THEN
            RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            RETURN OLD;
        END IF;

    END;


$$;


ALTER FUNCTION public.add_client_backup() OWNER TO admin;

--
-- Name: add_delivery_pharmacy_backup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.add_delivery_pharmacy_backup() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
        current_row RECORD;
    BEGIN
        IF (TG_OP = 'INSERT'  ) THEN
            current_row := NEW;
        ELSIF (TG_OP = 'DELETE'OR TG_OP = 'UPDATE' ) THEN
            current_row := OLD;
        END IF;

        INSERT INTO "Delivery_pharmacy_backup" ( type, old_id, name, city, address, schedule, change_time)
        VALUES (TG_OP, current_row.id, current_row.name, current_row.city, current_row.address, current_row.schedule, now());

        IF (TG_OP = 'INSERT'  OR TG_OP = 'UPDATE') THEN
            RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            RETURN OLD;
        END IF;

    END;


$$;


ALTER FUNCTION public.add_delivery_pharmacy_backup() OWNER TO admin;

--
-- Name: add_drug_backup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.add_drug_backup() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
        current_row RECORD;
    BEGIN
        IF (TG_OP = 'INSERT'  ) THEN
            current_row := NEW;
        ELSIF (TG_OP = 'DELETE'OR TG_OP = 'UPDATE' ) THEN
            current_row := OLD;
        END IF;

        INSERT INTO "Drug_backup" ( type, old_id, name, active_substance, description,release_form,single_weight,prescription,manufacturer_id,category_id,
in_stock,
price, change_time) VALUES (TG_OP, current_row.id, current_row.name, current_row.active_substance, current_row.description,current_row.release_form,current_row.single_weight, current_row.prescription,current_row.manufacturer_id, current_row.category_id, current_row.in_stock,current_row.price , now());

        IF (TG_OP = 'INSERT'  OR TG_OP = 'UPDATE') THEN
            RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            RETURN OLD;
        END IF;

    END;


$$;


ALTER FUNCTION public.add_drug_backup() OWNER TO admin;

--
-- Name: add_manager_backup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.add_manager_backup() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
        current_row RECORD;
    BEGIN
        IF (TG_OP = 'INSERT'  ) THEN
            current_row := NEW;
        ELSIF (TG_OP = 'DELETE'OR TG_OP = 'UPDATE' ) THEN
            current_row := OLD;
        END IF;

        INSERT INTO "Manager_backup" ( type, old_id, client_id, change_time)
        VALUES (TG_OP, current_row.id, current_row.client_id, now());

        IF (TG_OP = 'INSERT'  OR TG_OP = 'UPDATE') THEN
            RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            RETURN OLD;
        END IF;

    END;


$$;


ALTER FUNCTION public.add_manager_backup() OWNER TO admin;

--
-- Name: add_manufacturer_backup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.add_manufacturer_backup() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
        current_row RECORD;
    BEGIN
        IF (TG_OP = 'INSERT'  ) THEN
            current_row := NEW;
        ELSIF (TG_OP = 'DELETE'OR TG_OP = 'UPDATE' ) THEN
            current_row := OLD;
        END IF;

        INSERT INTO "Manufacturer_backup" ( type, old_id, name, country, change_time)
        VALUES (TG_OP, current_row.id, current_row.name, current_row.country, now());

        IF (TG_OP = 'INSERT'  OR TG_OP = 'UPDATE') THEN
            RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            RETURN OLD;
        END IF;

    END;


$$;


ALTER FUNCTION public.add_manufacturer_backup() OWNER TO admin;

--
-- Name: add_order_backup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.add_order_backup() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
        current_row RECORD;
    BEGIN
        IF (TG_OP = 'INSERT'  ) THEN
            current_row := NEW;
        ELSIF (TG_OP = 'DELETE'OR TG_OP = 'UPDATE' ) THEN
            current_row := OLD;
        END IF;

        INSERT INTO "Order_backup" ( type, old_id, client_id, delivery_pharmacy_id, status, order_cost, date, completion_date, manager_id, stockman_id, change_time)
        VALUES (TG_OP, current_row.id, current_row.client_id, current_row.delivery_pharmacy_id, current_row.status, current_row.order_cost, current_row.date, current_row.completion_date, current_row.manager_id, current_row.stockman_id, now());

        IF (TG_OP = 'INSERT'  OR TG_OP = 'UPDATE') THEN
            RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            RETURN OLD;
        END IF;

    END;


$$;


ALTER FUNCTION public.add_order_backup() OWNER TO admin;

--
-- Name: add_picture_backup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.add_picture_backup() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
        current_row RECORD;
    BEGIN
        IF (TG_OP = 'INSERT'  ) THEN
            current_row := NEW;
        ELSIF (TG_OP = 'DELETE'OR TG_OP = 'UPDATE' ) THEN
            current_row := OLD;
        END IF;

        INSERT INTO "Picture_backup" ( type, old_id, drug_id, path, change_time)
        VALUES (TG_OP, current_row.id, current_row.drug_id, current_row.path, now());

        IF (TG_OP = 'INSERT'  OR TG_OP = 'UPDATE') THEN
            RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            RETURN OLD;
        END IF;

    END;


$$;


ALTER FUNCTION public.add_picture_backup() OWNER TO admin;

--
-- Name: add_receipt_backup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.add_receipt_backup() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
        current_row RECORD;
    BEGIN
        IF (TG_OP = 'INSERT'  ) THEN
            current_row := NEW;
        ELSIF (TG_OP = 'DELETE'OR TG_OP = 'UPDATE' ) THEN
            current_row := OLD;
        END IF;

        INSERT INTO "Receipt_backup" ( type, old_id, order_id, cash, payed, date_time, change_time)
        VALUES (TG_OP, current_row.id, current_row.order_id, current_row.cash, current_row.payed, current_row.date_time, now());

        IF (TG_OP = 'INSERT'  OR TG_OP = 'UPDATE') THEN
            RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            RETURN OLD;
        END IF;

    END;


$$;


ALTER FUNCTION public.add_receipt_backup() OWNER TO admin;

--
-- Name: add_stockman_backup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.add_stockman_backup() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
        current_row RECORD;
    BEGIN
        IF (TG_OP = 'INSERT'  ) THEN
            current_row := NEW;
        ELSIF (TG_OP = 'DELETE'OR TG_OP = 'UPDATE' ) THEN
            current_row := OLD;
        END IF;

        INSERT INTO "Stockman_backup" ( type, old_id, delivery_pharmacy_id, client_id, change_time)
        VALUES (TG_OP, current_row.id, current_row.delivery_pharmacy_id, current_row.client_id, now());

        IF (TG_OP = 'INSERT'  OR TG_OP = 'UPDATE') THEN
            RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            RETURN OLD;
        END IF;

    END;


$$;


ALTER FUNCTION public.add_stockman_backup() OWNER TO admin;

--
-- Name: admnewbackup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.admnewbackup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        insert into journal(query_id, table_name) values (new.id,'Admin_backup');
        return  old;
END;
$$;


ALTER FUNCTION public.admnewbackup() OWNER TO admin;

--
-- Name: catnewbackup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.catnewbackup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        insert into journal(query_id, table_name) values (new.id,'Category_backup');
        return  old;
END;
$$;


ALTER FUNCTION public.catnewbackup() OWNER TO admin;

--
-- Name: clinewbackup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.clinewbackup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        insert into journal(query_id, table_name) values (new.id,'Client_backup');
        return  old;
END;
$$;


ALTER FUNCTION public.clinewbackup() OWNER TO admin;

--
-- Name: delphanewbackup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.delphanewbackup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        insert into journal(query_id, table_name) values (new.id,'Delivery_pharmacy_backup');
        return  old;
END;
$$;


ALTER FUNCTION public.delphanewbackup() OWNER TO admin;

--
-- Name: drugnewbackup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.drugnewbackup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        insert into journal(query_id, table_name) values (new.id,'Drug_backup');
        return  old;
END;
$$;


ALTER FUNCTION public.drugnewbackup() OWNER TO admin;

--
-- Name: managernewbackup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.managernewbackup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        insert into journal(query_id, table_name) values (new.id,'Manager_backup');
        return  old;
END;
$$;


ALTER FUNCTION public.managernewbackup() OWNER TO admin;

--
-- Name: manufacturernewbackup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.manufacturernewbackup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        insert into journal(query_id, table_name) values (new.id,'Manufacturer_backup');
        return  old;
END;
$$;


ALTER FUNCTION public.manufacturernewbackup() OWNER TO admin;

--
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

--
-- Name: mytrigonnewordpart(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.mytrigonnewordpart() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        update "Order" set order_cost = order_cost+NEW.full_price where id = new.order_id;
        return  old;
END;
$$;


ALTER FUNCTION public.mytrigonnewordpart() OWNER TO postgres;

--
-- Name: orderdrugnewbackup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.orderdrugnewbackup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    insert into journal(query_id, table_name) values (new.id, 'Order_Drug_backup');
    return old;
END;
$$;


ALTER FUNCTION public.orderdrugnewbackup() OWNER TO admin;

--
-- Name: ordernewbackup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.ordernewbackup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    insert into journal(query_id, table_name) values (new.id, 'Order_backup');
    return old;
END;
$$;


ALTER FUNCTION public.ordernewbackup() OWNER TO admin;

--
-- Name: picturenewbackup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.picturenewbackup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    insert into journal(query_id, table_name) values (new.id, 'Picture_backup');
    return old;
END;
$$;


ALTER FUNCTION public.picturenewbackup() OWNER TO admin;

--
-- Name: receiptnewbackup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.receiptnewbackup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    insert into journal(query_id, table_name) values (new.id, 'Receipt_backup');
    return old;
END;
$$;


ALTER FUNCTION public.receiptnewbackup() OWNER TO admin;

--
-- Name: stockmannewbackup(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.stockmannewbackup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    insert into journal(query_id, table_name) values (new.id, 'Stockman_backup');
    return old;
END;
$$;


ALTER FUNCTION public.stockmannewbackup() OWNER TO admin;

--
-- Name: undooper(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.undooper() RETURNS character varying
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
    lastTrId         integer;
    type             varchar(20);
    old_id           integer;
    tbl              varchar(20);
    tblOr            varchar(20);
    first_id         integer;
    second_id        integer;
    third_id         integer;
    fourth_id        integer;
    surname          varchar(20);
    name             varchar(20);
    patronymic       varchar(20);
    birth_year       integer;
    login            varchar(20);
    email            varchar(50);
    password         varchar(100);
    phone            varchar(15);
    city             varchar(20);
    address          varchar(20);
    schedule         text;
    active_substance varchar(20);
    description      text;
    release_form     varchar(20);
    single_weight    numeric;
    prescription     boolean;
    in_stock         integer;
    price            numeric;
    country          varchar(20);
    order_cost       numeric;
    status           varchar(20);
    date             date;
    completion_date  date;
    quantity         integer;
    full_price       numeric;
    path             varchar(30);
    cash             boolean;
    payed            numeric;
    date_time        timestamp;


BEGIN
    select table_name from "journal" ORDER BY id DESC LIMIT 1 into tbl;

    tblOr = substring(tbl, 0, length(tbl) - 6);

    select query_id from "journal" ORDER BY id DESC LIMIT 1 into lastTrId;

    IF (tblOr = 'Admin') THEN
        execute format(
                'select client_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;

    ELSIF (tblOr = 'Category') THEN
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select parent from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;

    ELSIF (tblOr = 'Category') THEN
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select parent from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;

    ELSIF (tblOr = 'Client') THEN
        execute format(
                'select surname from %s where id = %s;',
                format('%I', tbl), lastTrId) into surname;
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select patronymic from %s where id = %s;',
                format('%I', tbl), lastTrId) into patronymic;
        execute format(
                'select birth_year from %s where id = %s;',
                format('%I', tbl), lastTrId) into birth_year;
        execute format(
                'select login from %s where id = %s;',
                format('%I', tbl), lastTrId) into login;
        execute format(
                'select email from %s where id = %s;',
                format('%I', tbl), lastTrId) into email;
        execute format(
                'select password from %s where id = %s;',
                format('%I', tbl), lastTrId) into password;
        execute format(
                'select phone from %s where id = %s;',
                format('%I', tbl), lastTrId) into phone;


    ELSIF (tblOr = 'Delivery_pharmacy') THEN
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select city from %s where id = %s;',
                format('%I', tbl), lastTrId) into city;
        execute format(
                'select address from %s where id = %s;',
                format('%I', tbl), lastTrId) into address;
        execute format(
                'select schedule from %s where id = %s;',
                format('%I', tbl), lastTrId) into schedule;

    ELSIF (tblOr = 'Drug') THEN
        execute format('select name from %s where id = %s;', format('%I', tbl), lastTrId) into name;
        execute format('select active_substance from %s where id = %s;', format('%I', tbl),
                       lastTrId) into active_substance;
        execute format('select description from %s where id = %s;', format('%I', tbl), lastTrId) into description;
        execute format(
                'select release_form from %s where id = %s;',
                format('%I', tbl), lastTrId) into release_form;
        execute format(
                'select single_weight from %s where id = %s;',
                format('%I', tbl), lastTrId) into single_weight;
        execute format(
                'select prescription from %s where id = %s;',
                format('%I', tbl), lastTrId) into prescription;
        execute format(
                'select manufacturer_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;
        execute format(
                'select category_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into second_id;
        execute format('select in_stock from %s where id = %s;',
                       format('%I', tbl), lastTrId) into in_stock;
        execute format('select price from %s where id = %s;', format('%I', tbl), lastTrId) into price;


    ELSIF (tblOr = 'Manager') THEN
        execute format(
                'select client_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;


    ELSIF (tblOr = 'Manufacturer') THEN
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select country from %s where id = %s;',
                format('%I', tbl), lastTrId) into country;


    ELSIF (tblOr = 'Order') THEN
        execute format('select client_id from %s where id = %s;',
                       format('%I', tbl), lastTrId) into first_id;
        execute format('select delivery_pharmacy_id from %s where id = %s;',
                       format('%I', tbl), lastTrId) into second_id;
        execute format('select status from %s where id = %s;',
                       format('%I', tbl), lastTrId) into status;
        execute format(
                'select order_cost from %s where id = %s;',
                format('%I', tbl), lastTrId) into order_cost;
        execute format(
                'select date from %s where id = %s;',
                format('%I', tbl), lastTrId) into date;
        execute format(
                'select completion_date from %s where id = %s;',
                format('%I', tbl), lastTrId) into completion_date;
        execute format(
                'select manager_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into third_id;
        execute format(
                'select stockman_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into fourth_id;


    ELSIF (tblOr = 'Order_Drug') THEN
        execute format(
                'select order_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;
        execute format(
                'select drug_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into second_id;
        execute format(
                'select quantity from %s where id = %s;',
                format('%I', tbl), lastTrId) into quantity;
        execute format(
                'select full_price from %s where id = %s;',
                format('%I', tbl), lastTrId) into full_price;

    ELSIF (tblOr = 'Picture') THEN
        execute format(
                'select path from %s where id = %s;',
                format('%I', tbl), lastTrId) into path;
        execute format(
                'select drug_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;

    ELSIF (tblOr = 'Receipt') THEN
        execute format(
                'select order_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;
        execute format(
                'select cash from %s where id = %s;',
                format('%I', tbl), lastTrId) into cash;
        execute format(
                'select payed from %s where id = %s;',
                format('%I', tbl), lastTrId) into payed;
        execute format(
                'select date_time from %s where id = %s;',
                format('%I', tbl), lastTrId) into date_time;

    ELSIF (tblOr = 'Stockman') THEN
        execute format(
                'select delivery_pharmacy_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;
        execute format(
                'select client_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into second_id;

    END IF;


    execute format('select type from %s where id = %s;', format('%I', tbl), lastTrId) into type;
    execute format('select old_id from %s where id = %s;', format('%I', tbl), lastTrId) into old_id;

    IF (type = 'INSERT') THEN
        type = 'DELETE';
        execute format('%s from %s where id = %s;', type, format('%I', tblOr), old_id);
    ELSIF (type = 'DELETE') THEN
        type = 'INSERT';
        IF (tblOr = 'Admin') THEN
            execute format('%s into %s(id,client_id) values(%s,%s);', type, format('%I', tblOr), old_id, first_id);
        ELSIF (tblOr = 'Category') THEN

            execute format('%s into %s(id,name,parent) values(%s,%s,%s);', type, format('%I', tblOr), old_id, name,
                           first_id);
        ELSIF (tblOr = 'Client') THEN

            execute format(
                    '%s into %s(id, surname, name, patronymic, birth_year, login, email, password, phone) values (%s,%s,%s,%s,%s,%s,%s,%s,%s);',
                    type, format('%I', tblOr), old_id, quote_literal(surname),
                    quote_literal(name), quote_literal(patronymic), birth_year, quote_literal(login),
                    quote_literal(email), quote_literal(password), quote_literal(phone));

        ELSIF (tblOr = 'Delivery_pharmacy') THEN

            execute format(
                    '%s into %s(id, name, city, address, schedule  ) values (%s,%s,%s,%s,%s);',
                    type, format('%I', tblOr), old_id, quote_literal(name),
                    quote_literal(city), quote_literal(address), quote_literal(schedule));

        ELSIF (tblOr = 'Drug') THEN

            execute format(
                    '%s into %s(id, name, active_substance, description, release_form, single_weight, prescription, manufacturer_id, category_id, in_stock, price) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);',
                    type, format('%I', tblOr), old_id, quote_literal(name), quote_literal(active_substance),
                    quote_literal(description), quote_literal(release_form), quote_literal(single_weight),
                    quote_literal(prescription), quote_literal(first_id), quote_literal(second_id),
                    quote_literal(in_stock), quote_literal(price));

        ELSIF (tblOr = 'Manager') THEN

            execute format('%s into %s(id,client_id) values(%s,%s);', type, format('%I', tblOr), old_id, first_id);

        ELSIF (tblOr = 'Manufacturer') THEN

            execute format('%s into %s(id,name,country) values(%s,%s,%s);', type, format('%I', tblOr), old_id, name,
                           country);

        ELSIF (tblOr = 'Order') THEN

            execute format(
                    '%s into %s(id, client_id, delivery_pharmacy_id, status, order_cost, date, completion_date, manager_id, stockman_id) values (%s,%s,%s,%s,%s,%s,%s,%s,%s);',
                    type, format('%I', tblOr), old_id, quote_literal(first_id), quote_literal(second_id),
                    quote_literal(status), quote_literal(order_cost), quote_literal(date),
                    quote_literal(completion_date), quote_literal(third_id), quote_literal(fourth_id));

        ELSIF (tblOr = 'Order_Drug') THEN

            execute format('%s into %s(id,order_id, drug_id, quantity, full_price) values(%s,%s,%s,%s,%s);', type,
                           format('%I', tblOr), old_id, first_id, second_id, quantity, full_price);

        ELSIF (tblOr = 'Picture') THEN

            execute format('%s into %s(id,path,drug_id) values(%s,%s,%s);', type, format('%I', tblOr), old_id,
                           quote_literal(path),
                           first_id);

        ELSIF (tblOr = 'Receipt') THEN

            execute format('%s into %s(id, order_id, cash, payed, date_time) values(%s,%s,%s,%s,%s);', type,
                           format('%I', tblOr), old_id, first_id, quote_literal(cash), quote_literal(payed),
                           quote_literal(date_time));

        ELSIF (tblOr = 'Stockman') THEN

            execute format('%s into %s(id,delivery_pharmacy_id,client_id) values(%s,%s, %s);',
                           type, format('%I', tblOr), old_id, first_id, second_id);

        END IF;
    ELSIF (type = 'UPDATE') then
        IF (tblOr = 'Admin') THEN
            execute format('%s %s set client_id=%s where id = %s;', type, format('%I', tblOr), first_id, old_id);
        ELSIF (tblOr = 'Category') THEN

            execute format('%s %s set name=%s , parent=%s where id = %s;', type, format('%I', tblOr),
                           quote_literal(name),
                           first_id, old_id);
        ELSIF (tblOr = 'Client') THEN

            execute format(
                    '%s %s set surname=%s, name=%s, patronymic=%s, birth_year=%s, login=%s, email=%s, password=%s, phone=%s where id = %s;',
                    type, format('%I', tblOr), quote_literal(surname),
                    quote_literal(name), quote_literal(patronymic), birth_year, quote_literal(login),
                    quote_literal(email), quote_literal(password), quote_literal(phone), old_id);

        ELSIF (tblOr = 'Delivery_pharmacy') THEN

            execute format(
                    '%s %s set name=%s, city=%s, address=%s, schedule=%s where id =%s;',
                    type, format('%I', tblOr), quote_literal(name),
                    quote_literal(city), quote_literal(address), quote_literal(schedule), old_id);

        ELSIF (tblOr = 'Drug') THEN

            execute format(
                    '%s %s set name=%s, active_substance=%s, description=%s, release_form=%s, single_weight=%s, prescription=%s, manufacturer_id=%s, category_id=%s, in_stock=%s, price=%s where id =%s;',
                    type, format('%I', tblOr), quote_literal(name), quote_literal(active_substance),
                    quote_literal(description), quote_literal(release_form), quote_literal(single_ыweight),
                    quote_literal(prescription), quote_literal(first_id), quote_literal(second_id),
                    quote_literal(in_stock), quote_literal(price), old_id);
        ELSIF (tblOr = 'Order') THEN
            execute format(
                    '%s %s set client_id= %s , delivery_pharmacy_id= %s , status= %s , order_cost= %s , date=%s%s%s%s where id = %s;',
                    type, format('%I', tblOr), first_id, second_id,
                    quote_literal(status), order_cost, quote_literal(date),
                    NULLIF(format(',completion_date=%s', quote_literal(completion_date)), ',completion_date='),
                    NULLIF(format(',manager_id=%s', third_id), ',manager_id='),
                    NULLIF(format(',stockman_id=%s', fourth_id), ',stockman_id='), old_id);


        ELSIF (tblOr = 'Manager') THEN

            execute format('%s %s set client_id=%s where id =%s;', type, format('%I', tblOr), first_id, old_id);

        ELSIF (tblOr = 'Manufacturer') THEN

            execute format('%s %s set name=%s, country=%s where id =%s;', type, format('%I', tblOr), name,
                           country, old_id);

        ELSIF (tblOr = 'Order_Drug') THEN

            execute format('%s %s set order_id=%s, drug_id=%s, quantity=%s, full_price=%s where id =%s;', type,
                           format('%I', tblOr), first_id, second_id, quantity, full_price, old_id);

        ELSIF (tblOr = 'Picture') THEN

            execute format('%s %s set path=%s,drug_id=%s where id =%s;', type, format('%I', tblOr),
                           quote_literal(path),
                           first_id, old_id);

        ELSIF (tblOr = 'Receipt') THEN

            execute format('%s %s set order_id=%s, cash=%s, payed=%s, date_time=%s where id =%s;', type,
                           format('%I', tblOr), first_id, quote_literal(cash), quote_literal(payed),
                           quote_literal(date_time), old_id);

        ELSIF (tblOr = 'Stockman') THEN

            execute format('%s %s set delivery_pharmacy_id=%s,client_id=%s where id =%s;',
                           type, format('%I', tblOr), first_id, second_id, old_id);

        END IF;
    END IF;


    return tblOr;
END;


$$;


ALTER FUNCTION public.undooper() OWNER TO admin;

--
-- Name: undooper(integer); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.undooper(i integer) RETURNS character varying
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
    lastTrId         integer;
    type             varchar(20);
    old_id           integer;
    tbl              varchar(20);
    tblOr            varchar(20);
    first_id         integer;
    second_id        integer;
    third_id         integer;
    fourth_id        integer;
    surname          varchar(20);
    name             varchar(20);
    patronymic       varchar(20);
    birth_year       integer;
    login            varchar(20);
    email            varchar(50);
    password         varchar(100);
    phone            varchar(15);
    city             varchar(20);
    address          varchar(20);
    schedule         text;
    active_substance varchar(20);
    description      text;
    release_form     varchar(20);
    single_weight    numeric;
    prescription     boolean;
    in_stock         integer;
    price            numeric;
    country          varchar(20);
    order_cost       numeric;
    status           varchar(20);
    date             date;
    completion_date  date;
    quantity         integer;
    full_price       numeric;
    path             varchar(30);
    cash             boolean;
    payed            numeric;
    date_time        timestamp;


BEGIN
    return (select table_name from "journal" ORDER BY id DESC LIMIT i);

    tblOr = substring(tbl, 0, length(tbl) - 6);

    select query_id from "journal" ORDER BY id DESC LIMIT i into lastTrId;

    IF (tblOr = 'Admin') THEN
        execute format(
                'select client_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;

    ELSIF (tblOr = 'Category') THEN
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select parent from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;

    ELSIF (tblOr = 'Category') THEN
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select parent from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;

    ELSIF (tblOr = 'Client') THEN
        execute format(
                'select surname from %s where id = %s;',
                format('%I', tbl), lastTrId) into surname;
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select patronymic from %s where id = %s;',
                format('%I', tbl), lastTrId) into patronymic;
        execute format(
                'select birth_year from %s where id = %s;',
                format('%I', tbl), lastTrId) into birth_year;
        execute format(
                'select login from %s where id = %s;',
                format('%I', tbl), lastTrId) into login;
        execute format(
                'select email from %s where id = %s;',
                format('%I', tbl), lastTrId) into email;
        execute format(
                'select password from %s where id = %s;',
                format('%I', tbl), lastTrId) into password;
        execute format(
                'select phone from %s where id = %s;',
                format('%I', tbl), lastTrId) into phone;


    ELSIF (tblOr = 'Delivery_pharmacy') THEN
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select city from %s where id = %s;',
                format('%I', tbl), lastTrId) into city;
        execute format(
                'select address from %s where id = %s;',
                format('%I', tbl), lastTrId) into address;
        execute format(
                'select schedule from %s where id = %s;',
                format('%I', tbl), lastTrId) into schedule;

    ELSIF (tblOr = 'Drug') THEN
        execute format('select name from %s where id = %s;', format('%I', tbl), lastTrId) into name;
        execute format('select active_substance from %s where id = %s;', format('%I', tbl),
                       lastTrId) into active_substance;
        execute format('select description from %s where id = %s;', format('%I', tbl), lastTrId) into description;
        execute format(
                'select release_form from %s where id = %s;',
                format('%I', tbl), lastTrId) into release_form;
        execute format(
                'select single_weight from %s where id = %s;',
                format('%I', tbl), lastTrId) into single_weight;
        execute format(
                'select prescription from %s where id = %s;',
                format('%I', tbl), lastTrId) into prescription;
        execute format(
                'select manufacturer_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;
        execute format(
                'select category_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into second_id;
        execute format('select in_stock from %s where id = %s;',
                       format('%I', tbl), lastTrId) into in_stock;
        execute format('select price from %s where id = %s;', format('%I', tbl), lastTrId) into price;


    ELSIF (tblOr = 'Manager') THEN
        execute format(
                'select client_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;


    ELSIF (tblOr = 'Manufacturer') THEN
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select country from %s where id = %s;',
                format('%I', tbl), lastTrId) into country;


    ELSIF (tblOr = 'Order') THEN
        execute format('select client_id from %s where id = %s;',
                       format('%I', tbl), lastTrId) into first_id;
        execute format('select delivery_pharmacy_id from %s where id = %s;',
                       format('%I', tbl), lastTrId) into second_id;
        execute format('select status from %s where id = %s;',
                       format('%I', tbl), lastTrId) into status;
        execute format(
                'select order_cost from %s where id = %s;',
                format('%I', tbl), lastTrId) into order_cost;
        execute format(
                'select date from %s where id = %s;',
                format('%I', tbl), lastTrId) into date;
        execute format(
                'select completion_date from %s where id = %s;',
                format('%I', tbl), lastTrId) into completion_date;
        execute format(
                'select manager_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into third_id;
        execute format(
                'select stockman_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into fourth_id;


    ELSIF (tblOr = 'Order_Drug') THEN
        execute format(
                'select order_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;
        execute format(
                'select drug_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into second_id;
        execute format(
                'select quantity from %s where id = %s;',
                format('%I', tbl), lastTrId) into quantity;
        execute format(
                'select full_price from %s where id = %s;',
                format('%I', tbl), lastTrId) into full_price;

    ELSIF (tblOr = 'Picture') THEN
        execute format(
                'select path from %s where id = %s;',
                format('%I', tbl), lastTrId) into path;
        execute format(
                'select drug_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;

    ELSIF (tblOr = 'Receipt') THEN
        execute format(
                'select order_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;
        execute format(
                'select cash from %s where id = %s;',
                format('%I', tbl), lastTrId) into cash;
        execute format(
                'select payed from %s where id = %s;',
                format('%I', tbl), lastTrId) into payed;
        execute format(
                'select date_time from %s where id = %s;',
                format('%I', tbl), lastTrId) into date_time;

    ELSIF (tblOr = 'Stockman') THEN
        execute format(
                'select delivery_pharmacy_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;
        execute format(
                'select client_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into second_id;

    END IF;


    execute format('select type from %s where id = %s;', format('%I', tbl), lastTrId) into type;
    execute format('select old_id from %s where id = %s;', format('%I', tbl), lastTrId) into old_id;

    IF (type = 'INSERT') THEN
        type = 'DELETE';
        execute format('%s from %s where id = %s;', type, format('%I', tblOr), old_id);
    ELSIF (type = 'DELETE') THEN
        type = 'INSERT';
        IF (tblOr = 'Admin') THEN
            execute format('%s into %s(id,client_id) values(%s,%s);', type, format('%I', tblOr), old_id, first_id);
        ELSIF (tblOr = 'Category') THEN

            execute format('%s into %s(id,name,parent) values(%s,%s,%s);', type, format('%I', tblOr), old_id, name,
                           first_id);
        ELSIF (tblOr = 'Client') THEN

            execute format(
                    '%s into %s(id, surname, name, patronymic, birth_year, login, email, password, phone) values (%s,%s,%s,%s,%s,%s,%s,%s,%s);',
                    type, format('%I', tblOr), old_id, quote_literal(surname),
                    quote_literal(name), quote_literal(patronymic), birth_year, quote_literal(login),
                    quote_literal(email), quote_literal(password), quote_literal(phone));

        ELSIF (tblOr = 'Delivery_pharmacy') THEN

            execute format(
                    '%s into %s(id, name, city, address, schedule  ) values (%s,%s,%s,%s,%s);',
                    type, format('%I', tblOr), old_id, quote_literal(name),
                    quote_literal(city), quote_literal(address), quote_literal(schedule));

        ELSIF (tblOr = 'Drug') THEN

            execute format(
                    '%s into %s(id, name, active_substance, description, release_form, single_weight, prescription, manufacturer_id, category_id, in_stock, price) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);',
                    type, format('%I', tblOr), old_id, quote_literal(name), quote_literal(active_substance),
                    quote_literal(description), quote_literal(release_form), quote_literal(single_weight),
                    quote_literal(prescription), quote_literal(first_id), quote_literal(second_id),
                    quote_literal(in_stock), quote_literal(price));

        ELSIF (tblOr = 'Manager') THEN

            execute format('%s into %s(id,client_id) values(%s,%s);', type, format('%I', tblOr), old_id, first_id);

        ELSIF (tblOr = 'Manufacturer') THEN

            execute format('%s into %s(id,name,country) values(%s,%s,%s);', type, format('%I', tblOr), old_id, name,
                           country);

        ELSIF (tblOr = 'Order') THEN

            execute format(
                    '%s into %s(id, client_id, delivery_pharmacy_id, status, order_cost, date, completion_date, manager_id, stockman_id) values (%s,%s,%s,%s,%s,%s,%s,%s,%s);',
                    type, format('%I', tblOr), old_id, quote_literal(first_id), quote_literal(second_id),
                    quote_literal(status), quote_literal(order_cost), quote_literal(date),
                    quote_literal(completion_date), quote_literal(third_id), quote_literal(fourth_id));

        ELSIF (tblOr = 'Order_Drug') THEN

            execute format('%s into %s(id,order_id, drug_id, quantity, full_price) values(%s,%s,%s,%s,%s);', type,
                           format('%I', tblOr), old_id, first_id, second_id, quantity, full_price);

        ELSIF (tblOr = 'Picture') THEN

            execute format('%s into %s(id,path,drug_id) values(%s,%s,%s);', type, format('%I', tblOr), old_id,
                           quote_literal(path),
                           first_id);

        ELSIF (tblOr = 'Receipt') THEN

            execute format('%s into %s(id, order_id, cash, payed, date_time) values(%s,%s,%s,%s,%s);', type,
                           format('%I', tblOr), old_id, first_id, quote_literal(cash), quote_literal(payed),
                           quote_literal(date_time));

        ELSIF (tblOr = 'Stockman') THEN

            execute format('%s into %s(id,delivery_pharmacy_id,client_id) values(%s,%s, %s);',
                           type, format('%I', tblOr), old_id, first_id, second_id);

        END IF;
    ELSIF (type = 'UPDATE') then
        IF (tblOr = 'Admin') THEN
            execute format('%s %s set client_id=%s where id = %s;', type, format('%I', tblOr), first_id, old_id);
        ELSIF (tblOr = 'Category') THEN

            execute format('%s %s set name=%s , parent=%s where id = %s;', type, format('%I', tblOr),
                           quote_literal(name),
                           first_id, old_id);
        ELSIF (tblOr = 'Client') THEN

            execute format(
                    '%s %s set surname=%s, name=%s, patronymic=%s, birth_year=%s, login=%s, email=%s, password=%s, phone=%s where id = %s;',
                    type, format('%I', tblOr), quote_literal(surname),
                    quote_literal(name), quote_literal(patronymic), birth_year, quote_literal(login),
                    quote_literal(email), quote_literal(password), quote_literal(phone), old_id);

        ELSIF (tblOr = 'Delivery_pharmacy') THEN

            execute format(
                    '%s %s set name=%s, city=%s, address=%s, schedule=%s where id =%s;',
                    type, format('%I', tblOr), quote_literal(name),
                    quote_literal(city), quote_literal(address), quote_literal(schedule), old_id);

        ELSIF (tblOr = 'Drug') THEN

            execute format(
                    '%s %s set name=%s, active_substance=%s, description=%s, release_form=%s, single_weight=%s, prescription=%s, manufacturer_id=%s, category_id=%s, in_stock=%s, price=%s where id =%s;',
                    type, format('%I', tblOr), quote_literal(name), quote_literal(active_substance),
                    quote_literal(description), quote_literal(release_form), quote_literal(single_ыweight),
                    quote_literal(prescription), quote_literal(first_id), quote_literal(second_id),
                    quote_literal(in_stock), quote_literal(price), old_id);
        ELSIF (tblOr = 'Order') THEN
            execute format(
                    '%s %s set client_id= %s , delivery_pharmacy_id= %s , status= %s , order_cost= %s , date=%s%s%s%s where id = %s;',
                    type, format('%I', tblOr), first_id, second_id,
                    quote_literal(status), order_cost, quote_literal(date),
                    NULLIF(format(',completion_date=%s', quote_literal(completion_date)), ',completion_date='),
                    NULLIF(format(',manager_id=%s', third_id), ',manager_id='),
                    NULLIF(format(',stockman_id=%s', fourth_id), ',stockman_id='), old_id);


        ELSIF (tblOr = 'Manager') THEN

            execute format('%s %s set client_id=%s where id =%s;', type, format('%I', tblOr), first_id, old_id);

        ELSIF (tblOr = 'Manufacturer') THEN

            execute format('%s %s set name=%s, country=%s where id =%s;', type, format('%I', tblOr), name,
                           country, old_id);

        ELSIF (tblOr = 'Order_Drug') THEN

            execute format('%s %s set order_id=%s, drug_id=%s, quantity=%s, full_price=%s where id =%s;', type,
                           format('%I', tblOr), first_id, second_id, quantity, full_price, old_id);

        ELSIF (tblOr = 'Picture') THEN

            execute format('%s %s set path=%s,drug_id=%s where id =%s;', type, format('%I', tblOr),
                           quote_literal(path),
                           first_id, old_id);

        ELSIF (tblOr = 'Receipt') THEN

            execute format('%s %s set order_id=%s, cash=%s, payed=%s, date_time=%s where id =%s;', type,
                           format('%I', tblOr), first_id, quote_literal(cash), quote_literal(payed),
                           quote_literal(date_time), old_id);

        ELSIF (tblOr = 'Stockman') THEN

            execute format('%s %s set delivery_pharmacy_id=%s,client_id=%s where id =%s;',
                           type, format('%I', tblOr), first_id, second_id, old_id);

        END IF;
    END IF;


    return tblOr;
END;


$$;


ALTER FUNCTION public.undooper(i integer) OWNER TO admin;

--
-- Name: undooper(character varying, integer); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.undooper(tbl character varying, lasttrid integer) RETURNS character varying
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
    type             varchar(20);
    old_id           integer;
    tblOr            varchar(100);
    first_id         integer;
    second_id        integer;
    third_id         integer;
    fourth_id        integer;
    surname          varchar(100);
    name             varchar(100);
    patronymic       varchar(100);
    birth_year       integer;
    login            varchar(100);
    email            varchar(100);
    password         varchar(100);
    phone            varchar(100);
    city             varchar(20);
    address          varchar(20);
    schedule         text;
    active_substance varchar(50);
    description      text;
    release_form     varchar(20);
    single_weight    numeric;
    prescription     boolean;
    in_stock         integer;
    price            numeric;
    country          varchar(20);
    order_cost       numeric;
    status           varchar(20);
    date             date;
    completion_date  date;
    quantity         integer;
    full_price       numeric;
    path             varchar(300);
    cash             boolean;
    payed            numeric;
    date_time        timestamp;


BEGIN
    tblOr = substring(tbl, 0, length(tbl) - 6);


    IF (tblOr = 'Admin') THEN
        execute format(
                'select client_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;

    ELSIF (tblOr = 'Category') THEN
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select parent from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;

    ELSIF (tblOr = 'Category') THEN
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select parent from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;

    ELSIF (tblOr = 'Client') THEN
        execute format(
                'select surname from %s where id = %s;',
                format('%I', tbl), lastTrId) into surname;
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select patronymic from %s where id = %s;',
                format('%I', tbl), lastTrId) into patronymic;
        execute format(
                'select birth_year from %s where id = %s;',
                format('%I', tbl), lastTrId) into birth_year;
        execute format(
                'select login from %s where id = %s;',
                format('%I', tbl), lastTrId) into login;
        execute format(
                'select email from %s where id = %s;',
                format('%I', tbl), lastTrId) into email;
        execute format(
                'select password from %s where id = %s;',
                format('%I', tbl), lastTrId) into password;
        execute format(
                'select phone from %s where id = %s;',
                format('%I', tbl), lastTrId) into phone;



    ELSIF (tblOr = 'Delivery_pharmacy') THEN
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select city from %s where id = %s;',
                format('%I', tbl), lastTrId) into city;
        execute format(
                'select address from %s where id = %s;',
                format('%I', tbl), lastTrId) into address;
        execute format(
                'select schedule from %s where id = %s;',
                format('%I', tbl), lastTrId) into schedule;

    ELSIF (tblOr = 'Drug') THEN
        execute format('select name from %s where id = %s;', format('%I', tbl), lastTrId) into name;
        execute format('select active_substance from %s where id = %s;', format('%I', tbl),
                       lastTrId) into active_substance;
        execute format('select description from %s where id = %s;', format('%I', tbl), lastTrId) into description;
        execute format(
                'select release_form from %s where id = %s;',
                format('%I', tbl), lastTrId) into release_form;
        execute format(
                'select single_weight from %s where id = %s;',
                format('%I', tbl), lastTrId) into single_weight;
        execute format(
                'select prescription from %s where id = %s;',
                format('%I', tbl), lastTrId) into prescription;
        execute format(
                'select manufacturer_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;
        execute format(
                'select category_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into second_id;
        execute format('select in_stock from %s where id = %s;',
                       format('%I', tbl), lastTrId) into in_stock;
        execute format('select price from %s where id = %s;', format('%I', tbl), lastTrId) into price;


    ELSIF (tblOr = 'Manager') THEN
        execute format(
                'select client_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;


    ELSIF (tblOr = 'Manufacturer') THEN
        execute format(
                'select name from %s where id = %s;',
                format('%I', tbl), lastTrId) into name;
        execute format(
                'select country from %s where id = %s;',
                format('%I', tbl), lastTrId) into country;


    ELSIF (tblOr = 'Order') THEN
        execute format('select client_id from %s where id = %s;',
                       format('%I', tbl), lastTrId) into first_id;
        execute format('select delivery_pharmacy_id from %s where id = %s;',
                       format('%I', tbl), lastTrId) into second_id;
        execute format('select status from %s where id = %s;',
                       format('%I', tbl), lastTrId) into status;
        execute format(
                'select order_cost from %s where id = %s;',
                format('%I', tbl), lastTrId) into order_cost;
        execute format(
                'select date from %s where id = %s;',
                format('%I', tbl), lastTrId) into date;
        execute format(
                'select completion_date from %s where id = %s;',
                format('%I', tbl), lastTrId) into completion_date;
        execute format(
                'select manager_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into third_id;
        execute format(
                'select stockman_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into fourth_id;


    ELSIF (tblOr = 'Order_Drug') THEN
        execute format(
                'select order_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;
        execute format(
                'select drug_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into second_id;
        execute format(
                'select quantity from %s where id = %s;',
                format('%I', tbl), lastTrId) into quantity;
        execute format(
                'select full_price from %s where id = %s;',
                format('%I', tbl), lastTrId) into full_price;

    ELSIF (tblOr = 'Picture') THEN
        execute format(
                'select path from %s where id = %s;',
                format('%I', tbl), lastTrId) into path;
        execute format(
                'select drug_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;

    ELSIF (tblOr = 'Receipt') THEN
        execute format(
                'select order_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;
        execute format(
                'select cash from %s where id = %s;',
                format('%I', tbl), lastTrId) into cash;
        execute format(
                'select payed from %s where id = %s;',
                format('%I', tbl), lastTrId) into payed;
        execute format(
                'select date_time from %s where id = %s;',
                format('%I', tbl), lastTrId) into date_time;

    ELSIF (tblOr = 'Stockman') THEN
        execute format(
                'select delivery_pharmacy_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into first_id;
        execute format(
                'select client_id from %s where id = %s;',
                format('%I', tbl), lastTrId) into second_id;

    END IF;


    execute format('select type from %s where id = %s;', format('%I', tbl), lastTrId) into type;
    execute format('select old_id from %s where id = %s;', format('%I', tbl), lastTrId) into old_id;

    execute format('delete from %s where id = %s;', format('%I', tbl), lastTrId);
    execute format('delete from "journal" where query_id = %s;', lastTrId);


    IF (type = 'INSERT') THEN
        type = 'DELETE';
        execute format('%s from %s where id = %s;', type, format('%I', tblOr), old_id);
    ELSIF (type = 'DELETE') THEN
        type = 'INSERT';
        IF (tblOr = 'Admin') THEN
            execute format('%s into %s(id,client_id) values(%s,%s);', type, format('%I', tblOr), old_id, first_id);
        ELSIF (tblOr = 'Category') THEN

            execute format('%s into %s(id,name,parent) values(%s,%s,%s);', type, format('%I', tblOr), old_id, quote_literal(name),
                           first_id);
        ELSIF (tblOr = 'Client') THEN

            execute format(
                    '%s into %s(id, surname, name, patronymic, birth_year, login, email, password, phone) values (%s,%s,%s,%s,%s,%s,%s,%s,%s);',
                    type, format('%I', tblOr), old_id, quote_literal(surname),
                    quote_literal(name), quote_literal(patronymic), birth_year, quote_literal(login),
                    quote_literal(email), quote_literal(password), quote_literal(phone));

        ELSIF (tblOr = 'Delivery_pharmacy') THEN

            execute format(
                    '%s into %s(id, name, city, address, schedule  ) values (%s,%s,%s,%s,%s);',
                    type, format('%I', tblOr), old_id, quote_literal(name),
                    quote_literal(city), quote_literal(address), quote_literal(schedule));

        ELSIF (tblOr = 'Drug') THEN

            execute format(
                    '%s into %s(id, name, active_substance, description, release_form, single_weight, prescription, manufacturer_id, category_id, in_stock, price) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);',
                    type, format('%I', tblOr), old_id, quote_literal(name), quote_literal(active_substance),
                    quote_literal(description), quote_literal(release_form), quote_literal(single_weight),
                    quote_literal(prescription), quote_literal(first_id), quote_literal(second_id),
                    quote_literal(in_stock), quote_literal(price));

        ELSIF (tblOr = 'Manager') THEN

            execute format('%s into %s(id,client_id) values(%s,%s);', type, format('%I', tblOr), old_id, first_id);

        ELSIF (tblOr = 'Manufacturer') THEN

            execute format('%s into %s(id,name,country) values(%s,%s,%s);', type, format('%I', tblOr), old_id, name,
                           country);

        ELSIF (tblOr = 'Order') THEN

            execute format(
                    '%s into %s(id, client_id, delivery_pharmacy_id, status, order_cost, date, completion_date, manager_id, stockman_id) values (%s,%s,%s,%s,%s,%s,%s,%s,%s);',
                    type, format('%I', tblOr), old_id, quote_literal(first_id), quote_literal(second_id),
                    quote_literal(status), quote_literal(order_cost), quote_literal(date),
                    quote_literal(completion_date), quote_literal(third_id), quote_literal(fourth_id));

        ELSIF (tblOr = 'Order_Drug') THEN

            execute format('%s into %s(id,order_id, drug_id, quantity, full_price) values(%s,%s,%s,%s,%s);', type,
                           format('%I', tblOr), old_id, first_id, second_id, quantity, full_price);

        ELSIF (tblOr = 'Picture') THEN

            execute format('%s into %s(id,path,drug_id) values(%s,%s,%s);', type, format('%I', tblOr), old_id,
                           quote_literal(path),
                           first_id);

        ELSIF (tblOr = 'Receipt') THEN

            execute format('%s into %s(id, order_id, cash, payed, date_time) values(%s,%s,%s,%s,%s);', type,
                           format('%I', tblOr), old_id, first_id, quote_literal(cash), quote_literal(payed),
                           quote_literal(date_time));

        ELSIF (tblOr = 'Stockman') THEN

            execute format('%s into %s(id,delivery_pharmacy_id,client_id) values(%s,%s, %s);',
                           type, format('%I', tblOr), old_id, first_id, second_id);

        END IF;
    ELSIF (type = 'UPDATE') then
        IF (tblOr = 'Admin') THEN
            execute format('%s %s set client_id=%s where id = %s;', type, format('%I', tblOr), first_id, old_id);
        ELSIF (tblOr = 'Category') THEN

            execute format('%s %s set name=%s %s where id = %s;', type, format('%I', tblOr),
                           quote_literal(name),
                           NULLIF(format(',parent=%s', first_id), ',parent='), old_id);
        ELSIF (tblOr = 'Client') THEN

            execute format(
                    '%s %s set surname=%s, name=%s, patronymic=%s, birth_year=%s, login=%s, email=%s, password=%s, phone=%s where id = %s;',
                    type, format('%I', tblOr), quote_literal(surname),
                    quote_literal(name), quote_literal(patronymic), birth_year, quote_literal(login),
                    quote_literal(email), quote_literal(password), quote_literal(phone), old_id);

        ELSIF (tblOr = 'Delivery_pharmacy') THEN

            execute format(
                    '%s %s set name=%s, city=%s, address=%s, schedule=%s where id =%s;',
                    type, format('%I', tblOr), quote_literal(name),
                    quote_literal(city), quote_literal(address), quote_literal(schedule), old_id);

        ELSIF (tblOr = 'Drug') THEN

            execute format(
                    '%s %s set name=%s, active_substance=%s, description=%s, release_form=%s, single_weight=%s, prescription=%s, manufacturer_id=%s, category_id=%s, in_stock=%s, price=%s where id =%s;',
                    type, format('%I', tblOr), quote_literal(name), quote_literal(active_substance),
                    quote_literal(description), quote_literal(release_form), quote_literal(single_weight),
                    quote_literal(prescription), quote_literal(first_id), quote_literal(second_id),
                    quote_literal(in_stock), quote_literal(price), old_id);
        ELSIF (tblOr = 'Order') THEN
            execute format(
                    '%s %s set client_id= %s , delivery_pharmacy_id= %s , status= %s , order_cost= %s , date=%s%s%s%s where id = %s;',
                    type, format('%I', tblOr), first_id, second_id,
                    quote_literal(status), order_cost, quote_literal(date),
                    NULLIF(format(',completion_date=%s', quote_literal(completion_date)), ',completion_date='),
                    NULLIF(format(',manager_id=%s', third_id), ',manager_id='),
                    NULLIF(format(',stockman_id=%s', fourth_id), ',stockman_id='), old_id);


        ELSIF (tblOr = 'Manager') THEN

            execute format('%s %s set client_id=%s where id =%s;', type, format('%I', tblOr), first_id, old_id);

        ELSIF (tblOr = 'Manufacturer') THEN

            execute format('%s %s set name=%s, country=%s where id =%s;', type, format('%I', tblOr), name,
                           country, old_id);

        ELSIF (tblOr = 'Order_Drug') THEN

            execute format('%s %s set order_id=%s, drug_id=%s, quantity=%s, full_price=%s where id =%s;', type,
                           format('%I', tblOr), first_id, second_id, quantity, full_price, old_id);

        ELSIF (tblOr = 'Picture') THEN

            execute format('%s %s set path=%s,drug_id=%s where id =%s;', type, format('%I', tblOr),
                           quote_literal(path),
                           first_id, old_id);

        ELSIF (tblOr = 'Receipt') THEN

            execute format('%s %s set order_id=%s, cash=%s, payed=%s, date_time=%s where id =%s;', type,
                           format('%I', tblOr), first_id, quote_literal(cash), quote_literal(payed),
                           quote_literal(date_time), old_id);

        ELSIF (tblOr = 'Stockman') THEN

            execute format('%s %s set delivery_pharmacy_id=%s,client_id=%s where id =%s;',
                           type, format('%I', tblOr), first_id, second_id, old_id);

        END IF;
    END IF;


    return tblOr;
END;


$$;


ALTER FUNCTION public.undooper(tbl character varying, lasttrid integer) OWNER TO admin;

--
-- Name: undoopers(integer); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.undoopers(i integer) RETURNS character varying[]
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
DECLARE
    lastTrId integer[];
    tbl      varchar(100)[];
BEGIN

    tbl := ARRAY(select table_name from "journal" ORDER BY id DESC LIMIT i);
    lastTrId := ARRAY(select query_id from "journal" ORDER BY id DESC LIMIT i);
    FOR i IN array_lower(tbl, 1) .. array_upper(tbl, 1)
        LOOP
            execute format('select undooper(%s, %s);', quote_literal(tbl[i]), lastTrId[i]);

        END LOOP;
    RETURN lastTrId;
END;


$$;


ALTER FUNCTION public.undoopers(i integer) OWNER TO admin;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Admin" (
    id integer NOT NULL,
    client_id integer NOT NULL
);


ALTER TABLE public."Admin" OWNER TO postgres;

--
-- Name: Admin_backup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Admin_backup" (
    id integer NOT NULL,
    type character varying(10),
    old_id integer,
    client_id integer,
    change_time timestamp without time zone
);


ALTER TABLE public."Admin_backup" OWNER TO admin;

--
-- Name: Admin_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public."Admin_backup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Admin_backup_id_seq" OWNER TO admin;

--
-- Name: Admin_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public."Admin_backup_id_seq" OWNED BY public."Admin_backup".id;


--
-- Name: Admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Admin_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Admin_id_seq" OWNER TO postgres;

--
-- Name: Admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Admin_id_seq" OWNED BY public."Admin".id;


--
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    parent integer
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- Name: Category_backup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Category_backup" (
    id integer NOT NULL,
    type character varying(10),
    old_id integer,
    name character varying(20),
    parent integer,
    change_time timestamp without time zone
);


ALTER TABLE public."Category_backup" OWNER TO admin;

--
-- Name: Category_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public."Category_backup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Category_backup_id_seq" OWNER TO admin;

--
-- Name: Category_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public."Category_backup_id_seq" OWNED BY public."Category_backup".id;


--
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
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- Name: Client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Client" (
    id integer NOT NULL,
    surname character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    patronymic character varying(100) NOT NULL,
    birth_year integer NOT NULL,
    login character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    phone character varying(100) NOT NULL,
    CONSTRAINT checkbirthdate CHECK (((birth_year >= ((date_part('year'::text, CURRENT_DATE))::integer - 120)) AND (birth_year <= ((date_part('year'::text, CURRENT_DATE))::integer - 18))))
);


ALTER TABLE public."Client" OWNER TO postgres;

--
-- Name: Client_backup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Client_backup" (
    id integer NOT NULL,
    type character varying(10),
    old_id integer,
    surname character varying(100),
    name character varying(100),
    patronymic character varying(100),
    birth_year integer,
    login character varying(100),
    email character varying(100),
    password character varying(100),
    phone character varying(100),
    change_time timestamp without time zone
);


ALTER TABLE public."Client_backup" OWNER TO admin;

--
-- Name: Client_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public."Client_backup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Client_backup_id_seq" OWNER TO admin;

--
-- Name: Client_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public."Client_backup_id_seq" OWNED BY public."Client_backup".id;


--
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
-- Name: Client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Client_id_seq" OWNED BY public."Client".id;


--
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
-- Name: Delivery_pharmacy_backup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Delivery_pharmacy_backup" (
    id integer NOT NULL,
    type character varying(10),
    old_id integer,
    name character varying(20),
    city character varying(20),
    address character varying(20),
    schedule text,
    change_time timestamp without time zone
);


ALTER TABLE public."Delivery_pharmacy_backup" OWNER TO admin;

--
-- Name: Delivery_pharmacy_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public."Delivery_pharmacy_backup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Delivery_pharmacy_backup_id_seq" OWNER TO admin;

--
-- Name: Delivery_pharmacy_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public."Delivery_pharmacy_backup_id_seq" OWNED BY public."Delivery_pharmacy_backup".id;


--
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
-- Name: Delivery_pharmacy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Delivery_pharmacy_id_seq" OWNED BY public."Delivery_pharmacy".id;


--
-- Name: Drug; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Drug" (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    active_substance character varying(50) NOT NULL,
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
-- Name: Drug_backup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Drug_backup" (
    id integer NOT NULL,
    type character varying(10),
    old_id integer NOT NULL,
    name character varying(20),
    active_substance character varying(50),
    description text,
    release_form character varying(20),
    single_weight numeric,
    prescription boolean,
    manufacturer_id integer,
    category_id integer,
    in_stock integer,
    price numeric,
    change_time timestamp without time zone
);


ALTER TABLE public."Drug_backup" OWNER TO admin;

--
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
-- Name: Drug_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Drug_id_seq" OWNED BY public."Drug".id;


--
-- Name: Manager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Manager" (
    id integer NOT NULL,
    client_id integer NOT NULL
);


ALTER TABLE public."Manager" OWNER TO postgres;

--
-- Name: Manager_backup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Manager_backup" (
    id integer NOT NULL,
    type character varying(10),
    old_id integer,
    client_id integer,
    change_time timestamp without time zone
);


ALTER TABLE public."Manager_backup" OWNER TO admin;

--
-- Name: Manager_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public."Manager_backup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Manager_backup_id_seq" OWNER TO admin;

--
-- Name: Manager_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public."Manager_backup_id_seq" OWNED BY public."Manager_backup".id;


--
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
-- Name: Manager_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Manager_id_seq" OWNED BY public."Manager".id;


--
-- Name: Manufacturer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Manufacturer" (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    country character varying(20) NOT NULL
);


ALTER TABLE public."Manufacturer" OWNER TO postgres;

--
-- Name: Manufacturer_backup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Manufacturer_backup" (
    id integer NOT NULL,
    type character varying(10),
    old_id integer,
    name character varying(20),
    country character varying(20),
    change_time timestamp without time zone
);


ALTER TABLE public."Manufacturer_backup" OWNER TO admin;

--
-- Name: Manufacturer_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public."Manufacturer_backup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Manufacturer_backup_id_seq" OWNER TO admin;

--
-- Name: Manufacturer_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public."Manufacturer_backup_id_seq" OWNED BY public."Manufacturer_backup".id;


--
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
-- Name: Manufacturer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Manufacturer_id_seq" OWNED BY public."Manufacturer".id;


--
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
-- Name: Order_Drug_backup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Order_Drug_backup" (
    id integer NOT NULL,
    type character varying(10),
    old_id integer,
    order_id integer,
    drug_id integer,
    quantity integer,
    full_price numeric,
    change_time timestamp without time zone
);


ALTER TABLE public."Order_Drug_backup" OWNER TO admin;

--
-- Name: Order_Drug_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public."Order_Drug_backup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Order_Drug_backup_id_seq" OWNER TO admin;

--
-- Name: Order_Drug_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public."Order_Drug_backup_id_seq" OWNED BY public."Order_Drug_backup".id;


--
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
-- Name: Order_Drug_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_Drug_id_seq" OWNED BY public."Order_Drug".id;


--
-- Name: Order_backup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Order_backup" (
    id integer NOT NULL,
    type character varying(10),
    old_id integer,
    client_id integer,
    delivery_pharmacy_id integer,
    status character varying(20),
    order_cost numeric,
    date date,
    completion_date date,
    manager_id integer,
    stockman_id integer,
    change_time timestamp without time zone
);


ALTER TABLE public."Order_backup" OWNER TO admin;

--
-- Name: Order_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public."Order_backup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Order_backup_id_seq" OWNER TO admin;

--
-- Name: Order_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public."Order_backup_id_seq" OWNED BY public."Order_backup".id;


--
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
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- Name: Picture; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Picture" (
    id integer NOT NULL,
    path character varying(300) NOT NULL,
    drug_id integer
);


ALTER TABLE public."Picture" OWNER TO postgres;

--
-- Name: Picture_backup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Picture_backup" (
    id integer NOT NULL,
    type character varying(10),
    old_id integer,
    drug_id integer,
    path character varying(300),
    change_time timestamp without time zone
);


ALTER TABLE public."Picture_backup" OWNER TO admin;

--
-- Name: Picture_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public."Picture_backup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Picture_backup_id_seq" OWNER TO admin;

--
-- Name: Picture_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public."Picture_backup_id_seq" OWNED BY public."Picture_backup".id;


--
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
-- Name: Picture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Picture_id_seq" OWNED BY public."Picture".id;


--
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
-- Name: Prescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Prescription_id_seq" OWNED BY public."Prescription".id;


--
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
-- Name: Receipt_backup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Receipt_backup" (
    id integer NOT NULL,
    type character varying(10),
    old_id integer,
    order_id integer,
    cash boolean,
    payed numeric,
    date_time timestamp without time zone,
    change_time timestamp without time zone
);


ALTER TABLE public."Receipt_backup" OWNER TO admin;

--
-- Name: Receipt_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public."Receipt_backup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Receipt_backup_id_seq" OWNER TO admin;

--
-- Name: Receipt_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public."Receipt_backup_id_seq" OWNED BY public."Receipt_backup".id;


--
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
-- Name: Receipt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Receipt_id_seq" OWNED BY public."Receipt".id;


--
-- Name: Stockman; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Stockman" (
    id integer NOT NULL,
    delivery_pharmacy_id integer,
    client_id integer NOT NULL
);


ALTER TABLE public."Stockman" OWNER TO postgres;

--
-- Name: Stockman_backup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Stockman_backup" (
    id integer NOT NULL,
    type character varying(10),
    old_id integer,
    delivery_pharmacy_id integer,
    client_id integer,
    change_time timestamp without time zone
);


ALTER TABLE public."Stockman_backup" OWNER TO admin;

--
-- Name: Stockman_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public."Stockman_backup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Stockman_backup_id_seq" OWNER TO admin;

--
-- Name: Stockman_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public."Stockman_backup_id_seq" OWNED BY public."Stockman_backup".id;


--
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
-- Name: Stockman_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Stockman_id_seq" OWNED BY public."Stockman".id;


--
-- Name: drug_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.drug_backup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.drug_backup_id_seq OWNER TO admin;

--
-- Name: drug_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.drug_backup_id_seq OWNED BY public."Drug_backup".id;


--
-- Name: drug_backup_old_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.drug_backup_old_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.drug_backup_old_id_seq OWNER TO admin;

--
-- Name: drug_backup_old_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.drug_backup_old_id_seq OWNED BY public."Drug_backup".old_id;


--
-- Name: journal; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.journal (
    id integer NOT NULL,
    query_id integer,
    table_name character varying(100)
);


ALTER TABLE public.journal OWNER TO admin;

--
-- Name: journal_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.journal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.journal_id_seq OWNER TO admin;

--
-- Name: journal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.journal_id_seq OWNED BY public.journal.id;


--
-- Name: Admin id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Admin" ALTER COLUMN id SET DEFAULT nextval('public."Admin_id_seq"'::regclass);


--
-- Name: Admin_backup id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Admin_backup" ALTER COLUMN id SET DEFAULT nextval('public."Admin_backup_id_seq"'::regclass);


--
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- Name: Category_backup id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Category_backup" ALTER COLUMN id SET DEFAULT nextval('public."Category_backup_id_seq"'::regclass);


--
-- Name: Client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client" ALTER COLUMN id SET DEFAULT nextval('public."Client_id_seq"'::regclass);


--
-- Name: Client_backup id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Client_backup" ALTER COLUMN id SET DEFAULT nextval('public."Client_backup_id_seq"'::regclass);


--
-- Name: Delivery_pharmacy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delivery_pharmacy" ALTER COLUMN id SET DEFAULT nextval('public."Delivery_pharmacy_id_seq"'::regclass);


--
-- Name: Delivery_pharmacy_backup id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Delivery_pharmacy_backup" ALTER COLUMN id SET DEFAULT nextval('public."Delivery_pharmacy_backup_id_seq"'::regclass);


--
-- Name: Drug id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Drug" ALTER COLUMN id SET DEFAULT nextval('public."Drug_id_seq"'::regclass);


--
-- Name: Drug_backup id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Drug_backup" ALTER COLUMN id SET DEFAULT nextval('public.drug_backup_id_seq'::regclass);


--
-- Name: Drug_backup old_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Drug_backup" ALTER COLUMN old_id SET DEFAULT nextval('public.drug_backup_old_id_seq'::regclass);


--
-- Name: Manager id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Manager" ALTER COLUMN id SET DEFAULT nextval('public."Manager_id_seq"'::regclass);


--
-- Name: Manager_backup id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Manager_backup" ALTER COLUMN id SET DEFAULT nextval('public."Manager_backup_id_seq"'::regclass);


--
-- Name: Manufacturer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Manufacturer" ALTER COLUMN id SET DEFAULT nextval('public."Manufacturer_id_seq"'::regclass);


--
-- Name: Manufacturer_backup id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Manufacturer_backup" ALTER COLUMN id SET DEFAULT nextval('public."Manufacturer_backup_id_seq"'::regclass);


--
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- Name: Order_Drug id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Drug" ALTER COLUMN id SET DEFAULT nextval('public."Order_Drug_id_seq"'::regclass);


--
-- Name: Order_Drug_backup id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Order_Drug_backup" ALTER COLUMN id SET DEFAULT nextval('public."Order_Drug_backup_id_seq"'::regclass);


--
-- Name: Order_backup id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Order_backup" ALTER COLUMN id SET DEFAULT nextval('public."Order_backup_id_seq"'::regclass);


--
-- Name: Picture id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Picture" ALTER COLUMN id SET DEFAULT nextval('public."Picture_id_seq"'::regclass);


--
-- Name: Picture_backup id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Picture_backup" ALTER COLUMN id SET DEFAULT nextval('public."Picture_backup_id_seq"'::regclass);


--
-- Name: Prescription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Prescription" ALTER COLUMN id SET DEFAULT nextval('public."Prescription_id_seq"'::regclass);


--
-- Name: Receipt id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Receipt" ALTER COLUMN id SET DEFAULT nextval('public."Receipt_id_seq"'::regclass);


--
-- Name: Receipt_backup id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Receipt_backup" ALTER COLUMN id SET DEFAULT nextval('public."Receipt_backup_id_seq"'::regclass);


--
-- Name: Stockman id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Stockman" ALTER COLUMN id SET DEFAULT nextval('public."Stockman_id_seq"'::regclass);


--
-- Name: Stockman_backup id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Stockman_backup" ALTER COLUMN id SET DEFAULT nextval('public."Stockman_backup_id_seq"'::regclass);


--
-- Name: journal id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.journal ALTER COLUMN id SET DEFAULT nextval('public.journal_id_seq'::regclass);


--
-- Data for Name: Admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Admin" (id, client_id) FROM stdin;
15	104
\.


--
-- Data for Name: Admin_backup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Admin_backup" (id, type, old_id, client_id, change_time) FROM stdin;
7	INSERT	13	84	2020-12-14 23:17:25.322501
8	DELETE	13	84	2020-12-14 23:08:12.092532
9	INSERT	13	84	2020-12-14 23:27:59.7851
10	DELETE	13	84	2020-12-15 12:26:56.614554
11	INSERT	13	84	2020-12-15 09:27:14.916276
16	INSERT	2	92	2020-12-15 13:25:24.1917
17	UPDATE	2	92	2020-12-15 13:25:56.332701
19	UPDATE	2	84	2020-12-15 10:27:40.283058
20	UPDATE	2	92	2020-12-15 12:59:41.741085
21	UPDATE	2	84	2020-12-15 12:59:41.741085
22	DELETE	2	92	2020-12-15 16:33:27.921206
36	INSERT	2	92	2020-12-15 17:59:00.381832
37	UPDATE	2	92	2020-12-15 17:59:00.381832
38	UPDATE	2	84	2020-12-15 17:59:00.381832
39	UPDATE	2	92	2020-12-15 17:59:00.381832
40	UPDATE	2	84	2020-12-15 17:59:00.381832
41	DELETE	2	92	2020-12-15 17:59:00.381832
42	INSERT	13	84	2020-12-15 17:59:00.381832
43	DELETE	13	84	2020-12-15 17:59:00.381832
44	INSERT	13	84	2020-12-15 17:59:00.381832
45	DELETE	13	84	2020-12-15 17:59:00.381832
46	DELETE	1	1	2020-12-19 20:03:03.886566
47	INSERT	14	100	2020-12-19 17:20:53.391815
48	DELETE	14	100	2020-12-19 22:19:53.059796
49	INSERT	15	104	2020-12-19 19:20:36.713389
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Category" (id, name, parent) FROM stdin;
1	all	\N
14	Tranquilizers	12
15	Facial	3
16	Antiseptics	12
18	Sedative	12
3	Cosmetics	1
4	Ointment	3
12	Medicines	1
2	Analgetics	12
13	Antidepressants	12
\.


--
-- Data for Name: Category_backup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Category_backup" (id, type, old_id, name, parent, change_time) FROM stdin;
1	INSERT	6	wqqa	1	2020-12-14 13:02:55.306729
6	INSERT	11	Pudra	3	2020-12-15 02:36:02.344298
7	DELETE	11	Pudra	3	2020-12-14 23:37:26.886356
8	UPDATE	2	Analgetics	1	2020-12-15 14:09:37.371054
9	UPDATE	2	analgetics	1	2020-12-15 11:13:09.268224
10	UPDATE	2	Analgetics	1	2020-12-15 12:59:41.741085
11	UPDATE	2	analgetics	1	2020-12-15 12:59:41.741085
12	UPDATE	4	Ointment	3	2020-12-15 16:36:20.863781
13	UPDATE	4	Ointments	3	2020-12-15 13:36:46.1051
14	UPDATE	4	Ointment	3	2020-12-15 14:49:30.246329
15	UPDATE	4	Ointments	3	2020-12-15 17:54:37.49803
16	UPDATE	4	Ointment	3	2020-12-15 17:54:37.49803
17	UPDATE	4	Ointments	3	2020-12-15 17:54:37.49803
38	UPDATE	4	Ointment	3	2020-12-15 17:59:00.381832
39	UPDATE	4	Ointments	3	2020-12-15 17:59:00.381832
40	UPDATE	4	Ointment	3	2020-12-15 17:59:00.381832
41	UPDATE	4	Ointments	3	2020-12-15 17:59:00.381832
42	UPDATE	4	Ointment	3	2020-12-15 17:59:00.381832
43	UPDATE	4	Ointments	3	2020-12-15 17:59:00.381832
44	UPDATE	2	Analgetics	1	2020-12-15 17:59:00.381832
45	UPDATE	2	analgetics	1	2020-12-15 17:59:00.381832
46	UPDATE	2	Analgetics	1	2020-12-15 17:59:00.381832
47	UPDATE	2	analgetics	1	2020-12-15 17:59:00.381832
48	INSERT	11	Pudra	3	2020-12-15 17:59:00.381832
49	DELETE	11	Pudra	3	2020-12-15 17:59:00.381832
50	UPDATE	4	Ointment	3	2020-12-16 10:15:16.57364
51	UPDATE	4	Ointment	3	2020-12-16 10:15:34.554804
52	UPDATE	4	Ointment	2	2020-12-16 10:15:59.256359
53	UPDATE	3	Cosmetics	3	2020-12-16 10:16:20.299872
54	UPDATE	3	Cosmetics	6	2020-12-16 10:16:26.159697
55	DELETE	6	wqqa	1	2020-12-16 10:51:20.702649
56	UPDATE	4	Ointment	1	2020-12-16 10:52:44.499399
57	INSERT	12	Medicines	1	2020-12-16 11:06:51.068413
58	UPDATE	2	Analgetics	1	2020-12-16 11:07:00.991431
59	UPDATE	2	Analgetics	12	2020-12-16 11:07:07.518027
60	INSERT	13	Antidepressants	12	2020-12-16 11:07:58.564244
61	INSERT	14	Tranquilizers	12	2020-12-16 11:08:47.716328
62	UPDATE	14	Tranquilizers	12	2020-12-16 11:08:58.235454
63	INSERT	15	Facial	3	2020-12-16 11:11:20.270414
64	INSERT	16	Antiseptics	12	2020-12-16 11:13:23.562079
66	DELETE	17	Уход за телом	3	2020-12-16 14:18:46.216501
67	INSERT	18	Успокоительные	12	2020-12-19 06:41:21.781901
68	UPDATE	18	Успокоительные	12	2020-12-21 02:02:01.308667
\.


--
-- Data for Name: Client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Client" (id, surname, name, patronymic, birth_year, login, email, password, phone) FROM stdin;
104	c1dac4ef50	c1dac4ef50	c1dac4ef50	1960	c1dac4ef50	c1fec8	$2b$10$.oGJD7fN1Gb0RiNhP6wqlu2CI/He5X0qEhY9NN/dFQuhbbbPrFn6e	908e99b60eff76bdbacd
105	cddfc7e759aa34	cddfc7e759aa34	cddfc7e759aa34	2000	cddfc7e759aa34	cdfec4	$2b$10$AiejaHhEGu5ugZakXfdXluYxqpr5CDxbDHcsTEip.AaEc6Ta58xnG	918f98b70ffe77bcbbcc
107	d3cac6e555a227e3b8	d3cac6e555a227e3b8	d3cac6e555a227e3b8	1999	d3cac6e555a227e3b8	d38ce9f50c	$2b$10$wzzGcbPZdt/cJD2DYKXxsOEVuTYFlAIowVqFFkB8LvMzEI1LnTeyG	938d9ab50dfc75beb9ce
103	d1cf	d1cf	d1cf	2000	d4dbdaf20f	d4fedd	$2b$10$IIsjdC5MaceRMVd2joKiGunEFEgoOXObxCPtrSBzHlTu6MG4yjHlu	918c9ab20bf971b5b3cd
106	d3cac6e555a227e3bb	d3cac6e555a227e3bb	d3cac6e555a227e3bb	1999	d3cac6e555a227e3bb	d38fe9f50f	$2b$10$dyEgKamj7VG5TdrGipyp2ej.6Zi38lq1USGPsJ0AYvIYPSeJMWiWC	928c9bb40cfd74bfb8cf
\.


--
-- Data for Name: Client_backup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Client_backup" (id, type, old_id, surname, name, patronymic, birth_year, login, email, password, phone, change_time) FROM stdin;
1	INSERT	90	qq	qq	qq	2000	test1	t@t	$2b$10$64PvrazdndgDOR4XOH3CMeWsTdU7pBs6bY5b20NzlwLoFf8EWrTn2	1234567890	2020-12-15 02:59:03.470243
2	DELETE	90	qq	qq	qq	2000	test1	t@t	$2b$10$64PvrazdndgDOR4XOH3CMeWsTdU7pBs6bY5b20NzlwLoFf8EWrTn2	1234567890	2020-12-14 23:59:38.363118
3	INSERT	90	qq	qq	qq	2000	test1	t@t	$2b$10$64PvrazdndgDOR4XOH3CMeWsTdU7pBs6bY5b20NzlwLoFf8EWrTn2	1234567890	2020-12-15 00:27:26.874768
4	DELETE	90	qq	qq	qq	2000	test1	t@t	$2b$10$64PvrazdndgDOR4XOH3CMeWsTdU7pBs6bY5b20NzlwLoFf8EWrTn2	1234567890	2020-12-15 09:06:17.900543
5	INSERT	90	qq	qq	qq	2000	test1	t@t	$2b$10$64PvrazdndgDOR4XOH3CMeWsTdU7pBs6bY5b20NzlwLoFf8EWrTn2	1234567890	2020-12-15 09:14:17.920917
6	DELETE	90	qq	qq	qq	2000	test1	t@t	$2b$10$64PvrazdndgDOR4XOH3CMeWsTdU7pBs6bY5b20NzlwLoFf8EWrTn2	1234567890	2020-12-15 09:14:24.581675
7	INSERT	91	qq	qq	qq	2000	test1	t@t	$2b$10$VszBrE1ZGQy0VBd8eA483O3UUFQ/SFsmoky231BdCYr1THaOsSSyu	1234567890	2020-12-15 12:27:53.540313
8	DELETE	91	qq	qq	qq	2000	test1	t@t	$2b$10$VszBrE1ZGQy0VBd8eA483O3UUFQ/SFsmoky231BdCYr1THaOsSSyu	1234567890	2020-12-15 09:28:09.16176
9	INSERT	92	qq	qq	qq	2000	test1	t@t	$2b$10$cg/Nh..OYlQlUVVRMCfk.Ounpwl8XYKVdjE664NkpHU1ZQ4AHERIe	1234567890	2020-12-15 13:24:49.785986
20	DELETE	92	qq	qq	qq	2000	test1	t@t	$2b$10$cg/Nh..OYlQlUVVRMCfk.Ounpwl8XYKVdjE664NkpHU1ZQ4AHERIe	1234567890	2020-12-15 17:59:00.381832
21	INSERT	91	qq	qq	qq	2000	test1	t@t	$2b$10$VszBrE1ZGQy0VBd8eA483O3UUFQ/SFsmoky231BdCYr1THaOsSSyu	1234567890	2020-12-15 17:59:00.381832
22	DELETE	91	qq	qq	qq	2000	test1	t@t	$2b$10$VszBrE1ZGQy0VBd8eA483O3UUFQ/SFsmoky231BdCYr1THaOsSSyu	1234567890	2020-12-15 17:59:00.381832
23	INSERT	90	qq	qq	qq	2000	test1	t@t	$2b$10$64PvrazdndgDOR4XOH3CMeWsTdU7pBs6bY5b20NzlwLoFf8EWrTn2	1234567890	2020-12-15 17:59:00.381832
24	DELETE	90	qq	qq	qq	2000	test1	t@t	$2b$10$64PvrazdndgDOR4XOH3CMeWsTdU7pBs6bY5b20NzlwLoFf8EWrTn2	1234567890	2020-12-15 17:59:00.381832
25	INSERT	90	qq	qq	qq	2000	test1	t@t	$2b$10$64PvrazdndgDOR4XOH3CMeWsTdU7pBs6bY5b20NzlwLoFf8EWrTn2	1234567890	2020-12-15 17:59:00.381832
26	DELETE	90	qq	qq	qq	2000	test1	t@t	$2b$10$64PvrazdndgDOR4XOH3CMeWsTdU7pBs6bY5b20NzlwLoFf8EWrTn2	1234567890	2020-12-15 17:59:00.381832
27	INSERT	90	qq	qq	qq	2000	test1	t@t	$2b$10$64PvrazdndgDOR4XOH3CMeWsTdU7pBs6bY5b20NzlwLoFf8EWrTn2	1234567890	2020-12-15 17:59:00.381832
28	DELETE	90	qq	qq	qq	2000	test1	t@t	$2b$10$64PvrazdndgDOR4XOH3CMeWsTdU7pBs6bY5b20NzlwLoFf8EWrTn2	1234567890	2020-12-15 17:59:00.381832
29	INSERT	93	qq	qq	qq	2000	test1	t@t	$2b$10$/Hlk.8J1I9ZSufsitOLMvOHDeqG.Z4dWcaayH.ZdYMdRp53YDzPga	1234567890	2020-12-19 06:36:58.999522
30	INSERT	94	5eabc9544f42dc66ec7d9491e56b7a72	5eabc9544f42dc66ec7d9491e56b7a72	5eabc9544f42dc66ec7d9491e56b7a72	1998	5eabc9544f42dc66ec7d9491e56b7a72	5eabc9544f42dc66ec7d9491e56b7a72	$2b$10$S/5vgNUXoX79JiKxA1M/AOVMs2.OFsvl8Kt2T7SAw5vcpzUHwbp56	5eabc9544f42dc66ec7d9491e56b7a72	2020-12-19 19:55:47.065525
32	INSERT	96	a162920030fa	a776910235fd37	b861830536e227c584	1996	8776911238	8776911238d43ece8d367be73c3a	$2b$10$p4qkS2Ub0MFIjvo60qNiueABxpdjEAk9JzuNKqmDs4K4bcmnMz6NK	c82fda5260a57a95de7d	2020-12-19 19:59:37.031447
33	INSERT	97	ab5b	ab5b	ab5b	2000	ae4fe9fc1d	ae6aee	$2b$10$2cwmjHifvK9iVj4Zh1VhSe1Jxbe6J6HvfJcGpkIgiwzDu1LW4uJB.	eb18a9bc19fe4f683a83	2020-12-19 20:01:59.729762
34	DELETE	1	admin	admin	admin	1960	admin	a@a	$2b$10$wvZQ5l7q/3m2PrCT59qD8.qD6EI1lRxdooURcDQB9LigSnY6G8Ce6	0000000000	2020-12-19 20:03:03.886566
35	DELETE	85	manager	manager	manager	2000	manager	m@m	$2b$10$XmCuFzbBqXbzjekilUiBOODaoq2OdKXICJCi8gTkIcszoWm6dLwiG	2222222222	2020-12-19 20:03:03.886566
36	DELETE	93	qq	qq	qq	2000	test1	t@t	$2b$10$/Hlk.8J1I9ZSufsitOLMvOHDeqG.Z4dWcaayH.ZdYMdRp53YDzPga	1234567890	2020-12-19 20:03:03.886566
37	DELETE	94	5eabc9544f42dc66ec7d9491e56b7a72	5eabc9544f42dc66ec7d9491e56b7a72	5eabc9544f42dc66ec7d9491e56b7a72	1998	5eabc9544f42dc66ec7d9491e56b7a72	5eabc9544f42dc66ec7d9491e56b7a72	$2b$10$S/5vgNUXoX79JiKxA1M/AOVMs2.OFsvl8Kt2T7SAw5vcpzUHwbp56	5eabc9544f42dc66ec7d9491e56b7a72	2020-12-19 20:03:03.886566
38	DELETE	96	a162920030fa	a776910235fd37	b861830536e227c584	1996	8776911238	8776911238d43ece8d367be73c3a	$2b$10$p4qkS2Ub0MFIjvo60qNiueABxpdjEAk9JzuNKqmDs4K4bcmnMz6NK	c82fda5260a57a95de7d	2020-12-19 20:03:03.886566
39	DELETE	79	stockman	stockman	stockman	2000	stockman	s@s	$2b$10$rBhk437WbEbfY77WwIXQBuESo3VR7Mcgmz8oclf79sZO5uKlZtyTC	0987654321	2020-12-19 20:03:03.886566
40	DELETE	84	client	test	w	1999	testw	w@w	$2b$10$JhljU0h0qm8oxAXJUfnKEummbpTXaaZLkwjCQN7SwB9JOISMIqoyK	9999999999	2020-12-19 20:03:03.886566
41	DELETE	97	ab5b	ab5b	ab5b	2000	ae4fe9fc1d	ae6aee	$2b$10$2cwmjHifvK9iVj4Zh1VhSe1Jxbe6J6HvfJcGpkIgiwzDu1LW4uJB.	eb18a9bc19fe4f683a83	2020-12-19 20:03:03.886566
42	INSERT	98	6528	6528	6528	2000	603cc2d62e	6019c5	$2b$10$2FypcKMxLpiMMbitr3Qyp.PMS5Dsxa67cw1aHh6E2c.UIJFjPmgdG	256b82962a87c9ad2553	2020-12-19 20:03:28.924461
43	INSERT	99	c85e	c85e	c85e	2000	cd4abff202	cd6fb8	$2b$10$zMQ.x9Zy7nYkgsT9Aj1X/OUZPuRAtSTXxttGxcsznQbsbvB2nQzxO	881dffb206220217cf05	2020-12-19 20:04:58.481419
44	INSERT	100	d84ba1ef5d	d84ba1ef5d	d84ba1ef5d	1960	d84ba1ef5d	d86fad	$2b$10$gHJhp.FIwpS/OPBk/bUi8O0X2htmI6V8zMWMX1VCnuFk1W/UTUyEW	891ffcb60324051fc605	2020-12-19 20:19:11.304438
45	INSERT	101	9c68	9c68	9c68	2000	997c40e8b9	995947	$2b$10$A0LsP.OmF8yQx6n0ze0.ue8ABuyA9q4pnjwea/aGwXRgh6Wpw1X8a	dc2b00a8bdfc57d49715	2020-12-19 20:25:39.739021
46	INSERT	102	8c7d5ef5e6	8c7d5ef5e6	8c7d5ef5e6	1960	8c7d5ef5e6	8c5952	$2b$10$aoCIjfeEQ5hcO.Z0OCRf4.iLwQrsa6rGvEWQGABuLhDvQRbyiW0lG	dd2903acb8fa50dc9e15	2020-12-19 20:26:53.635558
47	INSERT	103	d1cf	d1cf	d1cf	2000	d4dbdaf20f	d4fedd	$2b$10$IIsjdC5MaceRMVd2joKiGunEFEgoOXObxCPtrSBzHlTu6MG4yjHlu	918c9ab20bf971b5b3cd	2020-12-19 20:41:24.811801
48	INSERT	104	c1dac4ef50	c1dac4ef50	c1dac4ef50	1960	c1dac4ef50	c1fec8	$2b$10$.oGJD7fN1Gb0RiNhP6wqlu2CI/He5X0qEhY9NN/dFQuhbbbPrFn6e	908e99b60eff76bdbacd	2020-12-19 22:18:15.007834
49	DELETE	98	6528	6528	6528	2000	603cc2d62e	6019c5	$2b$10$2FypcKMxLpiMMbitr3Qyp.PMS5Dsxa67cw1aHh6E2c.UIJFjPmgdG	256b82962a87c9ad2553	2020-12-19 22:19:53.059796
50	DELETE	100	d84ba1ef5d	d84ba1ef5d	d84ba1ef5d	1960	d84ba1ef5d	d86fad	$2b$10$gHJhp.FIwpS/OPBk/bUi8O0X2htmI6V8zMWMX1VCnuFk1W/UTUyEW	891ffcb60324051fc605	2020-12-19 22:19:53.059796
51	DELETE	99	c85e	c85e	c85e	2000	cd4abff202	cd6fb8	$2b$10$zMQ.x9Zy7nYkgsT9Aj1X/OUZPuRAtSTXxttGxcsznQbsbvB2nQzxO	881dffb206220217cf05	2020-12-19 22:19:53.059796
52	DELETE	101	9c68	9c68	9c68	2000	997c40e8b9	995947	$2b$10$A0LsP.OmF8yQx6n0ze0.ue8ABuyA9q4pnjwea/aGwXRgh6Wpw1X8a	dc2b00a8bdfc57d49715	2020-12-19 22:19:53.059796
53	INSERT	105	cddfc7e759aa34	cddfc7e759aa34	cddfc7e759aa34	2000	cddfc7e759aa34	cdfec4	$2b$10$AiejaHhEGu5ugZakXfdXluYxqpr5CDxbDHcsTEip.AaEc6Ta58xnG	918f98b70ffe77bcbbcc	2020-12-21 01:21:35.471872
54	DELETE	102	8c7d5ef5e6	8c7d5ef5e6	8c7d5ef5e6	1960	8c7d5ef5e6	8c5952	$2b$10$aoCIjfeEQ5hcO.Z0OCRf4.iLwQrsa6rGvEWQGABuLhDvQRbyiW0lG	dd2903acb8fa50dc9e15	2020-12-21 01:37:39.24418
55	INSERT	106	d3cac6e555a227e3bb	d3cac6e555a227e3bb	d3cac6e555a227e3bb	1999	d3cac6e555a227e3bb	d38fe9f50f	$2b$10$dyEgKamj7VG5TdrGipyp2ej.6Zi38lq1USGPsJ0AYvIYPSeJMWiWC	928c9bb40cfd74bfb8cf	2020-12-21 10:12:46.655086
56	INSERT	107	d3cac6e555a227e3b8	d3cac6e555a227e3b8	d3cac6e555a227e3b8	1999	d3cac6e555a227e3b8	d38ce9f50c	$2b$10$wzzGcbPZdt/cJD2DYKXxsOEVuTYFlAIowVqFFkB8LvMzEI1LnTeyG	938d9ab50dfc75beb9ce	2020-12-21 10:13:32.274748
\.


--
-- Data for Name: Delivery_pharmacy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Delivery_pharmacy" (id, name, city, address, schedule) FROM stdin;
1	apteka1	Moscow	ul. Lermontova 55	\N
2	Rigla	Volgograd	ul. Sadovaya 55	\N
\.


--
-- Data for Name: Delivery_pharmacy_backup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Delivery_pharmacy_backup" (id, type, old_id, name, city, address, schedule, change_time) FROM stdin;
2	INSERT	2	Rigla	Rostov	ul. Sadovaya 55	\N	2020-12-16 09:58:04.586598
3	UPDATE	2	Rigla	Rostov	ul. Sadovaya 55	\N	2020-12-16 09:59:47.01016
\.


--
-- Data for Name: Drug; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Drug" (id, name, active_substance, description, release_form, single_weight, prescription, manufacturer_id, category_id, in_stock, price) FROM stdin;
57	Клоназепам	клоназепам	Противоэпилептическое лекарственное средство из группы производных бензодиазепина. Припадки генерализованного типа подавляет в большей степени, чем фокального, поэтому используется при таких типах, как миоклонические и атонические припадки, абсансы, а также при фотосенситивной эпилепсии.	30 таблеток 	2	f	1	14	40	700
59	Флуоксетин	фл. гидрохлорид	Антидепрессант, производное пропиламина. Механизм действия связан с избирательной блокадой обратного нейронального захвата серотонина в ЦНС. 	20 капсул	20	f	1	13	35	325
56	Алпразолам	алпразолам	Лекарственное средство, анксиолитик (противотревожное средство), производное бензодиазепина средней продолжительности действия, которое используется для лечения панических расстройств, тревожных неврозов, таких как тревожное расстройство или социофобия.	50 таблеток 	1	f	1	14	30	1200
58	Амитриптилин	амитриптилин	Антидепрессант из группы трициклических соединений, производное дибензоциклогептадина.	50 таблеток 	25	f	1	13	140	25
7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	2	130	150
38	8	8	8	8	0	f	1	\N	0	0
61	Перекись водорода	п.о. водорода	Антисептик, используемый во многих направлениях медицины, чаще всего для обработки порезов, ссадин, царапин, промывания гнойных ран для удаления гноя и инфекции. 	1	100	f	1	16	200	5
2	paracetamol	paracetamol	Аспирин (ацетилсалициловая кислота) относится к группе неспецифических противовоспалительных препаратов (НПВП, или неспецифических противовоспалительных средств, НПВС), широко использовался как обезболивающий и противовоспалительный препарат. Относительно недавно стал использоваться в профилактике сердечно-сосудистых заболеваний.	100 tablets	100	t	1	2	119	350.50
55	Бепантен	пантеноновая кислота	Стимулятор регенерации тканей, относится к витаминам группы B. 	50мг мазь	2	f	1	4	150	240
62	Mineral 89	гиауроновая. кисл.	Восстанавливающий и укрепляющий уход для кожи вокруг глаз Mineral 89 с рекордной концентрацией термальной воды Vichy [89%].	1	15	f	4	15	10	500
1	aspirin	acetylsalicylic acid	НПВС. Оказывает противовоспалительное, анальгезирующее и жаропонижающее действие, а также угнетает агрегацию тромбоцитов.	100 tablets	100	f	1	2	97	50.50
\.


--
-- Data for Name: Drug_backup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Drug_backup" (id, type, old_id, name, active_substance, description, release_form, single_weight, prescription, manufacturer_id, category_id, in_stock, price, change_time) FROM stdin;
1	DELETE	18	ыsss	ыsss	ы1	21	231	t	1	\N	55	11	2020-12-14 08:17:48.47091
2	UPDATE	33	ssss	7	7	7	0	f	1	1	0	7	2020-12-14 08:18:05.802737
3	UPDATE	33	ssss	7	7	7	0	f	1	4	0	7	2020-12-14 11:18:31.32053
4	INSERT	53	Matii Kropka	1111	sadasd2	tre	0	t	2	3	0	0	2020-12-14 11:19:25.576413
5	UPDATE	34	7	7	7	7	0	f	1	2	0	7	2020-12-14 12:12:17.092701
6	UPDATE	34	7	7	7	7	0	f	1	2	0	7	2020-12-14 12:13:37.547
7	UPDATE	32	7	7	7	7	0	f	1	2	0	7	2020-12-14 12:15:40.297359
8	UPDATE	33	ssss	7	7	7	0	f	1	4	0	7	2020-12-14 12:17:30.782169
9	UPDATE	33	ssss	7	7	7	0	f	1	4	0	7	2020-12-14 09:20:06.490656
10	UPDATE	33	ssss	7	7	7	0	f	1	4	0	7	2020-12-14 12:21:49.067985
11	UPDATE	33	ssss	7	7	7	0	f	1	4	0	7	2020-12-14 12:22:02.345365
12	UPDATE	15	2	2	2	2	22222222	f	1	2	0	0	2020-12-14 12:29:36.02714
13	UPDATE	15	2	2	2	2	22222222	f	1	2	0	0	2020-12-14 12:29:36.201418
14	UPDATE	15	2	2	2	2	22222222	f	1	2	0	0	2020-12-14 12:29:36.360825
15	UPDATE	15	2	2	2	2	22222222	f	1	2	0	0	2020-12-14 12:39:08.424452
16	UPDATE	15	2	2	2	2	22222222	f	1	2	0	0	2020-12-14 12:40:19.341298
17	UPDATE	15	2	2	2	2	22222222	f	1	2	0	0	2020-12-14 12:40:19.841953
18	UPDATE	15	2	2	2	2	22222222	f	1	2	0	0	2020-12-14 12:40:20.014586
19	UPDATE	15	2	2	2	2	22222222	f	1	2	0	0	2020-12-14 12:45:12.031894
20	UPDATE	15	2	2	2	2	99999999	f	1	2	0	0	2020-12-14 12:45:12.22704
21	UPDATE	15	2	2	2	2	99999999	f	1	2	0	0	2020-12-14 12:45:12.384342
22	UPDATE	33	ssss	7	7	7	55555	f	2	3	0	7	2020-12-14 13:29:09.981572
23	UPDATE	2	paracetamol	paracetamol	Аспирин (ацетилсалициловая кислота) относится к группе неспецифических противовоспалительных препаратов (НПВП, или неспецифических противовоспалительных средств, НПВС), широко использовался как обезболивающий и противовоспалительный препарат. Относительно недавно стал использоваться в профилактике сердечно-сосудистых заболеваний.	100 tablets	100	t	1	2	118	350.50	2020-12-15 12:29:28.322831
24	INSERT	54	testDrug	testDrug	testDrug	testDrug	0	f	1	4	5	0	2020-12-15 12:30:08.127094
28	DELETE	54	testDrug	testDrug	testDrug	testDrug	0	f	1	4	5	0	2020-12-15 17:59:00.381832
29	UPDATE	2	Парацетамол	paracetamol	Аспирин (ацетилсалициловая кислота) относится к группе неспецифических противовоспалительных препаратов (НПВП, или неспецифических противовоспалительных средств, НПВС), широко использовался как обезболивающий и противовоспалительный препарат. Относительно недавно стал использоваться в профилактике сердечно-сосудистых заболеваний.	100 tablets	100	t	1	2	118	350.50	2020-12-15 17:59:00.381832
31	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	1	128	150	2020-12-15 18:17:35.466411
32	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	1	130	150	2020-12-15 18:17:35.466411
33	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	1	132	150	2020-12-15 20:26:15.216537
34	DELETE	53	Matii Kropka	1111	sadasd2	tre	0	t	2	3	0	0	2020-12-15 20:26:59.652259
35	DELETE	33	ssss	7	7	7222	55555	f	2	3	0	7	2020-12-15 20:27:02.937942
36	INSERT	55	Бепантен	пантеноновая кислота	Стимулятор регенерации тканей, относится к витаминам группы B. 	50мг мазь	2	f	1	4	150	240	2020-12-16 10:13:59.341717
37	DELETE	19	3	3	3	3	0	f	1	1	0	0	2020-12-16 10:34:35.65639
38	DELETE	20	3	3	3	3	0	t	1	1	0	0	2020-12-16 10:34:40.16896
39	DELETE	52	10	10	10	111	0	f	1	1	1	0	2020-12-16 10:34:43.71153
40	DELETE	51	10	10	10	111	0	f	1	1	1	0	2020-12-16 10:34:46.473357
41	DELETE	23	3	3	3	3	0	t	1	1	0	0	2020-12-16 10:34:49.629958
42	DELETE	22	3	3	3	3	0	t	1	1	0	0	2020-12-16 10:34:54.334394
43	DELETE	21	3	3	3	3	0	t	1	1	0	0	2020-12-16 10:36:27.297334
44	DELETE	24	4	4	4	4	0	f	1	2	0	0	2020-12-16 10:36:39.152787
45	DELETE	49	7	7	7	7	0	f	1	2	0	0	2020-12-16 10:36:44.479485
46	DELETE	34	7	7	7	7	0	f	1	2	0	7	2020-12-16 10:36:51.130193
47	DELETE	42	9	9	9	9	9	f	1	2	9	9	2020-12-16 10:42:50.508388
48	DELETE	28	5	5	5	5	0	f	1	2	0	0	2020-12-16 10:42:56.051438
49	DELETE	37	8	8	8	8	0	f	1	2	0	0	2020-12-16 10:42:58.959848
50	DELETE	39	8	8	8	8	0	f	1	2	0	0	2020-12-16 10:43:02.804196
51	DELETE	27	5	5	5	5	0	f	1	2	0	0	2020-12-16 10:43:05.716327
52	DELETE	41	9	9	9	9	9	f	1	2	9	9	2020-12-16 10:43:09.082708
53	DELETE	40	9	9	9	9	9	f	1	2	9	9	2020-12-16 10:43:11.695827
54	DELETE	15	2	2	2	2	99999999	f	1	2	0	0	2020-12-16 10:43:15.488956
55	DELETE	32	7	7	7	7	0	f	1	2	0	7	2020-12-16 10:43:19.009696
56	DELETE	48	7	7	7	7	0	f	1	2	0	0	2020-12-16 10:43:22.727366
57	UPDATE	29	5	5	5	5	0	f	1	2	0	0	2020-12-16 10:49:50.830469
58	DELETE	29	5	5	5	5	0	f	1	2	0	0	2020-12-16 10:49:50.835982
59	UPDATE	25	5	5	5	5	0	f	1	2	0	0	2020-12-16 10:50:36.474065
60	DELETE	25	5	5	5	5	0	f	1	2	0	0	2020-12-16 10:50:36.479755
61	UPDATE	26	5	5	5	5	0	f	1	2	0	0	2020-12-16 10:50:40.310236
62	DELETE	26	5	5	5	5	0	f	1	2	0	0	2020-12-16 10:50:40.316012
63	DELETE	43	9	9	9	9	9	f	1	2	9	9	2020-12-16 10:50:43.379408
64	DELETE	44	9	9	9	9	9	f	1	2	9	9	2020-12-16 10:50:46.969454
65	UPDATE	46	7	7	7	7	0	f	1	2	0	0	2020-12-16 10:50:49.614508
66	DELETE	46	7	7	7	7	0	f	1	2	0	0	2020-12-16 10:50:49.615087
67	UPDATE	38	8	8	8	8	0	f	1	2	0	0	2020-12-16 10:51:05.050374
68	UPDATE	38	8	8	8	8	0	f	1	6	0	0	2020-12-16 10:51:20.702649
69	UPDATE	36	7	7	7	7	0	f	1	2	0	7	2020-12-16 10:51:41.553328
70	DELETE	36	7	7	7	7	0	f	1	2	0	7	2020-12-16 10:51:41.558886
71	DELETE	47	7	7	7	7	0	f	1	2	0	0	2020-12-16 10:51:44.658764
72	DELETE	35	7	7	7	7	0	f	1	2	0	7	2020-12-16 10:51:47.437286
73	INSERT	56	Алпразолам	алпразолам	Лекарственное средство, анксиолитик (противотревожное средство), производное бензодиазепина средней продолжительности действия, которое используется для лечения панических расстройств, тревожных неврозов, таких как тревожное расстройство или социофобия.	50 таблеток 	1	f	1	14	30	1200	2020-12-16 11:21:38.815179
74	INSERT	57	Клоназепам	клоназепам	Противоэпилептическое лекарственное средство из группы производных бензодиазепина. Припадки генерализованного типа подавляет в большей степени, чем фокального, поэтому используется при таких типах, как миоклонические и атонические припадки, абсансы, а также при фотосенситивной эпилепсии.	30 таблеток 	2	f	1	14	40	700	2020-12-16 11:24:39.203439
75	INSERT	58	Амитриптилин	амитриптилин	Антидепрессант из группы трициклических соединений, производное дибензоциклогептадина.	50 таблеток 	25	f	1	13	140	25	2020-12-16 11:27:48.127443
76	INSERT	59	Флуоксетин	фл. гидрохлорид	Антидепрессант, производное пропиламина. Механизм действия связан с избирательной блокадой обратного нейронального захвата серотонина в ЦНС. 	20 капсул	20	f	1	13	35	325	2020-12-16 11:35:55.943241
77	UPDATE	58	Амитриптилин	амитриптилин	Антидепрессант из группы трициклических соединений, производное дибензоциклогептадина.	50 таблеток 	25	f	1	13	140	25	2020-12-16 11:37:46.679872
78	UPDATE	58	Амитриптилин	амитриптилин	Антидепрессант из группы трициклических соединений, производное дибензоциклогептадина.	50 таблеток 	25	f	1	13	140	25	2020-12-16 11:38:17.688267
79	UPDATE	58	Амитриптилин	амитриптилин	Антидепрессант из группы трициклических соединений, производное дибензоциклогептадина.	50 таблеток 	25	f	1	13	140	25	2020-12-16 11:40:42.326242
80	UPDATE	58	Амитриптилин	амитриптилин	Антидепрессант из группы трициклических соединений, производное дибензоциклогептадина.	50 таблеток 	25	f	1	13	140	25	2020-12-16 11:41:47.1759
81	INSERT	60	Перекись водорода	п.о. водорода	Антисептик, используемый во многих направлениях медицины, чаще всего для обработки порезов, ссадин, царапин, промывания гнойных ран для удаления гноя и инфекции. 	1	100	f	1	16	200	5	2020-12-16 11:48:28.792465
82	INSERT	61	Перекись водорода	п.о. водорода	Антисептик, используемый во многих направлениях медицины, чаще всего для обработки порезов, ссадин, царапин, промывания гнойных ран для удаления гноя и инфекции. 	1	100	f	1	16	200	5	2020-12-16 11:48:43.928946
83	UPDATE	60	Перекись водорода	п.о. водорода	Антисептик, используемый во многих направлениях медицины, чаще всего для обработки порезов, ссадин, царапин, промывания гнойных ран для удаления гноя и инфекции. 	1	100	f	1	16	200	5	2020-12-16 11:49:30.717689
84	DELETE	60	Перекись водорода	п.о. водорода	Антисептик, используемый во многих направлениях медицины, чаще всего для обработки порезов, ссадин, царапин, промывания гнойных ран для удаления гноя и инфекции. 	1	100	f	1	16	200	5	2020-12-16 11:49:30.718949
85	INSERT	62	Mineral 89	гиауроновая. кисл.	    Восстанавливающий и укрепляющий уход для кожи вокруг глаз Mineral 89 с рекордной концентрацией термальной воды Vichy [89%].	1	15	f	4	15	10	500	2020-12-16 11:54:25.839839
86	UPDATE	56	Алпразолам	алпразолам	Лекарственное средство, анксиолитик (противотревожное средство), производное бензодиазепина средней продолжительности действия, которое используется для лечения панических расстройств, тревожных неврозов, таких как тревожное расстройство или социофобия.	50 таблеток 	1	f	1	14	30	1200	2020-12-16 11:58:47.264254
87	UPDATE	2	paracetamol	paracetamol	Аспирин (ацетилсалициловая кислота) относится к группе неспецифических противовоспалительных препаратов (НПВП, или неспецифических противовоспалительных средств, НПВС), широко использовался как обезболивающий и противовоспалительный препарат. Относительно недавно стал использоваться в профилактике сердечно-сосудистых заболеваний.	100 tablets	100	t	1	2	118	350.50	2020-12-16 12:01:48.531366
88	UPDATE	2	paracetamol	paracetamol	Аспирин (ацетилсалициловая кислота) относится к группе неспецифических противовоспалительных препаратов (НПВП, или неспецифических противовоспалительных средств, НПВС), широко использовался как обезболивающий и противовоспалительный препарат. Относительно недавно стал использоваться в профилактике сердечно-сосудистых заболеваний.	100 tablets	100	t	1	2	117	350.50	2020-12-16 12:02:56.487495
89	UPDATE	56	Алпразолам	алпразолам	Лекарственное средство, анксиолитик (противотревожное средство), производное бензодиазепина средней продолжительности действия, которое используется для лечения панических расстройств, тревожных неврозов, таких как тревожное расстройство или социофобия.	50 таблеток 	1	f	1	14	29	1200	2020-12-16 12:04:04.257676
90	UPDATE	61	Перекись водорода	п.о. водорода	Антисептик, используемый во многих направлениях медицины, чаще всего для обработки порезов, ссадин, царапин, промывания гнойных ран для удаления гноя и инфекции. 	1	100	f	1	16	200	5	2020-12-16 12:07:49.392957
91	UPDATE	1	aspirin	acetylsalicylic acid	НПВС. Оказывает противовоспалительное, анальгезирующее и жаропонижающее действие, а также угнетает агрегацию тромбоцитов.	100 tablets	100	f	1	2	98	50.50	2020-12-16 12:08:22.957363
92	UPDATE	1	aspirin	acetylsalicylic acid	НПВС. Оказывает противовоспалительное, анальгезирующее и жаропонижающее действие, а также угнетает агрегацию тромбоцитов.	100 tablets	100	f	1	2	97	50.50	2020-12-16 12:14:38.52468
93	UPDATE	55	Бепантен	пантеноновая кислота	Стимулятор регенерации тканей, относится к витаминам группы B. 	50мг мазь	2	f	1	4	150	240	2020-12-16 12:18:48.388367
94	UPDATE	62	Mineral 89	гиауроновая. кисл.	    Восстанавливающий и укрепляющий уход для кожи вокруг глаз Mineral 89 с рекордной концентрацией термальной воды Vichy [89%].	1	15	f	4	15	10	500	2020-12-16 14:13:20.765088
95	UPDATE	2	paracetamol	paracetamol	Аспирин (ацетилсалициловая кислота) относится к группе неспецифических противовоспалительных препаратов (НПВП, или неспецифических противовоспалительных средств, НПВС), широко использовался как обезболивающий и противовоспалительный препарат. Относительно недавно стал использоваться в профилактике сердечно-сосудистых заболеваний.	100 tablets	100	t	1	2	116	350.50	2020-12-16 14:13:20.775238
96	UPDATE	1	aspirin	acetylsalicylic acid	НПВС. Оказывает противовоспалительное, анальгезирующее и жаропонижающее действие, а также угнетает агрегацию тромбоцитов.	100 tablets	100	f	1	2	96	50.50	2020-12-19 06:37:24.25855
97	UPDATE	1	aspirin	acetylsalicylic acid	НПВС. Оказывает противовоспалительное, анальгезирующее и жаропонижающее действие, а также угнетает агрегацию тромбоцитов.	100 tablets	100	f	1	2	95	50.50	2020-12-19 06:38:22.481487
98	UPDATE	1	aspirin	acetylsalicylic acid	НПВС. Оказывает противовоспалительное, анальгезирующее и жаропонижающее действие, а также угнетает агрегацию тромбоцитов.	100 tablets	100	f	1	2	93	50.50	2020-12-19 06:38:26.047761
99	UPDATE	1	aspirin	acetylsalicylic acid	НПВС. Оказывает противовоспалительное, анальгезирующее и жаропонижающее действие, а также угнетает агрегацию тромбоцитов.	100 tablets	100	f	1	2	94	50.50	2020-12-19 10:49:25.789514
100	UPDATE	55	Бепантен	пантеноновая кислота	Стимулятор регенерации тканей, относится к витаминам группы B. 	50мг мазь	2	f	1	4	149	240	2020-12-19 10:49:25.80504
101	UPDATE	1	aspirin	acetylsalicylic acid	НПВС. Оказывает противовоспалительное, анальгезирующее и жаропонижающее действие, а также угнетает агрегацию тромбоцитов.	100 tablets	100	f	1	2	93	50.50	2020-12-19 20:03:03.886566
102	UPDATE	2	paracetamol	paracetamol	Аспирин (ацетилсалициловая кислота) относится к группе неспецифических противовоспалительных препаратов (НПВП, или неспецифических противовоспалительных средств, НПВС), широко использовался как обезболивающий и противовоспалительный препарат. Относительно недавно стал использоваться в профилактике сердечно-сосудистых заболеваний.	100 tablets	100	t	1	2	114	350.50	2020-12-19 20:03:03.886566
103	UPDATE	1	aspirin	acetylsalicylic acid	НПВС. Оказывает противовоспалительное, анальгезирующее и жаропонижающее действие, а также угнетает агрегацию тромбоцитов.	100 tablets	100	f	1	2	95	50.50	2020-12-19 20:03:03.886566
104	UPDATE	2	paracetamol	paracetamol	Аспирин (ацетилсалициловая кислота) относится к группе неспецифических противовоспалительных препаратов (НПВП, или неспецифических противовоспалительных средств, НПВС), широко использовался как обезболивающий и противовоспалительный препарат. Относительно недавно стал использоваться в профилактике сердечно-сосудистых заболеваний.	100 tablets	100	t	1	2	115	350.50	2020-12-19 20:03:03.886566
105	UPDATE	2	paracetamol	paracetamol	Аспирин (ацетилсалициловая кислота) относится к группе неспецифических противовоспалительных препаратов (НПВП, или неспецифических противовоспалительных средств, НПВС), широко использовался как обезболивающий и противовоспалительный препарат. Относительно недавно стал использоваться в профилактике сердечно-сосудистых заболеваний.	100 tablets	100	t	1	2	116	350.50	2020-12-19 20:03:03.886566
106	UPDATE	61	Перекись водорода	п.о. водорода	Антисептик, используемый во многих направлениях медицины, чаще всего для обработки порезов, ссадин, царапин, промывания гнойных ран для удаления гноя и инфекции. 	1	100	f	1	16	197	5	2020-12-19 20:03:03.886566
107	UPDATE	1	aspirin	acetylsalicylic acid	НПВС. Оказывает противовоспалительное, анальгезирующее и жаропонижающее действие, а также угнетает агрегацию тромбоцитов.	100 tablets	100	f	1	2	96	50.50	2020-12-19 20:03:03.886566
108	UPDATE	1	aspirin	acetylsalicylic acid	НПВС. Оказывает противовоспалительное, анальгезирующее и жаропонижающее действие, а также угнетает агрегацию тромбоцитов.	100 tablets	100	f	1	2	97	50.50	2020-12-19 20:03:03.886566
109	UPDATE	55	Бепантен	пантеноновая кислота	Стимулятор регенерации тканей, относится к витаминам группы B. 	50мг мазь	2	f	1	4	144	240	2020-12-19 20:03:03.886566
110	UPDATE	62	Mineral 89	гиауроновая. кисл.	    Восстанавливающий и укрепляющий уход для кожи вокруг глаз Mineral 89 с рекордной концентрацией термальной воды Vichy [89%].	1	15	f	4	15	9	500	2020-12-19 20:03:03.886566
111	UPDATE	2	paracetamol	paracetamol	Аспирин (ацетилсалициловая кислота) относится к группе неспецифических противовоспалительных препаратов (НПВП, или неспецифических противовоспалительных средств, НПВС), широко использовался как обезболивающий и противовоспалительный препарат. Относительно недавно стал использоваться в профилактике сердечно-сосудистых заболеваний.	100 tablets	100	t	1	2	117	350.50	2020-12-19 20:03:03.886566
112	UPDATE	1	aspirin	acetylsalicylic acid	НПВС. Оказывает противовоспалительное, анальгезирующее и жаропонижающее действие, а также угнетает агрегацию тромбоцитов.	100 tablets	100	f	1	2	98	50.50	2020-12-19 20:03:03.886566
113	UPDATE	55	Бепантен	пантеноновая кислота	Стимулятор регенерации тканей, относится к витаминам группы B. 	50мг мазь	2	f	1	4	145	240	2020-12-19 20:03:03.886566
114	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	2	132	150	2020-12-21 01:38:36.663017
115	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	2	129	150	2020-12-21 01:55:33.986558
116	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	2	122	150	2020-12-21 01:55:44.786833
117	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	2	118	150	2020-12-21 01:58:07.959056
118	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	2	116	150	2020-12-21 01:58:13.240345
119	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	2	119	150	2020-12-21 01:58:14.071257
120	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	2	126	150	2020-12-21 01:58:14.287206
121	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	2	130	150	2020-12-21 01:58:14.472922
122	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	2	132	150	2020-12-21 01:59:43.344172
123	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	2	130	150	2020-12-21 01:59:54.466901
124	UPDATE	7	Магний B6	магния лактат	Магний является жизненно важным элементом, который находится во всех тканях организма и необходим для нормального функционирования клеток, участвует в большинстве реакций обмена веществ. В частности, участвует в регуляции передачи нервных импульсов и в сокращении мышц.	100 таблеток	140	f	1	2	132	150	2020-12-21 09:57:36.105455
125	UPDATE	62	Mineral 89	гиауроновая. кисл.	    Восстанавливающий и укрепляющий уход для кожи вокруг глаз Mineral 89 с рекордной концентрацией термальной воды Vichy [89%].	1	15	f	4	15	10	500	2020-12-21 09:59:29.813114
126	UPDATE	1	aspirin	acetylsalicylic acid	НПВС. Оказывает противовоспалительное, анальгезирующее и жаропонижающее действие, а также угнетает агрегацию тромбоцитов.	100 tablets	100	f	1	2	99	50.50	2020-12-21 14:14:45.942014
\.


--
-- Data for Name: Manager; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Manager" (id, client_id) FROM stdin;
13	103
14	105
\.


--
-- Data for Name: Manager_backup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Manager_backup" (id, type, old_id, client_id, change_time) FROM stdin;
1	INSERT	9	84	2020-12-15 18:07:48.410153
2	DELETE	9	84	2020-12-15 18:08:41.56729
4	DELETE	10	84	2020-12-15 18:18:29.448304
6	DELETE	11	93	2020-12-19 06:40:23.742397
7	DELETE	8	85	2020-12-19 20:03:03.886566
8	INSERT	12	105	2020-12-21 01:37:46.503518
9	INSERT	13	103	2020-12-21 14:25:34.461454
10	DELETE	12	105	2020-12-21 14:29:52.012534
12	INSERT	14	105	2020-12-21 14:42:45.032345
\.


--
-- Data for Name: Manufacturer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Manufacturer" (id, name, country) FROM stdin;
1	Organika	Russia
2	Pfizer	Germany
4	Bayer	France
\.


--
-- Data for Name: Manufacturer_backup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Manufacturer_backup" (id, type, old_id, name, country, change_time) FROM stdin;
1	UPDATE	2	Pfizer	Europe	2020-12-16 09:10:05.331607
2	INSERT	4	Bayer	France	2020-12-16 09:10:33.613126
3	INSERT	5	qwer	qwer	2020-12-16 09:13:57.534824
4	DELETE	5	qwer	qwer	2020-12-16 09:14:12.905167
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Order" (id, client_id, delivery_pharmacy_id, status, order_cost, date, completion_date, manager_id, stockman_id) FROM stdin;
43	103	1	new order	300	2020-12-21	\N	\N	\N
44	103	1	new order	0	2020-12-21	\N	\N	\N
\.


--
-- Data for Name: Order_Drug; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Order_Drug" (id, order_id, drug_id, quantity, full_price) FROM stdin;
53	43	7	2	300
54	44	1	2	101.00
\.


--
-- Data for Name: Order_Drug_backup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Order_Drug_backup" (id, type, old_id, order_id, drug_id, quantity, full_price, change_time) FROM stdin;
\.


--
-- Data for Name: Order_backup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Order_backup" (id, type, old_id, client_id, delivery_pharmacy_id, status, order_cost, date, completion_date, manager_id, stockman_id, change_time) FROM stdin;
1	UPDATE	25	84	1	new order	401.00	2020-12-11	\N	\N	\N	2020-12-15 13:58:45.094268
2	UPDATE	25	84	1	approved	401.00	2020-12-11	\N	8	\N	2020-12-15 14:14:17.636579
5	UPDATE	25	84	1	in delivery point	401.00	2020-12-11	\N	8	\N	2020-12-15 11:53:55.012666
6	UPDATE	25	84	1	approved	401.00	2020-12-11	\N	8	\N	2020-12-15 12:34:32.284012
7	UPDATE	25	84	1	in delivery point	401.00	2020-12-11	\N	8	\N	2020-12-15 12:35:11.978474
8	UPDATE	25	84	1	approved	401.00	2020-12-11	\N	8	\N	2020-12-15 12:35:34.06097
9	UPDATE	25	84	1	in delivery point	401.00	2020-12-11	\N	8	\N	2020-12-15 12:59:41.741085
10	UPDATE	25	84	1	approved	401.00	2020-12-11	\N	8	\N	2020-12-15 12:59:41.741085
11	UPDATE	25	84	1	in delivery point	401.00	2020-12-11	\N	8	\N	2020-12-15 12:59:41.741085
12	UPDATE	25	84	1	approved	401.00	2020-12-11	\N	8	\N	2020-12-15 12:59:41.741085
13	UPDATE	25	84	1	in delivery point	401.00	2020-12-11	\N	8	\N	2020-12-15 12:59:41.741085
14	UPDATE	25	84	1	approved	401.00	2020-12-11	\N	8	\N	2020-12-15 12:59:41.741085
39	UPDATE	25	84	1	new order	401.00	2020-12-11	\N	8	\N	2020-12-15 17:59:00.381832
40	UPDATE	25	84	1	approved	401.00	2020-12-11	\N	8	\N	2020-12-15 17:59:00.381832
41	UPDATE	25	84	1	in delivery point	401.00	2020-12-11	\N	8	\N	2020-12-15 17:59:00.381832
42	UPDATE	25	84	1	approved	401.00	2020-12-11	\N	8	\N	2020-12-15 17:59:00.381832
43	UPDATE	25	84	1	in delivery point	401.00	2020-12-11	\N	8	\N	2020-12-15 17:59:00.381832
44	UPDATE	25	84	1	approved	401.00	2020-12-11	\N	8	\N	2020-12-15 17:59:00.381832
45	UPDATE	25	84	1	in delivery point	401.00	2020-12-11	\N	8	\N	2020-12-15 17:59:00.381832
46	UPDATE	25	84	1	approved	401.00	2020-12-11	\N	8	\N	2020-12-15 17:59:00.381832
47	UPDATE	25	84	1	in delivery point	401.00	2020-12-11	\N	8	\N	2020-12-15 17:59:00.381832
48	UPDATE	25	84	1	approved	401.00	2020-12-11	\N	8	\N	2020-12-15 17:59:00.381832
49	UPDATE	25	84	1	in delivery point	401.00	2020-12-11	\N	8	\N	2020-12-15 17:59:00.381832
50	UPDATE	25	84	1	approved	401.00	2020-12-11	\N	8	\N	2020-12-15 17:59:00.381832
54	UPDATE	26	84	1	new order	0	2020-12-15	\N	\N	\N	2020-12-15 18:17:35.466411
55	DELETE	26	84	1	new order	300	2020-12-15	\N	\N	\N	2020-12-15 18:17:35.466411
56	UPDATE	25	84	1	new order	401.00	2020-12-11	\N	8	\N	2020-12-15 19:00:34.510477
57	UPDATE	25	84	1	approved	401.00	2020-12-11	\N	8	\N	2020-12-15 19:00:44.560679
58	UPDATE	25	84	1	in delivery point	401.00	2020-12-11	\N	8	\N	2020-12-15 19:00:47.273898
59	INSERT	27	84	\N	new order	0	2020-12-16	\N	\N	\N	2020-12-16 11:58:47.252602
60	UPDATE	27	84	\N	new order	0	2020-12-16	\N	\N	\N	2020-12-16 11:58:47.264254
61	INSERT	28	84	1	new order	0	2020-12-16	\N	\N	\N	2020-12-16 12:01:48.520783
62	UPDATE	28	84	1	new order	0	2020-12-16	\N	\N	\N	2020-12-16 12:01:48.531366
63	INSERT	29	84	2	new order	0	2020-12-16	\N	\N	\N	2020-12-16 12:02:56.480972
64	UPDATE	29	84	2	new order	0	2020-12-16	\N	\N	\N	2020-12-16 12:02:56.487495
65	DELETE	27	84	\N	new order	1200	2020-12-16	\N	\N	\N	2020-12-16 12:04:04.257676
66	INSERT	30	84	1	new order	0	2020-12-16	\N	\N	\N	2020-12-16 12:07:49.382379
67	UPDATE	30	84	1	new order	0	2020-12-16	\N	\N	\N	2020-12-16 12:07:49.392957
68	INSERT	31	84	2	new order	0	2020-12-16	\N	\N	\N	2020-12-16 12:08:22.94174
69	UPDATE	31	84	2	new order	0	2020-12-16	\N	\N	\N	2020-12-16 12:08:22.957363
70	INSERT	32	84	1	new order	0	2020-12-16	\N	\N	\N	2020-12-16 12:14:38.515381
71	UPDATE	32	84	1	new order	0	2020-12-16	\N	\N	\N	2020-12-16 12:14:38.52468
72	INSERT	33	84	2	new order	0	2020-12-16	\N	\N	\N	2020-12-16 12:18:48.380954
73	UPDATE	33	84	2	new order	0	2020-12-16	\N	\N	\N	2020-12-16 12:18:48.388367
74	INSERT	34	84	1	new order	0	2020-12-16	\N	\N	\N	2020-12-16 14:13:20.751463
75	UPDATE	34	84	1	new order	0	2020-12-16	\N	\N	\N	2020-12-16 14:13:20.765088
76	UPDATE	34	84	1	new order	500	2020-12-16	\N	\N	\N	2020-12-16 14:13:20.775238
77	UPDATE	34	84	1	new order	1201.00	2020-12-16	\N	\N	\N	2020-12-16 14:14:02.636292
78	UPDATE	34	84	1	approved	1201.00	2020-12-16	\N	8	\N	2020-12-16 14:14:47.669219
79	UPDATE	34	84	1	in delivery point	1201.00	2020-12-16	\N	8	\N	2020-12-16 14:15:08.907363
80	INSERT	35	93	2	new order	0	2020-12-19	\N	\N	\N	2020-12-19 06:37:24.239452
81	UPDATE	35	93	2	new order	0	2020-12-19	\N	\N	\N	2020-12-19 06:37:24.25855
82	UPDATE	35	93	2	new order	50.50	2020-12-19	\N	\N	\N	2020-12-19 06:37:47.403426
83	INSERT	36	93	1	new order	0	2020-12-19	\N	\N	\N	2020-12-19 06:38:22.471173
84	UPDATE	36	93	1	new order	0	2020-12-19	\N	\N	\N	2020-12-19 06:38:22.481487
85	DELETE	35	93	2	approved	50.50	2020-12-19	\N	8	\N	2020-12-19 06:38:26.047761
86	UPDATE	36	93	1	new order	101.00	2020-12-19	\N	\N	\N	2020-12-19 06:39:14.891122
87	UPDATE	36	93	1	approved	101.00	2020-12-19	\N	8	\N	2020-12-19 06:39:39.677526
88	UPDATE	36	93	1	in delivery point	101.00	2020-12-19	\N	8	\N	2020-12-19 06:39:44.497489
89	INSERT	37	84	2	new order	0	2020-12-19	\N	\N	\N	2020-12-19 10:49:25.765024
90	UPDATE	37	84	2	new order	0	2020-12-19	\N	\N	\N	2020-12-19 10:49:25.789514
91	UPDATE	37	84	2	new order	50.50	2020-12-19	\N	\N	\N	2020-12-19 10:49:25.80504
92	UPDATE	37	84	2	new order	1250.50	2020-12-19	\N	\N	\N	2020-12-19 10:50:49.664505
93	UPDATE	37	84	2	approved	1250.50	2020-12-19	\N	8	\N	2020-12-19 10:51:34.590568
94	UPDATE	37	84	2	in delivery point	1250.50	2020-12-19	\N	8	\N	2020-12-19 10:51:54.2358
95	DELETE	36	93	1	completed	101.00	2020-12-19	\N	8	\N	2020-12-19 20:03:03.886566
96	DELETE	25	84	1	completed	401.00	2020-12-11	\N	8	\N	2020-12-19 20:03:03.886566
97	DELETE	28	84	1	new order	350.50	2020-12-16	\N	\N	\N	2020-12-19 20:03:03.886566
98	DELETE	29	84	2	new order	350.50	2020-12-16	\N	\N	\N	2020-12-19 20:03:03.886566
99	DELETE	30	84	1	new order	15	2020-12-16	\N	\N	\N	2020-12-19 20:03:03.886566
100	DELETE	31	84	2	new order	50.50	2020-12-16	\N	\N	\N	2020-12-19 20:03:03.886566
101	DELETE	32	84	1	new order	50.50	2020-12-16	\N	\N	\N	2020-12-19 20:03:03.886566
102	DELETE	33	84	2	new order	240	2020-12-16	\N	\N	\N	2020-12-19 20:03:03.886566
103	DELETE	34	84	1	completed	1201.00	2020-12-16	\N	8	\N	2020-12-19 20:03:03.886566
104	DELETE	37	84	2	completed	1250.50	2020-12-19	\N	8	\N	2020-12-19 20:03:03.886566
105	INSERT	38	103	1	new order	0	2020-12-21	\N	\N	\N	2020-12-21 01:38:36.654574
106	UPDATE	38	103	1	new order	0	2020-12-21	\N	\N	\N	2020-12-21 01:38:36.663017
107	INSERT	39	103	1	new order	0	2020-12-21	\N	\N	\N	2020-12-21 01:55:33.969612
108	UPDATE	39	103	1	new order	0	2020-12-21	\N	\N	\N	2020-12-21 01:55:33.986558
109	INSERT	40	103	1	new order	0	2020-12-21	\N	\N	\N	2020-12-21 01:55:44.770656
110	UPDATE	40	103	1	new order	0	2020-12-21	\N	\N	\N	2020-12-21 01:55:44.786833
111	INSERT	41	103	1	new order	0	2020-12-21	\N	\N	\N	2020-12-21 01:58:07.944364
112	UPDATE	41	103	1	new order	0	2020-12-21	\N	\N	\N	2020-12-21 01:58:07.959056
113	DELETE	38	103	1	new order	450	2020-12-21	\N	\N	\N	2020-12-21 01:58:13.240345
114	DELETE	39	103	1	new order	1050	2020-12-21	\N	\N	\N	2020-12-21 01:58:14.071257
115	DELETE	40	103	1	new order	600	2020-12-21	\N	\N	\N	2020-12-21 01:58:14.287206
116	DELETE	41	103	1	new order	300	2020-12-21	\N	\N	\N	2020-12-21 01:58:14.472922
117	INSERT	42	103	1	new order	0	2020-12-21	\N	\N	\N	2020-12-21 01:59:43.329447
118	UPDATE	42	103	1	new order	0	2020-12-21	\N	\N	\N	2020-12-21 01:59:43.344172
119	DELETE	42	103	1	new order	300	2020-12-21	\N	\N	\N	2020-12-21 01:59:54.466901
120	INSERT	43	103	1	new order	0	2020-12-21	\N	\N	\N	2020-12-21 09:57:36.092151
121	UPDATE	43	103	1	new order	0	2020-12-21	\N	\N	\N	2020-12-21 09:57:36.105455
122	INSERT	44	103	1	new order	0	2020-12-21	\N	\N	\N	2020-12-21 14:14:45.927521
124	UPDATE	44	103	1	new order	101.00	2020-12-21	\N	\N	\N	2020-12-21 14:15:26.460239
\.


--
-- Data for Name: Picture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Picture" (id, path, drug_id) FROM stdin;
1	/pictures/aspirin.jpg	1
131	https://apteka245.ru/img/drugs/nnt6237.jpg	56
132	https://www.vidal.ru/upload/products/alprazolam-1-organica.jpg	56
3	/pictures/aspirin1.jpg	1
133	http://www.vidal.ge/assets/uploads/0b/0bfa7f96b7e270021f998480577840ee29f2c94e.jpg	57
134	https://visualsnow.ru/img/small-preview-news/kombunacia-preparatov-znachitelnoe-uluchshenie-somptomov-1,5x1.jpg	57
7	asd	\N
8	wqeqw	\N
9	wqeqw	\N
10	assaassa	\N
11	assaassa	\N
12	ll	\N
136	https://main-cdn.goods.ru/hlr-system/-1/87/42/12/47/15/29/100026498050b0.jpg	59
4	/pictures/paracetamol1.jpg	2
2	/pictures/paracetamol.jpg	2
95	https://images.ru.prom.st/628325604_w200_h200_magnij-v6-forte.jpg	7
137	http://alko112.ru/wp-content/uploads/2016/12/fluoksetin_1.jpg	59
143	https://pictures.apteka-april.ru/products/64389/jpg/902bc1aba91361dcd6c2daa1cbf557be.jpg/l	58
144	https://irecommend.ru/sites/default/files/imagecache/copyright1/user-images/962994/tgcV5j4wja74QRA9HrOpw.jpg	58
146	https://ozerki.ru/upload/iblock/409/4090ed2719096283777a68b3667f50f6.png	61
96	https://rchoztorg.ru/image/cache/catalog/newproducts/9f1591654978d835a8a3842816090945-800x800.jpg	7
99	http://apteki-yakutska.ru/pic/1543727716_4479334.jpg	55
100	https://im0-tub-ru.yandex.net/i?id=035e211150cfb5467bd5a72128c0a50b&n=13	55
148	https://sun9-17.userapi.com/4lyW9A96bczZyJ0zP0XKjf_kJ6kRs2O-YgEhNA/5jydh_eUUNA.jpg	62
53	https://sun9-75.userapi.com/dEpTmqv-rBt0-papgC7RD69eILo_XIQCnCWaxg/R_AursLD7GI.jpg	\N
13	1	\N
49	1	\N
127	8	38
\.


--
-- Data for Name: Picture_backup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Picture_backup" (id, type, old_id, drug_id, path, change_time) FROM stdin;
1	DELETE	2	2	/pictures/paracetamol.jpg	2020-12-15 12:29:28.32712
2	DELETE	4	2	/pictures/paracetamol1.jpg	2020-12-15 12:29:28.32712
3	INSERT	92	2	/pictures/paracetamol.jpg	2020-12-15 12:29:28.329457
4	INSERT	93	2	/pictures/paracetamol1.jpg	2020-12-15 12:29:28.33141
5	INSERT	94	54	testDrug	2020-12-15 12:30:08.141591
6	DELETE	94	54	testDrug	2020-12-15 10:10:33.82285
7	INSERT	94	54	testDrug	2020-12-15 10:14:17.89093
22	DELETE	94	54	testDrug	2020-12-15 17:59:00.381832
23	INSERT	94	54	testDrug	2020-12-15 17:59:00.381832
24	DELETE	94	54	testDrug	2020-12-15 17:59:00.381832
25	DELETE	93	2	/pictures/paracetamol1.jpg	2020-12-15 17:59:00.381832
26	DELETE	92	2	/pictures/paracetamol.jpg	2020-12-15 17:59:00.381832
27	INSERT	4	2	/pictures/paracetamol1.jpg	2020-12-15 17:59:00.381832
28	INSERT	2	2	/pictures/paracetamol.jpg	2020-12-15 17:59:00.381832
29	DELETE	5	7	https://images.ru.prom.st/628325604_w200_h200_magnij-v6-forte.jpg	2020-12-15 20:26:15.222224
30	DELETE	6	7	https://rchoztorg.ru/image/cache/catalog/newproducts/9f1591654978d835a8a3842816090945-800x800.jpg	2020-12-15 20:26:15.222224
31	INSERT	95	7	https://images.ru.prom.st/628325604_w200_h200_magnij-v6-forte.jpg	2020-12-15 20:26:15.224133
32	INSERT	96	7	https://rchoztorg.ru/image/cache/catalog/newproducts/9f1591654978d835a8a3842816090945-800x800.jpg	2020-12-15 20:26:15.225402
33	DELETE	67	53	22222	2020-12-15 20:26:59.652259
35	DELETE	91	33	7	2020-12-15 20:27:02.937942
37	INSERT	99	55	http://apteki-yakutska.ru/pic/1543727716_4479334.jpg	2020-12-16 10:13:59.348113
38	INSERT	100	55	https://im0-tub-ru.yandex.net/i?id=035e211150cfb5467bd5a72128c0a50b&n=13	2020-12-16 10:13:59.349851
39	DELETE	18	19	3	2020-12-16 10:34:35.65639
41	DELETE	19	20	3	2020-12-16 10:34:40.16896
43	DELETE	51	52	1	2020-12-16 10:34:43.71153
45	DELETE	50	51	1	2020-12-16 10:34:46.473357
47	DELETE	22	23	3	2020-12-16 10:34:49.629958
49	DELETE	21	22	3	2020-12-16 10:34:54.334394
51	DELETE	20	21	3	2020-12-16 10:36:27.297334
53	DELETE	23	24	4	2020-12-16 10:36:39.152787
55	DELETE	48	49	7	2020-12-16 10:36:44.479485
57	DELETE	69	34	7	2020-12-16 10:36:51.130193
59	DELETE	41	42	9	2020-12-16 10:42:50.508388
61	DELETE	27	28	5	2020-12-16 10:42:56.051438
63	DELETE	36	37	8	2020-12-16 10:42:58.959848
65	DELETE	38	39	8	2020-12-16 10:43:02.804196
67	DELETE	26	27	5	2020-12-16 10:43:05.716327
69	DELETE	40	41	9	2020-12-16 10:43:09.082708
71	DELETE	39	40	9	2020-12-16 10:43:11.695827
73	DELETE	90	15	2	2020-12-16 10:43:15.488956
75	DELETE	70	32	7	2020-12-16 10:43:19.009696
77	DELETE	47	48	7	2020-12-16 10:43:22.727366
79	DELETE	28	29	5	2020-12-16 10:49:50.826528
81	DELETE	24	25	5	2020-12-16 10:50:36.472702
83	DELETE	25	26	5	2020-12-16 10:50:40.30123
85	DELETE	42	43	9	2020-12-16 10:50:43.374364
87	DELETE	43	44	9	2020-12-16 10:50:46.962466
89	DELETE	45	46	7	2020-12-16 10:50:49.608564
91	DELETE	37	38	8	2020-12-16 10:51:05.065156
92	INSERT	127	38	8	2020-12-16 10:51:05.069602
93	DELETE	35	36	7	2020-12-16 10:51:41.55
95	DELETE	46	47	7	2020-12-16 10:51:44.651532
97	DELETE	34	35	7	2020-12-16 10:51:47.43346
99	INSERT	131	56	https://apteka245.ru/img/drugs/nnt6237.jpg	2020-12-16 11:21:38.818874
100	INSERT	132	56	https://www.vidal.ru/upload/products/alprazolam-1-organica.jpg	2020-12-16 11:21:38.820625
101	INSERT	133	57	http://www.vidal.ge/assets/uploads/0b/0bfa7f96b7e270021f998480577840ee29f2c94e.jpg	2020-12-16 11:24:39.214647
102	INSERT	134	57	https://visualsnow.ru/img/small-preview-news/kombunacia-preparatov-znachitelnoe-uluchshenie-somptomov-1,5x1.jpg	2020-12-16 11:24:39.219239
103	INSERT	135	58	https://pictures.apteka-april.ru/products/64389/jpg/902bc1aba91361dcd6c2daa1cbf557be.jpg/l	2020-12-16 11:27:48.13675
104	INSERT	136	59	https://main-cdn.goods.ru/hlr-system/-1/87/42/12/47/15/29/100026498050b0.jpg	2020-12-16 11:35:55.955011
105	INSERT	137	59	http://alko112.ru/wp-content/uploads/2016/12/fluoksetin_1.jpg	2020-12-16 11:35:55.959739
106	DELETE	135	58	https://pictures.apteka-april.ru/products/64389/jpg/902bc1aba91361dcd6c2daa1cbf557be.jpg/l	2020-12-16 11:37:46.685138
107	INSERT	138	58	https://pictures.apteka-april.ru/products/64389/jpg/902bc1aba91361dcd6c2daa1cbf557be.jpg	2020-12-16 11:37:46.68682
108	INSERT	139	58	https://i7.otzovik.com/2020/07/07/10312907/img/839147_26940821.jpeg	2020-12-16 11:37:46.688156
109	DELETE	138	58	https://pictures.apteka-april.ru/products/64389/jpg/902bc1aba91361dcd6c2daa1cbf557be.jpg	2020-12-16 11:38:17.699499
110	DELETE	139	58	https://i7.otzovik.com/2020/07/07/10312907/img/839147_26940821.jpeg	2020-12-16 11:38:17.699499
111	INSERT	140	58	https://pictures.apteka-april.ru/products/64389/jpg/902bc1aba91361dcd6c2daa1cbf557be.jpg/l	2020-12-16 11:38:17.70401
112	INSERT	141	58	https://i7.otzovik.com/2020/07/07/10312907/img/839147_26940821.jpeg	2020-12-16 11:38:17.70729
113	DELETE	140	58	https://pictures.apteka-april.ru/products/64389/jpg/902bc1aba91361dcd6c2daa1cbf557be.jpg/l	2020-12-16 11:40:42.340883
114	DELETE	141	58	https://i7.otzovik.com/2020/07/07/10312907/img/839147_26940821.jpeg	2020-12-16 11:40:42.340883
115	INSERT	142	58	https://pictures.apteka-april.ru/products/64389/jpg/902bc1aba91361dcd6c2daa1cbf557be.jpg/l	2020-12-16 11:40:42.344209
116	DELETE	142	58	https://pictures.apteka-april.ru/products/64389/jpg/902bc1aba91361dcd6c2daa1cbf557be.jpg/l	2020-12-16 11:41:47.185399
117	INSERT	143	58	https://pictures.apteka-april.ru/products/64389/jpg/902bc1aba91361dcd6c2daa1cbf557be.jpg/l	2020-12-16 11:41:47.190495
118	INSERT	144	58	https://irecommend.ru/sites/default/files/imagecache/copyright1/user-images/962994/tgcV5j4wja74QRA9HrOpw.jpg	2020-12-16 11:41:47.194189
119	INSERT	145	60	https://im0-tub-ru.yandex.net/i?id=5cf7b3fe348697dac4c7b3c2c0f90abd&n=13&exp=1	2020-12-16 11:48:28.806483
120	INSERT	146	61	https://ozerki.ru/upload/iblock/409/4090ed2719096283777a68b3667f50f6.png	2020-12-16 11:48:43.944742
121	DELETE	145	60	https://im0-tub-ru.yandex.net/i?id=5cf7b3fe348697dac4c7b3c2c0f90abd&n=13&exp=1	2020-12-16 11:49:30.716197
123	INSERT	148	62	https://sun9-17.userapi.com/4lyW9A96bczZyJ0zP0XKjf_kJ6kRs2O-YgEhNA/5jydh_eUUNA.jpg	2020-12-16 11:54:25.850913
126	DELETE	149	62	https://sun9-17.userapi.com/4lyW9A96bczZyJ0zP0XKjf_kJ6kRs2O-YgEhNA/5jydh_eUUNA.jpg	2020-12-21 10:09:52.68424
127	INSERT	148	62	https://sun9-17.userapi.com/4lyW9A96bczZyJ0zP0XKjf_kJ6kRs2O-YgEhNA/5jydh_eUUNA.jpg	2020-12-21 10:09:52.68424
\.


--
-- Data for Name: Prescription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Prescription" (id, form, date, order_id) FROM stdin;
\.


--
-- Data for Name: Receipt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Receipt" (id, order_id, cash, payed, date_time) FROM stdin;
\.


--
-- Data for Name: Receipt_backup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Receipt_backup" (id, type, old_id, order_id, cash, payed, date_time, change_time) FROM stdin;
1	INSERT	6	25	f	401.00	2020-12-15 19:00:47.284065	2020-12-15 19:00:47.284065
2	INSERT	7	34	f	1201.00	2020-12-16 14:15:08.919182	2020-12-16 14:15:08.919182
3	INSERT	8	36	f	101.00	2020-12-19 06:39:44.500152	2020-12-19 06:39:44.500152
4	INSERT	9	37	f	1250.50	2020-12-19 10:51:54.249006	2020-12-19 10:51:54.249006
5	DELETE	8	36	f	101.00	2020-12-19 06:39:44.500152	2020-12-19 20:03:03.886566
6	DELETE	6	25	f	401.00	2020-12-15 19:00:47.284065	2020-12-19 20:03:03.886566
7	DELETE	7	34	f	1201.00	2020-12-16 14:15:08.919182	2020-12-19 20:03:03.886566
8	DELETE	9	37	f	1250.50	2020-12-19 10:51:54.249006	2020-12-19 20:03:03.886566
\.


--
-- Data for Name: Stockman; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Stockman" (id, delivery_pharmacy_id, client_id) FROM stdin;
16	2	107
17	1	106
\.


--
-- Data for Name: Stockman_backup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Stockman_backup" (id, type, old_id, delivery_pharmacy_id, client_id, change_time) FROM stdin;
1	INSERT	7	1	84	2020-12-15 18:00:04.383349
2	DELETE	7	1	84	2020-12-15 18:00:10.285042
3	INSERT	8	1	84	2020-12-15 18:05:54.629032
4	DELETE	8	1	84	2020-12-15 18:07:39.001467
6	DELETE	9	2	84	2020-12-16 14:18:46.216501
7	INSERT	10	2	84	2020-12-16 14:19:01.25746
10	DELETE	10	2	84	2020-12-16 14:19:54.726233
11	INSERT	11	2	93	2020-12-19 10:51:13.058955
12	DELETE	11	2	93	2020-12-19 20:03:03.886566
13	DELETE	6	1	79	2020-12-19 20:03:03.886566
24	DELETE	13	2	107	2020-12-21 10:42:39.240416
25	DELETE	12	1	106	2020-12-21 10:42:39.240416
28	DELETE	15	\N	106	2020-12-21 10:43:28.007086
38	DELETE	14	2	107	2020-12-21 10:46:20.777841
39	INSERT	16	2	107	2020-12-21 10:46:20.777841
40	INSERT	17	1	106	2020-12-21 10:46:20.777841
\.


--
-- Data for Name: journal; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.journal (id, query_id, table_name) FROM stdin;
589	9	Manager_backup
209	4	Stockman_backup
210	1	Manager_backup
6	7	Admin_backup
13	6	Category_backup
14	7	Category_backup
15	1	Client_backup
16	2	Client_backup
18	4	Client_backup
20	6	Client_backup
21	10	Admin_backup
23	7	Client_backup
26	1	Picture_backup
27	2	Picture_backup
29	4	Picture_backup
30	24	Drug_backup
32	6	Picture_backup
33	7	Picture_backup
211	2	Manager_backup
43	1	Order_backup
46	2	Order_backup
216	54	Order_backup
50	6	Order_backup
51	7	Order_backup
54	10	Order_backup
56	12	Order_backup
57	13	Order_backup
58	10	Category_backup
64	12	Category_backup
65	13	Category_backup
218	55	Order_backup
219	32	Drug_backup
221	4	Manager_backup
222	56	Order_backup
223	57	Order_backup
224	58	Order_backup
225	1	Receipt_backup
226	33	Drug_backup
230	32	Picture_backup
231	34	Drug_backup
232	33	Picture_backup
237	1	Manufacturer_backup
238	2	Manufacturer_backup
239	3	Manufacturer_backup
240	4	Manufacturer_backup
241	2	Delivery_pharmacy_backup
242	3	Delivery_pharmacy_backup
245	38	Picture_backup
246	50	Category_backup
247	51	Category_backup
248	52	Category_backup
249	53	Category_backup
250	54	Category_backup
252	39	Picture_backup
154	38	Category_backup
155	39	Category_backup
156	40	Category_backup
157	41	Category_backup
158	42	Category_backup
159	43	Category_backup
162	38	Admin_backup
163	39	Order_backup
164	44	Category_backup
165	45	Category_backup
166	40	Order_backup
167	41	Order_backup
168	42	Order_backup
169	43	Order_backup
170	44	Order_backup
171	45	Order_backup
172	46	Order_backup
173	47	Order_backup
174	48	Order_backup
175	49	Order_backup
176	46	Category_backup
177	47	Category_backup
178	50	Order_backup
179	39	Admin_backup
180	40	Admin_backup
181	41	Admin_backup
185	24	Picture_backup
186	28	Drug_backup
187	25	Picture_backup
190	28	Picture_backup
194	42	Admin_backup
196	24	Client_backup
197	25	Client_backup
200	28	Client_backup
201	48	Category_backup
202	49	Category_backup
203	43	Admin_backup
204	44	Admin_backup
205	45	Admin_backup
206	1	Stockman_backup
207	2	Stockman_backup
590	10	Manager_backup
254	38	Drug_backup
255	41	Picture_backup
592	12	Manager_backup
263	41	Drug_backup
264	47	Picture_backup
266	42	Drug_backup
267	49	Picture_backup
257	39	Drug_backup
258	43	Picture_backup
260	40	Drug_backup
261	45	Picture_backup
269	43	Drug_backup
270	51	Picture_backup
272	44	Drug_backup
273	53	Picture_backup
275	45	Drug_backup
276	55	Picture_backup
278	46	Drug_backup
279	57	Picture_backup
281	47	Drug_backup
282	59	Picture_backup
284	48	Drug_backup
285	61	Picture_backup
287	49	Drug_backup
288	63	Picture_backup
290	50	Drug_backup
293	51	Drug_backup
294	67	Picture_backup
296	52	Drug_backup
297	69	Picture_backup
299	53	Drug_backup
300	71	Picture_backup
302	54	Drug_backup
303	73	Picture_backup
305	55	Drug_backup
306	75	Picture_backup
308	56	Drug_backup
309	77	Picture_backup
311	79	Picture_backup
312	57	Drug_backup
313	58	Drug_backup
315	81	Picture_backup
316	59	Drug_backup
317	60	Drug_backup
319	83	Picture_backup
320	61	Drug_backup
321	62	Drug_backup
323	85	Picture_backup
324	63	Drug_backup
326	87	Picture_backup
327	64	Drug_backup
329	89	Picture_backup
331	66	Drug_backup
333	67	Drug_backup
334	91	Picture_backup
335	92	Picture_backup
336	55	Category_backup
337	68	Drug_backup
338	93	Picture_backup
339	69	Drug_backup
340	70	Drug_backup
342	95	Picture_backup
343	71	Drug_backup
345	97	Picture_backup
346	72	Drug_backup
348	56	Category_backup
349	57	Category_backup
350	58	Category_backup
351	59	Category_backup
352	60	Category_backup
353	61	Category_backup
354	62	Category_backup
355	63	Category_backup
356	64	Category_backup
357	73	Drug_backup
358	99	Picture_backup
359	100	Picture_backup
360	74	Drug_backup
361	101	Picture_backup
362	102	Picture_backup
363	75	Drug_backup
364	103	Picture_backup
365	76	Drug_backup
366	104	Picture_backup
367	105	Picture_backup
368	77	Drug_backup
369	106	Picture_backup
370	107	Picture_backup
371	108	Picture_backup
372	78	Drug_backup
373	109	Picture_backup
374	110	Picture_backup
375	111	Picture_backup
376	112	Picture_backup
377	79	Drug_backup
378	113	Picture_backup
379	114	Picture_backup
380	115	Picture_backup
381	80	Drug_backup
382	116	Picture_backup
383	117	Picture_backup
384	118	Picture_backup
385	81	Drug_backup
386	119	Picture_backup
387	82	Drug_backup
388	120	Picture_backup
389	121	Picture_backup
390	83	Drug_backup
391	84	Drug_backup
393	85	Drug_backup
395	59	Order_backup
396	86	Drug_backup
397	60	Order_backup
398	61	Order_backup
399	87	Drug_backup
400	62	Order_backup
401	63	Order_backup
402	88	Drug_backup
403	64	Order_backup
405	89	Drug_backup
406	66	Order_backup
407	90	Drug_backup
408	67	Order_backup
409	68	Order_backup
410	91	Drug_backup
411	69	Order_backup
412	70	Order_backup
413	92	Drug_backup
414	71	Order_backup
415	72	Order_backup
416	93	Drug_backup
417	73	Order_backup
418	74	Order_backup
419	94	Drug_backup
420	75	Order_backup
421	95	Drug_backup
422	76	Order_backup
423	77	Order_backup
424	78	Order_backup
425	79	Order_backup
426	2	Receipt_backup
429	6	Stockman_backup
430	66	Category_backup
431	7	Stockman_backup
434	10	Stockman_backup
436	80	Order_backup
437	96	Drug_backup
438	81	Order_backup
439	82	Order_backup
440	83	Order_backup
441	97	Drug_backup
442	84	Order_backup
443	85	Order_backup
444	98	Drug_backup
445	86	Order_backup
446	87	Order_backup
447	88	Order_backup
448	3	Receipt_backup
450	6	Manager_backup
451	67	Category_backup
452	89	Order_backup
453	99	Drug_backup
454	90	Order_backup
455	100	Drug_backup
456	91	Order_backup
457	92	Order_backup
459	93	Order_backup
460	94	Order_backup
461	4	Receipt_backup
464	32	Client_backup
465	33	Client_backup
466	34	Client_backup
470	38	Client_backup
471	39	Client_backup
472	40	Client_backup
473	41	Client_backup
474	46	Admin_backup
475	7	Manager_backup
476	95	Order_backup
477	12	Stockman_backup
478	13	Stockman_backup
479	96	Order_backup
480	97	Order_backup
481	98	Order_backup
482	99	Order_backup
483	100	Order_backup
484	101	Order_backup
485	102	Order_backup
486	103	Order_backup
487	104	Order_backup
488	5	Receipt_backup
489	101	Drug_backup
490	6	Receipt_backup
491	102	Drug_backup
492	103	Drug_backup
493	104	Drug_backup
494	105	Drug_backup
495	106	Drug_backup
496	107	Drug_backup
497	108	Drug_backup
498	109	Drug_backup
499	7	Receipt_backup
500	110	Drug_backup
501	111	Drug_backup
502	8	Receipt_backup
503	112	Drug_backup
504	113	Drug_backup
505	42	Client_backup
506	43	Client_backup
507	44	Client_backup
508	47	Admin_backup
509	45	Client_backup
510	46	Client_backup
511	47	Client_backup
512	48	Client_backup
513	49	Client_backup
514	50	Client_backup
515	51	Client_backup
516	52	Client_backup
517	48	Admin_backup
518	49	Admin_backup
519	53	Client_backup
520	54	Client_backup
521	8	Manager_backup
522	105	Order_backup
523	114	Drug_backup
524	106	Order_backup
525	107	Order_backup
526	115	Drug_backup
527	108	Order_backup
528	109	Order_backup
529	116	Drug_backup
530	110	Order_backup
531	111	Order_backup
532	117	Drug_backup
533	112	Order_backup
534	113	Order_backup
535	118	Drug_backup
536	114	Order_backup
537	119	Drug_backup
538	115	Order_backup
539	120	Drug_backup
540	116	Order_backup
541	121	Drug_backup
542	117	Order_backup
543	122	Drug_backup
544	118	Order_backup
545	119	Order_backup
547	68	Category_backup
548	120	Order_backup
550	121	Order_backup
554	126	Picture_backup
555	127	Picture_backup
556	55	Client_backup
557	56	Client_backup
569	25	Stockman_backup
582	38	Stockman_backup
583	39	Stockman_backup
584	40	Stockman_backup
585	122	Order_backup
586	126	Drug_backup
588	124	Order_backup
\.


--
-- Name: Admin_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public."Admin_backup_id_seq"', 49, true);


--
-- Name: Admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Admin_id_seq"', 15, true);


--
-- Name: Category_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public."Category_backup_id_seq"', 68, true);


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Category_id_seq"', 18, true);


--
-- Name: Client_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public."Client_backup_id_seq"', 56, true);


--
-- Name: Client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Client_id_seq"', 107, true);


--
-- Name: Delivery_pharmacy_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public."Delivery_pharmacy_backup_id_seq"', 3, true);


--
-- Name: Delivery_pharmacy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Delivery_pharmacy_id_seq"', 2, true);


--
-- Name: Drug_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Drug_id_seq"', 62, true);


--
-- Name: Manager_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public."Manager_backup_id_seq"', 12, true);


--
-- Name: Manager_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Manager_id_seq"', 13, true);


--
-- Name: Manufacturer_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public."Manufacturer_backup_id_seq"', 4, true);


--
-- Name: Manufacturer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Manufacturer_id_seq"', 5, true);


--
-- Name: Order_Drug_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public."Order_Drug_backup_id_seq"', 1, false);


--
-- Name: Order_Drug_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_Drug_id_seq"', 54, true);


--
-- Name: Order_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public."Order_backup_id_seq"', 124, true);


--
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 44, true);


--
-- Name: Picture_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public."Picture_backup_id_seq"', 127, true);


--
-- Name: Picture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Picture_id_seq"', 149, true);


--
-- Name: Prescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Prescription_id_seq"', 1, false);


--
-- Name: Receipt_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public."Receipt_backup_id_seq"', 8, true);


--
-- Name: Receipt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Receipt_id_seq"', 9, true);


--
-- Name: Stockman_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public."Stockman_backup_id_seq"', 40, true);


--
-- Name: Stockman_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Stockman_id_seq"', 17, true);


--
-- Name: drug_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.drug_backup_id_seq', 126, true);


--
-- Name: drug_backup_old_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.drug_backup_old_id_seq', 1, false);


--
-- Name: journal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.journal_id_seq', 592, true);


--
-- Name: Admin_backup Admin_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Admin_backup"
    ADD CONSTRAINT "Admin_backup_pkey" PRIMARY KEY (id);


--
-- Name: Admin Admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Admin"
    ADD CONSTRAINT "Admin_pkey" PRIMARY KEY (id);


--
-- Name: Category_backup Category_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Category_backup"
    ADD CONSTRAINT "Category_backup_pkey" PRIMARY KEY (id);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: Client_backup Client_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Client_backup"
    ADD CONSTRAINT "Client_backup_pkey" PRIMARY KEY (id);


--
-- Name: Client Client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (id);


--
-- Name: Delivery_pharmacy_backup Delivery_pharmacy_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Delivery_pharmacy_backup"
    ADD CONSTRAINT "Delivery_pharmacy_backup_pkey" PRIMARY KEY (id);


--
-- Name: Delivery_pharmacy Delivery_pharmacy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delivery_pharmacy"
    ADD CONSTRAINT "Delivery_pharmacy_pkey" PRIMARY KEY (id);


--
-- Name: Drug Drug_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Drug"
    ADD CONSTRAINT "Drug_pkey" PRIMARY KEY (id);


--
-- Name: Manager_backup Manager_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Manager_backup"
    ADD CONSTRAINT "Manager_backup_pkey" PRIMARY KEY (id);


--
-- Name: Manager Manager_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Manager"
    ADD CONSTRAINT "Manager_pkey" PRIMARY KEY (id);


--
-- Name: Manufacturer_backup Manufacturer_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Manufacturer_backup"
    ADD CONSTRAINT "Manufacturer_backup_pkey" PRIMARY KEY (id);


--
-- Name: Manufacturer Manufacturer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Manufacturer"
    ADD CONSTRAINT "Manufacturer_pkey" PRIMARY KEY (id);


--
-- Name: Order_Drug_backup Order_Drug_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Order_Drug_backup"
    ADD CONSTRAINT "Order_Drug_backup_pkey" PRIMARY KEY (id);


--
-- Name: Order_Drug Order_Drug_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Drug"
    ADD CONSTRAINT "Order_Drug_pkey" PRIMARY KEY (id);


--
-- Name: Order_backup Order_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Order_backup"
    ADD CONSTRAINT "Order_backup_pkey" PRIMARY KEY (id);


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- Name: Picture_backup Picture_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Picture_backup"
    ADD CONSTRAINT "Picture_backup_pkey" PRIMARY KEY (id);


--
-- Name: Picture Picture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Picture"
    ADD CONSTRAINT "Picture_pkey" PRIMARY KEY (id);


--
-- Name: Prescription Prescription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Prescription"
    ADD CONSTRAINT "Prescription_pkey" PRIMARY KEY (id);


--
-- Name: Receipt_backup Receipt_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Receipt_backup"
    ADD CONSTRAINT "Receipt_backup_pkey" PRIMARY KEY (id);


--
-- Name: Receipt Receipt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Receipt"
    ADD CONSTRAINT "Receipt_pkey" PRIMARY KEY (id);


--
-- Name: Stockman_backup Stockman_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Stockman_backup"
    ADD CONSTRAINT "Stockman_backup_pkey" PRIMARY KEY (id);


--
-- Name: Stockman Stockman_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Stockman"
    ADD CONSTRAINT "Stockman_pkey" PRIMARY KEY (id);


--
-- Name: Drug_backup drug_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Drug_backup"
    ADD CONSTRAINT drug_backup_pkey PRIMARY KEY (id);


--
-- Name: Client email_unique1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT email_unique1 UNIQUE (email);


--
-- Name: journal journal_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.journal
    ADD CONSTRAINT journal_pkey PRIMARY KEY (id);


--
-- Name: Client login_unique1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT login_unique1 UNIQUE (login);


--
-- Name: Client phone_unique1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT phone_unique1 UNIQUE (phone);


--
-- Name: Admin_backup admin_backup_after_insert; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER admin_backup_after_insert AFTER INSERT ON public."Admin_backup" FOR EACH ROW EXECUTE PROCEDURE public.admnewbackup();


--
-- Name: Admin admin_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER admin_trigger BEFORE INSERT OR DELETE OR UPDATE ON public."Admin" FOR EACH ROW EXECUTE PROCEDURE public.add_admin_backup();


--
-- Name: Category_backup category_backup_after_insert; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER category_backup_after_insert AFTER INSERT ON public."Category_backup" FOR EACH ROW EXECUTE PROCEDURE public.catnewbackup();


--
-- Name: Category category_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER category_trigger BEFORE INSERT OR DELETE OR UPDATE ON public."Category" FOR EACH ROW EXECUTE PROCEDURE public.add_category_backup();


--
-- Name: Client_backup client_backup_after_insert; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER client_backup_after_insert AFTER INSERT ON public."Client_backup" FOR EACH ROW EXECUTE PROCEDURE public.clinewbackup();


--
-- Name: Client client_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER client_trigger BEFORE INSERT OR DELETE OR UPDATE ON public."Client" FOR EACH ROW EXECUTE PROCEDURE public.add_client_backup();


--
-- Name: Delivery_pharmacy_backup delivery_pharmacy_backup_after_insert; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER delivery_pharmacy_backup_after_insert AFTER INSERT ON public."Delivery_pharmacy_backup" FOR EACH ROW EXECUTE PROCEDURE public.delphanewbackup();


--
-- Name: Delivery_pharmacy delivery_pharmacy_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER delivery_pharmacy_trigger BEFORE INSERT OR DELETE OR UPDATE ON public."Delivery_pharmacy" FOR EACH ROW EXECUTE PROCEDURE public.add_delivery_pharmacy_backup();


--
-- Name: Order_Drug drug_after_delete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER drug_after_delete BEFORE DELETE ON public."Order_Drug" FOR EACH ROW EXECUTE PROCEDURE public.mytrigondelord();


--
-- Name: Order_Drug drug_after_insert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER drug_after_insert AFTER INSERT ON public."Order_Drug" FOR EACH ROW EXECUTE PROCEDURE public.mytrigonneword();


--
-- Name: Drug_backup drug_backup_after_insert; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER drug_backup_after_insert AFTER INSERT ON public."Drug_backup" FOR EACH ROW EXECUTE PROCEDURE public.drugnewbackup();


--
-- Name: Manager_backup manager_backup_after_insert; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER manager_backup_after_insert AFTER INSERT ON public."Manager_backup" FOR EACH ROW EXECUTE PROCEDURE public.managernewbackup();


--
-- Name: Manager manager_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER manager_trigger BEFORE INSERT OR DELETE OR UPDATE ON public."Manager" FOR EACH ROW EXECUTE PROCEDURE public.add_manager_backup();


--
-- Name: Manufacturer_backup manufacturer_backup_after_insert; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER manufacturer_backup_after_insert AFTER INSERT ON public."Manufacturer_backup" FOR EACH ROW EXECUTE PROCEDURE public.manufacturernewbackup();


--
-- Name: Manufacturer manufacturer_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER manufacturer_trigger BEFORE INSERT OR DELETE OR UPDATE ON public."Manufacturer" FOR EACH ROW EXECUTE PROCEDURE public.add_manufacturer_backup();


--
-- Name: Order_Drug order_after_delete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER order_after_delete BEFORE DELETE ON public."Order_Drug" FOR EACH ROW EXECUTE PROCEDURE public.mytrigondelord2();


--
-- Name: Order_Drug order_after_insert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER order_after_insert AFTER INSERT ON public."Order_Drug" FOR EACH ROW EXECUTE PROCEDURE public.mytrigonnewordpart();


--
-- Name: Order_backup order_backup_after_insert; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER order_backup_after_insert AFTER INSERT ON public."Order_backup" FOR EACH ROW EXECUTE PROCEDURE public.ordernewbackup();


--
-- Name: Order_Drug_backup order_drug_backup_after_insert; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER order_drug_backup_after_insert AFTER INSERT ON public."Order_Drug_backup" FOR EACH ROW EXECUTE PROCEDURE public.orderdrugnewbackup();


--
-- Name: Order order_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER order_trigger BEFORE INSERT OR DELETE OR UPDATE ON public."Order" FOR EACH ROW EXECUTE PROCEDURE public.add_order_backup();


--
-- Name: Picture_backup picture_backup_after_insert; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER picture_backup_after_insert AFTER INSERT ON public."Picture_backup" FOR EACH ROW EXECUTE PROCEDURE public.picturenewbackup();


--
-- Name: Picture picture_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER picture_trigger BEFORE INSERT OR DELETE OR UPDATE ON public."Picture" FOR EACH ROW EXECUTE PROCEDURE public.add_picture_backup();


--
-- Name: Receipt_backup receipt_backup_after_insert; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER receipt_backup_after_insert AFTER INSERT ON public."Receipt_backup" FOR EACH ROW EXECUTE PROCEDURE public.receiptnewbackup();


--
-- Name: Receipt receipt_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER receipt_trigger BEFORE INSERT OR DELETE OR UPDATE ON public."Receipt" FOR EACH ROW EXECUTE PROCEDURE public.add_receipt_backup();


--
-- Name: Stockman_backup stockman_backup_after_insert; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER stockman_backup_after_insert AFTER INSERT ON public."Stockman_backup" FOR EACH ROW EXECUTE PROCEDURE public.stockmannewbackup();


--
-- Name: Stockman stockman_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER stockman_trigger BEFORE INSERT OR DELETE OR UPDATE ON public."Stockman" FOR EACH ROW EXECUTE PROCEDURE public.add_stockman_backup();


--
-- Name: Drug subscriptions_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER subscriptions_trigger BEFORE INSERT OR DELETE OR UPDATE ON public."Drug" FOR EACH ROW EXECUTE PROCEDURE public.add_drug_backup();


--
-- Name: Order_Drug sumpartoforder; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER sumpartoforder BEFORE INSERT ON public."Order_Drug" FOR EACH ROW EXECUTE PROCEDURE public.mytrigonneword2();


--
-- Name: Category Category_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_parent_fkey" FOREIGN KEY (parent) REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Drug Drug_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Drug"
    ADD CONSTRAINT "Drug_category_id_fkey" FOREIGN KEY (category_id) REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Drug Drug_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Drug"
    ADD CONSTRAINT "Drug_manufacturer_id_fkey" FOREIGN KEY (manufacturer_id) REFERENCES public."Manufacturer"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Manager Manager_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Manager"
    ADD CONSTRAINT "Manager_client_id_fkey" FOREIGN KEY (client_id) REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Order_Drug Order_Drug_drug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Drug"
    ADD CONSTRAINT "Order_Drug_drug_id_fkey" FOREIGN KEY (drug_id) REFERENCES public."Drug"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Order_Drug Order_Drug_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Drug"
    ADD CONSTRAINT "Order_Drug_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Order Order_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_client_id_fkey" FOREIGN KEY (client_id) REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Order Order_delivery_pharmacy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_delivery_pharmacy_id_fkey" FOREIGN KEY (delivery_pharmacy_id) REFERENCES public."Delivery_pharmacy"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Order Order_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_manager_id_fkey" FOREIGN KEY (manager_id) REFERENCES public."Manager"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Order Order_stockman_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_stockman_id_fkey" FOREIGN KEY (stockman_id) REFERENCES public."Stockman"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Picture Picture_drug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Picture"
    ADD CONSTRAINT "Picture_drug_id_fkey" FOREIGN KEY (drug_id) REFERENCES public."Drug"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Prescription Prescription_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Prescription"
    ADD CONSTRAINT "Prescription_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Receipt Receipt_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Receipt"
    ADD CONSTRAINT "Receipt_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Stockman Stockman_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Stockman"
    ADD CONSTRAINT "Stockman_client_id_fkey" FOREIGN KEY (client_id) REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Stockman Stockman_delivery_pharmacy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Stockman"
    ADD CONSTRAINT "Stockman_delivery_pharmacy_id_fkey" FOREIGN KEY (delivery_pharmacy_id) REFERENCES public."Delivery_pharmacy"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Admin admin_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Admin"
    ADD CONSTRAINT admin_client_id_fkey FOREIGN KEY (client_id) REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO admin;


--
-- Name: TABLE "Admin"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Admin" TO admin;


--
-- Name: SEQUENCE "Admin_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."Admin_id_seq" TO admin;


--
-- Name: TABLE "Category"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Category" TO manager;
GRANT SELECT ON TABLE public."Category" TO client;
GRANT ALL ON TABLE public."Category" TO admin;


--
-- Name: SEQUENCE "Category_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public."Category_id_seq" TO admin;


--
-- Name: TABLE "Client"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Client" TO admin;


--
-- Name: SEQUENCE "Client_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public."Client_id_seq" TO admin;


--
-- Name: TABLE "Delivery_pharmacy"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Delivery_pharmacy" TO manager;
GRANT SELECT ON TABLE public."Delivery_pharmacy" TO client;
GRANT ALL ON TABLE public."Delivery_pharmacy" TO admin;


--
-- Name: SEQUENCE "Delivery_pharmacy_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public."Delivery_pharmacy_id_seq" TO admin;


--
-- Name: TABLE "Drug"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Drug" TO manager;
GRANT SELECT ON TABLE public."Drug" TO client;
GRANT ALL ON TABLE public."Drug" TO admin;


--
-- Name: SEQUENCE "Drug_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public."Drug_id_seq" TO admin;


--
-- Name: TABLE "Manager"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Manager" TO admin;


--
-- Name: SEQUENCE "Manager_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public."Manager_id_seq" TO admin;


--
-- Name: TABLE "Manufacturer"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Manufacturer" TO admin;
GRANT SELECT ON TABLE public."Manufacturer" TO client;


--
-- Name: SEQUENCE "Manufacturer_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public."Manufacturer_id_seq" TO admin;


--
-- Name: TABLE "Order"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Order" TO manager;
GRANT ALL ON TABLE public."Order" TO stockman;
GRANT SELECT ON TABLE public."Order" TO client;
GRANT ALL ON TABLE public."Order" TO admin;


--
-- Name: TABLE "Order_Drug"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Order_Drug" TO manager;
GRANT ALL ON TABLE public."Order_Drug" TO stockman;
GRANT SELECT ON TABLE public."Order_Drug" TO client;
GRANT ALL ON TABLE public."Order_Drug" TO admin;


--
-- Name: SEQUENCE "Order_Drug_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public."Order_Drug_id_seq" TO admin;


--
-- Name: SEQUENCE "Order_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public."Order_id_seq" TO admin;


--
-- Name: TABLE "Picture"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Picture" TO manager;
GRANT SELECT ON TABLE public."Picture" TO client;
GRANT ALL ON TABLE public."Picture" TO admin;


--
-- Name: SEQUENCE "Picture_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public."Picture_id_seq" TO admin;


--
-- Name: TABLE "Prescription"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Prescription" TO manager;
GRANT ALL ON TABLE public."Prescription" TO stockman;
GRANT SELECT ON TABLE public."Prescription" TO client;
GRANT ALL ON TABLE public."Prescription" TO admin;


--
-- Name: SEQUENCE "Prescription_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public."Prescription_id_seq" TO admin;


--
-- Name: TABLE "Receipt"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Receipt" TO manager;
GRANT ALL ON TABLE public."Receipt" TO stockman;
GRANT SELECT ON TABLE public."Receipt" TO client;
GRANT ALL ON TABLE public."Receipt" TO admin;


--
-- Name: SEQUENCE "Receipt_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public."Receipt_id_seq" TO admin;


--
-- Name: TABLE "Stockman"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Stockman" TO admin;


--
-- Name: SEQUENCE "Stockman_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public."Stockman_id_seq" TO admin;


--
-- PostgreSQL database dump complete
--

