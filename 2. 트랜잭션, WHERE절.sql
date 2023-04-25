CREATE TABLE employees (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    salary NUMBER(8,2)
);

INSERT INTO employees VALUES (1, 'Alice', 5000);
INSERT INTO employees VALUES (2, 'Bob', 6000);
INSERT INTO employees VALUES (3, 'Charlie', 7000);


-- 급여 총합 조회
SELECT sum(salary) FROM EMPLOYEES;

-- AUTO COMMIT을 MANUAL COMMIT으로 바꿈
COMMIT; -- 변경사항을 완전히 DB에 반영


--트랜잭션 시작
BEGIN
	-- 모든 사원들의 급여를 1000씩 올려줄거다
	UPDATE EMPLOYEES 
	SET SALARY =SALARY +1000;
-- 급여 총합 조회
	SELECT SUM(SALARY) FROM EMPLOYEES;

	ROLLBACK;

END;
-- S,I,U,D(DML)은 COMMIT을 해줘야 확정됨



--WHERE 조건절
SELECT 
EMP_NO ,EMP_NM ,ADDR ,SEX_CD 
FROM TB_EMP
WHERE SEX_CD =1;

-- WHERE 절로 PK 동등조건을 걸면
-- 무조건 단일행이 조회된다.
SELECT
EMP_NO ,EMP_NM ,ADDR ,SEX_CD 
FROM TB_EMP te 
WHERE EMP_NO =1000000003;


-- 비교 연산자(90년대생만 조회)
SELECT 
EMP_NO ,EMP_NM ,BIRTH_DE ,TEL_NO 
FROM TB_EMP
WHERE BIRTH_DE >='19900101' 
	AND BIRTH_DE <='19991231'
;


-- BETWEEN 연산자
SELECT 
EMP_NO ,EMP_NM ,BIRTH_DE ,TEL_NO 
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19900101'AND '19991231'
;


-- OR 연산
SELECT 
	EMP_NO, EMP_NM ,DEPT_CD 
	FROM TB_EMP
	WHERE DEPT_CD ='100004'
	OR DEPT_CD ='100006'
	;

-- IN 연산
SELECT 
	EMP_NO, EMP_NM ,DEPT_CD 
	FROM TB_EMP
	WHERE DEPT_CD IN ('100004','100006')
	;


-- NOT IN 연산(둘다 빼고 조회)
SELECT 
	EMP_NO, EMP_NM ,DEPT_CD 
	FROM TB_EMP
	WHERE DEPT_CD NOT IN ('100004','100006')
	;

--LIKE 연산자
-- 검색에서 주로 사용
-- 와일드 카드 매핑(% : 0글자 이상, _: 딱 1글자)
SELECT 
	EMP_NO ,EMP_NM 
FROM TB_EMP te 
WHERE EMP_NM LIKE '%심'
;

SELECT 
EMP_NO ,EMP_NM ,ADDR 
FROM TB_EMP te 
WHERE ADDR LIKE '%용인%';
;



SELECT 
	EMP_NO ,EMP_NM 
FROM TB_EMP te 
WHERE EMP_NM LIKE '이%'
;

SELECT DEPT_CD
FROM TB_EMP;

-- 성씨가 김씨이면서, 부서가 100003, 100004, 100006번 중에 하나이면서, 
-- 90년대생인 사원의 사번, 이름, 생일, 부서코드를 조회

SELECT EMP_NO ,EMP_NM,BIRTH_DE ,DEPT_CD 
FROM TB_EMP
WHERE 1=1
AND EMP_NM LIKE '김%'
AND DEPT_CD IN ('100003', '100004','100006')
AND BIRTH_DE BETWEEN  '19900101' AND '19991231'; 

-- 줄 분리를 통해 쉽게 주석처리 할수있다.
-- 1=1 항상 참!




-- '이_' _ 자리수 제한 1개만 이X   //  '이__' 이XX
SELECT 
	EMP_NO ,EMP_NM 
FROM TB_EMP te 
WHERE EMP_NM LIKE '이_'
;

-- '_B%' 두번째 글자가 B


-- 부정 일치 비교 연산자
SELECT 
	EMP_NO,
	EMP_NM,
	ADDR,
	SEX_CD
FROM TB_EMP
WHERE SEX_CD<>2;



-- 성별코드가 1이 아니면서 성씨가 이씨가 아닌 사람들의
-- 사번, 이름, 성별코드를 조회하세요.
SELECT 
	EMP_NO,
	EMP_NM,
	SEX_CD
FROM TB_EMP
WHERE 1=1
AND SEX_CD <>1
AND EMP_NM NOT LIKE '이%';


-- NULL 값 조회
-- 반드시 IS NULL 연산자로 조회해야 한다.EX) = NULL 안된다!!!!!!!!!!
-- 부정의 경우 NOT IS NULL 이 아니라 IS NOT NULL 이다.(영어 문법 처럼 적용)
SELECT 
	EMP_NO,
	EMP_NM,
	DIRECT_MANAGER_EMP_NO
FROM TB_EMP
WHERE DIRECT_MANAGER_EMP_NO IS NULL
;

-- 연산자 우선 순위
-- NOT>AND>OR
-- ()를 통해 우선순위 부여
SELECT 
	EMP_NO,
	EMP_NM,
	ADDR
FROM TB_EMP
WHERE 1=1
	AND EMP_NM LIKE '김%'
	AND (ADDR LIKE '%수원%' OR ADDR LIKE '%일산%');













