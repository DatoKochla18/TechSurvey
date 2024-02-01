/****** Script for SelectTopNRows command from SSMS  ******/
select  * from dbo.techdata
;

--What is the average monthly revenue for each education level?


select top 10 EducationLevel,avg(dbo.AvgFromTextInput(AverageMonthlyRevenueInGel))as salary from techdata
WHERE AverageMonthlyRevenueInGel is not null and
EducationLevel is not null and EducationLevel <>N'არ უპასუხია'
and AverageMonthlyRevenueInGel <>N'არ უპასუხია'
and AverageMonthlyRevenueInGel <>N'არ ვარ დასაქმებული'
group by EducationLevel
order by salary desc

--salary by coding language
select CurrentLanguage,avg(dbo.AvgFromTextInput(AverageMonthlyRevenueInGel))as salary,count(*)as number_of_users from techdata
WHERE CurrentLanguage is not null 
and AverageMonthlyRevenueInGel is not null 
and AverageMonthlyRevenueInGel <>N'არ უპასუხია'
and AverageMonthlyRevenueInGel <>N'არ ვარ დასაქმებული'
and CurrentLanguage<>N'არ უპასუხია'
and CurrentLanguage<>N'არც ერთს'
group by CurrentLanguage
having count(*)>10
order by salary desc


--salary by Experience language
SELECT Experience,avg(dbo.AvgFromTextInput(AverageMonthlyRevenueInGel))as salary ,count(*) as number_of_people  from techdata
where  AverageMonthlyRevenueInGel is not null 
and AverageMonthlyRevenueInGel <>N'არ უპასუხია'
and AverageMonthlyRevenueInGel <>N'არ ვარ დასაქმებული'
and Experience not like N'%არ%'
group by Experience
having count(*)>1
order by salary desc
