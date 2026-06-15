create database Covid_Analytics;
use Covid_Analytics;
create table Patients(
patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    city VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    admission_date DATE,
    discharge_date DATE,
    status VARCHAR(20)
);

select * from patients;

INSERT INTO Patients VALUES
(1, 'Aman Sharma', 'Delhi', 28, 'Male', '2025-01-02', '2025-01-10', 'Recovered'),
(2, 'Sara Khan', 'Mumbai', 45, 'Female', '2025-01-05', '2025-01-20', 'Recovered'),
(3, 'Rohit Verma', 'Delhi', 60, 'Male', '2025-02-01', NULL, 'Critical'),
(4, 'Neha Singh', 'Bangalore', 35, 'Female', '2025-02-12', '2025-02-18', 'Recovered'),
(5, 'Ali Hassan', 'Mumbai', 52, 'Male', '2025-03-01', NULL, 'Critical');


CREATE TABLE CovidCases (
    case_id INT PRIMARY KEY,
    patient_id INT,
    test_date DATE,
    severity VARCHAR(20),
    oxygen_required VARCHAR(10),
    hospital_bill DECIMAL(10,2),
    vaccination_status VARCHAR(20),

    FOREIGN KEY (patient_id)
    REFERENCES Patients(patient_id)
);
select* from covidcases;

INSERT INTO CovidCases VALUES
(101, 1, '2025-01-02', 'Moderate', 'No', 50000, 'Vaccinated'),
(102, 2, '2025-01-05', 'Severe', 'Yes', 120000, 'Vaccinated'),
(103, 3, '2025-02-01', 'Critical', 'Yes', 250000, 'Not Vaccinated'),
(104, 4, '2025-02-12', 'Mild', 'No', 30000, 'Vaccinated'),
(105, 5, '2025-03-01', 'Critical', 'Yes', 280000, 'Not Vaccinated');


select sum(hospital_bill) as total_revenue from covidcases;

select avg(hospital_bill) as avg_cost from covidcases;

SELECT p.city, COUNT(*) AS total_cases
FROM Patients p
JOIN CovidCases c
ON p.patient_id=c.patient_id
GROUP BY p.city
ORDER BY total_cases DESC;

SELECT vaccination_status, COUNT(*) AS total
FROM CovidCases
GROUP BY vaccination_status;

select status, count(*) as total
from patients
group by status;
select avg(age) as avg_age
from patients;

select age, count(age) as total_patients
from patients group by age
order by total_patients desc;

SELECT COUNT(*) AS critical_cases
FROM Patients
WHERE status='Critical';

SELECT COUNT(*) AS oxygen_patients
FROM CovidCases
WHERE oxygen_required='Yes';


SELECT MAX(hospital_bill) AS highest_bill
FROM CovidCases;

SELECT MONTHNAME(admission_date) AS month,
COUNT(*) AS admissions
FROM Patients
GROUP BY month;

select gender,
count(*) as total
from patients
group by gender;

select avg(datediff(discharge_date,admission_date))
as avg_stay_days
from patients
where discharge_date is not null;

select Severity,
count(*) as total_cases
from covidcases
group by Severity;

select p.city,
sum(c.hospital_bill) as total_revenue
from patients p
join covidcases c 
on p.patient_id=c.patient_id
group by p.city;

SELECT patient_name,
hospital_bill,
RANK() OVER(ORDER BY hospital_bill DESC) AS rnk
FROM Patients p
JOIN CovidCases c
ON p.patient_id=c.patient_id
LIMIT 3;


select patient_name,
city
from patients p 
join covidcases c 
on p.patient_id=c.patient_id
WHERE vaccination_status='Not Vaccinated'
AND severity='Critical';

SELECT COUNT(*)*100/
(SELECT COUNT(*) FROM CovidCases)
AS mild_percentage
FROM CovidCases
WHERE severity='Mild';

SELECT p.city,
AVG(c.hospital_bill) AS avg_bill
FROM Patients p
JOIN CovidCases c
ON p.patient_id=c.patient_id
GROUP BY p.city;

SELECT vaccination_status,
AVG(hospital_bill) AS avg_cost
FROM CovidCases
GROUP BY vaccination_status;












