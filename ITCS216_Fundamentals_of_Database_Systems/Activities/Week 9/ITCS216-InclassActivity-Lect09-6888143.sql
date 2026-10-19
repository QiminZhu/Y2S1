-- Create new database
DROP	DATABASE	IF	EXISTS	TutorMeDB;
CREATE	DATABASE	IF	NOT	EXISTS	TutorMeDB;

-- Select database
USE TutorMeDB;

-- Create tables
CREATE	TABLE	Tutor -- Each tutor is uniquely identified by tutor_id. A tutor must have a name, unique email address, subject, and positive hourly rate.
(
	tutor_id	INT	NOT	NULL	PRIMARY KEY,
    tutor_name	VARCHAR(100)	NOT	NULL,
    `subject`	VARCHAR(100)	NOT	NULL,
    email		VARCHAR(254)	NOT	NULL	UNIQUE,
    hourly_rate	DECIMAL(12,2)	NOT	NULL	CHECK(hourly_rate >	0)
);

CREATE	TABLE	Student	-- Each student is uniquely identified by student_id. A student must have a name and unique email address.
(
	student_id	INT	NOT	NULL	PRIMARY KEY,
    student_name	VARCHAR(100)	NOT	NULL,
    email			VARCHAR(254)	NOT	NULL	UNIQUE
);

CREATE	TABLE	TutoringSession -- Each tutoring session is uniquely identified by session_id.
(
	session_id		INT		NOT	NULL,
    student_id		INT		NOT	NULL,
    tutor_id		INT,
    session_date	DATE	NOT	NULL,	-- The session date must use the YYYY-MM-DD format.
    duration_min	INT		NOT	NULL	CHECK(duration_min BETWEEN 30 AND 180),	-- The session duration must be between 30 and 180 minutes.
    session_status	VARCHAR(100)	NOT	NULL,
    CONSTRAINT	FK_student	FOREIGN KEY(student_id)	REFERENCES	student(student_id),
    CONSTRAINT	FK_tutor	FOREIGN KEY(tutor_id)	REFERENCES	tutor(tutor_id),
    CONSTRAINT	PK_session	PRIMARY KEY(session_id),
    CONSTRAINT	CHECK(session_status IN ('Pending', 'Confirmed', 'Completed', 'Cancelled'))
);


-- Insert values
INSERT	INTO	Tutor(tutor_id, tutor_name, email, `subject`, hourly_rate)
VALUES	(101, 'Narin Chai', 'narin@tutorme.com', 'Mathematics', 450.00),
		(102, 'Bella Wong', 'bella@tutorme.com', 'English', 500.00),
		(103, 'Clara Kim', 'clara@tutorme.com', 'Programming', 550.00);

INSERT INTO Student(student_id, student_name, email)
VALUES	(201, 'Alex Wen', 'alex@email.com'),
		(202, 'Mina Lee', 'mina@email.com'),
		(203, 'Peter Park', 'peter@email.com');
        
INSERT INTO	TutoringSession(session_id, student_id, tutor_id, session_date, duration_min, session_status)
VALUES	(401, 201, 101, '2026-10-06', 60, 'Completed'),
		(402, 202, 103, '2026-10-07', 90, 'Confirmed'),
		(403, 203, 102, '2026-10-08', 60, 'Pending'),
		(404, 201, NULL, '2026-10-10', 120, 'Pending');
        
