DROP SCHEMA IF EXISTS poushak CASCADE;
--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1 (Debian 13.1-1.pgdg100+1)
-- Dumped by pg_dump version 13.1 (Debian 13.1-1.pgdg100+1)

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
-- Name: poushak; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA IF NOT EXISTS poushak;


ALTER SCHEMA poushak OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addresses; Type: TABLE; Schema: poushak; Owner: admin
--

CREATE TABLE IF NOT EXISTS poushak.addresses (
    id character varying(50) NOT NULL,
    user_id character varying(50),
    first_line character varying(100),
    second_line character varying(100),
    address_string character varying(300),
    city character varying(50),
    state character varying(50),
    country character varying(50),
    pincode character varying(6),
    lat numeric(8,6) NOT NULL,
    long numeric(8,6) NOT NULL,
    deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    name character varying(50),
    phone character varying(15),
    is_default boolean DEFAULT false
);


ALTER TABLE poushak.addresses OWNER TO admin;

--
-- Name: users; Type: TABLE; Schema: poushak; Owner: admin
--

CREATE TABLE IF NOT EXISTS poushak.users (
    id character varying(50) NOT NULL,
    first_name character varying(50) DEFAULT ''::character varying,
    last_name character varying(50) DEFAULT ''::character varying,
    dob date DEFAULT CURRENT_DATE,
    gender character varying(15) DEFAULT ''::character varying,
    aadhar character varying(200),
    pan character varying(200),
    email character varying(100),
    fb_email character varying(100),
    phone character varying(15),
    password character varying(200) DEFAULT ''::character varying,
    default_address character varying(50),
    deleted boolean DEFAULT false,
    t_and_c boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    phone_verified boolean DEFAULT false,
    email_verified boolean DEFAULT false
);


ALTER TABLE poushak.users OWNER TO admin;

--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: poushak; Owner: admin
--

ALTER TABLE ONLY poushak.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: users users_aadhar_key; Type: CONSTRAINT; Schema: poushak; Owner: admin
--

ALTER TABLE ONLY poushak.users
    ADD CONSTRAINT users_aadhar_key UNIQUE (aadhar);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: poushak; Owner: admin
--

ALTER TABLE ONLY poushak.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_fb_email_key; Type: CONSTRAINT; Schema: poushak; Owner: admin
--

ALTER TABLE ONLY poushak.users
    ADD CONSTRAINT users_fb_email_key UNIQUE (fb_email);


--
-- Name: users users_pan_key; Type: CONSTRAINT; Schema: poushak; Owner: admin
--

ALTER TABLE ONLY poushak.users
    ADD CONSTRAINT users_pan_key UNIQUE (pan);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: poushak; Owner: admin
--

ALTER TABLE ONLY poushak.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: poushak; Owner: admin
--

ALTER TABLE ONLY poushak.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: addresses addresses_users_fkey; Type: FK CONSTRAINT; Schema: poushak; Owner: admin
--

ALTER TABLE ONLY poushak.addresses
    ADD CONSTRAINT addresses_users_fkey FOREIGN KEY (user_id) REFERENCES poushak.users(id);


CREATE TABLE IF NOT EXISTS orders (
	id varchar(50),
	buyer_id varchar(50) NOT NULL,
	seller_id varchar(50) NOT NULL,
	address_id varchar(50) NOT NULL,
    scheduled_time timestamp with time zone,
	order_status varchar(50),
	amount integer,
	products json[],
	created_at timestamp with time zone DEFAULT current_timestamp,
	updated_at timestamp with time zone DEFAULT current_timestamp,
	CONSTRAINT orders_pkey PRIMARY KEY(id),
	CONSTRAINT orders_buyer_fkey FOREIGN KEY(buyer_id) REFERENCES users(id),
	CONSTRAINT orders_seller_fkey FOREIGN KEY(seller_id) REFERENCES users(id),
	CONSTRAINT orders_address_fkey FOREIGN KEY(address_id) REFERENCES addresses(id)
)

CREATE TABLE IF NOT EXISTS payments (
	id varchar(50) NOT NULL,
	order_id varchar(50) NOT NULL,
	amount decimal(7, 2) NOT NULL,
	payment_status varchar(50) DEFAULT '',
	refund_id varchar(50),
	refund_status varchar(50) DEFAULT '',
	created_at timestamp with time zone DEFAULT current_timestamp,
	updated_at timestamp with time zone DEFAULT current_timestamp,
	CONSTRAINT payments_pkey PRIMARY KEY(id),
	CONSTRAINT payments_order_fkey FOREIGN KEY(order_id) REFERENCES orders(id)
)

--
-- PostgreSQL database dump complete
--