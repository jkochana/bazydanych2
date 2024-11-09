--4
create table buildings (id int primary key not null, geometry geometry, name varchar(50));
create table roads (id int primary key not null, geometry geometry, name varchar(50));
create table poi (id int primary key not null, geometry geometry, name varchar(50));

--5
insert into roads (id, geometry, name) values (1,'LINESTRING(0 4.5, 12 4.5)','RoadX');
insert into roads (id, geometry, name) values (2,'LINESTRING(7.5 10.5, 7.5 0)','RoadY');
insert into poi (id, geometry, name) values (1,'POINT(6 9.5)','K');
insert into poi (id, geometry, name) values (2,'POINT(6.5 6)','J');
insert into poi (id, geometry, name) values (3,'POINT(9.5 6)','I');
insert into poi (id, geometry, name) values (4,'POINT(1 3.5)','G');
insert into poi (id, geometry, name) values (5,'POINT(5.5 1.5)','H');
insert into buildings (id, geometry, name) values (1,'POLYGON((9 9, 10 9, 10 8, 9 8, 9 9))','BuildingD');
insert into buildings (id, geometry, name) values (2,'POLYGON((3 8, 5 8, 5 6, 3 6, 3 8))','BuildingC');
insert into buildings (id, geometry, name) values (3,'POLYGON((4 7, 6 7, 6 5, 4 5, 4 7))','BuildingB');
insert into buildings (id, geometry, name) values (4,'POLYGON((8 4, 10.5 4, 10.5 1.5, 8 1.5, 8 4))','BuildingA');
insert into buildings (id, geometry, name) values (5,'POLYGON((1 2, 2 2, 2 1, 1 1, 1 2))','BuildingF');

--6a 
select sum(st_length(geometry)) from roads;

--6b
select st_astext(geometry), st_area(geometry), st_perimeter(geometry) from buildings where name = 'BuildingA';

--6c
select name, st_area(geometry) from buildings order by name;

--6d
select name, st_perimeter(geometry) from buildings order by st_area(geometry) desc limit 2;

--6e
select st_distance(buildings.geometry, poi.geometry) from buildings, poi 
where buildings.name = 'BuildingC' and poi.name = 'K';

--6f
select st_area(st_difference(geometry, st_buffer((select geometry from buildings where name = 'BuildingB'), 0.5))) 
from buildings where name = 'BuildingC';

--6g
select * from buildings where st_y(st_centroid(buildings.geometry)) > (select st_y(st_centroid(geometry)) 
from roads where name = 'RoadX');

--6f
select st_area(st_symdifference(geometry, st_geomfromtext('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))'))) from buildings 
where name = 'BuildingC';

