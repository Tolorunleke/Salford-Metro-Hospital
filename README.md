# Salford Metro Hospital Database Development

This repository contains the resources and code for developing a comprehensive database solution for Salford Metro Hospital. The project represents a scenario-based consultancy requirement where a hospital seeks to build a secure and efficient database system from scratch, ensuring robust data management, ongoing maintenance, and stringent security measures to protect sensitive patient information.

## 📊 Project Overview

### 🔍 Database Design and Development
- A Microsoft Management Studio database was created, following a structured design approach to meet the hospital's needs:
  - **Normalization**: The database was normalized to the third normal form (3NF) to minimize redundancy and ensure data integrity.
  - **Entity Relationship Diagrams (ERDs)**: Developed comprehensive ERDs to illustrate the relationships between entities such as patients, doctors, appointments, and medical records, facilitating easy navigation and understanding of the database structure.

### 🛠️ Functional Implementations
- Several critical functions and procedures were implemented to enhance hospital operations:
  - **Appointment Bookings**: Designed functions to manage patient appointments efficiently.
  - **Doctor Availability**: Developed procedures for real-time updates and management of doctor schedules.
  - **Patient Schedules and Records**: Created tables and processes to manage patient schedules, historical diagnoses, and ongoing prescriptions, ensuring continuity of care.
- These implementations optimize operational efficiency by automating manual tasks and improving workflow management.

### 🔐 Security Measures
- **Data Security**: Applied SHA2_256 hashing techniques to secure sensitive patient data and sign-in credentials.
- **Backup and Recovery**: Established a reliable backup and maintenance schedule to ensure data safety, recoverability, and compliance with healthcare regulations.

### 📂 Tools and Technologies Used
- **Microsoft SQL Server Management Studio (SSMS)**: Utilized for database creation, management, and normalization.
- **SQL Scripting**: Developed SQL scripts for creating tables, defining relationships, and implementing stored procedures for various operational needs.
- **Data Security Techniques**: Implemented SHA2_256 hashing for enhanced data protection.
- **Backup and Maintenance**: Created and managed database backups (`SalfordMetroHospitalBackup.bak`) to maintain data integrity and enable recovery.

### 🎯 Key Results and Insights
- **Optimized Database Structure**: The normalization and structured design improved data integrity, reduced redundancy, and enhanced data retrieval efficiency.
- **Operational Efficiency**: Automating scheduling and record management functions significantly streamlined hospital operations, reduced errors, and saved time.
- **Enhanced Security**: Robust security protocols were put in place, securing patient data and meeting compliance standards.

## 🚀 Getting Started

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Tolorunleke/Salford-Metro-Hospital-Database.git

2. **Set Up the Database**:
- Use Microsoft SQL Server Management Studio (SSMS) to restore the provided database backup file (`SalfordMetroHospitalBackup.bak`).
- Run the SQL scripts (`00714527_Task1.sql`) to create tables, establish relationships, and implement procedures.

### Review the Entity Relationship Diagram (ERD)

- Refer to the provided ERD image below to understand the database schema and relationships.

   ![Entity Relationship Diagram](Salford_Hospital_ER_Diagram.png)

## 📂 Files Included

- **SQL Script (`00714527_Task1.sql`)**: Contains SQL commands for creating tables, relationships, and procedures.
- **Database Backup (`SalfordMetroHospitalBackup.bak`)**: A full backup of the database for restoration purposes.
- **Entity Relationship Diagram (`Salford_Hospital_ER_Diagram.png`)**: Visual representation of the database schema.

## 📈 Future Enhancements

- **Expand Security Measures**: Implement advanced encryption techniques for sensitive data.
- **Integrate Real-Time Analytics**: Develop dashboards to provide insights into hospital operations, patient flow, and resource utilization.
- **Optimize Performance**: Continuously monitor and optimize query performance to handle increased data volumes as the hospital grows.
