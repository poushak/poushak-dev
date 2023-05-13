CREATE SCHEMA IF NOT EXISTS poushak;

SET search_path=poushak;

CREATE TABLE IF NOT EXISTS users(
	id varchar(50) NOT NULL,
	first_name varchar(50) DEFAULT '',
	last_name varchar(50) DEFAULT '',
	dob date DEFAULT current_date,
	gender varchar(15) DEFAULT '',
	aadhar varchar(200) UNIQUE,
	pan varchar(200) UNIQUE,
	email varchar(100) UNIQUE,
	fb_email varchar(100) UNIQUE,
	phone varchar(15) UNIQUE,
	password varchar(200) DEFAULT '',
	default_address varchar(50),
	deleted boolean DEFAULT false,
	verified boolean DEFAULT false,
	t_and_c boolean DEFAULT false,
	created_at timestamptz DEFAULT current_timestamp,
	updated_at timestamptz DEFAULT current_timestamp,
	CONSTRAINT users_pkey PRIMARY KEY(id)
)

CREATE TABLE IF NOT EXISTS addresses(
	id varchar(50) NOT NULL,
	user_id varchar(50),
	name varchar(50),
	phone varchar(15),
	first_line varchar(100),
	second_line varchar(100),
	address_string varchar(300),
	city varchar(50),
	state varchar(50),
	country varchar(50),
	pincode varchar(6),
	lat numeric(8, 6) NOT NULL,
	long numeric(8, 6) NOT NULL,
	deleted boolean DEFAULT false,
	created_at timestamptz DEFAULT current_timestamp,
	updated_at timestamptz DEFAULT current_timestamp,
	CONSTRAINT addresses_pkey PRIMARY KEY(id),
	CONSTRAINT addresses_users_fkey FOREIGN KEY(user_id) REFERENCES users(id)
)


ALTER TABLE users ADD CONSTRAINT users_addresses_fkey FOREIGN KEY(default_address) REFERENCES addresses(id)
