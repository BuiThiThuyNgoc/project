
create TABLE account(
    acc_id int  PRIMARY KEY,
    acc_email varchar(50),
    acc_phone INT,
    acc_password VARCHAR(20),
    acc_name varchar(50),
    acc_ssn char(9),
    acc_birth date,
    acc_address varchar(200),
    acc_type int
);
go;
create TABLE bill(
    bill_id INT PRIMARY KEY,
    bill_date DATE,
    bill_money int,
    bill_amount_ticket int,
    bill_status_payment varchar(4),
    acc_id int,
    FOREIGN KEY (acc_id) REFERENCES account(acc_id)
);

create table airport(
    airport_id int PRIMARY KEY, 
    airport_name varchar(20),
    airport_city varchar(30)
);

create TABLE plane(
    plane_id int PRIMARY KEY,
    plane_name varchar(30),
    plane_amount int
);
go;

CREATE table flight_route(
    flight_R_id int PRIMARY KEY,
    flight_R_departure_airport int,
    flight_R_arrival_airport int,
    flight_R_depart_date date,
    plane_id int,
    FOREIGN KEY (plane_id) REFERENCES plane(plane_id),
    FOREIGN KEY (flight_R_departure_airport) REFERENCES airport(airport_id),
    FOREIGN KEY (flight_R_arrival_airport) REFERENCES airport(airport_id)

);

create table passenger(
    passenger_id int PRIMARY KEY,
    passenger_name varchar(40),
    passenger_ssn INT,
    passenger_phone int,
    passenger_birth date,
    passenger_age int
);
go;
create table ticket_type(
    ticket_type_id int PRIVATE key;
    ticket_type_name VARCHAR(20)
)
create table ticket(
    ticket_id int PRIMARY KEY,
    ticket_type_id int,
    ticket_status varchar(4),
    -- ticket_location varchar(100),
    flight_R_id int,
    bill_id int,
    passenger_id int,
    FOREIGN KEY (flight_R_id) REFERENCES flight_route(flight_R_id),
    FOREIGN KEY (bill_id) REFERENCES bill(bill_id),
    FOREIGN KEY (passenger_id) REFERENCES passenger(passenger_id)
    FOREIGN KEY (ticket_type) REFERENCES ticket_type(ticket_type_id)

);
