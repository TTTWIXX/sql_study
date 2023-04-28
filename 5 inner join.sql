



-- 사원들의 사번, 이름, 주소, 부서명
SELECT 
    E.emp_no, E.emp_nm, E.addr, D.dept_nm
FROM tb_emp AS E 
JOIN tb_dept AS D
ON E.dept_cd = D.dept_cd
;

-- 조인 기초 테스트 데이터
CREATE TABLE TEST_A (
    id NUMBER(10) PRIMARY KEY
    , content VARCHAR2(200)
);
CREATE TABLE TEST_B (
    b_id NUMBER(10) PRIMARY KEY
    , reply VARCHAR2(100)
    , a_id NUMBER(10)
);

INSERT INTO TEST_A  VALUES (1, 'aaa');
INSERT INTO TEST_A  VALUES (2, 'bbb');
INSERT INTO TEST_A  VALUES (3, 'ccc');

INSERT INTO TEST_B  VALUES (1, 'ㄱㄱㄱ', 1);
INSERT INTO TEST_B  VALUES (2, 'ㄴㄴㄴ', 1);
INSERT INTO TEST_B  VALUES (3, 'ㄷㄷㄷ', 2);
INSERT INTO TEST_B  VALUES (4, 'ㄹㄹㄹ', 3);
COMMIT;

SELECT * FROM test_a;
SELECT * FROM test_b;

-- CROSS JOIN, 카테시안 곱(조건없이 다곱함, cartesian product)
SELECT 
    *
FROM test_a, test_b --오라클에서만 사용(join은 기본적으로 가로로 연결하는것)
;-- test_a 3줄, text_b 4줄 그래서 join하면 12줄

SELECT 
e.emp_no,
e.emp_nm,
e.DEPT_CD,
d.DEPT_CD,
d.DEPT_NM 
FROM tb_emp e,TB_DEPT d
WHERE e.DEPT_CD =d.dept_cd;
-- 매칭되는것만 가져와라!!(where이없으면 곱연산해서 다 가져와 버린다.)=inner join








-- INNER JOIN (EQUI JOIN의 한 종류)
SELECT 
    *
FROM test_a, test_b
WHERE test_a.id = test_b.a_id -- 조인 조건
;

SELECT 
    test_a.id, test_a.content, test_b.reply
FROM test_a, test_b
WHERE test_a.id = test_b.a_id 
;

SELECT 
    A.id, A.content, B.reply
FROM test_a A, test_b B
WHERE A.id = B.a_id 
;


-- 자격증 관련 테이블
SELECT * FROM tb_emp;
SELECT * FROM tb_emp_certi;
SELECT * FROM tb_certi;


-- 사원의 사원번호와 취득 자격증명을 조회하고 싶음
SELECT
 A.emp_no,
 B.certi_nm
-- a.CERTI_CD,
-- b.CERTI_CD 
FROM tb_emp_certi A, tb_certi B
WHERE A.certi_cd = B.certi_cd
ORDER BY A.emp_no, B.certi_cd
;

-- 사원의 사원번호와 사원이름과 취득 자격증명을 조회하고 싶음
SELECT
    A.emp_no, C.emp_nm, B.certi_nm
FROM tb_emp_certi A, tb_certi B, tb_emp C
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
ORDER BY A.emp_no, B.certi_cd
;

-- 사원의 사원번호와 사원이름과 부서이름과 취득 자격증명을 조회하고 싶음
SELECT
    A.emp_no, C.emp_nm, D.dept_nm, B.certi_nm
FROM tb_emp_certi A, tb_certi B, tb_emp C, tb_dept D
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
    AND C.dept_cd = D.dept_cd
ORDER BY A.emp_no, B.certi_cd
;


-- 부서별 총 자격증 취득 수를 조회

SELECT 
    B.dept_cd, C.dept_nm, COUNT(A.certi_cd) "부서별 자격증 수"
FROM tb_emp_certi A, tb_emp B, tb_dept C
WHERE A.emp_no = B.emp_no
    AND B.dept_cd = C.dept_cd
GROUP BY B.dept_cd, C.dept_nm
ORDER BY B.dept_cd
;


-- # INNER JOIN
-- 1. 2개 이상의 테이블이 공통된 컬럼에 의해 논리적으로 결합되는 조인기법입니다.
-- 2. WHERE절에 사용된 컬럼들이 동등연산자(=)에 의해 조인됩니다.

-- 용인시에 사는 사원의 사원번호, 사원명, 주소, 부서코드, 부서명을 조회하고 싶다.

SELECT 
    A.emp_no, A.emp_nm, A.addr, A.dept_cd, B.dept_nm
FROM tb_emp A, tb_dept B
WHERE 1=1
	AND A.addr LIKE '%용인%'
    AND A.dept_cd = B.dept_cd
    AND A.emp_nm LIKE '김%'
ORDER BY A.emp_no
;

-- JOIN ON (ANSI 표준 조인)
-- 1. FROM절 뒤, WHERE 절 앞
-- 2. JOIN 키워드 뒤에는 조인할 테이블명을 명시
-- 3. ON 키워드 뒤에는 조인 조건을 명시
-- 4. 조인 조건 서술부(ON절) 일반 조건 서술부 (WHERE절)를 분리해서 작성하는 방법
-- 5. ON절을 이용하면 JOIN 이후의 논리연산이나 서브쿼리와 같은 추가 서술이 가능

SELECT 
    A.emp_no, A.emp_nm, A.addr, A.dept_cd, B.dept_nm
FROM tb_emp A 
INNER JOIN tb_dept B --그냥 join은 INNER JOIN 이다.(on 조건에 매칭되는 조건만 가져오는것을 inner join 이라고한다.)
ON A.dept_cd = B.dept_cd
WHERE 1=1
	AND A.addr LIKE '%용인%' 
    AND A.emp_nm LIKE '김%'
ORDER BY A.emp_no
;

-- 1980년대생 사원들의 사번, 사원명, 부서명, 자격증명, 취득일자를 조회
SELECT
    E.emp_no, E.emp_nm, E.birth_de, D.dept_nm, C.certi_nm, EC.acqu_de
FROM tb_emp E, tb_dept D, tb_emp_certi EC, tb_certi C
WHERE E.dept_cd = D.dept_cd
    AND EC.certi_cd = C.certi_cd
    AND E.emp_no = EC.emp_no
    AND E.birth_de BETWEEN '19800101' AND '19891231'
; -- 오라클 JOIN 방식은 JOIN 조건과 일반 조건을 구분하기 힘들다.

SELECT
    E.emp_no, E.emp_nm, E.birth_de, D.dept_nm, C.certi_nm, EC.acqu_de
FROM tb_emp E 
JOIN tb_dept D 
ON E.dept_cd = D.dept_cd
JOIN tb_emp_certi EC 
ON E.emp_no = EC.emp_no
JOIN tb_certi C
ON EC.certi_cd = C.certi_cd
WHERE E.birth_de BETWEEN '19800101' AND '19891231'
;


-- SELECT [DISTINCT] { 열이름 .... } 
-- FROM  테이블 또는 뷰 이름
-- JOIN  테이블 또는 뷰 이름
-- ON    조인 조건
-- WHERE 조회 조건
-- GROUP BY  열을 그룹화
-- HAVING    그룹화 조건
-- ORDER BY  정렬할 열 [ASC | DESC];



-- JOIN ON 구문으로 카테시안 곱 만들기
SELECT 
    *
FROM test_a A, test_B b
;

SELECT 
    *
FROM test_a A 
CROSS JOIN test_B b
;


-- # NATURAL JOIN
-- 1. NATURAL JOIN은 동일한 이름을 갖는 컬럼들에 대해 자동으로 조인조건을 생성하는 기법입니다.
-- 2. 즉, 자동으로 2개 이상의 테이블에서 같은 이름을 가진 컬럼을 찾아 INNER조인을 수행합니다.
-- 3. 이 때 조인되는 동일 이름의 컬럼은 데이터 타입이 같아야 하며, 
--    ALIAS나 테이블명을 자동 조인 컬럼 앞에 표기하면 안됩니다.
-- 4. SELECT * 문법을 사용하면, 공통 컬럼은 집합에서 한번만 표기됩니다.
-- 5. 공통 컬럼이 n개 이상이면 조인 조건이 n개로 처리됩니다.


-- 사원 테이블과 부서 테이블을 조인 (사번, 사원명, 부서코드, 부서명)
SELECT 
    A.emp_no, A.emp_nm, B.dept_cd, B.dept_nm
FROM tb_emp A
INNER JOIN tb_dept B
ON A.dept_cd = B.dept_cd
;


SELECT 
    A.emp_no, A.emp_nm, dept_cd, B.dept_nm
  					-- 하나로 합쳐서 나오기 때문에 별칭을 쓰면안된다.
FROM tb_emp A
NATURAL JOIN tb_dept B
; -- 공통된 컬럼은 한번만 나온다. (inner join과 다른점)

-- # USING절 조인
-- 1. NATURAL조인에서는 자동으로 이름과 타입이 일치하는 모든 컬럼에 대해
--    조인이 일어나지만 USING을 사용하면 원하는 컬럼에 대해서면 선택적 조인조건을 
--    부여할 수 있습니다.
-- 2. USING절에서도 조인 컬럼에 대해 ALIAS나 테이블명을 표기하시면 안됩니다.
SELECT 
    A.emp_no, A.emp_nm, dept_cd, B.dept_nm
FROM tb_emp A
INNER JOIN tb_dept B
USING (dept_cd)
;


SELECT 
    *
FROM tb_emp A
INNER JOIN tb_dept B
ON A.dept_cd = B.dept_cd
;


SELECT 
    *
FROM tb_emp A
NATURAL JOIN tb_dept B
;

SELECT 
    *
FROM tb_emp A
INNER JOIN 