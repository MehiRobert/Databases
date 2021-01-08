CREATE TABLE Category
(
cid INT PRIMARY KEY IDENTITY,
categoryname CHAR(20) NOT NULL,
noofteams INT NOT NULL,
)
CREATE TABLE Team
(
    tid INT PRIMARY KEY IDENTITY,
    nameofteam VARCHAR(10) NOT NULL,
    origin VARCHAR(10),
    noofemployees INT,
    yearfounded INT,
    category_id INT FOREIGN KEY REFERENCES Category(cid)
)
CREATE TABLE Race
(
rid VARCHAR(20) PRIMARY KEY,
venue_name VARCHAR(20),
capacity INT NOT NULL,
race_duration INT NOT NULL,
country VARCHAR(20) NOT NULL,

)
CREATE TABLE Spectator
(
sid VARCHAR(20) PRIMARY KEY,
name VARCHAR(20) NOT NULL,
address VARCHAR(20) NOT NULL,
)
CREATE TABLE Attends_At
(
race_id VARCHAR(20),
spectator_id VARCHAR(20),
seat_no INT NOT NULL,
price_of_ticket INT NOT NULL,
FOREIGN KEY (race_id) REFERENCES Race(rid),
FOREIGN KEY (spectator_id) REFERENCES Spectator(sid)
)
CREATE TABLE Car
(
cid VARCHAR(20) PRIMARY KEY,
team_id INT FOREIGN KEY REFERENCES Team(tid),
model_of_car VARCHAR(20) NOT NULL,
number_of_car INT NOT NULL,
engine_manufacturer VARCHAR(20) NOT NULL

)
CREATE TABLE CrewMember
(
memid VARCHAR(20) PRIMARY KEY,
team_id INT FOREIGN KEY REFERENCES Team(tid),
name VARCHAR(20) NOT NULL,
role VARCHAR(20) NOT NULL,
salary INT NOT NULL,
years_of_experience INT NOT NULL
)
CREATE TABLE Driver
(
    did VARCHAR(20) PRIMARY KEY,
    drivername VARCHAR(20) NOT NULL,
    salary INT NOT NULL,
    team_id INT FOREIGN KEY REFERENCES Team(tid),
    years_of_experience INT NOT NULL
)
CREATE TABLE RaceParticipation
(
    team_id INT,
    race_id VARCHAR(20),
    position SMALLINT,
    points_gained INT,
    FOREIGN KEY(team_id) REFERENCES Team(tid),
    FOREIGN KEY(race_id) REFERENCES Race(rid)

)
ALTER TABLE RaceParticipation
ALTER COLUMN team_id INT NOT NULL
ALTER TABLE RaceParticipation
ALTER COLUMN race_id VARCHAR(20) NOT NULL

ALTER TABLE RaceParticipation
ADD CONSTRAINT Race_Part PRIMARY KEY(team_id,race_id)

CREATE TABLE TeamManager
(
    tmid VARCHAR(20) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    salary INT NOT NULL,
    contract_remaining INT,
    team_id INT FOREIGN KEY REFERENCES Team(tid)
)
DROP TABLE Attends_At
CREATE TABLE Attends
(
race_id VARCHAR(20) not null,
spectator_id VARCHAR(20) not null,
seat_no INT NOT NULL,
price_of_ticket INT NOT NULL,
PRIMARY KEY (race_id,spectator_id),
FOREIGN KEY (race_id) REFERENCES Race(rid),
FOREIGN KEY (spectator_id) REFERENCES Spectator(sid)
)