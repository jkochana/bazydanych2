--1
create table obiekty (id integer primary key, nazwa varchar(50), geom geometry);

insert into obiekty values (1, 'obiekt1', 'COMPOUNDCURVE(LINESTRING(0 1, 1 1), CIRCULARSTRING(1 1, 2 0, 3 1), CIRCULARSTRING(3 1, 4 2, 5 1), 
LINESTRING(5 1, 6 1))');
insert into obiekty values (2, 'obiekt2', 'GEOMETRYCOLLECTION(COMPOUNDCURVE(LINESTRING(10 6, 14 6), CIRCULARSTRING(14 6, 16 4, 14 2), CIRCULARSTRING(14 2, 12 0, 10 2),
LINESTRING(10 2, 10 6)), COMPOUNDCURVE(CIRCULARSTRING(11 2, 12 3, 13 2), CIRCULARSTRING(13 2, 12 1, 11 2)))');
insert into obiekty values (3, 'obiekt3', 'COMPOUNDCURVE(LINESTRING(10 17, 12 13), LINESTRING(12 13, 7 15), LINESTRING(7 15, 10 17))');
insert into obiekty values (4, 'obiekt4', 'COMPOUNDCURVE(LINESTRING(20 20, 25 25), LINESTRING(25 25, 27 24), LINESTRING(27 24, 25 22),
LINESTRING(25 22, 26 21), LINESTRING(26 21, 22 19), LINESTRING(22 19, 20.5 19.5))');
insert into obiekty values (5, 'obiekt5', 'GEOMETRYCOLLECTION(POINT Z (30 30 59), POINT Z ( 38 32 234))');
insert into obiekty values (6, 'obiekt6', 'GEOMETRYCOLLECTION(LINESTRING(1 1, 3 2), POINT(4 2))');

delete from obiekty where id='7';
--2
select st_area(st_buffer(st_shortestline((select geom from obiekty where id = '3'), (select geom from obiekty where id = '4')),5));

--3
update obiekty set geom = st_makepolygon(st_linemerge(st_collect(geom,'LINESTRING(20.5 19.5, 20 20)'))) where id = 4;

--4
insert into obiekty values (7, 'obiekt7', st_union(array(select geom from obiekty where id = '3' or id = '4'))); 

--5
select sum(st_area(st_buffer(geom, 5))) from obiekty where not st_hasarc(geom);