--CURSORES
--HR: Implemente un procedure que reciba un codigo de departamento
--y muestre en pantalla un reporte con el nombre del departamento
--y los datos de los empleados asociados (apellido y salario)

CREATE OR REPLACE PROCEDURE GET_EMPLOYEES(departmentId DEPARTMENTS.DEPARTMENT_ID%TYPE)
LANGUAGE PLPGSQL
AS
$$
DECLARE
	dptName DEPARTMENTS.DEPARTMENT_NAME%TYPE;
	
	curEmp CURSOR FOR
		SELECT LAST_NAME, SALARY 
		FROM EMPLOYEES 
		WHERE DEPARTMENT_ID = departmentId;		
BEGIN
	SELECT DEPARTMENT_NAME
	INTO dptName
	FROM DEPARTMENTS 
	WHERE DEPARTMENT_ID = departmentId;
	
	RAISE NOTICE 'Empleados del departamento %', dptName;
	RAISE NOTICE '****************************************';
	
	FOR emp IN curEmp LOOP
		RAISE NOTICE 'Apellido: %. Salario: %', emp.LAST_NAME, emp.SALARY;
	END LOOP;	
END;
$$

--PRUEBAS: BLOQUE ANONIMO
DO
$$
BEGIN
	CALL GET_EMPLOYEES(60);
END;
$$

--Académico: Implemente un procedure que, dados un valor de ciudad, muestre 
--en pantalla los nombres de todos los estudiantes que viven en esa ciudad. 

CREATE OR REPLACE PROCEDURE SHOW_STUDENTS(cityName ZIPCODE.CITY%TYPE)
LANGUAGE PLPGSQL
AS
$$
DECLARE
	curStudent CURSOR FOR
	SELECT S.FIRST_NAME, S.LAST_NAME, Z.CITY 
	FROM STUDENT S
	INNER JOIN ZIPCODE Z
	ON S.ZIP = Z.ZIP
	WHERE CITY = cityName;
BEGIN
	FOR student in curStudent LOOP
		RAISE NOTICE '%, %', student.LAST_NAME, student.FIRST_NAME;
	END LOOP;	
END;
$$

DO
$$
BEGIN
	CALL SHOW_STUDENTS('STANFORD');
END;
$$












