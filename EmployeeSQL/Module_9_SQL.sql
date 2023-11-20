CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title" VARCHAR   NOT NULL,
    "birth_date" INT   NOT NULL,
    "first_name" VARCHAR(255)   NOT NULL,
    "last_name" VARCHAR(255)   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" INT   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY ("emp_no")
);


CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY ("salary")
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" CHAR   NOT NULL
);

CREATE TABLE "debt_manager" (
    "dept_no" CHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" CHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY ("title")
);

CREATE TABLE "departments" (
    "dept_no" CHAR   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY ("dept_name")
);

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

---ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
---REFERENCES "salaries" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_name");

---ALTER TABLE "debt_manager" ADD CONSTRAINT "fk_debt_manager_dept_no_emp_no" FOREIGN KEY("dept_no", "emp_no")
---REFERENCES "dept_emp" ("dept_no", "emp_no");

---ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_title_id" FOREIGN KEY("title_id")
---REFERENCES "employees" ("emp_title");

ALTER TABLE "departments" ADD CONSTRAINT "fk_departments_dept_no" FOREIGN KEY("dept_no")
REFERENCES "dept_emp" ("emp_no");

