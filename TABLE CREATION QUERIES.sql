/* UserData Table Creation*/
CREATE TABLE userdata (
	user_id VARCHAR(20) NOT NULL,
	pass_word VARCHAR(20) NOT NULL,
	name_of_user VARCHAR(50) NOT NULL,
	phone_number VARCHAR(20) NOT NULL,
	preferences VARCHAR(255) NULL DEFAULT NULL,
	wallet_balance VARCHAR(100) NOT NULL,
	gender VARCHAR(10) NOT NULL,
	dob DATE NOT NULL,
	current_location CHAR(50) NOT NULL,
	CONSTRAINT PK_userdata PRIMARY KEY (user_id)
)

/* BookingHistory Table Creation*/
CREATE TABLE bookinghistory (
	user_id VARCHAR(20) NOT NULL,
	movie_name VARCHAR(100) NOT NULL,
	booking_id VARCHAR(10) NOT NULL,
	theatre_code VARCHAR(10) NOT NULL,
	city CHAR(50) NOT NULL,
	no_of_tickets SMALLINT(6) UNSIGNED NOT NULL,
	transaction_amount SMALLINT(6) UNSIGNED NOT NULL,
	time_of_purchase TIME NOT NULL,
	wallet_used BINARY(1) NOT NULL,
	wallet_balance_change SMALLINT(5) UNSIGNED NOT NULL,
	CONSTRAINT PK_bookinghistory PRIMARY KEY (booking_id),
	INDEX FK_bookinghistory_location (city),
	INDEX FK_bookinghistory_movies (movie_name),
	INDEX FK_bookinghistory_theatre (theatre_code),
	INDEX FK_bookinghistory_userdata (user_id),
	CONSTRAINT FK_bookinghistory_location FOREIGN KEY (city) REFERENCES location (city),
	CONSTRAINT FK_bookinghistory_movies FOREIGN KEY (movie_name) REFERENCES movies (movie_name),
	CONSTRAINT FK_bookinghistory_theatre FOREIGN KEY (theatre_code) REFERENCES theatre (theatre_code),
	CONSTRAINT FK_bookinghistory_userdata FOREIGN KEY (user_id) REFERENCES userdata (user_id)
)

/*Location Table Creation*/
CREATE TABLE location (
	city CHAR(50) NOT NULL,
	CONSTRAINT PK_LOCATION PRIMARY KEY (city)
)

/*Theatre Table Creation*/
CREATE TABLE theatre (
	theatre_code VARCHAR(10) NOT NULL,
	theatre_franchise VARCHAR(100) NOT NULL,
	theatre_name VARCHAR(100) NOT NULL,
	no_of_screens TINYINT(3) UNSIGNED NOT NULL,
	city CHAR(100) NOT NULL,
	CONSTRAINT PK_theatre PRIMARY KEY (theatre_code),
	INDEX FK_theatre_location (city),
	CONSTRAINT FK_theatre_location FOREIGN KEY (city) REFERENCES location (city)
)


/*Movies Table Creation*/
CREATE TABLE movies (
	movie_name VARCHAR(100) NOT NULL,
	release_date DATE NOT NULL,
	run_time TIME NOT NULL,
	movie_genre CHAR(20) NOT NULL,
	language CHAR(20) NOT NULL,
	certificate VARCHAR(5) NOT NULL,
	critic_rating VARCHAR(50) ,
	critic_review VARCHAR(300),
	movie_status TINYINT(3) UNSIGNED NOT NULL,
	movie_format VARCHAR(5) NOT NULL,
	sypnosis VARCHAR(1000) NOT NULL,
	CONSTRAINT PK_movies PRIMARY KEY (movie_name)
)

/*Screen Table Creation*/
CREATE TABLE screen (
	theatre_code VARCHAR(10) NOT NULL,
	screen_no TINYINT(4) UNSIGNED NOT NULL,
	movie_name VARCHAR(100) NOT NULL,
	show_timing TIME NOT NULL,
	class_of_seats VARCHAR(20) NOT NULL,
	price_of_class SMALLINT(6) UNSIGNED NOT NULL,
	INDEX FK_screen_theatre (theatre_code),
	INDEX FK_screen_movies (movie_name),
	CONSTRAINT FK_screen_movies FOREIGN KEY (movie_name) REFERENCES movies (movie_name),
	CONSTRAINT FK_screen_theatre FOREIGN KEY (theatre_code) REFERENCES theatre (theatre_code)
)

/* Shows_Selection Table Creation*/
CREATE TABLE shows_selection (
	theatre_code VARCHAR(10) NOT NULL,
	user_id VARCHAR(10) NOT NULL,
	booking_status TINYINT(3) UNSIGNED NOT NULL,
	movie_name VARCHAR(100) NOT NULL,
	city CHAR(50) NOT NULL,
	screen_no TINYINT(4) UNSIGNED NOT NULL,
	show_timing TIME NOT NULL,
	total_seats SMALLINT(6) UNSIGNED NOT NULL,
	selected_seats SMALLINT(6) UNSIGNED NOT NULL,
	class_of_seats VARCHAR(10) NOT NULL,
	INDEX FK_shows_selection_theatre (theatre_code),
	INDEX FK_shows_selection_userdata (user_id),
	INDEX FK_shows_selection_movies (movie_name),
	CONSTRAINT FK_shows_selection_movies FOREIGN KEY (movie_name) REFERENCES movies (movie_name),
	CONSTRAINT FK_shows_selection_theatre FOREIGN KEY (theatre_code) REFERENCES theatre (theatre_code),
	CONSTRAINT FK_shows_selection_userdata FOREIGN KEY (user_id) REFERENCES userdata (user_id)
)


