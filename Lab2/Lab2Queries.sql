insert into Category values('LMP1',10)
insert into Category values('LMP2',10)
insert into Category values('GTPro',10)
insert into Category values('Amateur',10)

insert into Team values('Toyota','Japan',40,2015,2)
insert into Team values('Audi Racing','Germany',50,1992,1)

SELECT *
FROM Team

insert into Team values('Aston Martin Racing','British',60,2000,3)
insert into Team values('UBB Racing','Romania',30,2019,4)
insert into Team values('Jackie Chan Racing','America',35,2010,4)
insert into Team values('Marc Racing','England',25,2020,4)

insert into Driver values('lw44','Lewis Hamilton',2000000,3,15)

SELECT *
FROM Driver

insert into Driver values('al101','Andre Lotterer',1000000,2,10)
insert into Driver values('mm88','Mehi Mihai',200000,6,1)
insert into Driver values('hulk27','Nico Hulkenberg',200000,3,20)
insert into Driver values('ves33','Max Verstappen',1000000,2,10)
insert into Driver values('ros6','Nico Rosberg',100000,2,6)
insert into Driver values('man24','Nigel Mansell',500000,6,35)
insert into Driver values('mal10','Pastor Maldonado',200000,5,10),
                          ('mar9','Mark Webber',500000,8,30)
insert into Driver values('geo3','George Russell',100000,7,3)
insert into Driver values('lat63','Nick Latify',50000,7,1)

insert into Car values('ast1',5,'Aston Marin Vantage',35,'Aston Martin')


SELECT *
From Car

insert into Car values('pors1',6,'Porsche 911 GT3',925,'Porsche')
insert into Car values('vag1',3,'Audi R8',1,'Audi')
insert into Car values('toyo1',2,'Toyota S1',7,'Toyota')
insert into Car values('toyo2',2,'Toyota S1',8,'Toyota')
insert into Car values('jack1',7,'Porsche 911 GT3',95,'Porsche'),
                       ('marc1',8,'Ferrari 458 Italia',55,'Ferrari')

SELECT *
From Race

insert into Race values('DE10','Nurburgring',80000,6,'Germany')
insert into Race values('HU1','Hungaroring',50000,6,'Hungary')
insert into Race values('F1','Le Mans',120000,24,'France')

SELECT *
From RaceParticipation

insert into RaceParticipation values('DE10',3,15,'toyo1')
insert into RaceParticipation values('DE10',1,25,'vag1')
insert into RaceParticipation values('F1',5,10,'pors1')
insert into RaceParticipation values('F1',NULL,NULL,'vag1')
insert into RaceParticipation values('HU1',1,25,'toyo1'),
                                     ('HU1',2,18,'vag1'),
                                     ('HU1',4,12,'jack1'),
                                     ('HU1',3,15,'toyo2')
insert into Attends values('HU1','1',32,500),
                           ('F1','4',21,300),
                           ('DE10','3',25,100)
INSERT INTO Spectator values('1','Marius Constantin','Romania')
INSERT INTO Spectator values('2','Adrian Paun','Romania')
insert Into Spectator values('3','John Mcnish','England')
INSERT INTO Spectator values('4','Alfonso Mireless','Spain')
--1/2 Delete
DELETE FROM Spectator
WHERE address IN ('Romania','Spain')

-- 1/3 Update
UPDATE Car
SET model_of_car = 'Aston Martin Vantage'
WHERE cid = 'ast1'

-- 2/2 Delete
DELETE FROM RaceParticipation
WHERE race_id = 'F1' and position IS NULL

-- 2/3 Update
UPDATE Driver
SET salary = 2000000
WHERE years_of_experience >= 10

SELECT *
FROM Driver
-- Update
UPDATE Driver
SET salary = 1500000
WHERE years_of_experience >= 5 AND drivername LIKE 'N_%g'
-- 3/3 Update
UPDATE Race
SET race_duration = 12
WHERE capacity BETWEEN 50000 AND 100000

INSERT INTO Spectator values('1','Marius Constantin','Romania')
INSERT INTO Spectator values('2','Adrian Paun','Romania')
insert Into Spectator values('3','John Mcnish','England')
INSERT INTO Spectator values('4','Alfonso Mireless','Spain')

SELECT DISTINCT S.address
FROM Spectator S
--2/2 Delete

SELECT * FROM Spectator
INSERT INTO Spectator values('1','Marius Constantin','Romania'),
                             ('4','Alfonso Mireless','Spain'),
                             ('2','Adrian Paun','Romania')
INSERT INTO CrewMember values('crew1',6,'Michael Sutter','mechanic',50000,4) ,
                              ('crew2',2,'Raul Marinescu','Technical enginner',100000,9)
INSERT INTO CrewMember values('crew3',3,'Robert Brown','Mechanic',65000,5),
                              ('crew4',5,'Alain Dupont','Race enginner',100000,7),
                              ('crew5',2,'Kamui Kobaiashi','Test Driver',200000,6)
INSERT INTO TeamManager values(1,'Zak Brown',50000,2,6)

SELECT *
FROM CrewMember
-- 1/2 a)
SELECT D1.did,D1.drivername
FROM Driver D1
WHERE drivername LIKE 'M_%'
UNION
SELECT D2.did,D2.drivername
FROM Driver D2
WHERE years_of_experience >= 20
ORDER BY did
-- 2/2 a) (1st Order by)
SELECT T1.nameofteam,T1.yearfounded
FROM Team T1
WHERE nameofteam LIKE 'A_%' OR yearfounded > 2016
ORDER BY T1.yearfounded

-- 1/2 Intersect
SELECT *
FROM RaceParticipation RP
WHERE RP.points_gained > 14 and RP.race_id in
                                      (
                                          SELECT RP2.race_id
                                          FROM RaceParticipation RP2
                                          WHERE RP.race_id = 'HU1'
                                      )

-- 2/2 Intersect
SELECT T.tid,T.nameofteam
FROM Team T
WHERE category_id = 4
INTERSECT
SELECT T2.tid,T2.nameofteam
FROM Team T2
WHERE yearfounded > 2010

-- 1/2 Except
SELECT D1.drivername
FROM Driver D1
WHERE years_of_experience < 25
EXCEPT
SELECT D2.drivername
FROM Driver D2
WHERE salary > 1000000

-- 2/2 Except
SELECT DISTINCT CM.salary
FROM CrewMember CM
WHERE salary > 80000 and years_of_experience NOT IN (1,2,3,4,5,6)

-- 1/4 d)
SELECT *
FROM Team
INNER JOIN Driver
ON Team.tid = Driver.team_id

-- 2/4 d)
SELECT S.name
FROM Spectator S
LEFT OUTER JOIN Attends A
on S.sid = A.spectator_id
LEFT OUTER JOIN Race R2
on A.race_id = R2.rid
LEFT JOIN RaceParticipation RP
on R2.rid = RP.race_id
LEFT JOIN Car C
on RP.car_id = C.cid
WHERE C.engine_manufacturer = 'Toyota' and position = 1


-- 3/4 d)
SELECT DISTINCT T.nameofteam,TM.name
FROM Team T
FULL OUTER JOIN Driver D
ON T.tid = D.team_id
FULL OUTER JOIN TeamManager TM
ON TM.team_id = T.tid

-- 4/4 d)
Select C.number_of_car,RP.points_gained,R2.venue_name
FROM Car C
RIGHT OUTER JOIN RaceParticipation RP
on C.cid = RP.car_id
RIGHT OUTER JOIN Race R2
on RP.race_id = R2.rid

-- 2 queries with IN
SELECT TOP 100 C.cid
FROM Car C
WHERE C.cid IN (SELECT RP.car_id FROM RaceParticipation RP)

SELECT *
FROM Team T
WHERE T.tid IN (SELECT C.team_id FROM CAR C
                WHERE C.engine_manufacturer = 'Toyota' AND C.cid in
                                                           (SELECT RP.car_id FROM RaceParticipation RP
                                                            WHERE RP.position = 1 ))

-- h.4 queries GROUP BY, ORDER BY(2nd use of it)

SELECT TOP 3 RP.car_id, SUM(RP.points_gained) AS TotalPoints
FROM RaceParticipation RP INNER JOIN Car C on RP.car_id = C.cid
GROUP BY RP.car_id
ORDER BY TotalPoints DESC

SELECT T.tid,T.nameofteam, AVG(D.salary) AS AverageSalary
FROM Team T,Driver D
WHERE T.tid = D.team_id
GROUP BY T.tid,T.nameofteam
HAVING 2 * AVG(D.salary) >= (SELECT MAX(D2.salary)
                    FROM DRIVER D2
                    )

SELECT T.tid,T.nameofteam, COUNT(C.team_id) AS NumberOfCars
FROM Team T INNER JOIN Car C on T.tid = C.team_id
GROUP BY T.tid, T.nameofteam
HAVING COUNT(C.team_id) >= 2

SELECT T.tid,D.drivername, MAX(D.years_of_experience) AS MostExperience
FROM Team T INNER JOIN Driver D on T.tid = D.team_id
GROUP BY T.tid, D.drivername
HAVING MAX(D.years_of_experience) = (
                                        SELECT MAX(D2.years_of_experience)
                                        FROM Driver D2
                                        WHERE D2.team_id = T.tid
    )
ORDER BY MostExperience DESC
-- i.
SELECT *
FROM Driver D
WHERE D.salary > ANY (
                        SELECT D2.salary
                        FROM Driver D2
                        WHERE D2.years_of_experience = 10
    )
SELECT *
FROM Driver D
WHERE D.salary > ALL (
                        SELECT D2.salary
                        FROM Driver D2
                        WHERE D2.years_of_experience = 10
    )
SELECT *
FROM Driver D
WHERE D.salary >  (
                        SELECT MIN(D2.salary)
                        FROM Driver D2
                        WHERE D2.years_of_experience = 10
    )
SELECT *
FROM Driver D
WHERE D.salary > (
                        SELECT MAX(D2.salary)
                        FROM Driver D2
                        WHERE D2.years_of_experience = 10
    )
SELECT *
FROM Car C
WHERE C.cid = ANY (
                    SELECT RP.car_id
                    FROM RaceParticipation RP
                    WHERE RP.points_gained >= 15

    )
SELECT *
FROM Car C
WHERE C.cid IN (
                    SELECT RP.car_id
                    FROM RaceParticipation RP
                    WHERE RP.points_gained >= 15

    )
SELECT *
FROM Car C
WHERE C.cid <>ALL (
                    SELECT RP.car_id
                    FROM RaceParticipation RP
                    WHERE RP.position = 1

    )
SELECT *
FROM Car C
WHERE C.cid NOT IN (
                    SELECT RP.car_id
                    FROM RaceParticipation RP
                    WHERE RP.position = 1

    )
-- 2 queries with Exists
SELECT *
FROM Car C
WHERE EXISTS (SELECT *
              FROM RaceParticipation R
              WHERE R.position = 1 and R.car_id = C.cid
    )
SELECT *
FROM Team T
WHERE EXISTS (SELECT *
              FROM Driver D
              WHERE D.team_id = T.tid
              HAVING COUNT(D.team_id) > 2
    )
-- g.
SELECT A.car_id,A.points_gained
FROM (SELECT RP.car_id,RP.points_gained
      FROM RaceParticipation RP INNER JOIN Car C on C.cid = RP.car_id
      GROUP BY  RP.car_id,RP.points_gained
      HAVING SUM(RP.points_gained) >= 15
     ) A

SELECT T.tid, TeamAVG.AverageSalary
FROM ( SELECT D.team_id , AVG (D.salary) AS AverageSalary
       FROM DRIVER D
       GROUP BY D.team_id
         ) TeamAVG
      INNER JOIN Team T on TeamAVG.team_id = T.tid