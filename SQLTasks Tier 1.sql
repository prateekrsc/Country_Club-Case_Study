/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 1 of the case study, which means that there'll be more guidance for you about how to
setup your local SQLite connection in PART 2 of the case study.

The questions in the case study are exactly the same as with Tier 2.

PART 1: PHPMyAdmin
You will complete questions 1-9 below in the PHPMyAdmin interface.
Log in by pasting the following URL into your browser, and
using the following Username and Password:

URL: https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

In this case study, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


/* QUESTIONS
/* Q1: Some of the facilities charge a fee to members, but some do not.
Write a SQL query to produce a list of the names of the facilities that do. */
*code:*
SELECT name
FROM Facilities
WHERE membercost > 0
LIMIT 0 , 30

*output*
name
Tennis Court 1
Tennis Court 2
Massage Room 1
Massage Room 2
Squash Court

/* Q2: How many facilities do not charge a fee to members? */
*code:*
SELECT COUNT( name )
FROM Facilities
WHERE membercost = 0

*output*
COUNT( name )
4

/* Q3: Write an SQL query to show a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
*code:*
SELECT facid, name, membercost, monthlymaintenance
FROM Facilities
WHERE membercost < 0.2 * monthlymaintenance

*output*
 	facid 	name 	membercost 	monthlymaintenance
  	0 	Tennis Court 1 	5.0 	200
  	1 	Tennis Court 2 	5.0 	200
  	2 	Badminton Court 	0.0 	50
  	3 	Table Tennis 	0.0 	10
  	4 	Massage Room 1 	9.9 	3000
  	5 	Massage Room 2 	9.9 	3000
  	6 	Squash Court 	3.5 	80
  	7 	Snooker Table 	0.0 	15
  	8 	Pool Table 	0.0 	15

/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */
*code:*
SELECT *
FROM Facilities
WHERE facid IN ( 1, 5 )

*output*
	facid 	name 	membercost 	guestcost 	initialoutlay Ascending 	monthlymaintenance
  	5 	Massage Room 2 	9.9 	80.0 	4000 	3000
  	1 	Tennis Court 2 	5.0 	25.0 	8000 	200

/* Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */
*code:*
SELECT
	name,
	monthlymaintenance,
	CASE WHEN monthlymaintenance <= 100 THEN 'cheap'
		 WHEN monthlymaintenance > 100 THEN 'expensive'
		 END AS facility_type
FROM Facilities;

*output*
name 	monthlymaintenance 	facility_type
Tennis Court 1 	200 	expensive
Tennis Court 2 	200 	expensive
Badminton Court 	50 	cheap
Table Tennis 	10 	cheap
Massage Room 1 	3000 	expensive
Massage Room 2 	3000 	expensive
Squash Court 	80 	cheap
Snooker Table 	15 	cheap
Pool Table 	15 	cheap

/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */
*code:*
SELECT firstname, surname, joindate
FROM Members
ORDER BY joindate DESC
LIMIT 2;

*output*
firstname 	surname 	joindate Descending
Darren 	Smith 	2012-09-26 18:08:45
Erica 	Crumpet 	2012-09-22 08:36:38

/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */
*code:*
SELECT DISTINCT f.name AS facility_name, CONCAT_WS( " ", m.firstname, m.surname ) AS member_name
FROM Members AS m
INNER JOIN Bookings AS b ON m.memid = b.memid
INNER JOIN Facilities AS f ON b.facid = f.facid
WHERE f.name LIKE '%tennis court%'
ORDER BY member_name;

*output*
facility_name 	member_name Ascending
Tennis Court 1 	Anne Baker
Tennis Court 2 	Anne Baker
Tennis Court 2 	Burton Tracy
Tennis Court 1 	Burton Tracy
Tennis Court 1 	Charles Owen
Tennis Court 2 	Charles Owen
Tennis Court 2 	Darren Smith
Tennis Court 1 	David Farrell
Tennis Court 2 	David Farrell
Tennis Court 1 	David Jones
Tennis Court 2 	David Jones
Tennis Court 1 	David Pinker
Tennis Court 1 	Douglas Jones
Tennis Court 1 	Erica Crumpet
Tennis Court 2 	Florence Bader
Tennis Court 1 	Florence Bader
Tennis Court 1 	Gerald Butters
Tennis Court 2 	Gerald Butters
Tennis Court 2 	GUEST GUEST
Tennis Court 1 	GUEST GUEST
Tennis Court 2 	Henrietta Rumney
Tennis Court 2 	Jack Smith
Tennis Court 1 	Jack Smith
Tennis Court 1 	Janice Joplette
Tennis Court 2 	Janice Joplette
Tennis Court 2 	Jemima Farrell
Tennis Court 1 	Jemima Farrell
Tennis Court 1 	Joan Coplin
Tennis Court 1 	John Hunt
Tennis Court 2 	John Hunt
Tennis Court 1 	Matthew Genting
Tennis Court 2 	Millicent Purview
Tennis Court 2 	Nancy Dare
Tennis Court 1 	Nancy Dare
Tennis Court 1 	Ponder Stibbons
Tennis Court 2 	Ponder Stibbons
Tennis Court 2 	Ramnaresh Sarwin
Tennis Court 1 	Ramnaresh Sarwin
Tennis Court 1 	Tim Boothe
Tennis Court 2 	Tim Boothe
Tennis Court 2 	Tim Rownam
Tennis Court 1 	Tim Rownam
Tennis Court 1 	Timothy Baker
Tennis Court 2 	Timothy Baker
Tennis Court 2 	Tracy Smith
Tennis Court 1 	Tracy Smith

/* Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */
*code:*
SELECT f.name AS facility_name, CONCAT_WS( " ", m.firstname, m.surname ) AS member_name,
	CASE WHEN m.memid = 0 THEN (f.guestcost * b.slots)
	ELSE (f.membercost * b.slots) END AS cost
FROM Bookings AS b
LEFT JOIN Members AS m ON b.memid = m.memid
LEFT JOIN Facilities AS f ON b.facid = f.facid
WHERE (b.starttime LIKE '%2012-09-14%') HAVING cost > 30
ORDER BY cost DESC

*output:*
facility_name 	member_name 	cost Descending
Massage Room 2 	GUEST GUEST 	320.0
Massage Room 1 	GUEST GUEST 	160.0
Massage Room 1 	GUEST GUEST 	160.0
Massage Room 1 	GUEST GUEST 	160.0
Tennis Court 2 	GUEST GUEST 	150.0
Tennis Court 1 	GUEST GUEST 	75.0
Tennis Court 2 	GUEST GUEST 	75.0
Tennis Court 1 	GUEST GUEST 	75.0
Squash Court 	GUEST GUEST 	70.0
Massage Room 1 	Jemima Farrell 	39.6
Squash Court 	GUEST GUEST 	35.0
Squash Court 	GUEST GUEST 	35.0
/* Q9: This time, produce the same result as in Q8, but using a subquery. */
SELECT subquery.member_name, subquery.cost
FROM (
  SELECT f.name AS facility_name, CONCAT_WS( " ", m.firstname, m.surname ) AS member_name,
  	CASE WHEN m.memid = 0 THEN (f.guestcost * b.slots)
  	ELSE (f.membercost * b.slots) END AS cost
  FROM Bookings AS b
  LEFT JOIN Members AS m ON b.memid = m.memid
  LEFT JOIN Facilities AS f ON b.facid = f.facid
  WHERE (b.starttime LIKE '%2012-09-14%')
) AS subquery
WHERE subquery.cost > 30
ORDER BY cost DESC

/* PART 2: SQLite
/* We now want you to jump over to a local instance of the database on your machine.

Copy and paste the LocalSQLConnection.py script into an empty Jupyter notebook, and run it.

Make sure that the SQLFiles folder containing thes files is in your working directory, and
that you haven't changed the name of the .db file from 'sqlite\db\pythonsqlite'.

You should see the output from the initial query 'SELECT * FROM FACILITIES'.

Complete the remaining tasks in the Jupyter interface. If you struggle, feel free to go back
to the PHPMyAdmin interface as and when you need to.

You'll need to paste your query into value of the 'query1' variable and run the code block again to get an output.

QUESTIONS:
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */
*code:*
SELECT f.name as facility_name,
	ROUND (SUM(CASE WHEN b.memid = 0 THEN f.guestcost * b.slots
	ELSE f.membercost * b.slots END),2) AS total_revenue
FROM Facilities AS f
LEFT JOIN Bookings AS b
ON f.facid = b.facid
GROUP BY facility_name
HAVING total_revenue > 1000
ORDER BY total_revenue DESC

*output:*
('Massage Room 1', 50351.6)
('Massage Room 2', 14454.6)
('Tennis Court 2', 14310.0)
('Tennis Court 1', 13860.0)
('Squash Court', 13468.0)
('Badminton Court', 1906.5)

/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */
SELECT
     m.surname||', '||m.firstname AS member_name,
       rec.surname||', '||rec.firstname AS recommender_name
FROM Members AS m
INNER JOIN Members AS rec
ON m.recommendedby = rec.memid AND m.surname||', '||m.firstname <> rec.surname||', '||rec.firstname
ORDER BY member_name, recommender_name;

('Bader, Florence', 'Stibbons, Ponder')
('Baker, Anne', 'Stibbons, Ponder')
('Baker, Timothy', 'Farrell, Jemima')
('Boothe, Tim', 'Rownam, Tim')
('Butters, Gerald', 'Smith, Darren')
('Coplin, Joan', 'Baker, Timothy')
('Crumpet, Erica', 'Smith, Tracy')
('Dare, Nancy', 'Joplette, Janice')
('Genting, Matthew', 'Butters, Gerald')
('Hunt, John', 'Purview, Millicent')
('Jones, David', 'Joplette, Janice')
('Jones, Douglas', 'Jones, David')
('Joplette, Janice', 'Smith, Darren')
('Mackenzie, Anna', 'Smith, Darren')
('Owen, Charles', 'Smith, Darren')
('Pinker, David', 'Farrell, Jemima')
('Purview, Millicent', 'Smith, Tracy')
('Rumney, Henrietta', 'Genting, Matthew')
('Sarwin, Ramnaresh', 'Bader, Florence')
('Smith, Jack', 'Smith, Darren')
('Stibbons, Ponder', 'Tracy, Burton')
('Worthington-Smyth, Henry', 'Smith, Tracy')

/* Q12: Find the facilities with their usage by member, but not guests */
SELECT
    F.name
    ,M.memid
    ,M.firstname || ' ' || M.surname as member_name
    ,SUM(B.slots) AS usage
    FROM Bookings B
    INNER JOIN Facilities F ON B.facid = F.facid
    INNER JOIN Members M ON B.memid = M.memid
    WHERE M.memid > 0
    GROUP BY
    F.name
    ,M.memid
    ,member_name
    ORDER BY
    usage DESC

/* Q13: Find the facilities usage by month, but not guests */
SELECT
    f.name
    ,strftime('%Y-%m', b.starttime) as month
    ,SUM(b.slots) AS usage
    FROM Bookings AS b
    INNER JOIN Facilities AS f ON b.facid = f.facid
    INNER JOIN Members AS m ON b.memid = m.memid
    WHERE m.memid > 0
    GROUP BY f.name ,month
    ORDER BY usage DESC
