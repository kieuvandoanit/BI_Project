use master
create database NDS_TH
go
use NDS_TH
GO
create table lsoa_nds (
	pcd_id int IDENTITY(1,1) PRIMARY KEY,
	pcd8_nk varchar(8),
	lsoa11cd varchar(9),
	lsoa11nm varchar(63),
	pcd int,
	source_id int,
	createdDate datetime,
	updatedDate datetime
);
GO
create table accident_nds(
	accident_id int IDENTITY(1,1) PRIMARY KEY,
	accident_index_nk varchar(13) not null,
	location_easting_osgr varchar(6),
	location_northing_osgr varchar(7),
	longitude varchar(9),
	latitude varchar(9),
	police_force int,
	accident_severity int,
	number_of_vehicles int,
	number_of_casualties int,
	[date] date,
	date_of_week int,
	[time] varchar(5),
	[local_authority_(district)] int,
	[local_authority_(highway)] varchar(9),
	[1st_road_class] int,
	[1st_road_number] int,
	[road_type] int,
	speed_limit int,
	junction_detail int,
	junction_control int,
	[2nd_road_number] int,
	[pedestrian_crossing-human_control] int,
	[pedestrian_crossing-physical_facilities] int,
	light_conditions int,
	weather_conditions int,
	road_surface_conditions int,
	special_conditions_at_site int,
	carriageway_hazards int,
	urban_or_rural_area int,
	did_police_officer_attend_scene_of_accident int,
	lsoa_of_accident_location int,
	source_id int,
	createdDate datetime,
	updatedDate datetime
)
GO 
create table casualties_nds(
	casualties_sk int identity(1,1) primary key,
	accident_id int,
	vehicle_id int,
	casualty_reference_nk int,
	casualty_class int,
	sex_of_casualty int,
	age_of_casualty int,
	age_band_of_casualty int,
	casualty_severity int,
	pedestrian_location int,
	pedestrian_movement int,
	car_passenger int,
	bus_or_coach_passenger int,
	pedestrian_road_maintenance_worker int,
	casualty_type int,
	casualty_home_area_type int,
	source_id int,
	createdDate datetime,
	updatedDate datetime
)
GO
create table vehicle_nds(
	vehicle_id int identity(1,1) primary key,
	accident_id int,
	vehicle_reference_nk int,
	vehicle_type int,
	towing_and_articulation int,
	vehicle_manoeuvre int,
	[vehicle_location-restricted_lane] int,
	junction_location int,
	skidding_and_overturning int,
	hit_object_in_carriageway int,
	vehicle_leaving_carriageway int,
	hit_object_off_carriageway int,
	[1st_point_of_impact] int,
	was_vehicle_left_hand_drive int,
	journey_purpose_of_driver int,
	sex_of_driver int,
	age_of_driver int,
	age_band_of_driver int,
	[engine_capacity_(cc)] int,
	propulsion_code int,
	age_of_vehicle int,
	driver_imd_decile int,
	driver_home_area_type int,
	source_id int,
	createdDate datetime,
	updatedDate datetime
)
GO 
create table postcode_nds(
	postcode_sk int identity(1,1) primary key,
	postcode_nk varchar(4),
	easting varchar(6),
	northing varchar(7),
	latitude varchar(8),
	longitude varchar(8),
	city varchar(50),
	county varchar(50),
	country_id int,
	region_id int,
	source_id int,
	createdDate datetime,
	updatedDate datetime
)
GO
Create table country_nds(
	country_id int identity(1,1) primary key,
	country_code varchar(3),
	country_name varchar(50),
	createdDate datetime,
	updatedDate datetime,
	source_id int
)
GO
create table region_nds(
	region_id int identity(1,1) primary key,
	region_code varchar(9),
	region_name varchar(50),
	createdDate datetime,
	updatedDate datetime,
	source_id int
)
GO
alter table postcode_nds add constraint FK_postcode_country foreign key (country_id) references country_nds(country_id)
alter table postcode_nds add constraint FK_postcode_region foreign key (region_id) references region_nds(region_id)
alter table lsoa_nds add constraint FK_lsoa_postcode foreign key (pcd) references postcode_nds(postcode_sk)
alter table accident_nds add constraint FK_accident_lsoa foreign key (lsoa_of_accident_location) references lsoa_nds(pcd_id)
alter table vehicle_nds add constraint FK_vehi_acci foreign key (accident_id) references accident_nds(accident_id)
alter table casualties_nds add constraint FK_casua_acci foreign key (accident_id) references accident_nds(accident_id)
alter table casualties_nds add constraint FK_casua_vehi foreign key (vehicle_id) references vehicle_nds(vehicle_id)
