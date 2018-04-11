/*Problem Statements*/

/*1)List of all the movies currently showing in cinemas according to user preferences of genre of
a particular user */
	
	SELECT name_of_user, movie_name, movie_genre
	FROM userdata
	INNER JOIN movies
	ON userdata.preferences = movie_genre
	WHERE userdata.user_id="4";
	
/*2)Lists all the movies and show timings that are currently running in a specific theatre 
in user's selected city */

	SELECT movie_name, theatre_name, show_timing
	FROM theatre
	INNER JOIN (
		SELECT theatre_code, screen.movie_name, show_timing
		FROM screen
		INNER JOIN movies
		ON screen.movie_name = movies.movie_name
		) AS a
	ON theatre.theatre_code = a.theatre_code
	WHERE theatre.theatre_name = "Cinepolis:Alpha One";
	
/*3)List all the movies currently running in different theatres in a specific city. */

	
	SELECT city, theatre_name, movie_name
	FROM theatre
	INNER JOIN (
		SELECT DISTINCT screen.movie_name, theatre_code
		FROM screen
		INNER JOIN movies
		ON screen.movie_name = movies.movie_name
		) AS a
	ON theatre.theatre_code = a.theatre_code

	
/*4)List movies that are filtered by user preferences like genre Action,language Hindi,critic_rating>8 and certificate UA*/

	SELECT DISTINCT movie_name, critic_rating,preferences
	FROM movies 
	NATURAL JOIN userdata
	WHERE 
		movies.certificate = 'UA' 
		AND movies.critic_rating >= 8.0 
		AND userdata.preferences="Action" 
		AND movies.language = 'Hindi'

/*5)Lists the movies currently running in respective theatres which are filtered by user as show timings should be before 4pm ,genre of movie should match user's preferences.*/ 

	
	SELECT shows_selection.show_timing,theatre.theatre_name,shows_selection.movie_name
	FROM shows_selection
	INNER JOIN theatre
	ON theatre.theatre_code = shows_selection.theatre_code 
	WHERE movie_name IN
	(	
		SELECT movie_name
		FROM movies
		INNER JOIN userdata
		ON userdata.preferences = movie_genre
	)
	AND  shows_selection.show_timing <="16:00:00"
	
/*6)List of show timings of movies that are coming in next week for advance booking*/
	
	SELECT city, theatre_name, movie_name, show_timing
	FROM theatre
	INNER JOIN (
		SELECT DISTINCT movies.movie_name, theatre_code, show_timing
		FROM movies
			INNER JOIN screen
			ON movies.movie_name = screen.movie_name
		WHERE movies.movie_status = 0) AS a
	ON theatre.theatre_code = a.theatre_code
	
/*7)List of movies in cinemas filtered according to afternoon timings between 12 to 5*/	
	
	SELECT city, theatre_name, movie_name, show_timing
	FROM theatre
	INNER JOIN 
	(
		SELECT DISTINCT movies.movie_name, theatre_code, show_timing
		FROM movies
		INNER JOIN screen
		ON movies.movie_name = screen.movie_name
	) AS a
	ON theatre.theatre_code = a.theatre_code
	WHERE show_timing >= '12:00:00' AND show_timing <= '17:00:00'
	
/*8)List of theatres having most number of shows of a particular movie in a specific city*/		

	SELECT city, theatre_name, movie_name, number_of_shows
	FROM theatre
	INNER JOIN
	(
		SELECT movies.movie_name, count(show_timing) as 'number_of_shows', theatre_code
		FROM movies
		INNER JOIN shows_selection
		ON shows_selection.movie_name = movies.movie_name
		GROUP BY theatre_code
	) AS a
	ON theatre.theatre_code = a.theatre_code
	ORDER BY number_of_shows desc
	LIMIT 1

/*9)List details of no of of shows of a all movies in every theatre in every city */

	SELECT city, theatre_name, movie_name, number_of_shows
	FROM theatre
	INNER JOIN 
	(	
		SELECT movies.movie_name, count(*) as 'number_of_shows', theatre_code
		FROM movies
		INNER JOIN screen
		ON screen.movie_name = movies.movie_name
		GROUP BY movies.movie_name
		) AS a
	ON theatre.theatre_code = a.theatre_code
	ORDER BY number_of_shows desc	
	
/*10)Show all screening timings of a movie*/
	
	SELECT movies.movie_name, show_timing
	FROM movies
	RIGHT OUTER JOIN shows_selection
	ON movies.movie_name = shows_selection.movie_name
	
	
	