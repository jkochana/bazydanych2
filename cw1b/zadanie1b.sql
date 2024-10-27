--1
select gole.matchid, gole.player from gole where gole.teamid = 'POL';

--2
select * from mecze where mecze.id = '1004';

--3
select gole.player, gole.teamid, mecze.stadium, mecze.mdate from gole inner join mecze on gole.matchid = mecze.id
where gole.teamid = 'POL';

--4
select mecze.team1, mecze.team2, gole.player from gole inner join mecze on gole.matchid = mecze.id
where gole.player like 'Mario%';

--5
select gole.player, gole.teamid, druzyny.coach, gole.gtime from gole inner join druzyny on gole.teamid = druzyny.id 
where gole.gtime <= '10';

--6 
select druzyny.teamname, mecze.mdate from druzyny inner join gole on druzyny.id = gole.teamid inner join mecze on
gole.matchid = mecze.id where druzyny.coach = 'Franciszek Smuda';

--7
select gole.player from gole inner join mecze on gole.matchid = mecze.id where mecze.stadium = 'National Stadium, Warsaw';

--8
select gole.player from gole inner join mecze on gole.matchid = mecze.id where gole.teamid != 'GER' and (mecze.team1 = 'GER'
or mecze.team2 = 'GER');

--9
select druzyny.teamname, count(gole.*) AS gole from druzyny inner join gole on druzyny.id = gole.teamid 
group by druzyny.teamname order by gole desc;

--10
select mecze.stadium, count(gole.*) as gole from mecze inner join gole on mecze.id = gole.matchid group by mecze.stadium 
order by gole desc;





