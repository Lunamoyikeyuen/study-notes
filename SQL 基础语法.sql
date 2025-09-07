-- ==========================
-- 0. 数据库管理
-- ==========================
-- 创建数据库（IF NOT EXISTS 避免已存在时报错）
CREATE DATABASE IF NOT EXISTS mydatabase DEFAULT CHARACTER SET utf8mb4;
SHOW DATABASES;

-- 切换到这个数据库
USE mydatabase;
SELECT DATABASE();
-- =========================
-- 0. 数据库管理
-- ==========================
-- 创建数据库（IF NOT EXISTS 避免已存在时报错）
CREATE DATABASE IF NOT EXISTS sql_demo DEFAULT CHARACTER SET utf8mb4;
-- 切换到这个数据库
USE sql_demo;
-- 查看当前数据库
SELECT DATABASE();
-- 删除数据库（谨慎使用，会清空所有数据）
-- DROP DATABASE sql_demo;

-- ==========================
-- 1. 表管理 (DDL: Data Definition Language)
-- ==========================
-- 创建表：员工表
CREATE TABLE IF NOT EXISTS employees (
  emp_id     INT PRIMARY KEY,           -- 主键（唯一标识）
  emp_name   VARCHAR(50) NOT NULL,      -- 姓名，不允许为空
  gender     VARCHAR(10),               -- 性别，可以为空
  age        INT,                       -- 年龄
  salary     DECIMAL(10,2),             -- 工资，保留两位小数
  hire_date  DATE,                      -- 入职日期
  dept_id    INT                        -- 部门ID
);

-- 删除表
-- DROP TABLE employees;

-- 查看当前库的所有表
SHOW TABLES;

-- 查看表结构
DESC employees;

-- ==========================
-- 2. 插入数据 (DML: Data Manipulation Language)
-- ==========================
-- 插入一条完整记录
INSERT INTO employees (emp_id, emp_name, gender, age, salary, hire_date, dept_id)
VALUES (1, 'Alice', 'F', 28, 12000.00, '2021-03-15', 10);

-- 插入多条记录
INSERT INTO employees (emp_id, emp_name, gender, age, salary, hire_date, dept_id)
VALUES
(2, 'Bob',   'M', 35, 15000.00, '2019-07-01', 10),
(3, 'Cindy', 'F', 26,  9000.00, '2022-10-10', 20);

-- 插入部分列（未指定的列默认为 NULL 或默认值）
INSERT INTO employees (emp_id, emp_name, age)
VALUES (4, 'David', 30);

-- ==========================
-- 3. 查询数据 (DQL: Data Query Language)
-- ==========================
-- 查询所有列
SELECT * FROM employees;

-- 查询部分列，并重命名
SELECT emp_name AS 姓名, salary AS 工资 FROM employees;

-- 条件查询
SELECT * FROM employees WHERE salary > 10000;

-- 多条件查询
SELECT * FROM employees WHERE salary > 10000 AND age < 30;

-- 排序查询
SELECT * FROM employees ORDER BY salary DESC;

-- 限制返回条数
SELECT * FROM employees LIMIT 2;

-- ==========================
-- 4. 更新数据
-- ==========================
-- 更新单个字段
UPDATE employees
SET salary = 16000
WHERE emp_id = 2;

-- 更新多个字段
UPDATE employees
SET age = 36, dept_id = 20
WHERE emp_id = 2;

-- ==========================
-- 5. 删除数据
-- ==========================
-- 删除指定记录
DELETE FROM employees WHERE emp_id = 4;

-- 删除所有记录（但保留表结构）
DELETE FROM employees;

-- 清空表（更快，重置自增）
-- TRUNCATE TABLE employees;

-- ==========================
-- 6. 聚合与分组
-- ==========================
-- 统计总人数
SELECT COUNT(*) AS 总人数 FROM employees;

-- 平均工资
SELECT AVG(salary) AS 平均工资 FROM employees;

-- 按部门统计平均工资
SELECT dept_id, AVG(salary) AS 部门平均工资
FROM employees
GROUP BY dept_id;

-- 分组后过滤（HAVING 必须配合 GROUP BY 使用）
SELECT dept_id, AVG(salary) AS 部门平均工资
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > 10000;

-- ==========================
-- 7. 约束与外键
-- ==========================
-- 创建部门表
CREATE TABLE IF NOT EXISTS departments (
  dept_id   INT PRIMARY KEY,
  dept_name VARCHAR(50) NOT NULL
);

-- 添加外键（员工表里的 dept_id 必须在部门表存在）
ALTER TABLE employees
ADD CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- ==========================
-- 8. 多表查询 (JOIN)
-- ==========================
-- 插入部门数据
INSERT INTO departments (dept_id, dept_name) VALUES
(10, 'Engineering'), (20, 'Marketing');

-- 查询员工及部门名称（内连接）
SELECT e.emp_name, e.salary, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- 左连接（即使部门不存在也显示员工）
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- ==========================
-- 9. 子查询
-- ==========================
-- 查询工资高于全公司平均工资的员工
SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- ==========================
-- 10. 视图 (虚拟表)
-- ==========================
-- 创建视图：高薪员工
CREATE VIEW high_salary_emps AS
SELECT emp_name, salary
FROM employees
WHERE salary > 12000;

-- 使用视图
SELECT * FROM high_salary_emps;
