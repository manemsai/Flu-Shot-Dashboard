select *
from public.conditions
where code in ('585.1','585.2','585.3','585.4')

select city,count(*) as no_patients from patients
group by city
having count(*) >100
order by count(*) desc


/*
-- dashboard for 2022 
1.total % of patients getting stratified by 
a.age
b.race
c.county(on map)
d.overall
2.running total of flue shots over  the course of 2022
3. total no of flu shots given in 2022
4. a list of patients that show wheather or not flu shots were recieved 
"requirements must be admitted in the hospital"
*/
with acive_patients as
(
select patient
from encounters

)


with flu_shot_2022 as
(
select patient,min(date) earlist_flu_shot from public.immunizations
where code='5302' and date between'2022-01-01 00:00' and '2022-12-31 23:59'
group by patient
)
select pt.id,pt.first,pt.last,pt.birthdate,pt.race,pt.county,earlist_flu_shot,case when fl.patient is not null then 1 else 0 end as flus_shot_2022 from patients as pt
left join flu_shot_2022 fl
on pt.id=fl.patient

