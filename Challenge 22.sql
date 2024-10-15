USE COUNTRY_DB;

#FUNCTION

#1. Add a new column called DOB in Persons table with data type as Date.
ALTER TABLE PERSONS ADD DOB DATE;
UPDATE PERSONS SET DOB = '1990-01-01' WHERE ID = 551;
UPDATE PERSONS SET DOB = '1988-11-12' WHERE ID = 552;
UPDATE PERSONS SET DOB = '1985-06-09' WHERE ID = 553;
UPDATE PERSONS SET DOB = '1990-12-11' WHERE ID = 554;
UPDATE PERSONS SET DOB = '1984-12-31' WHERE ID = 555;
UPDATE PERSONS SET DOB = '1980-11-09' WHERE ID = 556;
UPDATE PERSONS SET DOB = '1988-01-22' WHERE ID = 557;
UPDATE PERSONS SET DOB = '1986-02-05' WHERE ID = 558;
UPDATE PERSONS SET DOB = '1980-03-27' WHERE ID = 559;
UPDATE PERSONS SET DOB = '1981-04-23' WHERE ID = 560;
UPDATE PERSONS SET DOB = '1982-05-07' WHERE ID = 561;
UPDATE PERSONS SET DOB = '1983-06-02' WHERE ID = 562;
UPDATE PERSONS SET DOB = '1984-07-12' WHERE ID = 563;
UPDATE PERSONS SET DOB = '1985-08-15' WHERE ID = 564;
UPDATE PERSONS SET DOB = '1986-09-18' WHERE ID = 565;
UPDATE PERSONS SET DOB = '1987-10-20' WHERE ID = 566;
UPDATE PERSONS SET DOB = '1988-11-22' WHERE ID = 567;
UPDATE PERSONS SET DOB = '1989-12-23' WHERE ID = 568;


#2. Write a user-defined function to calculate age using DOB. 
DELIMITER $$
CREATE FUNCTION calculate_age(dob DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE age INT;
    SET age = TIMESTAMPDIFF(YEAR, dob, CURDATE());
    RETURN age;
END$$
DELIMITER ;

#3. Write a select query to fetch the Age of all persons using the function that has been created. 
SELECT ID, FNAME, LNAME, DOB, calculate_age(DOB) AS AGE FROM PERSONS;

#STORED PROCEDURE

CREATE TABLE Worker(
    Worker_Id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    FirstName CHAR(25) NOT NULL,
    LastName CHAR(25),
    Salary INT NOT NULL,
    JoiningDate DATETIME NOT NULL,
    Department CHAR(25) NOT NULL
);

DROP TABLE WORKER;

INSERT INTO Worker (FirstName, LastName, Salary, JoiningDate, Department) VALUES
('John', 'Doe', 50000, '2023-01-15 09:00:00', 'HR'),
('Jane', 'Smith', 55000, '2023-02-20 09:30:00', 'IT'),
('Emily', 'Johnson', 60000, '2023-03-10 10:00:00', 'Finance'),
('Michael', 'Brown', 52000, '2023-04-05 08:45:00', 'Marketing'),
('Linda', 'Davis', 58000, '2023-05-15 09:15:00', 'Sales'),
('David', 'Wilson', 61000, '2023-06-25 10:30:00', 'IT'),
('Susan', 'Taylor', 62000, '2023-07-20 11:00:00', 'Finance'),
('James', 'Anderson', 53000, '2023-08-10 08:00:00', 'HR'),
('Patricia', 'Thomas', 54000, '2023-09-05 09:30:00', 'Marketing'),
('Robert', 'Moore', 60000, '2023-10-12 10:00:00', 'Sales'),
('Jessica', 'Martin', 57000, '2023-11-01 08:45:00', 'IT'),
('William', 'Lee', 59000, '2023-12-15 09:15:00', 'Finance'),
('Karen', 'Garcia', 58000, '2024-01-10 10:30:00', 'Marketing'),
('Charles', 'Martinez', 55000, '2024-02-20 08:00:00', 'Sales'),
('Nancy', 'Rodriguez', 56000, '2024-03-15 09:00:00', 'HR');

SELECT * FROM WORKER;

#1. Create a stored procedure that takes in IN parameters for all the columns in the Worker table and 
#adds a new record to the table and then invokes the procedure call. 

DELIMITER $$
CREATE PROCEDURE Add_Row_to_Worker(IN FirstName_pro CHAR(25),IN LastName_pro  CHAR(25),IN Salary_pro  INT,
    IN JoiningDate_pro  DATETIME,IN Department_pro  CHAR(25))
BEGIN
    INSERT INTO Worker(FirstName, LastName, Salary, JoiningDate, Department)
    VALUES (FirstName_pro,LastName_pro,Salary_pro,JoiningDate_pro,Department_pro );
END $$
DELIMITER ;

CALL Add_Row_to_Worker('Ann', 'jenifer', 77000, '2022-09-11 08:30:00', 'IT');
SELECT * FROM WORKER;

#2. Write stored procedure takes in an IN parameter for WORKER_ID and an OUT parameter for SALARY. 
#It should retrieve the salary of the worker with the given ID and returns it in the p_salary parameter. 
#Then make the procedure call. 
DELIMITER $$
CREATE PROCEDURE Get_Worker_Salary(IN Worker_Id_pro INT,OUT Salary_pro INT)
BEGIN
    SELECT Salary INTO Salary_pro FROM Worker WHERE Worker_Id = Worker_Id_pro;
END $$
DELIMITER ;

SET @salary = 0;
CALL Get_Worker_Salary(1, @salary);
SELECT @salary AS Salary;



#3. Create a stored procedure that takes in IN parameters for WORKER_ID and DEPARTMENT.
# It should update the department of the worker with the given ID. Then make a procedure call. 
DELIMITER $$
CREATE PROCEDURE Update_Department_of_worker(IN Worker_Id_pro INT,IN Department_pro CHAR(25))
BEGIN
    UPDATE Worker SET Department = Department_pro WHERE Worker_Id = Worker_Id_pro;
END $$
DELIMITER ;

CALL Update_Department_of_worker(1, 'Engineering');
SELECT * FROM WORKER;



#4. Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_workerCount. 
#It should retrieve the number of workers in the given department and returns it in the p_workerCount parameter. 
#Make procedure call. 
DELIMITER $$
CREATE PROCEDURE Worker_CountBy_Department(IN p_Department CHAR(25),OUT p_WorkerCount INT)
BEGIN
    SELECT COUNT(*) INTO p_WorkerCount FROM Worker WHERE Department = p_Department;
END $$
DELIMITER ;

SET @workerCount = 0;
CALL Worker_CountBy_Department('IT', @workerCount);
SELECT @workerCount AS WorkerCount;

#5. Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_avgSalary. 
#It should retrieve the average salary of all workers in the given department and returns it in the p_avgSalary parameter
# and call the procedure.
DELIMITER $$
CREATE PROCEDURE Average_SalaryBy_Department(IN p_Department CHAR(25),OUT p_AvgSalary DECIMAL(10, 2))
BEGIN
    SELECT AVG(Salary) INTO p_AvgSalary FROM Worker WHERE Department = p_Department;
END $$
DELIMITER ;

SET @avgSalary = 0;
CALL Average_SalaryBy_Department('Sales', @avgSalary);
SELECT @avgSalary AS AvgSalary;