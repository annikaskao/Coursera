/* Exercise 1: Using Joins */

-- 1. Write and execute a SQL query to list the school names, community names and average attendance for communities with a hardship index of 98.

SELECT CPS.NAME_OF_SCHOOL, CPS.COMMUNITY_AREA_NAME, CPS.AVERAGE_STUDENT_ATTENDANCE, CPS.AVERAGE_TEACHER_ATTENDANCE
FROM CHICAGO_PUBLIC_SCHOOLS AS CPS
LEFT JOIN CENSUS_DATA AS CD
ON CPS.COMMUNITY_AREA_NUMBER = CD.COMMUNITY_AREA_NUMBER
WHERE CD.HARDSHIP_INDEX = 98;


-- 2. Write and execute a SQL query to list all crimes that took place at a school. Include case number, crime type and community name.

SELECT CDC.CASE_NUMBER, CDC.PRIMARY_TYPE, CD.COMMUNITY_AREA_NAME
FROM CHICAGO_CRIME_DATA AS CDC
LEFT JOIN CENSUS_DATA AS CD
ON CDC.COMMUNITY_AREA_NUMBER = CD.COMMUNITY_AREA_NUMBER
WHERE CDC.LOCATION_DESCRIPTION LIKE '%SCHOOL%';

/* Exercise 2: Creating a View */ 

-- 1. Write and execute a SQL statement to create a view showing the columns listed in the following table, with new column names as shown in 
-- the second column.

CREATE VIEW CHICAGO_PUBLIC_SCHOOLS_V(School_Name, Safety_Rating, Family_Rating, Environment_Rating, Instrustion_Rating, Leaders_Rating, Teaching_Rating)
AS SELECT NAME_OF_SCHOOL, Safety_Icon, Family_Involvement_Icon, Environment_Icon, Instruction_Icon, Leaders_Icon, Teachers_Icon
FROM CHICAGO_PUBLIC_SCHOOLS;

-- Write and execute a SQL statement that returns all of the columns from the view.
SELECT * FROM CHICAGO_PUBLIC_SCHOOLS_V;

-- Write and execute a SQL statement that returns just the school name and leaders rating from the view.
SELECT SCHOOL_NAME, LEADERS_RATING FROM CHICAGO_PUBLIC_SCHOOLS_V;

/* Exercise 3: Creating a Stored Procedure */ 

-- 1. Write the structure of a query to create or replace a stored procedure called UPDATE_LEADERS_SCORE that takes a in_School_ID parameter 
-- as an integer and a in_Leader_Score parameter as an integer. Don't forget to use the #SET TERMINATOR statement to use the @ for the CREATE 
-- statement terminator.

--#SET TERMINATOR @
CREATE PROCEDURE UPDATE_LEADERS_SCORE                         -- Name of this stored procedure routine

LANGUAGE SQL                                                -- Language used in this routine 
MODIFIES SQL DATA                                           -- This routine will only write/modify data in the table

BEGIN

        DECLARE SQLCODE INTEGER DEFAULT 0;                  -- Host variable SQLCODE declared and assigned 0
        DECLARE retcode INTEGER DEFAULT 0;                  -- Local variable retcode with declared and assigned 0
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION           -- Handler tell the routine what to do when an error or warning occurs
        SET retcode = SQLCODE;                              -- Value of SQLCODE assigned to local variable retcode
        
        UPDATE BankAccounts
        SET Balance = Balance-200
        WHERE AccountName = 'Rose';
        
        UPDATE BankAccounts
        SET Balance = Balance+200
        WHERE AccountName = 'Shoe Shop';
        
        UPDATE ShoeShop
        SET Stock = Stock-1
        WHERE Product = 'Boots';
        
        UPDATE BankAccounts
        SET Balance = Balance-300
        WHERE AccountName = 'Rose';

        
        IF retcode < 0 THEN                                  --  SQLCODE returns negative value for error, zero for success, positive value for warning
            ROLLBACK WORK;
        
        ELSE
            COMMIT WORK;
        
        END IF;
        
END
@                                                            -- Routine termination character

-- 2. Inside your stored procedure, write a SQL statement to update the Leaders_Score field in the CHICAGO_PUBLIC_SCHOOLS table for the 
-- school identified by in_School_ID to the value in the in_Leader_Score parameter.

-- 3. Inside your stored procedure, write a SQL IF statement to update the Leaders_Icon field in the CHICAGO_PUBLIC_SCHOOLS table for the 
-- school identified by in_School_ID using the following information.

-- 4. Run your code to create the stored procedure.
