SELECT * FROM project_medical_data_history.admissions;

select* from admissions;
select*from doctors;
select*from patients;
select*from province_names;

 -- 1. Show first name, last name, and gender of patients who's gender is 'M'
 select First_name, last_name,gender from patients where gender = 'M'; 

 -- 2. Show first name and last name of patients who does not have allergies.
 select first_name, last_name from patients where allergies is null; 
 
 -- 3. Show first name of patients that start with the letter 'C'
 select first_name from patients where first_name like 'c%'; 
 
 -- 4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
 select first_name, last_name from patients where weight between 100 and 120;
 select first_name, last_name from patients where weight >100 and weight <120;
 
 -- 5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
 update patients set allergies = 'NKA' where allergies is null; -- we can't update 
 
select patient_id, coalesce(allergies, 'NKA') as allergies from patients;


 -- 6. Show first name and last name concatenated into one column to show their full name.
 select concat(first_name,' ',last_name) as full_name from patients;
 
 -- 7. Show first name, last name, and the full province name of each patient.
 select pat.first_name, pat.last_name, pr.province_name from patients pat join province_names pr on pat.province_id = pr.province_id;
 
 -- 8. Show how many patients have a birth_date with 2010 as the birth year.
 select*from patients;
 select count(birth_date) as birth_day  from patients where birth_date like '2010%';
 select count(birth_date) as birth_day from patients where year(birth_date)=2010;-- 2th type
 
 -- 9. Show the first_name, last_name, and height of the patient with the greatest height.

SELECT first_name, last_name, max(height) as height
FROM patients
group by first_name, last_name
ORDER BY height DESC
LIMIT 1;
 
select first_name, last_name,height from patients where height=(Select max(height) from patients);
 
-- 10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
select* from patients where patient_id in (1,45,534,879,1000);

-- 11. Show the total number of admissions
select count(*) from admissions;

-- 12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
select* from admissions where date(admission_date) = date(discharge_date);
SELECT * FROM admissions WHERE DATEDIFF(discharge_date, admission_date) = 0;
select* from admissions where admission_date=discharge_date;


-- 13. Show the total number of admissions for patient_id 579.
select count(*) as Total from admissions where patient_id = '579';

-- 14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
select distinct(city),province_id from patients where province_id='NS';

-- 15. Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70
select first_name, last_name, birth_date, height, weight  from patients where height >160 and weight >70;

-- 16. Show unique birth years from patients and order them by ascending.
select distinct year (birth_date) from patients order by year (birth_date) asc;

-- 17. Show unique first names from the patients table which only occurs once in the list.
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(*) = 1;

select distinct(first_name) as tt from patients group by tt having count(*) = 1;

-- 18. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select patient_id, first_name from patients where first_name like 's____%s';

-- 19. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table.
select a.patient_id, a.first_name, a.last_name, b.diagnosis from patients a
join admissions b
on a.patient_id = b.patient_id
where b.diagnosis = 'Dementia';

-- 20. Display every patient's first_name. Order the list by the length of each name and then by alphbetically.
select first_name from patients
order by len(first_name) asc, first_name asc; -- command denied

select distinct(first_name) from patients
order by length(first_name) asc, first_name asc;

-- 21. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
select
(select count(*) from patients where gender = 'M') as total_male,
(select count(*) from patients where gender = 'F') as total_female; 

--  22. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
select
(select count(*) from patients where gender = 'M') as Total_Male,
(select count(*) from patients where gender = 'F') as Total_Female; 

-- 23. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select* from admissions;
select* from patients;

select patient_id, diagnosis from admissions
group by patient_id, diagnosis
having count(patient_id and diagnosis)>1;

-- 24. Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
select city, count(patient_id) from patients
group by city
order by count(patient_id)desc, city asc ;

-- 25. Show first name, last name and role of every person that is either patient or doctor.    The roles are either "Patient" or "Doctor"
select* from admissions;
select*from doctors;
select*from patients;
select*from province_names;

select first_name, last_name, 'Patient' as 'Role' from patients
union all
select first_name, last_name, 'Doctor' from doctors;

---------------------------------------------------------------------
ALTER TABLE admission CHANGE attending_doctor_id doctor_id INT;-- it can't change the column name in admissions
---------------------------------------------------------------------


-- 26. Show all allergies ordered by popularity. Remove NULL values from query.
select allergies, count(allergies) as total from patients
group by allergies
having allergies is not null
order by count(allergies) desc;

-- 27. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select* from patients;

select first_name, last_name, birth_date from patients where year(birth_date) = '1970'
order by birth_date;

-- 28. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order    EX: SMITH,jane
select concat(upper(last_name), ',', lower(first_name)) as full_name
from patients
order by first_name desc;

-- 29. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select*from patients;
select*from province_names;

select province_id, sum(height) as total_height_of_patient
from patients
group by province_id
having total_height_of_patient >= 7000;

-- 30. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni
select last_name,max(weight), min(weight),max(weight)-min(weight) as sub
from patients
where last_name = 'Maroni';

-- 31. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select*from patients;
select* from admissions;

select day(admission_date) as date, count(admission_date) as admissions
from admissions
group by date
order by admissions desc;

-- 32. Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending. e.g. if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
select
case 
	when weight between 1 and 9 then "1 weight group"
	when weight between 10 and 19 then "10 weight group"
    	when weight between 20 and 29 then "20 weight group"
	when weight between 20 and 29 then "20 weight group"
	when weight between 30 and 39 then "30 weight group"
	when weight between 40 and 49 then "40 weight group"
	when weight between 50 and 59 then "50 weight group"
	when weight between 60 and 69 then "60 weight group"
	when weight between 70 and 79 then "70 weight group"
	when weight between 80 and 89 then "80 weight group"	
	when weight between 90 and 99 then "90 weight group"
    when weight between 100 and 109 then "100 weight group"
	when weight between 110 and 119 then "110 weight group"
	when weight between 120 and 129 then "120 weight group"
    when weight between 130 and 139 then "130 weight group"
    when weight between 140 and 149 then "140 weight group"
    else "other weight group"
end as weight_group, count(*) as tot_patients from patients
group by weight_group order by weight_group desc;

-- 33. Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in 
-- Generally, a Body Mass Index (BMI) of 30 or higher is considered obese

select patient_id, weight, height,
case
	when (weight/(height/100) >=30) then 1
else 0
end as 'isobese (1)/ not obese (0)'
from patients;
    


-- 34. Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. Check patients, admissions, and doctors tables for required information.
select p.patient_id, p.first_name, p.last_name, c.specialty from patients p
join admissions b on p.patient_id = b.patient_id
join doctors c on b.attending_doctor_id = c.doctor_id
where b.diagnosis = 'Epilepsy' and c.first_name = 'Lisa'; 		


 -- 35. All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

 -- The password must be the following, in order: 5, 20 ,23 , 25 , 28, 32
 -- patient_id
 -- the numerical length of patient's last_name
 -- year of patient's birth_date

 SELECT patient_id,CONCAT(patient_id, LENGTH(last_name), YEAR(birth_date)) AS temp_password FROM patients;

