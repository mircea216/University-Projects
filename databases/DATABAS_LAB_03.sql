GO
USE Filmography
GO

-- User Defined Function 1

CREATE FUNCTION usp_validation_for_add_Actors(
	@name VARCHAR(50),
	@birthdate DATETIME,
	@birthplace VARCHAR(50)
	)
RETURNS BIT
AS
BEGIN
	IF @name IS NULL
		RETURN 0
	IF @birthdate IS NULL OR @birthdate <= '1920-01-01'
		RETURN 0
	IF @birthplace IS NULL
		RETURN 0
	RETURN 1
END
GO

-- User Stored Procedure 1

CREATE PROCEDURE usp_add_Actors
	@name VARCHAR(50),
	@birthdate DATETIME,
	@birthplace VARCHAR(50)
AS
BEGIN
	IF dbo.usp_validation_for_add_Actors(@name, @birthdate, @birthplace) = 1
		INSERT INTO Actors(NAME, BIRTHDATE, BIRTHPLACE) VALUES (@name, @birthdate, @birthplace)
	ELSE
		PRINT ('The introduced fields are invalid')
END

EXEC usp_add_Actors 'Natalie Portman', '1981-06-20', 'Jerusalem'
EXEC usp_add_Actors 'Marlon Brando', '1919-02-02', null
GO

-- User Defined Function 2

CREATE FUNCTION usp_validation_for_add_Movies(
	@name VARCHAR(50),
	@release_date DATETIME,
	@genre VARCHAR(50),
	@rating FLOAT,
	@id_director INT,
	@id_streaming_service INT
	)
RETURNS BIT
AS
BEGIN
	IF @name IS NULL
		RETURN 0
	IF @release_date IS NULL OR @release_date <= '1900-01-01'
		RETURN 0
	IF @genre IS NULL
		RETURN 0
	IF @rating is NULL or @rating<0 OR @rating >10
		RETURN 0
	IF NOT EXISTS (SELECT ID_DIRECTOR FROM Directors WHERE ID_DIRECTOR = @id_director)
		RETURN 0
	IF NOT EXISTS (SELECT ID_STREAMING_SERVICE FROM StreamingServices WHERE ID_STREAMING_SERVICE = @id_streaming_service)
		RETURN 0
	RETURN 1
END
GO

-- User Stored Procedure 2

CREATE PROCEDURE usp_add_Movies
	@name VARCHAR(50),
	@release_date DATETIME,
	@genre VARCHAR(50),
	@rating FLOAT,
	@id_director INT,
	@id_streaming_service INT
AS
BEGIN
	IF dbo.usp_validation_for_add_Movies(@name, @release_date, @genre, @rating, @id_director, @id_streaming_service) = 1
		INSERT INTO Movies (NAME, RELEASE_DATE , GENRE, RATING, ID_DIRECTOR, ID_STREAMING_SERVICE) VALUES (@name, @release_date, @genre,
		@rating, @id_director, @id_streaming_service)
	ELSE
		PRINT ('The introduced fields are invalid')
END

EXEC usp_add_Movies 'Leon The Professional', '1994-03-05','action and drama',8.8,1,1
EXEC usp_add_Movies 'Grane belezza', '1994-03-05','thriller and drama',10,19,7
EXEC usp_add_Movies 'Where hands touch', '1899-03-05','drama',1,1,2
EXEC usp_add_Movies 'Once upon a time', '2019-03-05','drama',10.1,1,1

GO

-- User Defined Function 3

CREATE FUNCTION usp_validation_for_add_Roles(
	@id_movie INT,
	@id_actor INT
	)
RETURNS BIT
AS
BEGIN
	IF NOT EXISTS (SELECT ID_MOVIE  FROM Movies WHERE ID_MOVIE = @id_movie)
		RETURN 0
	IF NOT EXISTS (SELECT ID_ACTOR FROM Actors WHERE ID_ACTOR = @id_actor)
		RETURN 0
	RETURN 1
END
GO

-- User Stored Procedure 3

CREATE PROCEDURE usp_add_Roles
	@id_movie INT,
	@id_actor INT
AS
BEGIN
	IF dbo.usp_validation_for_add_Roles(@id_movie, @id_actor) = 1
		INSERT INTO Roles (ID_MOVIE, ID_ACTOR) VALUES (@id_movie, @id_actor)
	ELSE
		PRINT ('The introduced fields are invalid')
END

EXEC usp_add_Roles 12,6
EXEC usp_add_Roles 20,90
