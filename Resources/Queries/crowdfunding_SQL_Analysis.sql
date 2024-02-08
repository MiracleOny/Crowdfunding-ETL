-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT * FROM campaign;

SELECT cp.cf_id, cp.backers_count 
INTO live_backers
FROM campaign as cp
WHERE (cp.outcome = 'live')
ORDER BY cp.backers_count DESC;

SELECT * FROM live_backers;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT * FROM backers;

-- joining backers and live_backers table (merging cf_id column)
SELECT bk.cf_id, COUNT(bk.cf_id) 
FROM backers as bk
LEFT JOIN live_backers as lbk
ON bk.cf_id = lbk.cf_id
GROUP BY bk.cf_id
ORDER BY count DESC;

SELECT * FROM live_backers;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT * FROM live_backers;
SELECT * FROM campaign;
SELECT * FROM contacts;

SELECT ct.first_name, ct.last_name, ct.email, (cp.goal-cp.pledged) "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM live_backers as lbk
JOIN campaign as cp
ON lbk.cf_id = cp.cf_id
JOIN contacts as ct
ON cp.contact_id = ct.contact_id
ORDER BY "Remaining Goal Amount" DESC;

-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount;

DROP TABLE email_contacts_remaining_goal_amount CASCADE;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal".
-- Sort the table by the last name of each backer, in descending order.
SELECT * FROM backers;
SELECT * FROM campaign;
SELECT * FROM live_backers;

SELECT bk.email, 
	bk.first_name, 
	bk.last_name, 
	lbk.cf_id, 
	cp.company_name, 
	cp.description, 
	cp.end_date, 
	(cp.goal-cp.pledged) "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM live_backers as lbk
JOIN backers as bk
ON lbk.cf_id = bk.cf_id
JOIN campaign as cp
ON bk.cf_id = cp.cf_id
ORDER BY bk.last_name DESC;

-- Check the table
SELECT * FROM email_backers_remaining_goal_amount;

