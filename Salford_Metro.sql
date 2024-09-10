CREATE DATABASE SalfordMetroHospital;

USE SalfordMetroHospital;

-- Create Department Table
CREATE TABLE Departments(
	DepartmentID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	DepartmentName VARCHAR(20) NOT NULL,
	DepartmentLocation VARCHAR(60) NOT NULL,
	DepartmentPhoneLine VARCHAR(20) NOT NULL,
	DepartmentEmailAddress VARCHAR (60) NOT NULL,
	CONSTRAINT CHK_DepartmentEmailAddress CHECK (DepartmentEmailAddress LIKE '%_@_%._%')
);

-- Create Medicines Table
CREATE TABLE Medicines (
    MedicineID INT IDENTITY(1,1) PRIMARY KEY,
    MedicineName NVARCHAR(100) NOT NULL,
	AdministrationType VARCHAR (50) NOT NULL,
    DateOfPurchase DATE NOT NULL,
    ExpiryDate DATE NOT NULL
);

-- Create Address Table
CREATE TABLE Addresses(
	AddressID INT PRIMARY KEY NOT NULL,
	AddressLine1 VARCHAR(60) NOT NULL,
	AddressLine2 VARCHAR(60) NULL,
	Postcode VARCHAR(10) NOT NULL,
	City VARCHAR(20) NULL,
	County VARCHAR (30) NOT NULL,
	Country VARCHAR (30) NOT NULL
);

-- Create Credentials Table
CREATE TABLE Credentials (
    CredentialID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(30) UNIQUE NOT NULL,
    Password NVARCHAR (100) NOT NULL,
    SecurityQuestion NVARCHAR(100) NOT NULL,
    SecurityAnswerHash BINARY(64) NOT NULL,
    AccountStatus VARCHAR(30),
);


-- Create Patients Table
CREATE TABLE Patients (
    PatientsID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
	MiddleName VARCHAR(50) NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
	Gender VARCHAR(20) NOT NULL,
    Occupation VARCHAR(50) NOT NULL,
    InssuranceNumber NVARCHAR(50) NOT NULL,
    RegistrationDate DATETIME NOT NULL,
    MaritalStatus NVARCHAR(10) NOT NULL,
    EmailAddress NVARCHAR(100) UNIQUE,
    TelephoneNumber NVARCHAR(20),
	AddressID INT NOT NULL,
	CredentialID INT NOT NULL,
	TerminationDate DATE NULL,
	FOREIGN KEY (AddressID) REFERENCES Addresses (AddressID),
	FOREIGN KEY (CredentialID) REFERENCES Credentials (CredentialID),
	CONSTRAINT CHK_PatientsEmailAddress CHECK (EmailAddress LIKE '%_@_%._%'),
	CONSTRAINT CHK_Gender CHECK (Gender IN ('Male', 'Female'))
);


-- Create Doctors Table
CREATE TABLE Doctors(
	DoctorID INT IDENTITY(1,1) PRIMARY KEY,
	DepartmentID INT NOT NULL,
	FirstName VARCHAR(50) NOT NULL,
	MiddleName VARCHAR (50) NULL,
	LastName VARCHAR (50) NOT NULL,
	AvailabilityStatus VARCHAR(50) NOT NULL,
	DateOfBirth DATE NOT NULL,
	Gender NVARCHAR (10) NOT NULL,
	MedicalLicenseNumber NVARCHAR(50) NOT NULL,
	Specialization VARCHAR (50) NOT NULL,
	EmailAddress NVARCHAR(100),
    TelephoneNumber NVARCHAR(20),
	EmploymentDate DATE NOT NULL,
    TerminationDate DATE NULL,
	AddressID INT,
	CredentialID INT,
	FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID),
	FOREIGN KEY (CredentialID) REFERENCES Credentials (CredentialID),
	FOREIGN KEY (DepartmentID) REFERENCES Departments (DepartmentID),
	CONSTRAINT CHK_DoctorEmailAddress CHECK (EmailAddress LIKE '%_@_%._%')
);

-- Create Appointment Table
CREATE TABLE Appointments(
	AppointmentID INT IDENTITY (9,1) PRIMARY KEY ,
	PatientID INT NOT NULL,
	DoctorID INT NOT NULL,
	AppointmentDate DATE NOT NULL,
	StartTime TIME NOT NULL,
	EndTime TIME NULL,
	ReasonForVisit VARCHAR (100),
	Status VARCHAR(20) NOT NULL,
	ReasonForCancellation VARCHAR (100),
	CancellationDate DATE,
	FOREIGN KEY (PatientID) REFERENCES Patients (PatientsID),
	FOREIGN KEY (DoctorID) REFERENCES Doctors (DoctorID)
);

-- Create AppointmentArchive Table
CREATE TABLE AppointmentArchive (
	AppointmentID INT  PRIMARY KEY,
	PatientID INT NOT NULL,
	DoctorID INT NOT NULL,
	AppointmentDate DATE NOT NULL,
	StartTime TIME NOT NULL,
	EndTime TIME NULL,
	ReasonForVisit VARCHAR (100),
	Status VARCHAR(20) NOT NULL,
	ReasonForCancellation VARCHAR (100),
	CancellationDate DATE,
	FOREIGN KEY (PatientID) REFERENCES Patients (PatientsID),
	FOREIGN KEY (DoctorID) REFERENCES Doctors (DoctorID)
);

-- Create Allergy Table
CREATE TABLE Allergy(
	AllergyID INT IDENTITY(1,1) PRIMARY KEY,
	AllergyName VARCHAR(30) NOT NULL,
	Reactions VARCHAR (50) NOT NULL
);

-- Create Patients Allergy Table
CREATE TABLE PatientsAllergy(
	PatientID INT,
	AllergyID INT,
	PRIMARY KEY(AllergyID, PatientID),
	FOREIGN KEY (AllergyID) REFERENCES Allergy (AllergyID),
	FOREIGN KEY (PatientID) REFERENCES Patients (PatientsID)
);

-- Create Diagnose Table
CREATE TABLE Diagnoses (
	DiagnoseID INT IDENTITY(1,1) PRIMARY KEY,
	AppointmentID INT,
	Diagnose VARCHAR(255) NOT NULL,
	Severity VARCHAR (50) NOT NULL,
	TreatmentPlan VARCHAR (200) NOT NULL,
	DoctorNote VARCHAR (255) NOT NULL,
	FOREIGN KEY (AppointmentID) REFERENCES AppointmentArchive (AppointmentID)
);


-- Create Prescription Table
CREATE TABLE Prescription(
	DiagnoseID INT,
	PrescriptionDateTime DATETIME NOT NULL,
	MedicineID INT,
	Dosage VARCHAR (50) NOT NULL,
	Frequency VARCHAR (50) NOT NULL,
	Duration VARCHAR (50) NOT NULL,
	SpecialInstructions VARCHAR (200) NULL,
	FOREIGN KEY (DiagnoseID) REFERENCES Diagnoses (DiagnoseID),
	FOREIGN KEY (MedicineID) REFERENCES Medicines (MedicineID)
);

--Create Review Table
CREATE TABLE Reviews(
	AppointmentID INT NOT NULL,
	PatientID INT NOT NULL,
	Ratings TINYINT NOT NULL,
	Feedback VARCHAR(150) NULL,
	PRIMARY KEY (AppointmentID, PatientID),
	FOREIGN KEY (PatientID) REFERENCES Patients (PatientsID),
	FOREIGN KEY (AppointmentID) REFERENCES AppointmentArchive (AppointmentID)
);

										------ INSERTING INTO THE DATABASE -------
-- Insert Into Department
INSERT INTO Departments (DepartmentName, DepartmentLocation, DepartmentPhoneLine, DepartmentEmailAddress)
VALUES
    ('Oncology', 'Main Building, 3rd Floor', '+44 555 123 4567', 'oncologydepartment@salfordmetrohospital.ac.uk'),
    ('Endocrinology', 'East Wing, 2nd Floor', '+44 555 234 5678', 'endocrinologydepartment@salfordmetrohospital.ac.uk'),
    ('Gastroenterology', 'West Wing, 4th Floor', '+44 555 345 6789', 'gastroenterologydepartment@salfordmetrohospital.ac.uk'),
    ('Cardiology', 'North Wing, 5th Floor', '+44 555 456 7890', 'cardiologydepartment@salfordmetrohospital.ac.uk'),
    ('Dermatology', 'South Wing, 1st Floor', '+44 555 567 8901', 'dermatologydepartment@salfordmetrohospital.ac.uk'),
    ('Neurology', 'Main Building, 2nd Floor', '+44 555 678 9012', 'neurologydepartment@salfordmetrohospital.ac.uk'),
    ('Orthopedics', 'Main Building, 4th Floor', '+44 555 789 0123', 'orthopedicsdepartment@salfordmetrohospital.ac.uk');

-- Insert Into Medicine Table 
INSERT INTO Medicines (MedicineName, AdministrationType, DateOfPurchase, ExpiryDate)
VALUES
    ('Paracetamol', 'Oral', '2023-01-15', '2024-01-15'),
    ('Aspirin', 'Oral', '2023-02-20', '2024-02-20'),
    ('Ibuprofen', 'Oral', '2023-03-25', '2024-03-25'),
    ('Metformin', 'Oral', '2023-04-10', '2024-04-10'),
    ('Insulin', 'Injection', '2023-05-05', '2024-05-05'),
    ('Lisinopril', 'Oral', '2023-06-15', '2024-06-15'),
    ('Amoxicillin', 'Oral', '2023-07-20', '2024-07-20'),
    ('Prednisone', 'Oral', '2023-08-25', '2024-08-25'),
    ('Warfarin', 'Oral', '2023-09-10', '2024-09-10'),
    ('Hydrochlorothiazide', 'Oral', '2023-10-05', '2024-10-05'),
    ('Atorvastatin', 'Oral', '2023-11-15', '2024-11-15'),
    ('Diazepam', 'Oral', '2023-12-20', '2024-12-20'),
    ('Adrenaline', 'Injection', '2023-01-25', '2024-01-25'),
    ('Sodium Chloride', 'Drip', '2023-02-20', '2024-02-20'),
    ('Morphine', 'Injection', '2023-03-15', '2024-03-15');

-- Insert Into Addresses
INSERT INTO Addresses (AddressID, AddressLine1, AddressLine2, Postcode, City, County, Country)
VALUES
    -- Addresses for patients
    (1, '123 Main Street', 'Apt 1', 'AB1 2CD', 'London', 'Greater London', 'United Kingdom'),
    (2, '456 Elm Avenue', NULL, 'CD3 4EF', 'Manchester', 'Greater Manchester', 'United Kingdom'),
    (3, '789 Oak Drive', 'Suite 3B', 'EF5 6GH', 'Liverpool', 'Merseyside', 'United Kingdom'),
    (4, '101 Maple Lane', NULL, 'GH7 8IJ', 'Leeds', 'West Yorkshire', 'United Kingdom'),
    (5, '234 Pine Road', 'Flat 2', 'IJ9 0KL', 'Newcastle', 'Tyne and Wear', 'United Kingdom'),
    (6, '345 Cedar Street', NULL, 'KL1 2MN', 'Birmingham', 'West Midlands', 'United Kingdom'),
    (7, '567 Birch Crescent', 'Unit 5', 'MN3 4OP', 'Glasgow', 'Glasgow City', 'United Kingdom'),
    (8, '789 Walnut Court', NULL, 'OP5 6QR', 'Cardiff', 'Cardiff', 'United Kingdom'),
    (9, '910 Elm Way', NULL, 'QR7 8ST', 'Bristol', 'Bristol', 'United Kingdom'),
    (10, '123 Oak Lane', 'Floor 3', 'ST9 0UV', 'Sheffield', 'South Yorkshire', 'United Kingdom'),
    (11, '234 Maple Street', NULL, 'UV1 2WX', 'Edinburgh', 'Edinburgh', 'United Kingdom'),
    -- Addresses for doctors
    (14, '101 Oak Street', NULL, 'AB1 2CD', 'Leeds', 'West Yorkshire', 'United Kingdom'),
    (15, '202 Pine Avenue', 'Suite 2', 'CD3 4EF', 'Liverpool', 'Merseyside', 'United Kingdom'),
    (16, '303 Elm Road', NULL, 'EF5 6GH', 'Manchester', 'Greater Manchester', 'United Kingdom'),
    (17, '404 Maple Lane', 'Flat 3', 'GH7 8IJ', 'Newcastle', 'Tyne and Wear', 'United Kingdom'),
    (18, '505 Cedar Drive', NULL, 'IJ9 0KL', 'Leeds', 'West Yorkshire', 'United Kingdom'),
    (19, '606 Birch Street', 'Unit 3', 'KL1 2MN', 'Manchester', 'Greater Manchester', 'United Kingdom'),
    (20, '707 Walnut Avenue', NULL, 'MN3 4OP', 'Liverpool', 'Merseyside', 'United Kingdom');


	select * from Credentials
-- Insert into Credentials Table
INSERT INTO Credentials (Username, Password, SecurityQuestion, SecurityAnswerHash, AccountStatus)
VALUES
    -- Credentials for patients
    ('John45', 'MyDog123@', 'What is the name of your first pet?', HASHBYTES('SHA2_256', 'My first pet was a dog named Max.'), 'Active'),
    ('Rose5', 'HealthyLife123*', 'What is your favorite hobby?', HASHBYTES('SHA2_256', 'My favorite hobby is hiking in the mountains.'), 'Active'),
    ('William300', 'DiabeticCare#1', 'What is the name of your favorite book?', HASHBYTES('SHA2_256', 'My favorite book is "To Kill a Mockingbird."'), 'Active'),
    ('SarahD', 'Sunshine123#', 'What is the name of the street you grew up on?', HASHBYTES('SHA2_256', 'I grew up on Sunshine Street.'), 'Active'),
    ('Wilson3', 'HealthyEating$1', 'What is your favorite food?', HASHBYTES('SHA2_256', 'My favorite food is sushi.'), 'Active'),
    ('JennyM4', 'FitnessLife123$', 'What is your favorite sport?', HASHBYTES('SHA2_256', 'I love playing basketball.'), 'Active'),
    ('DanielGreat', 'Wellness123!', 'What is your mother''s maiden name?', HASHBYTES('SHA2_256', 'My mother''s maiden name is Smith.'), 'Active'),
    ('Jessica9', 'HappyLife123!', 'What is your favorite movie?', HASHBYTES('SHA2_256', 'My favorite movie is "The Shawshank Redemption."'), 'Active'),
    ('Christopher7', 'HealthyMind$1', 'What is your favorite color?', HASHBYTES('SHA2_256', 'My favorite color is blue.'), 'Active'),
    ('AmandaMay', 'GoodHealth123!', 'What is your favorite holiday destination?', HASHBYTES('SHA2_256', 'My favorite holiday destination is Hawaii.'), 'Active'),
    ('James300', 'NatureLover123$', 'What is your favorite animal?', HASHBYTES('SHA2_256', 'I love horses.'), 'Active'),
    -- Credentials for doctors
    ('John23', 'DrCare123!', 'What inspired you to become a doctor?', HASHBYTES('SHA2_256', 'I was inspired to become a doctor by my desire to help others.'), 'Active'),
    ('Jane55', 'HealthyDoc123!', 'What is your favorite aspect of medicine?', HASHBYTES('SHA2_256', 'My favorite aspect of medicine is seeing patients improve their health.'), 'Active'),
    ('MichaelE', 'ExpertDoc123@', 'What is your area of expertise in medicine?', HASHBYTES('SHA2_256', 'My area of expertise is in cardiology.'), 'Active'),
    ('Emily7', 'DrLife123$', 'What do you enjoy most about being a doctor?', HASHBYTES('SHA2_256', 'I enjoy the opportunity to make a positive impact on people''s lives.'), 'Active'),
    ('David4', 'PatientCare123$', 'What is your approach to patient care?', HASHBYTES('SHA2_256', 'I believe in providing compassionate and personalized care to each patient.'), 'Active'),
    ('Sarah5', 'HealthyLiving123@', 'How do you promote healthy living to your patients?', HASHBYTES('SHA2_256', 'I emphasize the importance of diet and exercise in promoting overall health.'), 'Active'),
    ('Christopher88', 'WellnessDoc123@', 'What is your philosophy on wellness?', HASHBYTES('SHA2_256', 'I believe that wellness encompasses physical, mental, and emotional well-being.'), 'Active');


--Insert Into Patients Table
INSERT INTO Patients (FirstName, MiddleName, LastName, DateOfBirth, Gender, Occupation, InssuranceNumber, RegistrationDate, MaritalStatus, EmailAddress, TelephoneNumber, AddressID, CredentialID, TerminationDate)
VALUES
    ('John', 'Michael', 'Smith', '1985-03-12', 'Male', 'Software Engineer', 'INS123456', '2023-01-15', 'Single', 'john.smith@gmail.com', '+441234567890', 1, 1, NULL),
    ('Emily', 'Rose', 'Johnson', '1990-07-25', 'Female', 'Nurse', 'INS987654', '2022-11-20', 'Married', 'emily.johnson@yahoo.com', '+441234567891', 2, 2, NULL),
    ('David', 'William', 'Brown', '1978-09-08', 'Male', 'Teacher', 'INS456789', '2023-02-05', 'Divorced', 'david.brown@hotmail.com', '+441234567892', 3, 3, NULL),
    ('Sarah', NULL, 'Davis', '1982-12-15', 'Female', 'Doctor', 'INS234567', '2022-12-10', 'Single', 'sarah.davis@outlook.com', '+441234567893', 4, 4, NULL),
    ('Michael', 'James', 'Wilson', '1975-05-20', 'Male', 'Engineer', 'INS654321', '2023-03-18', 'Married', 'michael.wilson@gmail.com', '+441234567894', 5, 5, NULL),
    ('Jennifer', 'Anne', 'Martinez', '1989-08-30', 'Female', 'Accountant', 'INS765432', '2022-10-25', 'Single', 'jennifer.martinez@yahoo.com', '+441234567895', 6, 6, NULL),
    ('Daniel', NULL, 'Thompson', '1976-04-02', 'Male', 'Lawyer', 'INS876543', '2023-04-12', 'Married', 'daniel.thompson@hotmail.com', '+441234567896', 7, 7, NULL),
    ('Jessica', 'Nicole', 'Garcia', '1983-11-18', 'Female', 'Dentist', 'INS987654', '2022-11-20', 'Divorced', 'jessica.garcia@outlook.com', '+441234567897', 8, 8, NULL),
    ('Christopher', NULL, 'Hernandez', '1992-09-23', 'Male', 'Architect', 'INS345678', '2023-05-05', 'Single', 'christopher.hernandez@gmail.com', '+441234567898', 9, 9, NULL),
    ('Amanda', 'Marie', 'Young', '1974-06-23', 'Female', 'Marketing Manager', 'INS456789', '2022-12-30', 'Married', 'amanda.young@yahoo.com', '+441234567899', 10, 10, NULL),
    ('James', NULL, 'Lee', '1980-02-28', 'Male', 'Chef', 'INS567890', '2023-06-20', 'Single', 'james.lee@hotmail.com', '+441234567810', 11, 11, NULL);

-- Insert Into Doctors Table
INSERT INTO Doctors (DepartmentID, FirstName, MiddleName, LastName, AvailabilityStatus, DateOfBirth, Gender, MedicalLicenseNumber, Specialization, EmailAddress, TelephoneNumber, EmploymentDate, TerminationDate, AddressID, CredentialID)
VALUES
    (1, 'John', 'Robert', 'Doe', 'Available', '1980-05-15', 'Male', 'MED123456', 'Gastroenterologist', 'john.doe@gmail.com', '+441234567890', '2010-02-15', NULL, 1, 1),
    (1, 'Jane', 'Elizabeth', 'Smith', 'Available', '1975-09-20', 'Female', 'MED987654', 'Oncologist', 'jane.smith@yahoo.com', '+441234567891', '2008-07-10', NULL, 2, 2),
    (2, 'Michael', 'James', 'Johnson', 'Available', '1982-12-10', 'Male', 'MED456789', 'Endocrinologists', 'michael.johnson@hotmail.com', '+441234567892', '2015-05-20', NULL, 3, 3),
    (1, 'Emily', 'Anne', 'Wilson', 'Available', '1978-07-25', 'Female', 'MED654321', 'Neurologist', 'emily.wilson@outlook.com', '+441234567893', '2012-09-30', NULL, 4, 4),
    (6, 'David', 'Christopher', 'Brown', 'Available', '1970-03-05', 'Male', 'MED789123', 'Neurologist', 'david.brown@gmail.com', '+441234567894', '2005-04-18', NULL, 5, 5),
    (3, 'Sarah', 'Louise', 'Anderson', 'Available', '1985-08-12', 'Female', 'MED234567', 'Gastroenterologist', 'sarah.anderson@yahoo.com', '+441234567895', '2018-10-25', NULL, 6, 6),
    (5, 'Christopher', 'William', 'Taylor', 'Available', '1973-11-30', 'Male', 'MED321789', 'Dermatologist', 'chris.taylor@hotmail.com', '+441234567896', '2007-06-15', NULL, 7, 7);


-- Insert into appointment table 
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, StartTime, EndTime, ReasonForVisit, Status, ReasonForCancellation, CancellationDate)
VALUES
    (1, 1, '2024-06-01', '09:00:00', '10:00:00', 'General check-up', 'Scheduled', NULL, NULL),
    (2, 4, '2024-06-02', '10:30:00', '11:30:00', 'Follow-up appointment', 'Scheduled', NULL, NULL),
    (3, 3, GETDATE(), '13:00:00', '14:00:00', 'Consultation', 'Scheduled', NULL, NULL),
    (4, 4, GETDATE(), '11:00:00', '12:00:00', 'Treatment session', 'Completed', NULL, NULL),
    (5, 5, '2024-06-05', '15:30:00', '16:30:00', 'Diagnostic test', 'Scheduled', NULL, NULL),
    (6, 6, '2024-06-06', '14:00:00', '15:00:00', 'Physical therapy', 'Scheduled', NULL, NULL),
    (7, 6, GETDATE(), '16:30:00', '17:30:00', 'Medication review', 'Scheduled', NULL, NULL),
    (8, 1, '2024-06-08', '10:00:00', '11:00:00', 'Routine check-up', 'Scheduled', NULL, NULL);


-- Insert Into Appointment Archive
INSERT INTO AppointmentArchive (AppointmentID, PatientID, DoctorID, AppointmentDate, StartTime, EndTime, ReasonForVisit, Status, ReasonForCancellation, CancellationDate)
VALUES
    (1, 9, 1, '2023-12-20', '10:00:00', '11:00:00', 'Stomach pain and blood in the stool', 'Cancelled', 'Rescheduled', '2023-12-18'),
    (2, 9, 1, '2024-01-05', '10:00:00', '11:00:00', 'Stomach and blood in the stool ', 'Completed', NULL, NULL),
    (3, 10, 2, '2024-01-10', '09:30:00', '10:30:00', 'Follow-up appointment', 'Completed', NULL, NULL),
    (4, 11, 3, '2024-01-15', '11:30:00', '16:30:00', 'Annual checkup', 'Completed', NULL, NULL),
    (5, 3, 3, '2024-02-01', '13:00:00', '14:00:00', 'Consultation', 'Completed', NULL, NULL),
    (6, 7, 6, '2024-02-10', '16:30:00', '17:30:00', 'Medication review', 'Completed', NULL, NULL),
    (7, 4, 4, '2024-02-20', '11:00:00', '12:00:00', 'Treatment session', 'Completed', NULL, NULL),
    (8, 8, 1, '2024-03-09', '10:00:00', '11:00:00', 'Routine check-up', 'Completed', NULL, NULL);

	-- Inserting sample allergies into the Allergy table
INSERT INTO Allergy (AllergyName, Reactions)
VALUES
    ('Pollen', 'Hay fever'),
    ('Dust Mites', 'Allergic rhinitis'),
    ('Penicillin', 'Hives'),
    ('Peanuts', 'Anaphylaxis'),
    ('Shellfish', 'Hives, swelling'),
    ('Latex', 'Skin rash'),
    ('Mold', 'Allergic rhinitis'),
    ('Pet Dander', 'Allergic rhinitis'),
    ('Eggs', 'Hives and digestive issues');

-- Inserting into PatientsAllergy Table
INSERT INTO PatientsAllergy
VALUES (2, 3),
(2, 6),
(3, 9),
(4,5),
(5, 8),
(5, 4),
(10, 7),
(10, 2),
(8, 5);

-- Insert into Diagnoses Table 
INSERT INTO Diagnoses (AppointmentID, Diagnose, Severity, TreatmentPlan, DoctorNote)
VALUES
    (2, 'Gastritis', 'Moderate', 'Prescription of proton pump inhibitors (PPIs) with dietary modifications. Follow-up endoscopy in 3 months.', 'Patient advised to adhere strictly to the medication regimen and dietary recommendations.'),
    (3, 'Cancer', 'Low', 'Regular monitoring with physical examinations, blood tests, and imaging studies. Referral to oncology specialist if concerning symptoms arise.', 'Patient encouraged to maintain a healthy lifestyle and report any concerning symptoms.'),
    (4, 'Diabetes', 'Low', 'Medication adjustment based on recent HbA1c levels. Education on carbohydrate counting and meal planning. Referral to diabetes educator and nutritionist.', 'Patient advised to monitor blood sugar levels regularly and report any significant changes.'),
    (5, 'Thyroid Cancer', 'Moderate', 'Initiation of levothyroxine therapy. Follow-up blood tests in 6 weeks to adjust dosage if necessary. Referral to endocrinologist for further evaluation.', 'Patient counseled on medication adherence and potential side effects.'),
    (6, 'Gastroesophageal reflux disease (GERD)', 'Moderate', 'Prescription of proton pump inhibitors (PPIs) or H2 blockers with lifestyle modifications. Consideration of upper endoscopy if symptoms persist.', 'Patient advised on lifestyle modifications and medication adherence.'),
    (7, 'Migraine', 'High', 'Acute treatment with triptans or NSAIDs for migraine attacks. Prophylactic treatment with beta-blockers or tricyclic antidepressants. Lifestyle modifications for migraine prevention.', 'Patient encouraged to keep a headache diary and follow lifestyle recommendations.'),
    (8, 'Colon polyps', 'Low', 'Colonoscopy for polyp removal and biopsy. Surveillance colonoscopy recommended every 3-5 years. Education on bowel preparation and post-procedure care.', 'Patient advised to follow all pre-procedure instructions carefully.');


-- Insert Into Prescription Table
INSERT INTO Prescription (DiagnoseID, PrescriptionDateTime, MedicineID, Dosage, Frequency, Duration, SpecialInstructions)
VALUES
    (1, '2024-01-05 13:00:00', 8, '10 mg', 'Once daily', '1 month', 'Take with food.'),
    (2, '2024-01-10 11:20:00', 13, '0.3 mg', 'As needed for severe pain', 'As needed', 'Administer intramuscularly.'),
    (3, '2024-01-15 14:00:00', 4, '1000 mg', 'Twice daily', 'Indefinite', 'Take with meals. Monitor blood sugar regularly.'),
    (4, '2024-02-01 15:04:00', 5, '10 units', 'Before meals', 'Indefinite', 'Administer subcutaneously.'),
    (5, '2024-02-10 17:00:00', 6, '20 mg', 'Once daily', '3 months', 'Take 30 minutes before meals.'),
    (6, '2024-02-20 14:00:00', 2, '300 mg', 'As needed for migraine attacks', 'As needed', 'Avoid alcohol while taking.'),
    (7, '2024-03-09 15:00:00', 14, '1000 mL', 'Continuous infusion', 'During procedure', 'Administer via intravenous drip.');

-- Insert into Reviews Table
INSERT INTO Reviews (AppointmentID, PatientID, Ratings, Feedback)
VALUES
    (2, 9, 4, 'The doctor provided thorough explanations and made me feel comfortable throughout the appointment.'),
    (3, 10, 5, 'Excellent follow-up appointment. The doctor was attentive and addressed all my concerns.'),
    (4, 11, 5, 'I had a great experience during my annual checkup. The staff was friendly and professional.'),
    (5, 3, 4, 'The consultation was informative, and the doctor took the time to listen to my questions.'),
    (6, 7, 3, 'The medication review went smoothly, but I wish there was more discussion about potential side effects.'),
    (7, 4, 5, 'The treatment session was effective, and I felt well taken care of by the medical team.'),
    (8, 8, 4, 'Routine check-up was quick and efficient. The doctor provided useful tips for maintaining good health.');



												--TASK
--2. Constraint to Check Appointment Date is Not in The Past
ALTER TABLE Appointments
WITH NOCHECK
ADD CONSTRAINT check_date CHECK (AppointmentDate >= GETDATE());


--3. Patients Older than 40 With Cancer Diagnose
SELECT p.FirstName, p.MiddleName, p.LastName, p.DateOfBirth, DATEDIFF(Year, p.DateOfBirth, GETDATE()) as Age, d.Diagnose, d.Severity
FROM Patients p
INNER JOIN AppointmentArchive a
ON p.PatientsID = a.PatientID
INNER JOIN Diagnoses d
ON a.AppointmentID = d.AppointmentID
WHERE Diagnose LIKE '%Cancer%' AND DATEDIFF(YEAR, p.DateOfBirth, GETDATE()) >= 40
;


-- 4a. Create a Search Procedure for Medicines Name
CREATE PROCEDURE GetPrescribedMedicines @medine VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    WITH PrescriptionCTE AS (
        SELECT m.MedicineName, d.Diagnose, d.Severity, p.PrescriptionDateTime, p.Dosage
        FROM Prescription p 
        INNER JOIN Diagnoses d ON p.DiagnoseID = d.DiagnoseID
        INNER JOIN Medicines m ON p.MedicineID = m.MedicineID
        WHERE m.MedicineName LIKE '%' + @medine + '%'
    )
    SELECT MedicineName, Diagnose, Severity, PrescriptionDateTime, Dosage
    FROM PrescriptionCTE
    ORDER BY PrescriptionDateTime;
END;

EXEC GetPrescribedMedicines @medine = 'insulin';


-- 4b Return List of diagnoses and Allergy for patients who has appointment today
CREATE FUNCTION TodayAppointment (@patName VARCHAR(50))
RETURNS TABLE AS
	RETURN
		(
			SELECT p.FirstName +' ' + ISNULL(p.MiddleName, ' ') + p.LastName AS PatientName, d.Diagnose, al.AllergyName, al.Reactions, a.StartTime, a.EndTime
			FROM Patients p 
			INNER JOIN PatientsAllergy pa  ON p.PatientsID = pa.PatientID
			INNER JOIN Allergy al  ON pa.AllergyID = al.AllergyID	
			INNER JOIN AppointmentArchive aa ON p.PatientsID = aa.PatientID
			INNER JOIN Diagnoses d ON aa.AppointmentID = d.AppointmentID
			INNER JOIN Appointments a  ON a.PatientID = p.PatientsID
			WHERE p.FirstName +' ' + ISNULL(p.MiddleName, ' ') + p.LastName LIKE '%'+ @patName+ '%'
				AND CONVERT(DATE, a.AppointmentDate) = CONVERT(DATE, GETDATE())
		);
Select * from dbo.TodayAppointment('David')


--4c. Create Procedure to Update Doctors table
CREATE PROCEDURE UpdateDoctor
    @DepartmentID INT = NULL, @FirstName VARCHAR(50) = NULL, @MiddleName VARCHAR(50) = NULL, 
    @LastName VARCHAR(50) = NULL,@AvailabilityStatus VARCHAR(50) = NULL, @DateOfBirth DATETIME = NULL, 
    @Gender NVARCHAR(10) = NULL, @MedicalLicenseNumber NVARCHAR(50) = NULL,
    @Specialization VARCHAR(50) = NULL, @EmailAddress NVARCHAR(100) = NULL, 
    @TelephoneNumber NVARCHAR(20) = NULL, @EmploymentDate DATE = NULL,
    @TerminationDate DATE = NULL, @AddressID INT = NULL,  @CredentialID INT = NULL,  @SearchName VARCHAR(50) = NULL
AS
BEGIN
    IF @SearchName IS NOT NULL
    BEGIN
        UPDATE Doctors
        SET DepartmentID = COALESCE(@DepartmentID, DepartmentID),
            FirstName = COALESCE(@FirstName, FirstName), MiddleName = COALESCE(@MiddleName, MiddleName),
            LastName = COALESCE(@LastName, LastName), AvailabilityStatus = COALESCE(@AvailabilityStatus, AvailabilityStatus),
            DateOfBirth = COALESCE(@DateOfBirth, DateOfBirth), Gender = COALESCE(@Gender, Gender),
            MedicalLicenseNumber = COALESCE(@MedicalLicenseNumber, MedicalLicenseNumber),
            Specialization = COALESCE(@Specialization, Specialization), EmailAddress = COALESCE(@EmailAddress, EmailAddress),
            TelephoneNumber = COALESCE(@TelephoneNumber, TelephoneNumber),  EmploymentDate = COALESCE(@EmploymentDate, EmploymentDate),
            TerminationDate = COALESCE(@TerminationDate, TerminationDate),  AddressID = COALESCE(@AddressID, AddressID),
            CredentialID = COALESCE(@CredentialID, CredentialID)
        WHERE FirstName + ' ' + ISNULL(MiddleName, '') + ' ' + LastName LIKE '%' + @SearchName + '%';
    END
END;

EXEC dbo.UpdateDoctor @SearchName = 'Emily', @FirstName = 'Luke'
SELECT * FROM Doctors


-- 4.d Create Procedure for DEleteing completed appointments
CREATE PROCEDURE DeleteCompletedAppointments
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Appointments
    WHERE Status = 'Completed';
END;
EXEC DeleteCompletedAppointments;


-- 5 Create a view that shows doctor past and current appointment.
CREATE VIEW DoctorAppointmentsView AS
SELECT 
    d.FirstName + ' ' + ISNULL(d.MiddleName, '') + ' ' + d.LastName AS DoctorName,
    d.Specialization, dep.DepartmentName, 'Current' AS AppointmentType,
    aa.AppointmentID, aa.PatientID, aa.AppointmentDate, aa.StartTime, aa.EndTime,
    aa.ReasonForVisit, aa.Status, aa.ReasonForCancellation, aa.CancellationDate,
    r.Ratings, r.Feedback
FROM 
    Doctors d  INNER JOIN 
    Departments dep ON d.DepartmentID = dep.DepartmentID
LEFT JOIN   AppointmentArchive aa ON d.DoctorID = aa.DoctorID
LEFT JOIN  Reviews r ON aa.AppointmentID = r.AppointmentID
UNION
SELECT 
    d.FirstName + ' ' + ISNULL(d.MiddleName, '') + ' ' + d.LastName AS DoctorName,
    d.Specialization, dep.DepartmentName,  'Previous' AS AppointmentType, a.AppointmentID,
    a.PatientID, a.AppointmentDate, a.StartTime, a.EndTime, a.ReasonForVisit,
    a.Status, a.ReasonForCancellation, a.CancellationDate, r.Ratings, r.Feedback
FROM 
    Doctors d
INNER JOIN   Departments dep ON d.DepartmentID = dep.DepartmentID
LEFT JOIN   Appointments a ON d.DoctorID = a.DoctorID
LEFT JOIN   Reviews r ON a.AppointmentID = r.AppointmentID;

SELECT * FROM DoctorAppointmentsView;

-- 6 Create a trigger to update appointment status
CREATE TRIGGER MoveCancelledAppointmentToArchiveTrigger
ON Appointments
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(Status)
    BEGIN
        -- Insert cancelled appointments into the AppointmentArchive table
        INSERT INTO AppointmentArchive (AppointmentID, PatientID, DoctorID, AppointmentDate, StartTime, EndTime, ReasonForCancellation, CancellationDate, Status, ReasonForVisit)
        SELECT AppointmentID, PatientID, DoctorID, AppointmentDate, StartTime, EndTime, ReasonForCancellation, CancellationDate, Status, ReasonForVisit
        FROM inserted
        WHERE Status = 'Cancelled';

        -- Delete cancelled appointments from the Appointments table
        DELETE FROM Appointments WHERE Status = 'Cancelled';
    END
END;

UPDATE Appointments
SET Status = 'Cancelled'
WHERE AppointmentID = 13;

select * from AppointmentArchive


--7  Count of Completed Appointments for Gastroenterologists
SELECT COUNT(*) AS CompletedAppointments
FROM DoctorAppointmentsView
WHERE AppointmentType = 'Current'
    AND Status = 'Completed'
    AND Specialization = 'Gastroenterologist';





---ADDITIONAL FUNCTIONALITIES FOR UPDATING APPOINTMENT STATUS 
CREATE PROCEDURE UpdateAppointmentsStatus 
    @status VARCHAR(20), @appid INT= NULL , @patid INT = NULL
AS
BEGIN
    UPDATE Appointments
    SET Status = @status,
        EndTime = CAST(GETDATE() AS TIME)
		WHERE AppointmentID = @appid
END;
EXEC dbo.UpdateAppointmentsStatus @status = 'Pending', @appid = 12


-- Create A Trigger To Move Deleted Completed Appointments To AppointmentArchieve.
CREATE TRIGGER MoveToAppointmentArchive
ON Appointments
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO AppointmentArchive (AppointmentID, PatientID, DoctorID, AppointmentDate, StartTime, EndTime, ReasonForVisit, Status, ReasonForCancellation, CancellationDate)
        SELECT AppointmentID, PatientID, DoctorID, AppointmentDate, StartTime, GETDATE(), ReasonForVisit, Status, ReasonForCancellation, CancellationDate
        FROM deleted
        WHERE Status = 'Completed';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
-- Raise an error and print error message for any issue while the trigger is working.

        PRINT ERROR_MESSAGE();
    END CATCH;
END;


-- BackUp Data base
BACKUP DATABASE [SalfordMetroHospital]
TO DISK = 'C:\Backup\SalfordMetroHospitalBackup.bak';


-- Enable 'show advanced options'
EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE WITH OVERRIDE;
GO

-- Enable 'Agent XPs'
EXEC sp_configure 'Agent XPs', 1;
GO
RECONFIGURE WITH OVERRIDE;
GO