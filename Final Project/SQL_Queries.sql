-- 1. Find all projects’ details in the “Web Development” category

SELECT * 
FROM project 
WHERE category_name='Web Development';



-- 2. Find no. of projects’ having a “game-design” tag

SELECT count(project_id) 
FROM tag 
WHERE tag='game design';



--3. Find details of the project titled “UI/UX Redesign”

SELECT *
FROM project 
WHERE name='UI/UX Redesign';



--4. List all the projects having a budget between “7000” and “20000”

SELECT * 
FROM project
WHERE maxbudget <= 20000  AND maxbudget >= 7000;



--5. List 3 most common categories ( based on no. of 3projects )
   
SELECT COUNT(project_id) AS Number_of_project,category_name 
FROM project 
GROUP BY category_name 
ORDER BY Number_of_project DESC LIMIT 3;


			
--6. List all the freelancers who have done at least 2 projects in the “Web Development” category

SELECT *
FROM Freelancer AS f
JOIN (
   SELECT freelancer_id
   FROM Project
   WHERE category_name = 'Web Development'
   GROUP BY freelancer_id
   HAVING COUNT(project_id) >= 2
) AS p ON f.freelancer_id = p.freelancer_id;



--7. List all the freelancers who have done at least 1 project in the top most common category

SELECT *
FROM Freelancer AS f
JOIN Project AS p ON f.freelancer_id = p.freelancer_id
WHERE p.category_name = (
    SELECT category_name
    FROM Project
    GROUP BY category_name
    ORDER BY COUNT(*) DESC
    LIMIT 1
);



--8. List all the projects posted in between “04-2023” and “06-2023” (M-Y and M-Y )

SELECT *
FROM Project
WHERE EXTRACT(YEAR FROM post_time) >= 2023
AND EXTRACT(MONTH FROM post_time) >= 4 AND EXTRACT(YEAR FROM post_time) <= 2023
AND EXTRACT(MONTH FROM post_time) <= 6;



--9. Find the freelancer who has done the maximum no. of projects.

SELECT *
FROM freelancer AS f
JOIN (
    SELECT freelancer_id, COUNT(project_id) AS project_count
    FROM project WHERE freelancer_id 	IS NOT NULL
    GROUP BY freelancer_id
) AS p ON f.freelancer_id = p.freelancer_id
WHERE p.project_count = (
    SELECT MAX(project_count)
    FROM (
        SELECT COUNT(project_id) AS project_count
        FROM project
		WHERE freelancer_id IS NOT NULL
        GROUP BY freelancer_id
    ) AS max_counts
);


   
--10. List all the freelancers who lived in “'Vancouver'-'BC'” (city-state)

SELECT * 
FROM freelancer NATURAL JOIN address 
WHERE city='Vancouver' AND state='BC';



--11. List the top 5 highest bidder projects

SELECT project.* 
FROM 
( 
	SELECT MAX(amount) AS max_bid,project_id 
	FROM bid 
	GROUP BY project_id 
	ORDER BY max_bid DESC
	LIMIT 5 
) AS r
NATURAL JOIN project;



--12. Find the details of the freelancer who earned the most

SELECT r.earning,f.*
FROM
(
	SELECT SUM(fp.amount) AS earning ,p.freelancer_id
	FROM freelancer_payment AS fp 
	JOIN Milestone AS m ON m.milestone_no = fp.milestone_no AND m.project_id = fp.project_id 
	JOIN project AS p ON p.project_id = m.project_id
	GROUP BY freelancer_id 
	ORDER BY earning DESC
	LIMIT 1
) AS r
NATURAL JOIN freelancer AS f;



--13. List all the bids for project “P4”

SELECT * FROM bid 
JOIN project on project.project_id=bid.project_id 
WHERE project.project_id='P4';



--14. Count the number of bids for all the projects that are not assigned yet

SELECT count(*) FROM project WHERE status='Open'; 



--15. Find the average number of milestones
	
SELECT ROUND(AVG(no_of_milestones),2) as avg_no_of_Milestone 
FROM project;



--16. Find the average earnings of a freelancer.

SELECT AVG(r.earning) as avg_earnig_of_freelancer
FROM (
    SELECT SUM(fp.amount) AS earning, p.freelancer_id
    FROM freelancer_payment AS fp 
    JOIN Milestone AS m ON m.milestone_no = fp.milestone_no AND m.project_id = fp.project_id 
    JOIN project AS p ON p.project_id = m.project_id
    GROUP BY p.freelancer_id 
) AS r;



--17. Find the total profit of admin for the year “2023” (year)

SELECT SUM(profit) as Total_profit
FROM
(
	SELECT (sum(fp.amount) - sum(m.amount)) as profit
	FROM freelancer_payment AS fp 
	JOIN Milestone AS m 
	ON m.milestone_no = fp.milestone_no AND m.project_id = fp.project_id 
	WHERE payment_status='Completed' AND fp.time_stamp >= '2023-01-01 00:00:00' AND fp.time_stamp < '2024-01-01 00:00:00' 
	Group by m.project_id

	UNION

	SELECT (payment_t.amount -  bid_t.amount) as profit
	FROM
	(
		SELECT pp.project_id,pp.amount
		FROM project_payment AS pp 
		JOIN project AS p
		ON p.project_id = pp.project_id
		WHERE pp.status='Completed' AND pp.time_stamp >= '2023-01-01 00:00:00' AND pp.time_stamp < '2024-01-01 00:00:00'
	) as payment_t
	JOIN 
	(
		SELECT b.project_id,b.amount
		FROM bid AS b 
		JOIN project AS p
		ON p.project_id = b.project_id
		WHERE b.bid_status='accepted'
	) as bid_t
	ON payment_t.project_id=bid_t.project_id
)AS combined_profits;



--18. Count the number of freelancers per country

SELECT COUNT(freelancer_id),country 
FROM address  NATURAL JOIN  freelancer 
GROUP BY country;



--19. List all the projects having at least one unpaid but completed milestone

SELECT project_id 
FROM milestone 
WHERE workdone_status = 'Completed' AND payment_status = 'Pending'
GROUP BY project_id;



--20. Find the percentage gender ratio of female and male platform users

SELECT 
    ROUND(COUNT(CASE WHEN gender = 'Female' THEN 1  END) * 1.0 / COUNT(*), 2) AS female_ratio,
    COUNT(CASE WHEN gender = 'Female' THEN 1 END) AS female_count,
    COUNT(*) AS total_count
FROM 
( SELECT gender FROM project_owner
  UNION ALL
  SELECT gender FROM freelancer 
) AS combined_table;



--21. Find the total earnings of freelancers gender wise

SELECT SUM( amount ), gender 
FROM freelancer_payment NATURAL JOIN project NATURAL JOIN freelancer 
GROUP BY gender ;



--22. List the top 5 highest rated Project Owners.

SELECT owner_id, AVG(rating) AS avg_rating
FROM (feedback  NATURAL JOIN project ) AS A
WHERE sender = 'freelancer'
GROUP BY owner_id
ORDER BY avg_rating DESC
LIMIT 5;

	

--23. Find the average platform rating given by Project Owners

SELECT AVG(rating) 
FROM plateform_feedback natural join project_owner ;



--24. Find the average platform charges for freelancers

SELECT AVG(freelancer_charges) 
FROM plateform_charges  ;



--25. List countries that have greater platform charges for project owners compared to platform charges for freelancers.

SELECT country 
FROM plateform_charges 
WHERE  project_owner_charges>freelancer_charges;




--26. Find the average number of bids per project

SELECT AVG(total_bids) 
from (select count(*) as total_bids from bid group by project_id) as bids_on_project;




--27. List all the ongoing projects that are bided by the “FL20” freelancer but not assigned to the “FL20” freelancer.

SELECT bid.project_id
FROM bid JOIN project ON bid.project_id = project.project_id
WHERE  bid.freelancer_id='FL20'  AND bid_status='rejected' AND status='In Progress';




--28. Find the number of ongoing, completed by 'FL13' freelancer

SELECT status, COUNT(project_id) 
FROM project 
WHERE freelancer_id = 'FL13' 
GROUP BY status;



--29. List all platform feedbacks rated less than “4”

SELECT * 
FROM plateform_feedback 
WHERE rating < 4;



--30. List all feedback from all the freelancers to the “PO7” project owner rated less than “4.9”

SELECT feedback.* 
FROM project NATURAL JOIN feedback 
WHERE owner_id = 'PO7' AND sender = 'freelancer' AND rating < 4.9;



--31. List all projects along with the number of completed and pending milestones 

SELECT
	project_id, name,
	COUNT(CASE WHEN workdone_status = 'Completed' THEN 1 END) AS milestone_completed,
	COUNT(CASE WHEN workdone_status = 'Pending' THEN 1 END) AS milestone_pending
FROM project NATURAL JOIN milestone 
GROUP BY project_id, name;



--32. List all conversations regarding the “P4” project.

SELECT * FROM freelance_managment_system.message      
WHERE project_id='P4';



--33. Find the percentage of completed milestones for “FL20” freelancer for all projects

SELECT (COUNT(CASE WHEN workdone_status = 'Completed' THEN 1 END))*100.0/COUNT(*)
FROM project NATURAL JOIN milestone
WHERE freelancer_id='FL20'
GROUP BY project_id ;



--34. List all the freelancers who have not been active (no completed milestones) in the last 3 months

Select * 
from Freelancer
where freelancer_id Not in
(
	SELECT freelancer_id
	FROM 
	(
		SELECT freelancer_id, MAX(deadline) AS max_completed_date
		FROM 
		project natural join milestone 
		WHERE workdone_status = 'Completed'
		GROUP BY freelancer_id

	) AS max_date
	WHERE max_completed_date < CURRENT_DATE - INTERVAL '3 months'
);


--35. List all the projects with durations greater than “” days.

select * from 
project
natural join
(
SELECT project_id, (MAX(deadline) - post_time) AS duration
FROM project
NATURAL JOIN milestone
GROUP BY project_id
HAVING MAX(deadline) - post_time > INTERVAL '10 days'
) as r;
