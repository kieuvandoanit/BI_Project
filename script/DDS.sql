--drop database DDS_TH
use master
go 
create database DDS_TH
go
use DDS_TH
go
create table dim_geography(
	geography_id int identity(1,1) primary key,
	geography_nk varchar(4),
	townCity_name varchar(50),
	County_name varchar(50),
	region_name varchar(50),
	country_name varchar(50),
	status int
)
go
create table dim_casualities_info(
	casualities_info_id int identity(1,1) primary key,
	accident_id int,
	vehical_id int,
	casualty_reference_nk int,
	casualities_type int,
	sex int,
	age_band_of_casualty int,
	age varchar(50),
	status int
)
go
/*create table dim_time(
	id_time int identity(1,1) primary key,
	year int,
	quarterOfYear int,
	month int,
	day int,
	hour varchar(5),
	time_nk varchar(13),
	status int
)*/
create table year(
	id_year int identity(1,1) primary key,
	year int
)
go
create table timeOfYear(
	id_timeOfYear int identity(1,1) primary key,
	month int,
	quarter int,
	day int,
	hour int,
	timeOfDay varchar(50),
	id_year int
)
go
create table dim_accident_info(
	accident_info_id int identity(1,1) primary key,
	accident_nk varchar(13),
	urban_or_rural_area int,
	road_type int,
	built_up_road varchar(50),
	time_in_day varchar(50),
	local_authority_(district) int,
	status int
)
go
create table dim_vehical(
	vehical_id int identity(1,1) primary key,
	vehicle_reference_nk int,
	accident_id int,
	journey_purpose_of_driver int,
	vehicle_type int,
	status int
)
go
create table fact_Accident(
	accident_id int identity(1,1) primary key,
	accident_nk varchar(13),
	vehical_id int,
	accident_info_id int,
	id_time int,
	id_geography int,
	accident_severity int,
	accident_count int
)
go
create table fact_casuality(
	casualty_id int identity(1,1) primary key,
	accident_id_nk int,
	vehical_id_nk int,
	casualty_reference_nk int,
	id_time int,
	casualities_info_id int,
	id_geography int,
	casualty_severity int,
	casualty_count int,
	accident_info_id int
)
go
create table fact_variance(
	variance_id int identity(1,1) primary key,
	id_time int,
	accident_quantity int,
	[percent] float
)
go
alter table fact_accident add constraint FK_accident_roadtype foreign key (roadType_id) references dim_roadType(roadType_id)
alter table fact_accident add constraint FK_accident_vehical foreign key(vehical_id) references dim_vehical(vehical_id)
alter table fact_accident add constraint FK_accident_info foreign key(accident_info_id) references dim_accident_info(accident_info_id)
alter table fact_accident add constraint FK_accident_time foreign key(id_time) references dim_time(id_time)
alter table fact_accident add constraint FK_accident_towncity foreign key(id_townCity) references dim_townCity(townCity_id)

alter table fact_casuality add constraint FK_casuality_towncity foreign key(townCity_id) references dim_townCity(townCity_id)
alter table fact_casuality add constraint FK_casuality_info foreign key(casualities_info_id) references dim_casualities_info(casualities_info_id)
alter table fact_casuality add constraint FK_casuality_time foreign key(id_time) references dim_time(id_time)

alter table fact_variance add constraint FK_variance_time foreign key(id_time) references dim_time(id_time)

alter table dim_region add constraint FK_region_country foreign key (country_id) references dim_country(country_id)
alter table dim_county add constraint FK_county_region foreign key (region_id) references dim_region(region_id)
alter table dim_townCity add constraint FK_townCity_County foreign key (county_id) references dim_county(county_id)

