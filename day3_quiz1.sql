CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY,
    specialization VARCHAR(50),
    qualification VARCHAR(50),
    name_first VARCHAR(50),
    name_middle VARCHAR(50),
    name_last VARCHAR(50)
);
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    dob DATE,
    address_locality VARCHAR(50),
    address_city VARCHAR(50)
);
CREATE TABLE Medicine (
    code VARCHAR(10) PRIMARY KEY,
    price NUMERIC(10,2),
    quantity INT
);
CREATE TABLE Doctor_Treats_Patient (
    doctor_id INT,
    patient_id INT,
    PRIMARY KEY (doctor_id, patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);
CREATE TABLE Patient_Bills_Medicine (
    patient_id INT,
    medicine_code VARCHAR(10),
    quantity INT,
    PRIMARY KEY (patient_id, medicine_code),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (medicine_code) REFERENCES Medicine(code)
);

ALTER TABLE Doctor
ADD COLUMN salary NUMERIC(10,2);

ALTER TABLE Patient
ADD COLUMN name VARCHAR(100),
ADD COLUMN phone VARCHAR(20);


INSERT INTO Doctor (Doctor_id, Specialization, Qualification, Name_First, Name_Middle, Name_Last) 
VALUES 
(1, 'Cardiology', 'MD', 'Ahmed', 'Ali', 'Hassan'), 
(2, 'Neurology', 'PhD', 'Mona', 'Mohamed', 'Fahmy'), 
(3, 'Orthopedics', 'MBBS', 'Khaled', NULL, 'Saeed'), 
(4, 'Pediatrics', 'MD', 'Sara', 'Ahmed', 'Nabil'), 
(5, 'Dermatology', 'MD', 'Omar', 'Hassan', 'Farouk');

INSERT INTO Patient (Patient_id, DOB, Address_Locality, Address_City) 
VALUES 
(101, '1990-05-12', 'Heliopolis', 'Cairo'), 
(102, '1985-11-23', 'Zamalek', 'Cairo'), 
(103, '2000-01-30', 'Nasr City', 'Cairo'), 
(104, '2010-07-15', 'Maadi', 'Cairo'), 
(105, '1975-09-10', 'Dokki', 'Giza');

INSERT INTO Medicine (Code, Price, Quantity) 
VALUES 
('M001', 150.50, 20), 
('M002', 75.00, 50), 
('M003', 300.25, 10), 
('M004', 120.00, 30), 
('M005', 50.75, 100);

INSERT INTO Doctor_Treats_Patient (Doctor_id, Patient_id) 
VALUES 
(1, 101), 
(1, 102), 
(2, 103), 
(3, 104), 
(4, 105), 
(2, 101);

INSERT INTO Patient_Bills_Medicine (Patient_id, Medicine_Code, Quantity) 
VALUES 
(101, 'M001', 2), 
(101, 'M002', 1), 
(102, 'M003', 1), 
(103, 'M002', 3), 
(104, 'M004', 2), 
(105, 'M005', 5);


UPDATE Doctor SET salary = 18000 WHERE doctor_id = 1;
UPDATE Doctor SET salary = 14000 WHERE doctor_id = 2;
UPDATE Doctor SET salary = 11000 WHERE doctor_id = 3;
UPDATE Doctor SET salary = 16000 WHERE doctor_id = 4;
UPDATE Doctor SET salary = 13000 WHERE doctor_id = 5;

--1
DELETE FROM Patient
WHERE patient_id = 5;

SELECT * FROM Patient

-- 2
SELECT *
FROM Doctor
WHERE specialization = 'Cardiology'
  AND salary > 12000;
-------------------------------------------------------------------------

UPDATE Patient
SET 
    name = CASE patient_id
        WHEN 101 THEN 'Mohamed Adel'
        WHEN 102 THEN 'Mariam Hany'
        WHEN 103 THEN 'Ali Samy'
        WHEN 104 THEN 'Ahmed Tarek'
        WHEN 105 THEN 'Nora Emad'
    END,
    
    phone = CASE patient_id
        WHEN 101 THEN '01011111111'
        WHEN 102 THEN '01022222222'
        WHEN 103 THEN '01033333333'
        WHEN 104 THEN '01044444444'
        WHEN 105 THEN NULL
    END
WHERE patient_id IN (101,102,103,104,105);
------------------------------------------------------------------------------
-- 3
SELECT *
FROM Patient
WHERE name LIKE 'M%';

--4
SELECT *
FROM doctor
WHERE salary BETWEEN 10000 AND 20000;

--5
SELECT *
FROM doctor
WHERE specialization IN ('Cardiology', 'Dermatology');

--6
SELECT *
FROM doctor
WHERE specialization != 'Neurology';


--7
SELECT *
FROM patient
WHERE phone IS NULL;

--8
SELECT
    name_first,
    name_last,
    salary,
    CASE
        WHEN salary > 15000 THEN 'High Salary'
        ELSE 'Normal Salary'
    END AS salary_status
FROM doctor;


--9
SELECT p.*
FROM Patient p, Doctor_Treats_Patient d
WHERE p.patient_id = d.patient_id
AND d.doctor_id = 1;


--10
CREATE TABLE high_salary_doctors AS
SELECT *
FROM Doctor
WHERE salary > 15000;

--11
SELECT DISTINCT d.*
FROM Doctor d, Doctor_Treats_Patient dtp
WHERE d.doctor_id = dtp.doctor_id;

--12
SELECT *
FROM Doctor
WHERE salary > (
    SELECT MIN(salary)
    FROM Doctor
    WHERE specialization = 'Cardiology'
);

-- 13
SELECT *
FROM Patient
WHERE name SIMILAR TO '(A|M)%';

-- 14
SELECT DISTINCT specialization
FROM Doctor;

-- 15
SELECT name,
EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM dob)
FROM patient;

--16
SELECT name,
       UPPER(name) AS upper_name,
       LOWER(name) AS lower_name,
       INITCAP(name) AS capitalized_name
FROM Patient;


--17
SELECT phone,
       TRIM(phone) AS clean_phone
FROM Patient;

--18
SELECT CONCAT(name, ' - ', phone) AS contact_info
FROM patient;

--19
SELECT name,
       SUBSTRING(name FROM 1 FOR 3) AS first_3_letters,
       POSITION('a' IN LOWER(name)) AS position_of_a
FROM Patient;

--20
SELECT name_first,
       REPLACE(name_first, 'Ahmed', 'Ahmad') AS updated_name
FROM Doctor;

--21
SELECT salary,
       CAST(salary AS INTEGER) AS salary_as_integer,
       CAST(salary AS TEXT) AS salary_as_text
FROM Doctor;






