--1
--shp2pgsql.exe -s 4326 "C:\Users\Kuba\Desktop\zad3\T2018_KAR_BUILDINGS.shp" zad3.buildings_2018 | 
--psql -h localhost -p 5432 -U postgres -d zad3
create table buildings_new as select buildings_2019.* from buildings_2019 left join buildings_2018 on 
buildings_2019.geom = buildings_2018.geom where buildings_2018.polygon_id is null;

--2
select poi_2019.type, count(poi_2019.*) from poi_2019 left join poi_2018 on 
poi_2018.poi_id = poi_2019.poi_id join buildings_new on st_within(poi_2019.geom, st_buffer(buildings_new.geom, 0.001))
where poi_2018.poi_id is null group by poi_2019.type;

--3 
create table streets_reprojected as select gid, link_id, st_name,ref_in_id, nref_in_id, func_class, speed_cat, fr_speed_l, 
to_speed_l, dir_travel, st_transform(geom, 3068) as geom from streets_2019;
select st_srid(geom)from streets_reprojected; 

--4
create table input_points (id integer primary key, geom geometry);
insert into input_points (id, geom) values (1, st_setsrid(st_makepoint(8.36093, 49.03174), 4326));
insert into input_points (id, geom) values (2, st_setsrid(st_makepoint(8.39876, 49.00644), 4326));
select st_srid(geom)from input_points; 

--5
update input_points set geom = st_transform(geom, 3068); 

--6
select node_2019.* from node_2019 join (select st_buffer(st_makeline(input_points.geom), 0.0004) as 
buffer from input_points) as buffer on st_contains(buffer.buffer,st_transform(node_2019.geom, 3068))

--7
select count(poi_2019.*) from poi_2019 join land_a on st_dwithin(poi_2019.geom, land_a.geom, 0.0006) 
where poi_2019.type='Sporting Goods Store';

--8
create table t2019_kar_bridges as select st_intersection(railway.geom, water_line.geom) from railway join water_line on 
st_intersects(railway.geom, water_line.geom);





