create database metrics


create table EmployeeDetails
(
EmployeeName varchar(max),
ApplicationName varchar(max),
TaskDescription varchar(max),
TaskClassification varchar(max),
AssignedDate varchar(max),
CompletedDate varchar(max),
EffortHours int,
StatusOfTask varchar(max),
AssignedTo varchar(max),
Validationf varchar(max)
)

GO
alter procedure InsertIntoEmployeeDetails
(
@EmployeeName varchar(max),
@ApplicationName varchar(max),
@TaskDescription varchar(max),
@TaskClassification varchar(max),
@AssignedDate varchar(max),
@CompletedDate varchar(max),
@EffortHours int,
@StatusOfTask varchar(max),
@AssignedTo varchar(max),
@Validationf varchar(max)
)
as
begin
insert into EmployeeDetails values(@EmployeeName,@ApplicationName,@TaskDescription,@TaskClassification,@AssignedDate,@CompletedDate,@EffortHours,@StatusOfTask,@AssignedTo,@Validationf)
end
GO

create table vacationDates
(
EmployeeName varchar(max),
StartDate varchar(max),
EndDate varchar(max),
NumberOfDates int,
Weekend varchar(max) null
)

drop table vacationDates
GO
alter procedure insertintovacationDates
(
@EmployeeName varchar(max),
@StartDate varchar(max),
@EndDate varchar(max),
@NumberOfDates int,
@Weekend varchar(max)
)
as
begin
insert into vacationDates values(@EmployeeName,@StartDate,@EndDate,@NumberOfDates,@Weekend)
end


create table FillHoursTable
(
EmployeeName varchar(max),
MetricsHours int,
CatwHours int
)

GO

create procedure insertintoFillHoursTable
(
@EmployeeName varchar(max),
@MetricsHours int,
@CatwHours int
)
as
begin
insert into FillHoursTable values(@EmployeeName,@MetricsHours,@CatwHours)
end

GO

create procedure insertintoFillHoursTableNoMetrics
(
@EmployeeName varchar(max)
)
as
begin
insert into FillHoursTable values(@EmployeeName,0,0)
end

GO

create procedure UpdateFillHoursTable(@EmployeeName varchar(max),@CatwHours int)as
begin
update FillHoursTable set CatwHours=@CatwHours where EmployeeName=@EmployeeName
end

select distinct EmployeeName from EmployeeDetails
select * from EmployeeDetails where validationf!='valid'
delete from EmployeeDetails
select * from vacationDates
delete from vacationDates
select * from FillHoursTable
delete from FillHoursTable

GO

create procedure GettingMissMathedEmployees as
begin
select * from FillHoursTable fh
where fh.MetricsHours!=fh.CatwHours
end

GO

alter procedure DeleteMetrics as
begin
delete from EmployeeDetails
delete from vacationDates
delete from FillHoursTable
end

GO

alter procedure statussheet as begin
select distinct ed.EmployeeName,ApplicationName,CatwHours from EmployeeDetails ed,FillHoursTable ft
where ed.EmployeeName=ft.EmployeeName
order by ed.EmployeeName
end

GO

alter procedure teamleavedetails as begin
select distinct ed.ApplicationName,vd.EmployeeName,cast(vd.StartDate as date) as StartDate,cast(vd.EndDate as date) as EndDate,vd.NumberOfDates,vd.Weekend
from vacationDates vd,EmployeeDetails ed
where vd.EmployeeName=ed.EmployeeName
order by vd.EmployeeName
end

GO

alter PROCEDURE Metrics as BEGIN
SELECT ApplicationName,TaskDescription,TaskClassification,cast(AssignedDate as date) as StartDate,cast(CompletedDate as date) as EndDate,EffortHours,StatusOfTask,AssignedTo FROM EmployeeDetails
order by AssignedTo
end

Go
