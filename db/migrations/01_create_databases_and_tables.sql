CREATE DATABASE makersbnb;
CREATE DATABASE makersbnb_test;

CREATE TABLE users(id SERIAL PRIMARY KEY, first_name VARCHAR(60), last_name VARCHAR(60), email_address VARCHAR(60), password VARCHAR(140));

CREATE TABLE properties(id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users (id), property_name VARCHAR(200), property_description VARCHAR(5000), price_per_night INTEGER, availability_start_date DATE, availability_end_date DATE);

CREATE TABLE bookings(id SERIAL PRIMARY KEY, owner_id INTEGER REFERENCES users (id), booker_id INTEGER REFERENCES users (id), booking_date DATE, booking_status VARCHAR(20));