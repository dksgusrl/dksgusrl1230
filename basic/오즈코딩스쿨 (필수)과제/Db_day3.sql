-- 1. employees 테이블 생성
-- CREATE TABLE employees (
--    id INT AUTO_INCREMENT PRIMARY KEY,
--    name VARCHAR(100),
--    position VARCHAR(100),
--    salary DECIMAL(10, 2)
-- );

-- 2. 직원 데이터 추가
--INSERT INTO employees (name, position, salary) VALUES
--('혜린', 'PM', 90000),
--('은우', 'Frontend', 80000),
--('가을', 'Backend', 92000),
--('지수', 'Frontend', 78000),
--('민혁', 'Frontend', 96000),
--('하온', 'Backend', 130000);

-- 3. 모든 직원의 이름과 연봉 정보 조회
--SELECT name, salary 
--FROM employees;

-- 4. Frontend 직책에서 연봉이 90000 이하인 직원의 이름과 연봉 조회
--SELECT name, salary 
--FROM employees 
--WHERE position = 'Frontend' AND salary <= 90000;

-- 5. PM 직책 직원의 연봉을 10% 인상
--UPDATE employees 
--SET salary = salary * 1.10 
--WHERE position = 'PM';

-- 5-1. PM 직책 연봉 인상 결과 확인
--SELECT name, position, salary 
--FROM employees 
--WHERE position = 'PM';

-- 6. Backend 직책 직원의 연봉을 5% 인상
--UPDATE employees 
--SET salary = salary * 1.05 
--WHERE position = 'Backend';

-- 7. 민혁 사원의 데이터 삭제
--DELETE FROM employees 
--WHERE name = '민혁';

-- 8. 직책별로 그룹화하여 평균 연봉 계산
--SELECT position, AVG(salary) as average_salary 
--FROM employees 
--GROUP BY position;

-- 9. employees 테이블 삭제
--DROP TABLE employees;
