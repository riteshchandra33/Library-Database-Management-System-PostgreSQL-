CREATE TABLE "Lib".GENRE(
    Genre_ID INT,
    Name VARCHAR(50),
	Description VARCHAR(255),
    PRIMARY KEY (Genre_ID)
);	
Select *from "Lib".GENRE;

CREATE TABLE "Lib".AUTHOR(
    Author_ID INT,
	NAME VARCHAR(50),
	Birth_Date DATE,
	Nationality VARCHAR(255),
    PRIMARY KEY (Author_ID)
);	
Select *from "Lib".AUTHOR;

CREATE TABLE "Lib".CATALOG(
    Catalog_ID INT,
    NAME VARCHAR(50),
    LOCATION VARCHAR(255),
    PRIMARY KEY(Catalog_ID)
);
Select *from "Lib".CATALOG;

CREATE TABLE "Lib".MATERIAL (
    Material_ID INT,
    Title VARCHAR(255) NOT NULL,
    Publication_Date DATE,
    Catalog_ID INT,
    Genre_ID INT,
    PRIMARY KEY (Material_ID),
    FOREIGN KEY (Catalog_ID) REFERENCES "Lib".Catalog(Catalog_ID),
    FOREIGN KEY (Genre_ID) REFERENCES "Lib".Genre(Genre_ID)
);
Select *from "Lib". MATERIAL;

CREATE TABLE "Lib".AUTHOURSHIP(
    Authourship_ID INT,
    Author_ID INT,
    Material_ID INT,
    PRIMARY KEY (Authourship_ID),
    FOREIGN KEY (Author_ID) REFERENCES "Lib".Author (Author_ID),
    FOREIGN KEY (Material_ID) REFERENCES "Lib".MATERIAL(Material_ID)
);
Select *from "Lib".AUTHOURSHIP;

CREATE TABLE "Lib".MEMBER(
    Member_ID INT,
	NAME VARCHAR(255),
	Contact_Info VARCHAR(255),
	Join_Date DATE,
	PRIMARY KEY (Member_ID)
);
Select *from "Lib".MEMBER;

CREATE TABLE "Lib".STAFF(
   Staff_ID INT,
   NAME VARCHAR(255),
   Contact_Info VARCHAR(255),
   Job_Tile VARCHAR(255),
   Hire_Date DATE,
   PRIMARY KEY (Staff_ID)
);
Select *from "Lib".STAFF;

CREATE TABLE "Lib".BORROW(
   Borrow_ID INT,
   Material_ID INT,
   Member_ID INT,
   Staff_ID INT,
   Borrow_Date DATE,
   Return_Date DATE,
   Due_Date DATE,
   PRIMARY KEY (Borrow_ID),
   FOREIGN KEY (Material_ID) REFERENCES "Lib".MATERIAL(Material_ID),
   FOREIGN KEY (Member_ID) REFERENCES "Lib".MEMBER(Member_ID),
   FOREIGN KEY (Staff_ID) REFERENCES "Lib".STAFF(Staff_ID)
);
Select *from "Lib".BORROW;

