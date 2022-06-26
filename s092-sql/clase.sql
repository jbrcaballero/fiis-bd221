--CREACION DE TABLA
CREATE TABLE EMPLEADO(
	ID NUMERIC(5) PRIMARY KEY,
	NOMBRE VARCHAR(100) NOT NULL,
	SALARIO NUMERIC(5, 2),
	FECHA_CONTRATACION DATE
);

--INSERCION DE DATOS
INSERT INTO EMPLEADO(ID, NOMBRE) VALUES(101, 'PEDRO VASQUEZ');

--ACTUALIZACION DE DATOS
UPDATE EMPLEADO 
SET SALARIO = 10000, FECHA_CONTRATACION = TO_DATE('10/10/2021', 'DD/MM/YYYY')
WHERE ID = 101;

--ELIMINACION DE DATOS
DELETE FROM EMPLEADO WHERE SALARIO <= 8500;

--MODIFICAR LA ESTRUCTURA DE LA TABLA (ALTER TABLE)
ALTER TABLE EMPLEADO ALTER COLUMN SALARIO TYPE NUMERIC(7,2);
ALTER TABLE EMPLEADO ADD CANT_AMONESTACIONES NUMERIC(2);
UPDATE EMPLEADO SET CANT_AMONESTACIONES = 0;

/*
JOINS
*****
*/
-- OLD-STYLE
SELECT E.FIRST_NAME, E.LAST_NAME, E.SALARY, D.DEPARTMENT_NAME, L.CITY
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID;

-- ANSI-SQL
SELECT E.FIRST_NAME, E.LAST_NAME, E.SALARY, D.DEPARTMENT_NAME, L.CITY
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
INNER JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;


--LEFT JOIN
SELECT *
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.DEPARTMENT_ID IS NULL;


--MOSTRAR EL NOMBRE COMPLETO DEL EMPLEADO Y EL NOMBRE COMPLETO DE SU SUPERVISOR
SELECT 	E.FIRST_NAME || ' ' || E.LAST_NAME AS EMPLOYEE, 
		MGR.FIRST_NAME || ' ' || MGR.LAST_NAME AS MANAGER
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES MGR
ON E.MANAGER_ID = MGR.EMPLOYEE_ID;

--RIGHT JOIN (SOLO CAMBIA EL ORDEN DE LAS TABLAS)
SELECT 	E.FIRST_NAME || ' ' || E.LAST_NAME AS EMPLOYEE, 
		MGR.FIRST_NAME || ' ' || MGR.LAST_NAME AS MANAGER
FROM EMPLOYEES MGR
RIGHT JOIN EMPLOYEES E
ON E.MANAGER_ID = MGR.EMPLOYEE_ID;

--GROUP BY
--Reporte de la cantidad de empleados por departamento, considerando tanto
--los departamentos sin empleados como los empleados sin ningun departamento
--asociado (FULL OUTER JOIN)
SELECT COALESCE(D.DEPARTMENT_NAME, '<None>'), COUNT(E.EMPLOYEE_ID)
FROM EMPLOYEES E
FULL OUTER JOIN DEPARTMENTS D 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME;

--El mismo deporte considerando solo los departamentos con mas de 2 empleados
--y ordenado de forma descendente
SELECT COALESCE(D.DEPARTMENT_NAME, '<None>'), COUNT(E.EMPLOYEE_ID)
FROM EMPLOYEES E
FULL OUTER JOIN DEPARTMENTS D 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
HAVING COUNT(E.EMPLOYEE_ID) > 2
ORDER BY COUNT(E.EMPLOYEE_ID) DESC;