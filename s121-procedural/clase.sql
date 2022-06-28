--PRIMER PROGRAMA
DO $$
BEGIN
	RAISE NOTICE 'Hola mundo';
END;
$$

--VARIABLES Y TIPOS DE DATO
DO $$
DECLARE
	name VARCHAR;
	lastName VARCHAR := 'Pardo';
	fullName VARCHAR;
	grade NUMERIC := 10;
	today DATE;
BEGIN
	name := 'Cesar';
	fullName := name || ' ' || lastName;
	grade := grade + 3;
	today := CURRENT_DATE;
	RAISE NOTICE 'El alumno % tiene nota %', UPPER(fullName), grade;
	RAISE NOTICE 'Hoy es %', TO_CHAR(today, 'DD/MM/YYYY');
END;
$$

--ESTRUCTURAS SELECTIVAS
--Reciba la nota de un alumno y muestre un mensaje en funcion a su rendimiento:
--nota [0, 10]: Desaprobado
--nota <10, 15]: Aprobado
--nota [15, 20]: Sobresaliente
--Precondicion: La nota esta en el intervalo [0, 20]
DO $$
DECLARE
	grade NUMERIC := 10;
BEGIN
	IF grade <= 10 THEN
		RAISE NOTICE 'Desaprobado';
	ELSIF grade <= 15 THEN
		RAISE NOTICE 'Aprobado';
	ELSE
		RAISE NOTICE 'Sobresaliente';
	END IF;	
END;
$$

--ESTRUCTURAS REPETITIVAS
--Implemente un programa que permite calcular el factorial de un numero "n"
DO $$
DECLARE
	n NUMERIC := 6;
	factorial NUMERIC := 1;
BEGIN
	FOR i IN 1..n LOOP	
		factorial := factorial * i;
	END LOOP;
	RAISE NOTICE 'El factorial de % es %', n, factorial;
END;
$$

--FUNCIONES Y PROCEDURES

--Implemente un procedure que reciba un idInicial y un idFinal y muestre
--todos el nombre completo y el salario de los empleados con codigo 
--en el intervalo [idInicial, idFinal]. Utilice una funcion para obtener
--el nombre completo.

--Creacion de Funcion
CREATE OR REPLACE FUNCTION GET_FULL_NAME(employeeId EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURNS VARCHAR
LANGUAGE PLPGSQL
AS
$$
DECLARE
	fullName VARCHAR;
BEGIN
	SELECT FIRST_NAME || ' ' || LAST_NAME
	INTO fullName
	FROM EMPLOYEES
	WHERE EMPLOYEE_ID = employeeId;

	RETURN fullName;
END;
$$

--Pruebas de Funcion: Bloque PL/pgSQL
DO $$
BEGIN
	RAISE NOTICE 'Nombre completo: %', GET_FULL_NAME(101);
END;
$$

--Pruebas de Funcion: Consulta
SELECT EMPLOYEE_ID, GET_FULL_NAME(EMPLOYEE_ID) FROM EMPLOYEES;


--Creacion de Procedure
CREATE OR REPLACE PROCEDURE SHOW_REPORT(first EMPLOYEES.EMPLOYEE_ID%TYPE, last EMPLOYEES.EMPLOYEE_ID%TYPE)
LANGUAGE PLPGSQL
AS
$$
DECLARE
	empFullName VARCHAR;
	empSalary EMPLOYEES.SALARY%TYPE;
BEGIN
	FOR employeeId IN first..last LOOP			
		SELECT SALARY
		INTO empSalary
		FROM EMPLOYEES
		WHERE EMPLOYEE_ID = employeeId;
		--Llamado a la funcion anterior
		empFullName := GET_FULL_NAME(employeeId);

		RAISE NOTICE 'Nombre completo: %', empFullName;
		RAISE NOTICE 'Salario: %', empSalary;
	END LOOP;	
END;
$$

--Pruebas del Procedure: Bloque PL/pgSQL
DO $$
BEGIN
	CALL SHOW_REPORT(100, 106);
END;
$$

























