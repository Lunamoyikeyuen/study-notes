CREATE DATABASE IF NOT EXISTS mydatabase DEFAULT CHARACTER SET utf8mb4;
SHOW DATABASES;
USE mydatabase;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  emp_id     INT PRIMARY KEY,
  emp_name   VARCHAR(50),
  gender     VARCHAR(10),
  age        INT,
  salary     DECIMAL(10,2),
  hire_date  DATE,
  dept_id    INT
);

--INSERT INTO 表 (列...) VALUES (值...)
INSERT INTO employees (emp_id, emp_name, gender, age, salary, hire_date, dept_id)
VALUES (201, 'Luna', 'F', 27, 13500.00, '2025-09-06', 20);

SELECT * FROM employees WHERE emp_id = 201;
-- 自动展示最新表数据
SELECT * FROM employees ORDER BY emp_id;

INSERT INTO employees (emp_id, emp_name, gender, age, salary, hire_date, dept_id)
VALUES
(202, 'Mike', 'M', 30, 15000.00, '2025-09-06', 10),
(203, 'Nina', 'F', 25, 10000.00, '2025-09-06', 20);


-- =============================
-- 2. 更新示例
-- =============================
UPDATE employees
SET salary = salary + 1000
WHERE emp_id = 201;

-- 自动展示更新结果
SELECT * FROM employees WHERE emp_id = 201;

-- =============================
-- 3. 删除示例
-- =============================
DELETE FROM employees
WHERE emp_id = 201;

-- 自动展示删除后的表
SELECT * FROM employees ORDER BY emp_id;