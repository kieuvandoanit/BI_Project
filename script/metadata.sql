create table data_flow (
	id int identity(1,1) primary key,
	name varchar(50),
	LSET datetime,
	CET datetime
)
GO
insert into data_flow(name,lset, cet) values('accident_stage',GETDATE(),Getdate())
insert into data_flow(name,lset, cet) values('vehical_stage',GETDATE(),Getdate())
insert into data_flow(name,lset, cet) values('casualties_stage',GETDATE(),Getdate())
insert into data_flow(name,lset, cet) values('postcode_stage',GETDATE(),Getdate())
insert into data_flow(name,lset, cet) values('lsoa_stage',GETDATE(),Getdate())