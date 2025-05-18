/*Which materials are currently available in the library? If a material is borrowed and not returned, it’s not considered as available.*/
/*Query-1*/
SELECT M.Material_ID, M.Title
FROM"Lib".material  AS M
WHERE M.Material_ID NOT IN (
    SELECT B.Material_ID
    FROM "Lib".Borrow AS B
    WHERE B.Return_Date IS NULL OR B.Return_Date > CURRENT_DATE
);

/*Which materials are currently overdue? Suppose today is 04/01/2023, and show the borrow date and due date of each material. */
/*Query-2*/
SELECT M.Material_ID,M.Title,
    B.Borrow_Date,B.Due_Date
FROM "Lib". Material
JOIN "Lib".Catalog ON M.Catalog_ID = Catalog.Catalog_ID
JOIN "Lib".Genre ON M.Genre_ID = G.Genre_ID
JOIN "Lib".Borrow ON M.Material_ID = B.Material_ID
WHERE B.Return_Date IS NULL AND B.Due_Date < '04/01/2023';

/*What are the top 10 most borrowed materials in the library? Show the title of each material and order them based on their available counts. */
/*Query-3*/
SELECT M.Material_ID,M.Title,COUNT(Borrow.Material_ID) AS Borrow_Count
FROM "Lib".Material
LEFT JOIN "Lib".Borrow ON M.Material_ID = B.Material_ID
GROUP BY M.Material_ID,M.Title
ORDER BY Borrow_Count DESC
LIMIT 10;

/*How many materials has the author Lucas Piki written? */
/*Query-4*/
SELECT COUNT(ASH.Authourship_ID) AS Lucas_Authored_Books,
       M.Title AS Book_Name
FROM "Lib".Author AS A
JOIN "Lib".Authourship AS ASH ON A.Author_ID = ASH.Author_ID
JOIN "Lib".Material AS M ON ASH.Material_ID = M.Material_ID
WHERE A.Name = 'Lucas Piki'
GROUP BY M.Title;


/*How many materials were written by two or more authors? */
/*Query-5*/
SELECT COUNT(*) AS No_Books_Having_Two_or_More_Authors
FROM (
    SELECT M.Material_ID, M.Title,
           COUNT(M.Material_ID) AS Authors_Written
    FROM "Lib".Material AS M
    JOIN "Lib".Authourship AS ASH ON M.Material_ID = ASH.Material_ID
    GROUP BY M.Material_ID
    HAVING COUNT(ASH.Author_ID) >= 2
);

/*What are the most popular genres in the library ranked by the total number of borrowed 
times of each genre? 
*/
/*Query-6*/
SELECT G.Genre_ID,G.Name AS Genre_Name,
    COUNT(B.Borrow_ID) AS Number_Of_Borrowed_Times
FROM "Lib".Genre AS G
LEFT JOIN "Lib".Material AS M ON G.Genre_ID = M.Genre_ID
LEFT JOIN "Lib".Borrow AS B ON M.Material_ID = B.Material_ID
GROUP BY G.Genre_ID,G.Name
ORDER BY Number_Of_Borrowed_Times DESC;

/*How many materials had been borrowed from 09/2020-10/2020? */
/*Query-7*/
SELECT COUNT(DISTINCT B.Material_ID) AS Borrow_Count
FROM "Lib".Borrow AS B
WHERE B.Borrow_Date BETWEEN '2020-09-01' AND '2020-10-31';

/*How do you update the “Harry Potter and the Philosopher's Stone” when it is returned on 
04/01/2023?*/
/*Query-8*/
/*Query before updating the record*/
SELECT *FROM "Lib".Borrow
WHERE Material_ID = (SELECT Material_ID FROM "Lib".Material WHERE Title = 'Harry Potter and the Philosopher''s Stone');
/*UPDATE Query*/
UPDATE "Lib".Borrow
SET Return_Date = '2023-04-01'
WHERE Material_ID = (SELECT Material_ID FROM "Lib".Material WHERE Title = 'Harry Potter and the Philosopher''s Stone');
/*Displaying the records after updating the reocrd*/
SELECT *FROM "Lib".Borrow
WHERE Material_ID = (SELECT Material_ID FROM "Lib".Material WHERE Title = 'Harry Potter and the Philosopher''s Stone');

/*How do you delete the member Emily Miller and all her related records from the database? */
/*Query-9*/
/*DISPLAYING THE RECORDS FROM BOTH MEMBER AND BORROW TABLES HAVING RECORDS OF EMILY MILLER*/
SELECT B.*, M.*
FROM "Lib".Borrow AS B
JOIN "Lib".Member AS M ON B.Member_ID = M.Member_ID
WHERE B.Member_ID = (SELECT Member_ID FROM "Lib".Member WHERE Name = 'Emily Miller');
/*FOR DELETING THE RECORDS OF EMILY MILLER FROM THE DATABASE*/
DELETE FROM "Lib".Borrow
WHERE Member_ID = (SELECT Member_ID FROM "Lib".Member WHERE Name = 'Emily Miller');
DELETE FROM "Lib".Member
WHERE Name = 'Emily Miller';
/*Running the same select query to display the records of EMILY MILLER in the database to check if the records have been deleted*/
SELECT B.*, M.*
FROM "Lib".Borrow AS B
JOIN "Lib".Member AS M ON B.Member_ID = M.Member_ID
WHERE B.Member_ID = (SELECT Member_ID FROM "Lib".Member WHERE Name = 'Emily Miller');


/*How do you add the following material to the database? 
Title: New book 
Date: 2020-08-01 
Catalog: E-Books 
Genre: Mystery & Thriller    
Author: Lucas Luke 
*/
/*Query-10*/
/*INSERTION OF Author related records into the AUTHOR table and displaying the same, here only AUTHOR_ID and NAME are specified so we consider other columns as null fields during insertion*/
INSERT INTO "Lib".Author (Author_ID,Name) VALUES('21','Lucas Luke');
Select *from "Lib".Author;
/*FETCHING the records of CATALOG_ID and GENRE_ID from CATALOG as well as GENRE table*/
SELECT Catalog_ID FROM "Lib".Catalog WHERE Name = 'E-Books';
SELECT Genre_ID FROM "Lib".Genre WHERE Name = 'Mystery & Thriller';
/*USE the Outputs of the above queries and INSERT the values Catalog and GENRE into the MATERIAL table*/
INSERT INTO "Lib".Material (Material_ID,Title, Publication_Date, Catalog_ID, Genre_ID)
VALUES ('32','New Book', '2020-08-01', 3, 2); 
/*INSERTING the author values in the AUTHORSHIP table giving the value of Authorship_ID as 35*/
INSERT INTO "Lib".Authourship (Authourship_ID,Author_ID,Material_ID)
VALUES ('35','21',(SELECT Material_ID FROM "Lib".Material WHERE Title = 'New Book'));
SELECT * FROM "Lib".Authourship;





