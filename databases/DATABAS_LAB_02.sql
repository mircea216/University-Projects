GO 
USE 
Filmography
INSERT INTO Roles (ID_MOVIE, ID_ACTOR) VALUES (9,2)
INSERT INTO Movies (NAME, RELEASE_DATE , GENRE, RATING, ID_DIRECTOR, ID_STREAMING_SERVICE) VALUES 
('SE7EN', '19971020 08:00:00 AM','thriller and drama',8.8,3,2)

-- UNION 
-- toate ID-urile filmelor vazute de urmaritorii cu ID-urile 1 si 4

SELECT ID_MOVIE FROM ViewedMovies
WHERE ID_VIEWER=1
UNION
SELECT ID_MOVIE FROM ViewedMovies
WHERE ID_VIEWER=4

-- INNER JOIN - 
-- Minim 3 tabele 
-- clausa where 
-- numele filmelor si regizorilor in care Adrien Brody e actor principal

SELECT mov.NAME as Movie_Name ,dir.NAME as Director_Name FROM Directors dir
INNER JOIN Movies mov ON mov.ID_DIRECTOR=dir.ID_DIRECTOR
INNER JOIN Roles rol ON rol.ID_MOVIE = mov.ID_MOVIE
INNER JOIN Actors act ON act.ID_ACTOR = rol.ID_ACTOR
WHERE act.NAME = 'Adrien Brody' 

-- LEFT JOIN
-- DISTINCT 
-- clauza WHERE compusa
-- sa se afiseze o singura data actorii care au rol in filme

SELECT DISTINCT act.NAME from Actors act
LEFT JOIN Roles rol on act.ID_ACTOR = rol.ID_ACTOR 
WHERE rol.ID_ACTOR IS NOT NULL AND NOT(rol.ID_MOVIE is NULL)


-- GROUP BY
-- clauza HAVING 
-- 2 functii agregate diferite 
-- sa se afiseze numarul de filme si rating-ul mediu al filmelor pentru fiecare regizor ce are mai mult de 1 un film

SELECT ID_DIRECTOR, COUNT(*) as NUMBER_OF_MOVIES, AVG(RATING) as AVERAGE_RATING FROM Movies
GROUP BY ID_DIRECTOR
HAVING
COUNT(*)>1

-- GROUP BY

SELECT * FROM ViewedMovies
SELECT * FROM Viewers
SELECT * FROM StreamingServices

-- GROUP BY
-- MIN, MAX 
-- pentru fiecare serviciu de streaming sa se afiseze rating-ul minim si rating-ul maxim al filmelor pe care le difuzeaza

SELECT ID_STREAMING_SERVICE, MIN(RATING) AS MINIMUM_RATING, MAX(RATING) as MAXIMUM_RATING from Movies
GROUP BY ID_STREAMING_SERVICE

-- schimb de design - adaugare coloana PROFIT

ALTER TABLE Movies
ADD PROFIT INT 
UPDATE Movies SET PROFIT=35000000 WHERE ID_MOVIE=1
UPDATE Movies SET PROFIT=15000000 WHERE ID_MOVIE=2
UPDATE Movies SET PROFIT=10000000 WHERE ID_MOVIE=3
UPDATE Movies SET PROFIT=25000000 WHERE ID_MOVIE=5
UPDATE Movies SET PROFIT=27500000 WHERE ID_MOVIE=6
UPDATE Movies SET PROFIT=9000000  WHERE ID_MOVIE=9
UPDATE Movies SET PROFIT=12500000 WHERE ID_MOVIE=11

-- GROUP BY
-- HAVING
-- SUM
-- sa se afiseze castigurile totale ale fiecarui regizor ce a directionat cel putin un film tinand cont ca acesta 
-- castiga jumatate din profitul total al filmului

SELECT ID_DIRECTOR, SUM(PROFIT)/2 AS DIRECTOR_PROFIT  FROM Movies
GROUP BY ID_DIRECTOR
HAVING
COUNT(*)>=1