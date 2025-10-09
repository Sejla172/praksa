CREATE DATABASE eZdravlje;
USE eZdravlje;

-- USERS
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender ENUM('M', 'F', 'Other'),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(30),
    jmbg VARCHAR(13) UNIQUE,
    user_type ENUM('patient', 'doctor', 'admin') NOT NULL
);

-- DOCTORS
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    specialization VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- APPOINTMENTS
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('scheduled', 'completed', 'canceled') DEFAULT 'scheduled',
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- SPECIAL CARE PROGRAMS
CREATE TABLE SpecialCarePrograms (
    program_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    target_group VARCHAR(100)
);

-- USER-PROGRAM RELATION
CREATE TABLE UserPrograms (
    user_id INT NOT NULL,
    program_id INT NOT NULL,
    enrollment_date DATE,
    PRIMARY KEY (user_id, program_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (program_id) REFERENCES SpecialCarePrograms(program_id)
);

-- MEDICAL REPORTS
CREATE TABLE MedicalReports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    doctor_id INT NOT NULL,
    report_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- PRESCRIPTIONS
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    doctor_id INT NOT NULL,
    program_id INT,
    issue_date DATE,
    medication VARCHAR(255),
    dosage VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (program_id) REFERENCES SpecialCarePrograms(program_id)
);

-- REFERRALS
CREATE TABLE Referrals (
    referral_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    doctor_id INT NOT NULL,
    referral_date DATE,
    reason TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);
