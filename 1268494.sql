--answer the question no 1 (a)--

create database CollegeDB
on
(
	name='CollegeDB_Data_1',
	filename='C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\CollegeDB_Data_1.mdf',
	size= 25mb,
	maxsize=100mb,
	filegrowth=5%
)
Log on
(
	name='CollegeDB_Log_1',
	filename='C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\CollegeDB_Log_1.lodf',
	size= 2mb,
	maxsize=50mb,
	filegrowth=1mb
)
go
use CollegeDB
go
--answer the question no 1 (b)--
---insert all record into tables script--
create table Teachers
(
	teacherid int primary key,
	teachername nvarchar(40) not null
)
go
create table Semesters
(
	semesterid int primary key,
	semsetername nvarchar(40) not null
)
go
create table Students
(
	studentid int primary key,
	studentname nvarchar(40) not null,
	semesterid int not null references Semesters (semesterid)
)
go
create table Subjects
(
	subjectid int primary key,
	subjectname nvarchar(40) not null,
	teacherid int not null references teachers (teacherid)
)
go
create table StudentSubject
(
	studentid int not null references Students (studentid),
	subjectid int not null references Subjects (subjectid),
	primary key (studentid,subjectid)
	
)
go
---insert all record into tables script--
insert into Teachers values
(1,'A'),
(2,'B'),
(3,'C'),
(4,'D'),
(5,'E')
go
select *
from Teachers
go
insert into Semesters values
(1,'spring'),
(2,'summer'),
(3,'fall'),
(4,'winter'),
(5,'fall')
go
select *
from Semesters
go
insert into Students values
(1,'s1',1),
(2,'s2',1),
(3,'s3',3),
(4,'s4',2),
(5,'s5',4)
go
select *
from Students
go
insert into Subjects values
(1,'C#',2),
(2,'DATABASE',1),
(3,'WEB DESIGN',4),
(4,'C#',3),
(5,'DATABASE',5)
go
select *
from Subjects
go
insert into StudentSubject values
(1,1),
(1,2),
(2,3),
(3,1),
(4,4)
go
select *
from StudentSubject
go

select t.teachername,s.subjectname,st.studentname,sm.semsetername
from Teachers t
inner join Subjects s on t.teacherid=s.teacherid
inner join StudentSubject ss on s.subjectid= ss.subjectid
inner join Students st on ss.studentid=st.studentid
inner join Semesters sm on st.semesterid=sm.semesterid
go

--answer the question no 2 (a)--
select st.studentid,sm.semsetername, count(s.subjectid) as 'count'
from Teachers t
inner join Subjects s on t.teacherid=s.teacherid
inner join StudentSubject ss on s.subjectid= ss.subjectid
inner join Students st on ss.studentid=st.studentid
inner join Semesters sm on st.semesterid=sm.semesterid
group by st.studentid,sm.semsetername
having sm.semsetername ='fall'
go

--answer the question no 2 (b)--

select * from 
(select studentid, count(subjectid) as 'subject count'
from StudentSubject group by studentid) as v
order by v.[subject count]
go

--answer the question no 2 (c)--


select subjectid,subjectname,
case
		when subjectname in ('DATABASE') then 'programming'
		when subjectname in ('C#') then 'java'
		else 'Others program'
end 'Subject Group'

from Subjects
go


--answer the question no 2 (d)--

select cast ('01-June-2019 10:00 AM' as date)
go

--answer the question no 2 (e)--

select CONVERT(nvarchar(9), cast ('01-June-2019 10:00 AM' as time),131)
go


--answer the question no 3---

--insert--
create proc insertdata @studentid int, @studentname nvarchar(40),@semesterid int 
as
begin try 
			insert into Students (studentid,studentname,semesterid)
			values(@studentid,@studentname,@semesterid)
end try

begin catch

		declare @msg nvarchar(500)
		select @msg =ERROR_MESSAGE()
		raiserror (@msg,16,1)
end catch
go
execute insertdata 6,'s6',5
go
select *
from Students
go
--update--
create proc updatedata @studentid int, @studentname nvarchar(40)
as
begin try 
			update Students
			set studentname=@studentname
			where studentid=@studentid
end try

begin catch

		declare @msg nvarchar(500)
		select @msg =ERROR_MESSAGE()
		raiserror (@msg,16,1)
end catch
go
execute updatedata 6,'Abu taher'
go
select *
from Students
go
--delete--
create proc deletedata @studentid int
as
begin try 
			delete Students
			where studentid=@studentid
end try

begin catch

		declare @msg nvarchar(500)
		select @msg =ERROR_MESSAGE()
		raiserror (@msg,16,1)
end catch
go
execute deletedata 6
go
select *
from Students
go
--answer the question no 4---
create trigger inserttrigger
on students
instead of insert
as
begin
		if @@ROWCOUNT>1
			begin
			raiserror ('Can not insert multiple record',16,1)
			rollback transaction
			return
		end
	else
		begin
				insert into Students
				select * from inserted
		end
	end
go
insert into Students values
(6,'s6',5),
(7,'s7',4)
go
select *
from Students
go
--update--
create trigger updatetrigger
on students
after update
as
begin
		if @@ROWCOUNT>1
			begin
			raiserror ('Can not update multiple record',16,1)
			rollback transaction
			return
		end
	
	end
go
update Students
set semesterid=5
where studentid=5 
go
select *
from Students
go
--delete--
create trigger deletetrigger
on students
after delete
as
begin
		if @@ROWCOUNT>1
			begin
			raiserror ('Can not delete multiple record',16,1)
			rollback transaction
			return
		end
	
	end
go
delete Students
where studentid= 1 and studentid=2
go
select *
from Students
go

--answer the question no 5(a)---

create function fnscaler (@semesterid int) returns int
as
begin
		declare @a int
		select @a=count(*)
		from Students
		where semesterid=@semesterid
		return @a
end
go
select dbo.fnscaler (1)
go

--answer the question no 5(b)---

create function fntable (@semesterid int) returns table
as
return
(
		
		select studentid,studentname
		from Students
		where semesterid=@semesterid
 )
go
select * from fntable(1)
go

create function fntablevalue (@semesterid int) returns @tbl table(studentid int, studentname nvarchar(40))
as
begin
		insert into @tbl
		select studentid,studentname
		from Students
		where semesterid=@semesterid
		return
end
go
select * from fntable(1)
go
--answer the question no 6(a)---

create view vdata
as

select * from 
(select studentid, count(subjectid) as 'subject count'
from StudentSubject group by studentid) as v
order by v.[subject count]
go

select *
from vdata
go
