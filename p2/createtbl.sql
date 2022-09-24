-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.
CREATE TABLE Categories(
    name varchar(25) not null,
    priority INT check(priority >= 0),
    PRIMARY KEY (name)
);
CREATE TABLE People(
    hinsurnum char(12) not null,
    name varchar(30) not null,
    phone varchar(12),
    city varchar(25),
    streetaddr varchar(50),
    postalcode char(6),
    dateofbirth DATE not null,
    gender varchar(6) not null check(gender IN ('male', 'female', 'other')),
    regdate DATE not null,
    cname varchar(25) not null,
    PRIMARY KEY (hinsurnum),
    FOREIGN KEY (cname) REFERENCES Categories(name),
    check(dateofbirth <= regdate)
);
CREATE TABLE Locations(
    name varchar(30) not null,
    streetaddr varchar(50) not null,
    city varchar(25),
    postalcode char(6) not null,
    PRIMARY KEY (name)
);
CREATE TABLE Hospitals(
    name varchar(30) not null,
    PRIMARY KEY (name),
    FOREIGN KEY (name) REFERENCES Locations(name)
);
CREATE TABLE Nurses(
    licenseno char(10) not null,
    name varchar(30) not null,
    hospname varchar(30) not null,
    PRIMARY KEY (licenseno),
    FOREIGN KEY (hospname) REFERENCES Hospitals(name)
);
CREATE TABLE WorkingDays(
    locname varchar(30) not null,
    date DATE not null,
    PRIMARY KEY (locname, date),
    FOREIGN KEY (locname) REFERENCES Locations(name)
);
CREATE TABLE Vaccines(
    name varchar(30) not null,
    numdoses INT not null check(numdoses > 0),
    waitingperiod INT not null check(waitingperiod > 0),
    PRIMARY KEY (name)
);
CREATE TABLE Batches(
    name varchar(30) not null,
    batchnum INT not null check(batchnum >= 0),
    manufacdate DATE not null,
    expirydate DATE not null,
    numvials INT not null check(numvials > 0),
    locname varchar(30) not null,
    PRIMARY KEY (name, batchnum),
    FOREIGN KEY (name) REFERENCES Vaccines(name),
    FOREIGN KEY (locname) REFERENCES Locations(name)
);
CREATE TABLE Vials(
    name varchar(30) not null,
    batchnum int not null,
    num INT not null check(num >= 0),
    PRIMARY KEY (name, batchnum, num),
    FOREIGN KEY (name, batchnum) REFERENCES Batches(name, batchnum)
);
CREATE TABLE Slots(
    locname varchar(30) not null,
    date DATE not null,
    time TIME not null,
    tentnum INT not null check(tentnum >= 0),
    hinsurnum char(12),
    allocdate DATE,
    licenseno char(12),
    vname varchar(30),
    batchnum INT,
    num INT,
    PRIMARY KEY (locname, date, time, tentnum),
    FOREIGN KEY (locname, date) REFERENCES WorkingDays(locname, date),
    FOREIGN KEY (hinsurnum) REFERENCES People(hinsurnum),
    FOREIGN KEY (licenseno) REFERENCES Nurses(licenseno),
    FOREIGN KEY (vname, batchnum, num) REFERENCES Vials(name, batchnum, num),
    check(allocdate <= date)
);
CREATE TABLE NurseDay(
    licenseno char(12) not null,
    locname varchar(30) not null,
    date DATE not null,
    PRIMARY KEY (licenseno, locname, date),
    FOREIGN KEY (licenseno) REFERENCES Nurses(licenseno),
    FOREIGN KEY (locname, date) REFERENCES WorkingDays(locname, date)
);