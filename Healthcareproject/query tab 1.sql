CREATE DATABASE health_data;

-- count & percentage of M&F that have ocd and avg obsession score per year
with data as(
select Gender,count(`Patient ID`)as patient_count , avg(`Y-BOCS Score (Obsessions)`)as avg_obs_score from health_data.ocd_patient_dataset
group by 1
order by 2)

select
sum(case when Gender = 'Female' then patient_count else 0 end)as count_female,
sum(case when Gender = 'Male' then patient_count else 0 end)as count_male,

round(sum(case when Gender = 'Female' then patient_count else 0 end)/
(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end))*100,2) as pct_female,

round(sum(case when Gender = 'Male' then patient_count else 0 end)/
(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end))*100,2) as pct_male

from data;

-- count of patients by ethnicity and thier respective avg obss score
select Ethnicity,count(`Patient ID`) as patient_count, avg(`Y-BOCS Score (Obsessions)`)as obs_score
from health_data.ocd_patient_dataset
group by 1
order by 2;

-- number of people diagnosed with OCD MoM
alter table health_data.ocd_patient_dataset
modify `OCD Diagnosis Date` date;
select date_format(`OCD Diagnosis Date`,'%Y-%m-01 00:00') as month,
count(`Patient ID`)as patient_count
from health_data.ocd_patient_dataset
group by 1
order by 1;

-- what is the most common obsession type and its respective avg obss score
select `Obsession Type`,
count(`Patient ID`)as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
from health_data.ocd_patient_dataset
group by 1
order by 2;

-- what is the most common compulsion type and its respective obss score
select `Compulsion Type`,
count(`Patient ID`)as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
from health_data.ocd_patient_dataset
group by 1
order by 2;