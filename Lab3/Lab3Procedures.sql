USE WEC;

-- this procedure changes the address type from VARCHAR(20) to VARCHAR(70)
CREATE OR ALTER PROCEDURE initial_proc_1 AS
    ALTER TABLE Spectator
    ALTER COLUMN address VARCHAR(70) NOT NULL
--this procedure reverses the type of address to it's initial one
CREATE OR ALTER PROCEDURE reverse_proc_1 AS
    ALTER TABLE Spectator
    ALTER COLUMN address VARCHAR(20) NOT NULL

--this procedure adds a new column to the Spectator table called date_of_birth
CREATE OR ALTER PROCEDURE initial_proc_2 AS
    ALTER TABLE Spectator
    ADD date_of_birth INT

-- this procedure removes the column named date_of_birth
CREATE PROCEDURE reverse_proc_2 AS
    ALTER TABLE Spectator
    DROP COLUMN if exists date_of_birth

-- it drops the primary constraint
CREATE OR ALTER PROCEDURE initial_proc_4 AS
    ALTER TABLE CrewMember
    DROP CONSTRAINT Pk_CrewMember

-- it adds a new constraint
CREATE OR ALTER PROCEDURE reverse_proc_4 AS
    ALTER TABLE CrewMember
    ADD CONSTRAINT Pk_CrewMember PRIMARY KEY(memid)

-- adds a new default constraint
CREATE PROCEDURE initial_proc_3 AS
    ALTER TABLE Race
    ADD CONSTRAINT DF_capacity
    DEFAULT 30000 for capacity
--drops the default constraint
CREATE PROCEDURE reverse_proc_3 AS
    ALTER TABLE Race
    DROP CONSTRAINT if exists
    DF_capacity

CREATE OR ALTER PROCEDURE reverse_proc_7 AS
    DROP TABLE if exists TestProcedure

CREATE OR ALTER PROCEDURE initial_proc_7 AS
    create table TestProcedure
(
    pid CHAR(20) PRIMARY KEY NOT NULL,
    quality VARCHAR(30)

)

--remove the foreign key
CREATE OR ALTER PROCEDURE initial_proc_6 AS
    ALTER TABLE CrewMember
    DROP CONSTRAINT if exists FK_teamID
--adds a foreign key
CREATE OR ALTER PROCEDURE reverse_proc_6 AS
    ALTER TABLE CrewMember
    ADD CONSTRAINT FK_teamID FOREIGN KEY(team_id) references Team(tid)
--adds a candidate key
CREATE OR ALTER PROCEDURE initial_proc_5 AS
    ALTER TABLE CrewMember
    ADD CONSTRAINT Candidate_keyUnique UNIQUE(name)
--remove the candidate key
CREATE OR ALTER PROCEDURE reverse_proc_5 AS
    ALTER TABLE CrewMember
    DROP CONSTRAINT IF EXISTS Candidate_keyUnique

CREATE OR ALTER PROCEDURE Main(@version INT) AS
    BEGIN
    DECLARE @currentversion INT
    DECLARE @next_procedure VARCHAR(30)

        SET @currentversion = (SELECT version_id FROM VersionTable)
        IF @version < 0 OR @version > 7
            Begin
                print ('Not a valid version!')
                return
            end
        WHILE @currentversion < @version
        BEGIN
            SET @currentversion = @currentversion + 1
            SET @next_procedure = 'initial_proc_' + CONVERT(varchar(3),@currentversion)
            EXEC @next_procedure


        end
        WHILE @currentversion > @version
        BEGIN
            SET @next_procedure = 'reverse_proc_' + CONVERT(varchar(3),@currentversion)
            EXEC @next_procedure
            SET @currentversion = @currentversion - 1
        end
        TRUNCATE TABLE VersionTable
        INSERT INTO VersionTable values(@currentversion)

    END


EXEC Main 2

EXEC Main 3




