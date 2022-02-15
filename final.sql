--firstly we will just have an overlook on  the data and its records

select * from [dbo].[IDS_ALLCountries_Data]

select * from [dbo].[IDS_Series-TimeMetaData]

select * from [dbo].[IDS_CountryMetaData]

select * from [dbo].[IDS_Country-SeriesMetaData] 


-- now we will get number of countries in data

select count(distinct(Code)) from IDS_CountryMetaData 

-- now we will get debt indicators

select count(distinct(Code) ) from [dbo].[IDS_SeriesMetaData]

-- now we will get total debt and stored it into another new table

create table totaldebtdata
(country_name nvarchar(50),
country_code nvarchar(50),
series_name nvarchar(155),
series_code nvarchar(155),
totaldebt numeric
)
insert into totaldebtdata
select column1, column2, column5,column6, coalesce( column7 , 0) + coalesce(column8,0) + coalesce(column9,0)+ coalesce(column10,0) + coalesce(column11,0)+ coalesce(column11,0)+coalesce(column12,0)+coalesce(column13,0)+coalesce(column14,0)+coalesce(column15,0)+coalesce(column16,0)+coalesce(column17,0)+coalesce(column18,0)+coalesce(column19,0)+coalesce(column20,0)+coalesce(column21,0)+coalesce(column22,0)+coalesce(column23,0)+coalesce(column24,0)+coalesce(column25,0)+coalesce(column26,0)+coalesce(column27,0)+coalesce(column28,0)+coalesce(column29,0)+coalesce(column30,0)+coalesce(column31,0)+coalesce(column32,0)+coalesce(column33,0)+coalesce(column34,0)+coalesce(column35,0)+coalesce(column36,0)+coalesce(column37,0)+coalesce(column38,0)+coalesce(column39,0)+coalesce(column40,0)+coalesce(column41,0)+coalesce(column42,0)+coalesce(column43,0)+coalesce(column44,0)+coalesce(column45,0)+coalesce(column46,0)+coalesce(column47,0)+coalesce(column48,0)+coalesce(column49,0)+coalesce(column50,0)+coalesce(column51,0)+coalesce(column52,0)+coalesce(column53,0)+coalesce(column54,0)+coalesce(column55,0)+coalesce(column56,0)+coalesce(column57,0)+coalesce(column58,0)+coalesce(column59,0)+coalesce(column60,0)+coalesce(column61,0)+coalesce(column62,0)+coalesce(column63,0)+coalesce(column64,0)+coalesce(column65,0)
as total
from [dbo].[IDS_ALLCountries_Data]



-- now we will remove unwanted data of debt and stored it countrywise in another table

create table finaldebt
(
country_name nvarchar(50),
totaldebt numeric,
long_name nvarchar(50),
code nvarchar(50),

 )

insert into finaldebt
select totaldebtdata.country_name,totaldebtdata.totaldebt,tb1.Long_Name, tb1.Code
from tb1
inner join totaldebtdata on totaldebtdata.country_code = tb1.Code


--now we will get data for principal repayments
create table principalrepayment
( code nvarchar(50),
   Indicator_Name nvarchar(155))

   insert into principalrepayment
select Code, Indicator_Name from [dbo].[IDS_SeriesMetaData] where Indicator_Name like 'Principal repayments%'


-- now we will get data for total debt

select sum(totaldebt) form finaldebt 


-- now we will create final table for visualization 

create table vizdata
( country_name nvarchar(50),
series_code nvarchar(50),
series_Name nvarchar (155),
debt numeric)

insert into vizdata
select  totaldebtbycountry.country_name, totaldebtdata.series_code, totaldebtdata.series_name,totaldebtbycountry.totaldebt
from totaldebtdata
inner join totaldebtbycountry on totaldebtdata.country_name = totaldebtbycountry.country_name

select * from vizdata
