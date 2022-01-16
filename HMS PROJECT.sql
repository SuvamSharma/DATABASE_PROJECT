
CREATE DATABASE Hospital_Management_System;

USE Hospital_Management_System;


CREATE TABLE patient_details
(
	patient_Id INT PRIMARY KEY AUTO_INCREMENT,
	patient_name VARCHAR(30)NOT NULL,
	patient_age INT ,
	patient_gender ENUM('MALE','FEMALE','TRANSGENDER'),
	telephone_number VARCHAR(20) DEFAULT NULL,
	emergency_number VARCHAR(20) DEFAULT NULL,
	doctor_code INT NOT NULL,
	FOREIGN KEY (doctor_code)REFERENCES docter_details(doctor_code)

);

DELIMITER $$
CREATE PROCEDURE patient_info()
BEGIN

SELECT * FROM patient_details;

END $$
DELIMITER;

CALL patient_info;



SELECT * FROM patient_details;


INSERT INTO patient_details (patient_Id,patient_name,patient_age,patient_gender,telephone_number,doctor_code)
VALUES (1,"shuvam sharma",28,'MALE',"946512358",1001);

INSERT INTO patient_details (patient_Id,patient_name,patient_age,patient_gender,emergency_number,doctor_code)
VALUES (2,"roshan kumar",55,'MALE',"984568358",1002);


INSERT INTO patient_details (patient_Id,patient_name,patient_age,patient_gender,telephone_number,emergency_number,doctor_code)
VALUES (3,"priyanka singh",32,'FEMALE',"844568712","03384567894",1003);


INSERT INTO patient_details (patient_Id,patient_name,patient_age,patient_gender,telephone_number,doctor_code)
VALUES (4,"rashmi surana",40,'FEMALE',"946512358",1004);


INSERT INTO patient_details (patient_Id,patient_name,patient_age,patient_gender,telephone_number,doctor_code)
VALUES (5,"shivam sukla",39,'MALE',"946512358",1005);


CREATE TABLE patient_location
(
	address VARCHAR(30),
	country VARCHAR(20)DEFAULT "INDIA",
	region ENUM('NORTH','SOUTH','EAST','WEST'),
	postal_code INT NOT NULL,
	patient_Id INT NOT NULL,
	FOREIGN KEY (patient_Id)REFERENCES patient_details(patient_Id)
);

SELECT * FROM patient_location;

INSERT INTO patient_location(address,region,postal_code,patient_Id) VALUES ('banglore','SOUTH',742365,1);

INSERT INTO patient_location(address,region,postal_code,patient_Id) VALUES ('mumbai','NORTH',713564,2);

INSERT INTO patient_location(address,region,postal_code,patient_Id) VALUES ('kolkata','EAST',700045,3);

INSERT INTO patient_location(address,region,postal_code,patient_Id) VALUES ('madhya pradesh','WEST',721456,4);

INSERT INTO patient_location(address,region,postal_code,patient_Id) VALUES ('kerela','SOUTH',752365,5);


CREATE TABLE docter_details
(
	doctor_code INT PRIMARY KEY,
	doctor_name VARCHAR(30) NOT NULL,
	docter_gender ENUM('MALE','FEMALE'), 
	docter_address VARCHAR(30),
	doctor_designation VARCHAR(30),
	doctor_number INT
);

SELECT * FROM docter_details;


INSERT INTO docter_details (doctor_code,doctor_name,docter_gender,docter_address,doctor_designation,doctor_number)
VALUES (1001,'Dr Rajib sukla','MALE','Mumbai','Senior Resident',845556547);

INSERT INTO docter_details (doctor_code,doctor_name,docter_gender,docter_address,doctor_designation,doctor_number)
VALUES (1002,'Dr Pramila Sharma','FEMALE','Mumbai','Chief Resident',627845326);

INSERT INTO docter_details (doctor_code,doctor_name,docter_gender,docter_address,doctor_designation,doctor_number)
VALUES (1003,'Dr Ramesh Kumar','MALE','Mumbai','Medical Director',877562143);

INSERT INTO docter_details (doctor_code,doctor_name,docter_gender,docter_address,doctor_designation,doctor_number)
VALUES (1004,'Dr Sushma Singh','FEMALE','Mumbai','HOD',944568712);

INSERT INTO docter_details (doctor_code,doctor_name,docter_gender,docter_address,doctor_designation,doctor_number)
VALUES (1005,'Dr A R Bata','MALE','Mumbai','Junior Resident',984566547);


CREATE TABLE patient_diagnosis
(
	diagonis_Id INT PRIMARY KEY ,
	diagonis_details VARCHAR(30) NOT NULL,
	diagonis_remarks VARCHAR(30) NOT NULL,
	diagonis_date DATE,
	patient_Id INT NOT NULL,
	FOREIGN KEY(patient_Id) REFERENCES patient_details(patient_Id),
	doctor_code INT NOT NULL,
	FOREIGN KEY(doctor_code) REFERENCES docter_details(doctor_code)
);

SELECT * FROM patient_diagnosis;

INSERT INTO patient_diagnosis (diagonis_Id,diagonis_details,diagonis_remarks,diagonis_date,patient_Id,doctor_code)
VALUES (2021001,'Acute Asthama Found','Precaution Needed','2021-06-02',1,1001);

INSERT INTO patient_diagnosis (diagonis_Id,diagonis_details,diagonis_remarks,diagonis_date,patient_Id,doctor_code)
VALUES (2021002,'High Blood Sugar','Diet Control','2021-09-21',2,1002);

INSERT INTO patient_diagnosis (diagonis_Id,diagonis_details,diagonis_remarks,diagonis_date,patient_Id,doctor_code)
VALUES (2021003,'Kidney Stone Found','Operation Needed','2021-03-19',3,1003);

INSERT INTO patient_diagnosis (diagonis_Id,diagonis_details,diagonis_remarks,diagonis_date,patient_Id,doctor_code)
VALUES (2021004,'Harnia found','Medication Needed','2021-04-22',4,1004);

INSERT INTO patient_diagnosis (diagonis_Id,diagonis_details,diagonis_remarks,diagonis_date,patient_Id,doctor_code)
VALUES (2021005,'Bone Facture','Surgery Needed','2021-08-12',5,1005);



CREATE TABLE mediclaim_center
(
	policy_number INT PRIMARY KEY,
	company_name VARCHAR(30),
	amount_covered INT NOT NULL,
	patient_Id INT NOT NULL,
	FOREIGN KEY(patient_Id) REFERENCES patient_details(patient_Id)
);

SELECT * FROM mediclaim_center;


INSERT INTO mediclaim_center(policy_number,company_name,amount_covered,patient_Id)VALUES (200025465,'Bajaj Allaince Ltd',500000,1);

INSERT INTO mediclaim_center(policy_number,company_name,amount_covered,patient_Id)VALUES (211128456,'HDFC LIFE Ltd',500000,1);

INSERT INTO mediclaim_center(policy_number,company_name,amount_covered,patient_Id)VALUES (355400026,'MediBuddy Assit Ltd',500000,1);

INSERT INTO mediclaim_center(policy_number,company_name,amount_covered,patient_Id)VALUES (400568945,'Relaince Ltd',500000,1);

INSERT INTO mediclaim_center(policy_number,company_name,amount_covered,patient_Id)VALUES (100245654,'ICICI Ltd',500000,1);

	
CREATE TABLE patient_Bill
(
	bill_no INT NOT NULL,
	total_amount INT NOT NULL,
	policy_number INT NOT NULL,
	FOREIGN KEY(policy_number) REFERENCES mediclaim_center(policy_number),
	patient_Id INT NOT NULL,
	FOREIGN KEY(patient_Id) REFERENCES patient_details(patient_Id),
	doctor_code INT NOT NULL,
	FOREIGN KEY (doctor_code)REFERENCES   docter_details(doctor_code),
	diagonis_Id INT NOT NULL,
	FOREIGN KEY (diagonis_Id)REFERENCES patient_diagnosis(diagonis_Id)

);

SELECT * FROM patient_Bill;

SELECT patient_details.patient_name,patient_details.telephone_number,patient_Bill.bill_no,patient_Bill.total_amount
FROM patient_details,patient_Bill WHERE patient_details.patient_Id =patient_Bill.patient_Id;


INSERT INTO patient_Bill(bill_no,total_amount,policy_number,patient_Id,doctor_code,diagonis_Id)
VALUES (1001,45000,100245654,1,1001,2021001);

INSERT INTO patient_Bill(bill_no,total_amount,policy_number,patient_Id,doctor_code,diagonis_Id)
VALUES (1002,300000,200025465,2,1002,2021002);

INSERT INTO patient_Bill(bill_no,total_amount,policy_number,patient_Id,doctor_code,diagonis_Id)
VALUES (1003,22000,211128456,3,1003,2021003);
INSERT INTO patient_Bill(bill_no,total_amount,policy_number,patient_Id,doctor_code,diagonis_Id)
VALUES (1004,75000,355400026,4,1004,2021004);

INSERT INTO patient_Bill(bill_no,total_amount,policy_number,patient_Id,doctor_code,diagonis_Id)
VALUES (1005,100000,400568945,5,1005,2021005);
	
	
----------------	-------------------------------------------------------------------------------------------------------------------------	
	







	
	
 	
	
	
	
	
