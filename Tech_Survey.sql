/****** Script for SelectTopNRows command from SSMS  ******/
select  * from dbo.techdata
;

--What is the average monthly revenue for each education level?
with cte as (
SELECT EducationLevel,
case when AverageMonthlyRevenueInGel like '%k-%' then cast(SUBSTRING(AverageMonthlyRevenueInGel,1,CHARINDEX('-',AverageMonthlyRevenueInGel,1)-2)as int)*1000 
when AverageMonthlyRevenueInGel  like '%[0-9]-%' then cast(SUBSTRING(AverageMonthlyRevenueInGel,1,CHARINDEX('-',AverageMonthlyRevenueInGel,1)-1)as int)
when AverageMonthlyRevenueInGel like '%k+' then 0

end as a,

case when AverageMonthlyRevenueInGel like '%k-%' then cast(SUBSTRING(AverageMonthlyRevenueInGel,CHARINDEX('-',AverageMonthlyRevenueInGel,1)+1,CHARINDEX('k',AverageMonthlyRevenueInGel,CHARINDEX('-',AverageMonthlyRevenueInGel,1))-CHARINDEX('-',AverageMonthlyRevenueInGel,1)-1) as int)*1000 
when AverageMonthlyRevenueInGel  like '0-500' then cast(SUBSTRING(AverageMonthlyRevenueInGel,CHARINDEX('-',AverageMonthlyRevenueInGel,1)+1,LEN(AverageMonthlyRevenueInGel))as int)
when AverageMonthlyRevenueInGel  like '500-1k' then cast(SUBSTRING(AverageMonthlyRevenueInGel,CHARINDEX('-',AverageMonthlyRevenueInGel,1)+1,1)as int)*1000

when AverageMonthlyRevenueInGel like '%k+' then cast(SUBSTRING(AverageMonthlyRevenueInGel,1,CHARINDEX('k',AverageMonthlyRevenueInGel,1)-1)as int)*1000
end as b

FROM dbo.techdata
WHERE AverageMonthlyRevenueInGel is not null and
EducationLevel is not null and EducationLevel <>N'არ უპასუხია'
and AverageMonthlyRevenueInGel <>N'არ უპასუხია'
and AverageMonthlyRevenueInGel <>N'არ ვარ დასაქმებული'
)

select EducationLevel,AVG(a+b) as salary from cte
group by EducationLevel
order by salary desc

--salary by coding language
with cte as (
SELECT CurrentLanguage,
case when AverageMonthlyRevenueInGel like '%k-%' then cast(SUBSTRING(AverageMonthlyRevenueInGel,1,CHARINDEX('-',AverageMonthlyRevenueInGel,1)-2)as int)*1000 
when AverageMonthlyRevenueInGel  like '%[0-9]-%' then cast(SUBSTRING(AverageMonthlyRevenueInGel,1,CHARINDEX('-',AverageMonthlyRevenueInGel,1)-1)as int)
when AverageMonthlyRevenueInGel like '%k+' then 0

end as a,

case when AverageMonthlyRevenueInGel like '%k-%' then cast(SUBSTRING(AverageMonthlyRevenueInGel,CHARINDEX('-',AverageMonthlyRevenueInGel,1)+1,CHARINDEX('k',AverageMonthlyRevenueInGel,CHARINDEX('-',AverageMonthlyRevenueInGel,1))-CHARINDEX('-',AverageMonthlyRevenueInGel,1)-1) as int)*1000 
when AverageMonthlyRevenueInGel  like '0-500' then cast(SUBSTRING(AverageMonthlyRevenueInGel,CHARINDEX('-',AverageMonthlyRevenueInGel,1)+1,LEN(AverageMonthlyRevenueInGel))as int)
when AverageMonthlyRevenueInGel  like '500-1k' then cast(SUBSTRING(AverageMonthlyRevenueInGel,CHARINDEX('-',AverageMonthlyRevenueInGel,1)+1,1)as int)*1000

when AverageMonthlyRevenueInGel like '%k+' then cast(SUBSTRING(AverageMonthlyRevenueInGel,1,CHARINDEX('k',AverageMonthlyRevenueInGel,1)-1)as int)*1000
end as b

FROM dbo.techdata
WHERE CurrentLanguage is not null 
and AverageMonthlyRevenueInGel is not null 
and AverageMonthlyRevenueInGel <>N'არ უპასუხია'
and AverageMonthlyRevenueInGel <>N'არ ვარ დასაქმებული'
and CurrentLanguage<>N'არ უპასუხია'
and CurrentLanguage<>N'არც ერთს')
select CurrentLanguage,AVG(a+b) as salary,count(*)as number_of_users from cte
group by CurrentLanguage
having count(*)>10
order by salary desc


--salary by Experience language
with cte as (
SELECT Experience,
case when AverageMonthlyRevenueInGel like '%k-%' then cast(SUBSTRING(AverageMonthlyRevenueInGel,1,CHARINDEX('-',AverageMonthlyRevenueInGel,1)-2)as int)*1000 
when AverageMonthlyRevenueInGel  like '%[0-9]-%' then cast(SUBSTRING(AverageMonthlyRevenueInGel,1,CHARINDEX('-',AverageMonthlyRevenueInGel,1)-1)as int)
when AverageMonthlyRevenueInGel like '%k+' then 0

end as a,

case when AverageMonthlyRevenueInGel like '%k-%' then cast(SUBSTRING(AverageMonthlyRevenueInGel,CHARINDEX('-',AverageMonthlyRevenueInGel,1)+1,CHARINDEX('k',AverageMonthlyRevenueInGel,CHARINDEX('-',AverageMonthlyRevenueInGel,1))-CHARINDEX('-',AverageMonthlyRevenueInGel,1)-1) as int)*1000 
when AverageMonthlyRevenueInGel  like '0-500' then cast(SUBSTRING(AverageMonthlyRevenueInGel,CHARINDEX('-',AverageMonthlyRevenueInGel,1)+1,LEN(AverageMonthlyRevenueInGel))as int)
when AverageMonthlyRevenueInGel  like '500-1k' then cast(SUBSTRING(AverageMonthlyRevenueInGel,CHARINDEX('-',AverageMonthlyRevenueInGel,1)+1,1)as int)*1000

when AverageMonthlyRevenueInGel like '%k+' then cast(SUBSTRING(AverageMonthlyRevenueInGel,1,CHARINDEX('k',AverageMonthlyRevenueInGel,1)-1)as int)*1000
end as b

FROM dbo.techdata
WHERE Experience is not null 
and AverageMonthlyRevenueInGel is not null 
and AverageMonthlyRevenueInGel <>N'არ უპასუხია'
and AverageMonthlyRevenueInGel <>N'არ ვარ დასაქმებული'
and Experience<>N'არ მაქვს'
)
select Experience,AVG(a+b) as salary,count(*)as number_of_users from cte
group by Experience
having count(*)>10
order by salary desc
