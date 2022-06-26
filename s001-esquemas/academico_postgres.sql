--COLOCAMOS LOS SCRIPTS DROP AL INICIO, DE FORMA QUE PODAMOS REPROCESAR LA CREACION
DROP TABLE IF EXISTS GRADE_CONVERSION;
DROP TABLE IF EXISTS ENROLLMENT;
DROP TABLE IF EXISTS SECTION;
DROP TABLE IF EXISTS COURSE;
DROP TABLE IF EXISTS STUDENT;
DROP TABLE IF EXISTS INSTRUCTOR;
DROP TABLE IF EXISTS ZIPCODE;

CREATE TABLE ZIPCODE(
ZIP VARCHAR(5) PRIMARY KEY,
CITY VARCHAR(25),
STATE VARCHAR(2),
CREATED_BY VARCHAR(30) NOT NULL,
CREATED_DATE VARCHAR(30) NOT NULL,
MODIFIED_BY VARCHAR(30) NOT NULL,
MODIFIED_DATE DATE NOT NULL
);

/*
CURRENT_DATE: OBTIENE LA FECHA / HORA DEL SERVIDOR
USER: OBTIENE EL NOMBRE DEL USURIO LOGUEADO
*/
INSERT INTO ZIPCODE VALUES('90001', 'LOS ANGELES', 'CA', 'USER01', CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO ZIPCODE VALUES('91041', 'LOS ANGELES', 'CA', 'USER01', CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO ZIPCODE VALUES('33132', 'MIAMI', 'FL', 'USER01', CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO ZIPCODE VALUES('94305', 'STANFORD', 'CA', 'USER01', CURRENT_DATE, USER, CURRENT_DATE);

CREATE TABLE STUDENT(
STUDENT_ID NUMERIC(8,0) PRIMARY KEY,
SALUTATION VARCHAR(5),
FIRST_NAME VARCHAR(25),
LAST_NAME VARCHAR(25) NOT NULL,
STREET_ADDRESS VARCHAR(50),
ZIP VARCHAR(5) REFERENCES ZIPCODE NOT NULL,
PHONE VARCHAR(15),
EMPLOYER VARCHAR(50),
REGISTRATION_DATE DATE NOT NULL,
CREATED_BY VARCHAR(30) NOT NULL,
CREATED_DATE VARCHAR(30) NOT NULL,
MODIFIED_BY VARCHAR(30) NOT NULL,
MODIFIED_DATE DATE NOT NULL
);

INSERT INTO STUDENT VALUES(100, 'MR.', 'JUAN', 'PEREZ', 'CALLE1 484', '90001', '958576775', 'FACEBOOK', CURRENT_DATE, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO STUDENT VALUES(200, 'MISS.', 'JOHANA', 'RODRIGUEZ', 'CALLE2 685', '90001', '984758337', 'AMAZON', CURRENT_DATE, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO STUDENT VALUES(300, 'MR.', 'PEDRO', 'VARGAS', 'CALLE3 999', '91041', '934758867', 'GOOGLE', CURRENT_DATE, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO STUDENT VALUES(400, 'MRS.', 'KARINA', 'CESPEDES', 'CALLE11 746', '91041', '983745623', 'NETFLIX', CURRENT_DATE, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO STUDENT VALUES(500, 'MR.', 'ALVARO', 'GONZALES', 'CALLE9 366', '94305', '964732134', 'AMAZON', CURRENT_DATE, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO STUDENT VALUES(600, 'MRS.', 'MARIANA', 'MARTINEZ', 'CALLE8 766', '94305', '903857361', 'MICROSOFT', CURRENT_DATE, USER, CURRENT_DATE, USER, CURRENT_DATE);


CREATE TABLE INSTRUCTOR(
INSTRUCTOR_ID NUMERIC(8,0) PRIMARY KEY,
SALUTATION VARCHAR(5),
FIRST_NAME VARCHAR(25),
LAST_NAME VARCHAR(25),
STREET_ADDRESS VARCHAR(50),
ZIP VARCHAR(5) REFERENCES ZIPCODE,
PHONE VARCHAR(15),
CREATED_BY VARCHAR(30) NOT NULL,
CREATED_DATE VARCHAR(30) NOT NULL,
MODIFIED_BY VARCHAR(30) NOT NULL,
MODIFIED_DATE DATE NOT NULL
);

INSERT INTO INSTRUCTOR VALUES(201, 'DR.', 'ASHLEY', 'TAYLOR',  '450 Serra Mall', '94305', '985658663', USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO INSTRUCTOR VALUES(202, 'DR.', 'ERIC', 'ROBERTS',  NULL, '94305', '623358956', USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO INSTRUCTOR VALUES(203, 'MR.', 'JOHN', 'DOE',  '698 NE 1st Ave', '33132', '65895655', USER, CURRENT_DATE, USER, CURRENT_DATE);

/*
SE OBSERVA EN ESTA TABLA UNA RELACION RECURSIVA (SIMILAR A LA DE EMPLEADO - MANAGER)
CADA TUPLA DE CURSO SE RELACIONA A OTRA TUPLA DE CURSO QUE ES SU PRE-REQUISITO
PARA INDICAR ESA RELACION SOLAMENTE INCLUIIMOS "REFERENCES COURSE" EN EL CAMPO CORRESPONDIENTE
*/

CREATE TABLE COURSE(
COURSE_NO NUMERIC(8,0) PRIMARY KEY,
DESCRIPTION VARCHAR(50) NOT NULL,
COST NUMERIC(9,2),
PREREQUISITE NUMERIC(8,0) REFERENCES COURSE, --RELACION RECURSIVA
CREATED_BY VARCHAR(30) NOT NULL,
CREATED_DATE VARCHAR(30) NOT NULL,
MODIFIED_BY VARCHAR(30) NOT NULL,
MODIFIED_DATE DATE NOT NULL
);

INSERT INTO COURSE VALUES (101, 'INTRODUCTION TO COMPUTING AT STANFORD', 1000, NULL, USER, CURRENT_DATE, USER, CURRENT_DATE); 
INSERT INTO COURSE VALUES (102, 'PROGRAMMING ABSTRACTIONS (ACCELERATED)', 1000, NULL, USER, CURRENT_DATE, USER, CURRENT_DATE); 
INSERT INTO COURSE VALUES (105, 'LINEAR ALGEBRA', 1000, NULL, USER, CURRENT_DATE, USER, CURRENT_DATE); 
INSERT INTO COURSE VALUES (106, 'COMPUTER VISION: FOUNDATIONS AND APPLICATIONS', 1000, 105, USER, CURRENT_DATE, USER, CURRENT_DATE); 
INSERT INTO COURSE VALUES (103, 'MACHINE LEARNING', 1000, 106, USER, CURRENT_DATE, USER, CURRENT_DATE); 
INSERT INTO COURSE VALUES (107, 'MACHINE LEARNING II', 1000, 103, USER, CURRENT_DATE, USER, CURRENT_DATE); 
INSERT INTO COURSE VALUES (108, 'MACHINE LEARNING III', 1000, 107, USER, CURRENT_DATE, USER, CURRENT_DATE); 

/*
OBSERVESE LO SIGUIENTE:
- SECIONT_ID: CODIGO QUE IDENTIFICA A LA SECCION (PK)
- COURSE_NO: FK QUE REFERENCIA A LA TABLA CURSO
*/

CREATE TABLE SECTION(
SECTION_ID NUMERIC(8,0) PRIMARY KEY,
COURSE_NO NUMERIC(8,0) NOT NULL REFERENCES COURSE,
SECTION_NO NUMERIC(3,0) NOT NULL,
START_DATE_TIME DATE,
LOCATION VARCHAR(50),
INSTRUCTOR_ID NUMERIC(8,0) REFERENCES INSTRUCTOR,
CAPACITY NUMERIC(3,0),
CREATED_BY VARCHAR(30) NOT NULL,
CREATED_DATE VARCHAR(30) NOT NULL,
MODIFIED_BY VARCHAR(30) NOT NULL,
MODIFIED_DATE DATE NOT NULL
);

INSERT INTO SECTION VALUES(1001, 101, 1, TO_DATE('10/13/2020', 'MM/DD/YYYY'), 'S4-156', 201, 40, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO SECTION VALUES(1002, 101, 2, TO_DATE('10/13/2020', 'MM/DD/YYYY'), 'S2-655', 201, 40, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO SECTION VALUES(1003, 102, 1, TO_DATE('10/13/2020', 'MM/DD/YYYY'), 'S6-458', 202, 40, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO SECTION VALUES(1004, 102, 2, TO_DATE('10/13/2020', 'MM/DD/YYYY'), 'S5-623', 202, 25, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO SECTION VALUES(1005, 105, 1, TO_DATE('10/13/2020', 'MM/DD/YYYY'), 'S1-825', 203, 30, USER, CURRENT_DATE, USER, CURRENT_DATE);

/*
OBSERVE QUE LA TABLA ENROLLMENT (MATRICULA) ES UNA TABLA ASOCIATIVA.
LA TABLA VINCULA SECTION Y STUDENT.
PARA PODER DEFINIR LAS RESTRICCIONES DEBEMOS HACER LOS SIGUIENTE:
- DEFINIR EL CAMPO STUDENT_ID COMO FK.
    STUDENT_ID NUMERIC(8,0) REFERENCES STUDENT NOT NULL,
- DEFINIR EL CAMPO SECTION_ID COMO FK.
    SECTION_ID NUMERIC(8,0) REFERENCES SECTION NOT NULL,
- DEFINIR COMO PK A LA COMPOSICION DE AMBOS CAMPOS.
    PRIMARY KEY(STUDENT_ID, SECTION_ID)
*/

CREATE TABLE ENROLLMENT(
STUDENT_ID NUMERIC(8,0) REFERENCES STUDENT NOT NULL,
SECTION_ID NUMERIC(8,0) REFERENCES SECTION NOT NULL,
ENROLL_DATE DATE NOT NULL,
FINAL_GRADE NUMERIC(3,0),
CREATED_BY VARCHAR(30) NOT NULL,
CREATED_DATE VARCHAR(30) NOT NULL,
MODIFIED_BY VARCHAR(30) NOT NULL,
MODIFIED_DATE DATE NOT NULL,
PRIMARY KEY(STUDENT_ID, SECTION_ID)
);

INSERT INTO ENROLLMENT VALUES(100, 1001, CURRENT_DATE, 100, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO ENROLLMENT VALUES(100, 1003, CURRENT_DATE, 88, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO ENROLLMENT VALUES(100, 1005, CURRENT_DATE, 76, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO ENROLLMENT VALUES(200, 1002, CURRENT_DATE, 90, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO ENROLLMENT VALUES(200, 1003, CURRENT_DATE, 95, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO ENROLLMENT VALUES(200, 1005, CURRENT_DATE, 77, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO ENROLLMENT VALUES(300, 1005, CURRENT_DATE, 58, USER, CURRENT_DATE, USER, CURRENT_DATE);
INSERT INTO ENROLLMENT VALUES(400, 1005, CURRENT_DATE, 66, USER, CURRENT_DATE, USER, CURRENT_DATE);

/*
OBSERVESE EL USO DE LA TABLA GRADE_CONVERSION:
ME AYUDARA A CONVERTIR LAS NOTAS FINALES EN ESCALA 1 - 100 (FINAL_GRADE) A LETRAS.
*/

CREATE TABLE GRADE_CONVERSION(
LETTER_GRADE VARCHAR(2) PRIMARY KEY,
GRANDE_POINT NUMERIC(3,2) NOT NULL,
MAX_GRADE NUMERIC(3,0) NOT NULL,
MIN_GRADE NUMERIC(3,0) NOT NULL,
CREATED_BY VARCHAR(30) NOT NULL,
CREATE_DATE DATE NOT NULL,
MODIFIED_BY VARCHAR(30) NOT NULL,
MODIFIED_DATE DATE NOT NULL
);

INSERT INTO GRADE_CONVERSION VALUES ('A', 4, 100, 70, 'ADMIN', CURRENT_DATE, 'ADMIN', CURRENT_DATE);
INSERT INTO GRADE_CONVERSION VALUES ('B', 3, 69, 40, 'ADMIN', CURRENT_DATE, 'ADMIN', CURRENT_DATE);
INSERT INTO GRADE_CONVERSION VALUES ('C', 2, 39, 10, 'ADMIN', CURRENT_DATE, 'ADMIN', CURRENT_DATE);
INSERT INTO GRADE_CONVERSION VALUES ('D', 1, 9, 0, 'ADMIN', CURRENT_DATE, 'ADMIN', CURRENT_DATE);


