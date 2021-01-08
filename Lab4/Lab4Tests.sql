INSERT INTO Tables values('Race'),
                          ('Car'),
                          ('RaceParticipation')

--simple View
CREATE VIEW View_1 AS
    SELECT rid,venue_name
    FROM Race
    WHERE race_duration >= 6
--view on 2 tables
CREATE VIEW View_2 AS
    SELECT car_id,points_gained,venue_name
    FROM RaceParticipation INNER JOIN Race R2 on R2.rid = RaceParticipation.race_id
--view with group by
CREATE VIEW View_3 AS
   SELECT RP.car_id, SUM(RP.points_gained) AS TotalPoints
    FROM RaceParticipation RP INNER JOIN Car C on RP.car_id = C.cid
    GROUP BY RP.car_id

SELECT * FROM View_1
SELECT * FROM View_2
SELECT * FROM View_3

INSERT INTO Views values('View_1'),
                         ('View_2'),
                         ('View_3')

INSERT INTO TestViews values(1,1)
insert into TestViews values(2,2)
INSERT INTO TestViews values(3,3)

insert into Tests values('delete_table'),
                         ('insert_table')
insert into Tests values ('select_view')

insert into TestTables values(2,1,100,1)
insert into TestTables values(2,2,100,2)
insert into TestTables values(2,3,100,3)
insert into TestTables values(1,3,100,1)
insert into TestTables values(1,2,100,2),
                              (1,1,100,3)


CREATE OR ALTER PROCEDURE insert_table(@Position INT) AS
    DECLARE @n INT
    DECLARE @NoOfRows INT
    SET @n = 1

    IF @Position = 1
    Begin
        --inserting into the table that has only 1 primary key
        SET @n = 1
        SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestID = 2 and @Position = 1
        DECLARE @Venue VARCHAR(30)
        DECLARE @RaceId VARCHAR(30)
            While @n <= @NoOfRows
                Begin
                    SET @Venue = 'Venue_' + CONVERT (VARCHAR(5),@n)
                    SET @RaceId = 'Race_' + CONVERT (VARCHAR(5),@n)
                    INSERT INTO Race VALUES (@RaceId,@Venue,10000,12,'Romania')
                        SET @n=@n+1
                end
    End

    IF @Position = 2
    Begin
    --table with 1 primary and 1 foreign
            SET @n = 1
            SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestID = 2 and @Position = 2
            DECLARE @model_of_car VARCHAR(20)
            DECLARE @engine_manufacturer VARCHAR(20)
            DECLARE @cid VARCHAR(20)
            WHILE @n <= @NoOfRows
            Begin
                SET @model_of_car = 'model_' + CONVERT (VARCHAR(5),@n)
                SET @engine_manufacturer = 'engine_' + CONVERT (VARCHAR(5),@n)
                SET @cid = 'car_' + CONVERT (VARCHAR(5),@n)
                INSERT INTO Car VALUES (@cid,2,@model_of_car,@n,@engine_manufacturer)
                SET @n = @n + 1
            end
    End

    IF @Position = 3
    Begin
    --table with 2 primary
            SET @n = 1
            DECLARE @Race_Id VARCHAR(30)
            DECLARE @CarId VARCHAR(30)
            SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestID = 2 and @Position = 3
            WHILE @n <= @NoOfRows
            Begin
                SET @Race_Id = 'Race_'+ CONVERT(VARCHAR(5),@n)
                SET @CarId = 'Car_' + CONVERT(VARCHAR(5),@n)
                INSERT INTO RaceParticipation VALUES (@Race_Id,1,25,@CarId)
                SET @n = @n + 1
            end
    End





CREATE OR ALTER PROCEDURE delete_table(@Position int) AS

    DECLARE @NoOfRows INT
    SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestID = 1
    IF @Position = 1
    BEGIN
        DELETE TOP(@NoOfRows) FROM RaceParticipation WHERE race_id like 'Race_%'
    END

    IF @Position = 2
    BEGIN
        DELETE TOP(@NoOfRows) FROM Race WHERE rid like 'Race_%'
    END

    IF @Position = 3
    BEGIN
        DELETE TOP(@NoOfRows) FROM Car WHERE cid like 'Car_%'
    END


EXEC insert_table 1

EXEC insert_table 2

EXEC insert_table 3


DELETE FROM Car
WHERE cid like 'car%'

DELETE FROM RaceParticipation
WHERE race_id like'race_%'

DELETE FROm Race
WHERE rid like 'Race_%'

-- main application
CREATE OR ALTER PROCEDURE Main AS
    DECLARE @StartOfAllProcedures DATETIME2 -- start time test
    DECLARE @EndOfAllProcedures DATETIME2 -- final
    DECLARE @description VARCHAR(31)

SET @StartOfAllProcedures = GETDATE()

-- deleting the RaceParticipation data
DECLARE @start_rp_delete DATETIME2
DECLARE @end_rp_delete DATETIME2
SET @start_rp_delete = GETDATE()
    EXEC delete_table 1
SET @end_rp_delete = GETDATE()

-- deleting the Car data
DECLARE @start_car_delete DATETIME2
DECLARE @end_car_delete DATETIME2

SET @start_car_delete = GETDATE()
    EXEC delete_table 2
SET @end_car_delete = GETDATE()

-- deleting the Race data
DECLARE @start_race_delete DATETIME2
DECLARE @end_race_delete DATETIME2

SET @start_race_delete = GETDATE()
    EXEC delete_table 3
SET @end_race_delete = GETDATE()


-- inserting the Race data
DECLARE @start_race_insert DATETIME2
DECLARE @end_race_insert DATETIME2

SET @start_race_insert = GETDATE()
    EXEC insert_table 1
SET @end_race_insert = GETDATE()

-- inserting the Car data
DECLARE @start_car_insert DATETIME2
DECLARE @end_car_insert DATETIME2

SET @start_car_insert = GETDATE()
    EXEC insert_table 2
SET @end_car_insert = GETDATE()

-- deleting the RaceParticipation data
DECLARE @start_rp_insert DATETIME2
DECLARE @end_rp_insert DATETIME2

SET @start_rp_insert = GETDATE()
    EXEC insert_table 3
SET @end_rp_insert = GETDATE()

DECLARE @View_Group_By_Start DATETIME2
DECLARE @View_Group_By_End DATETIME2

--View Group By
SET @View_Group_By_Start = GETDATE()

SELECT * FROM View_3

SET @View_Group_By_End = GETDATE()

DECLARE @View_Inner_Join_Start DATETIME2
DECLARE @View_Inner_Join_End DATETIME2
--View Inner Join
SET @View_Inner_Join_Start = GETDATE()

SELECT * FROM View_2

SET @View_Inner_Join_End = GETDATE()

DECLARE @View_Select_Start DATETIME2
DECLARE @View_Select_End DATETIME2
--View Inner Join
SET @View_Select_Start = GETDATE()

SELECT * FROM View_1

SET @View_Select_End = GETDATE()


SET @EndOfAllProcedures = GETDATE()

SET @description = 'We performed the delete, insert and select of the views'

insert into TestRuns values(@description,@StartOfAllProcedures,@EndOfAllProcedures)

DECLARE @testrunid INT
SELECT @testrunid= MAX(TestRunID) FROM TestRuns

insert into TestRunTables values(@testrunid,1,@start_race_delete,@start_race_insert)

insert into TestRunTables values(@testrunid,2,@start_car_delete,@start_car_insert)

insert into TestRunTables values(@testrunid,3,@start_rp_delete,@start_rp_insert)

insert into TestRunViews  values(@testrunid,3,@View_Group_By_Start,@View_Group_By_End)

insert into TestRunViews values(@testrunid,2,@View_Inner_Join_Start,@View_Inner_Join_End)

insert into TestRunViews values(@testrunid,1,@View_Select_Start,@View_Select_End)

EXEC Main

SELECT * FROM TestRunViews
SELECT * FROM TestRunTables
SELECT * FROM TestRuns


