CREATE SCHEMA Freelance_Managment_System; 
SET SEARCH_PATH TO Freelance_Managment_System;


CREATE TABLE Plateform_Feedback(
	feedback_id VARCHAR(10),
	rating FLOAT,
	time_stamp TIMESTAMP,
	message_text TEXT,
	
	PRIMARY KEY(feedback_id)
);


CREATE TABLE Bank_Details(
	IBAN VARCHAR(50),
	BIC VARCHAR(15),
	account_no BIGINT,
	bank_name VARCHAR(100),
	
	PRIMARY KEY(IBAN)
);


CREATE TABLE Plateform_Charges(
	country VARCHAR(50),
	freelancer_charges FLOAT,
	project_owner_charges FLOAT,

	PRIMARY KEY (country)
);

CREATE TABLE Address (
	zipcode VARCHAR(10),
	city VARCHAR(50),
	state VARCHAR(50),
	country VARCHAR(50),
	
	PRIMARY KEY (zipcode),
	FOREIGN KEY (country) REFERENCES Plateform_Charges(country) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Freelancer (
	freelancer_id VARCHAR(10),
	mobile_no BIGINT NOT NULL UNIQUE,
	email_id VARCHAR(60) NOT NULL UNIQUE,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	zipcode	VARCHAR(10),
	DOB DATE,
	joining_date TIMESTAMP,
	gender VARCHAR(6),
	IBAN VARCHAR(50),
	feedback_id VARCHAR(10),
	
	PRIMARY KEY (freelancer_id),
	FOREIGN KEY (zipcode) REFERENCES Address(zipcode) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (IBAN)  REFERENCES Bank_Details(IBAN) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (feedback_id) REFERENCES Plateform_Feedback(feedback_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Project_Owner (
	owner_id VARCHAR(10),
	mobile_no BIGINT NOT NULL UNIQUE,
	email_id VARCHAR(60) NOT NULL UNIQUE,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	zipcode	VARCHAR(10),
	DOB DATE,
	joining_date TIMESTAMP,
	gender VARCHAR(6),
	IBAN VARCHAR(50),
	feedback_id VARCHAR(10),
	
	PRIMARY KEY (owner_id),
	FOREIGN KEY (zipcode) REFERENCES Address(zipcode) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (IBAN)  REFERENCES Bank_Details(IBAN) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (feedback_id) REFERENCES Plateform_Feedback(feedback_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Category(
	category_name VARCHAR(50),
	
	PRIMARY KEY(category_name)
);


CREATE TABLE Subcategory(
	category_name VARCHAR(50),
	subcategory_name VARCHAR(50),
	
	PRIMARY KEY(category_name,subcategory_name),
	FOREIGN KEY(category_name) REFERENCES Category(category_name) ON DELETE CASCADE ON UPDATE CASCADE
	
);


CREATE TABLE Project(
	project_id VARCHAR(10),
	name VARCHAR(60),
	status VARCHAR(15),
	category_name VARCHAR(30),
	no_of_milestones INT,
	type VARCHAR(15),
	maxbudget FLOAT,
	owner_id VARCHAR(10),
	freelancer_id VARCHAR(10),
	post_time TIMESTAMP,
	PRIMARY KEY(project_id),
	FOREIGN KEY(owner_id) REFERENCES Project_owner(owner_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(freelancer_id) REFERENCES Freelancer(freelancer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (category_name) REFERENCES Category(category_name) ON DELETE CASCADE ON UPDATE CASCADE
	
);


CREATE TABLE Milestone(
	milestone_no INT,
	project_id VARCHAR(10),
	details TEXT,
	deadline TIMESTAMP,
	workdone_status VARCHAR(15),
	payment_status VARCHAR(10),
	amount FLOAT,
	
	PRIMARY KEY(milestone_no,project_id),
	FOREIGN KEY(project_id) REFERENCES project(project_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Freelancer_payment(
	transaction_id VARCHAR(30),
	amount FLOAT,
	status VARCHAR(10),
	time_stamp TIMESTAMP,
	milestone_no INT,
	project_id VARCHAR(10),
	
	PRIMARY KEY(transaction_id),
	FOREIGN KEY(milestone_no,project_id) REFERENCES milestone(milestone_no,project_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE project_payment(
	transaction_id VARCHAR(30),
	amount FLOAT,
	status VARCHAR(10),
	time_stamp TIMESTAMP,
	project_id VARCHAR(10),
	
	PRIMARY KEY(transaction_id),
	FOREIGN KEY(project_id) REFERENCES project(project_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Feedback(
	project_id VARCHAR(10),
	Time_stamp TIMESTAMP,
	sender VARCHAR(10),
	content TEXT,
	rating FLOAT,
	
	PRIMARY KEY(project_id,Time_stamp),
	FOREIGN KEY(project_id) REFERENCES project(project_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Message(
	project_id VARCHAR(10),
	Time_stamp TIMESTAMP,
	sender VARCHAR(10),
	message_text TEXT,
	
	PRIMARY KEY(project_id,Time_stamp),
	FOREIGN KEY(project_id) REFERENCES project(project_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Tag(
	project_id VARCHAR(10),
	tag VARCHAR(50),
	
	PRIMARY KEY(project_id, tag),
	FOREIGN KEY(project_id) REFERENCES project(project_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE freelancer_skill(
	skill VARCHAR(50),
	freelancer_id VARCHAR(10),	
	
	PRIMARY KEY(freelancer_id, skill),
	FOREIGN KEY(freelancer_id) REFERENCES freelancer(freelancer_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Bid(
	project_id VARCHAR(10),
	freelancer_id VARCHAR(10),
	amount BIGINT,
	bid_message TEXT,
	bid_status VARCHAR(15),

	PRIMARY KEY(freelancer_id,project_id),
	FOREIGN KEY(freelancer_id) REFERENCES freelancer(freelancer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(project_id) REFERENCES project(project_id) ON DELETE CASCADE ON UPDATE CASCADE
);
