CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    middle_name VARCHAR(50),
    last_name VARCHAR(50),
    specialization VARCHAR(100),
    qualification VARCHAR(100)
);


CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    locality VARCHAR(100),
    city VARCHAR(100),
    doctor_id INT
);



ALTER TABLE patients
ADD CONSTRAINT fk_patients_doctor
FOREIGN KEY (doctor_id)
REFERENCES doctors(doctor_id)
ON DELETE CASCADE
ON UPDATE CASCADE;


CREATE TABLE medicines (
    code INT PRIMARY KEY,
    medicine_name VARCHAR(100),
    price NUMERIC(10,2),
    quantity INT
);



CREATE TABLE patient_medicine (
    bill_id INT PRIMARY KEY,
    patient_id INT,
    medicine_code INT,
    quantity INT,
    bill_date DATE
);


ALTER TABLE patient_medicine
ADD CONSTRAINT fk_pm_patient
FOREIGN KEY (patient_id)
REFERENCES patients(patient_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE patient_medicine
ADD CONSTRAINT fk_pm_medicine
FOREIGN KEY (medicine_code)
REFERENCES medicines(code)
ON DELETE CASCADE
ON UPDATE CASCADE;



INSERT INTO doctors (doctor_id, first_name, middle_name, last_name, specialization, qualification)
VALUES
(1, 'Ahmed', 'Ali', 'Hassan', 'Cardiology', 'MBBS'),
(2, 'Mona', 'Ibrahim', 'Khaled', 'Dermatology', 'MD'),
(3, 'Youssef', 'Samir', 'Adel', 'Neurology', 'PhD');



INSERT INTO patients (patient_id, first_name, last_name, dob, locality, city, doctor_id)
VALUES
(101, 'Sara', 'Mahmoud', '2000-05-10', 'Nasr City', 'Cairo', 1),
(102, 'Omar', 'Fathy', '1998-08-15', 'Smouha', 'Alexandria', 2),
(103, 'Laila', 'Tarek', '2002-01-20', 'Dokki', 'Giza', 1),
(104, 'Karim', 'Nabil', '1995-11-03', 'Stanley', 'Alexandria', 3),
(105, 'Nour', 'Ayman', '2001-07-25', 'Maadi', 'Cairo', 2);



INSERT INTO medicines (code, medicine_name, price, quantity)
VALUES
(1001, 'Panadol', 30.00, 100),
(1002, 'Amoxicillin', 55.50, 60),
(1003, 'Brufen', 42.75, 80),
(1004, 'Vitamin C', 25.00, 120),
(1005, 'Insulin', 150.00, 40);


INSERT INTO patient_medicine (bill_id, patient_id, medicine_code, quantity, bill_date)
VALUES
(1, 101, 1001, 2, '2026-03-01'),
(2, 102, 1002, 1, '2026-03-02'),
(3, 103, 1003, 3, '2026-03-03'),
(4, 104, 1005, 1, '2026-03-04'),
(5, 105, 1004, 2, '2026-03-05');



UPDATE medicines
SET price = price + 10
WHERE code = 1001;


UPDATE patients
SET doctor_id = 3
WHERE patient_id = 105;


ALTER TABLE doctors
ADD COLUMN phone_number VARCHAR(20);


ALTER TABLE patients
ADD COLUMN email VARCHAR(100) UNIQUE;



UPDATE patients SET email = 'sara@example.com' WHERE patient_id = 101;
UPDATE patients SET email = 'omar@example.com' WHERE patient_id = 102;
UPDATE patients SET email = 'laila@example.com' WHERE patient_id = 103;
UPDATE patients SET email = 'karim@example.com' WHERE patient_id = 104;
UPDATE patients SET email = 'nour@example.com' WHERE patient_id = 105;


ALTER TABLE medicines
ADD CONSTRAINT chk_medicines_price
CHECK (price >= 0);



UPDATE doctors
SET doctor_id = 10
WHERE doctor_id = 1;

SELECT * FROM doctors;
SELECT * FROM patients;
SELECT * FROM medicines;
SELECT * FROM patient_medicine;
