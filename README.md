# MYSQL_STORED-PROCEDURES_AND_FUNCTIONS
This repository provides insights into stored procedures and functions in SQL, highlighting their roles in enhancing code reusability, encapsulating logic, and improving database efficiency.

1. Write a user-defined function to calculate age using DOB.

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

2.Write a select query to fetch the Age of all persons using the function that has been created.

 SELECT ID, FNAME, LNAME, DOB, calculate_age(DOB) AS AGE FROM PERSONS; 

![image](https://github.com/user-attachments/assets/a1e2fe8e-5739-46a8-9ec8-fa1c7e52a6c8)

STORED PROCEDURE

1.Create a stored procedure that takes in IN parameters for all the columns in the Worker table and adds a new record to the table and then invokes the procedure call.

DELIMITER $$

CREATE PROCEDURE Add_Row_to_Worker(IN FirstName_pro CHAR(25),IN LastName_pro  CHAR(25),IN Salary_pro  INT,  IN JoiningDate_pro  DATETIME,IN Department_pro  CHAR(25))

BEGIN

    INSERT INTO Worker(FirstName, LastName, Salary, JoiningDate, Department)
    VALUES
    (FirstName_pro,LastName_pro,Salary_pro,JoiningDate_pro,Department_pro );
    
END $$

DELIMITER ;

         CALL Add_Row_to_Worker('Ann', 'jenifer', 77000, '2022-09-11 08:30:00', 'IT');
         
SELECT * FROM WORKER;

![image](https://github.com/user-attachments/assets/c1c071e4-1187-4a8d-b23f-2711eff8cbc0)

2. Write stored procedure takes in an IN parameter for WORKER_ID and an OUT parameter for SALARY. It should retrieve the salary of the worker with the given ID and returns it in the salary_pro parameter. Then make the procedure call.
   
DELIMITER $$

CREATE PROCEDURE Get_Worker_Salary(IN Worker_Id_pro INT,OUT Salary_pro INT)

BEGIN

    SELECT Salary INTO Salary_pro FROM Worker WHERE Worker_Id =   Worker_Id_pro;
    
END $$

DELIMITER ;

SET @salary = 0;

CALL Get_Worker_Salary(1, @salary);

SELECT @salary AS Salary;

![image](https://github.com/user-attachments/assets/017c22aa-d8b1-42a2-abb3-eed93afc39fb)

3. Create a stored procedure that takes in IN parameters for WORKER_ID and DEPARTMENT.It should update the department of the worker with the given ID. Then make a procedure call. 

DELIMITER $$

CREATE PROCEDURE Update_Department_of_worker(IN Worker_Id_pro INT,IN Department_pro CHAR(25))

BEGIN

    UPDATE Worker SET Department = Department_pro WHERE Worker_Id = Worker_Id_pro;
    
END $$

DELIMITER ;

CALL Update_Department_of_worker(1, 'Engineering');

SELECT * FROM WORKER;

![image](https://github.com/user-attachments/assets/94492b07-5168-4a78-8aec-02000828e713)

4. Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_workerCount.It should retrieve the number of workers in the given department and returns it in the p_workerCount parameter. Make procedure call.
   
DELIMITER $$

CREATE PROCEDURE Worker_CountBy_Department(IN p_Department CHAR(25),OUT p_WorkerCount INT)

BEGIN

    SELECT COUNT(*) INTO p_WorkerCount FROM Worker WHERE Department = p_Department;
    
END $$

DELIMITER ;

SET @workerCount = 0;

CALL Worker_CountBy_Department('IT', @workerCount);

SELECT @workerCount AS WorkerCount; 

![image](https://github.com/user-attachments/assets/84d70a58-fae9-4314-bbf0-cbd2fa40f23c)

5. Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_avgSalary.It should retrieve the average salary of all workers in the given department and returns it in the p_avgSalary parameter and call the procedure.
   
DELIMITER $$

CREATE PROCEDURE Average_SalaryBy_Department(IN p_Department CHAR(25),OUT p_AvgSalary DECIMAL(10, 2))

BEGIN

    SELECT AVG(Salary) INTO p_AvgSalary FROM Worker WHERE Department = p_Department;
    
END $$

DELIMITER ;

SET @avgSalary = 0;

CALL Average_SalaryBy_Department('Sales', @avgSalary);

SELECT @avgSalary AS AvgSalary;

![image](https://github.com/user-attachments/assets/b795457a-8e58-4758-9175-9fd19f4c1fc8)












