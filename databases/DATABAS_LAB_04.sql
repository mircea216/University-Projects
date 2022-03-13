GO
USE Filmography
GO

-- VIEW - counts the number of movies created by each director 

CREATE VIEW vw_countNumberOfMoviesOfEachDirector
AS
	SELECT Dir.ID_DIRECTOR, COUNT(*) AS NUMBER_OF_MOVIES 
	FROM Movies Mov INNER JOIN 
	Directors Dir ON Mov.ID_DIRECTOR = Dir.ID_DIRECTOR
	GROUP BY Dir.ID_DIRECTOR

GO
select * from vw_countNumberOfMoviesOfEachDirector

-- TRIGGER -- after inserting actors

GO
CREATE TRIGGER tg_addActors
ON Actors
AFTER INSERT 
AS
BEGIN
	PRINT 'The date at which the actor was inserted is: ' + cast(GETDATE() AS VARCHAR(100))
END

GO
INSERT INTO Actors (NAME, BIRTHDATE, BIRTHPLACE) VALUES ('Marlon Brando', '1920-12-01', 'USA')

-- TRIGGER -- after deleting actors
GO
CREATE TRIGGER tg_deleteActors
ON Actors
AFTER DELETE 
AS
BEGIN
	PRINT 'The date at which the actor was deleted is: ' + cast(GETDATE() AS VARCHAR(100))
END

GO
DELETE FROM Actors WHERE NAME = 'Marlon Brando'