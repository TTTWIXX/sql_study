CREATE TABLE tbl_score (
   name VARCHAR2(4) NOT NULL,
   kor NUMBER(3) NOT NULL CHECK(kor > 0 AND kor <= 100),
   eng NUMBER(3) NOT NULL CHECK(eng > 0 AND eng <= 100),
   math NUMBER(3) NOT NULL CHECK(math > 0 AND math <= 100),
   total NUMBER(3) NULL,
   avarage NUMBER(5, 2),
   grade CHAR(1),
   stu_num NUMBER(6),
   -- PK 거는법(table 생성과 함게)
   CONSTRAINT pk_stu_num 
   PRIMARY KEY (stu_num);

-- 테이블 생성 후 PK 적용하기
ALTER TABLE tbl_score
ADD CONSTRAINT pk_stu_num 
   PRIMARY KEY (stu_num);


  ADD CONSTRAINT PK_STU
  
  
  
-- 컬럼 추가하기
ALTER TABLE
	TBL_SCORE 
add(sci NUMBER(3) NOT null);

-- 컬럼 제거하기
ALTER TABLE
	TBL_SCORE 
	DROP COLUMN SCI;
	
-- 테이블 복사(TB_EMP)
-- CTAS
CREATE TABLE TB_EMP_COPY AS SELECT  * FROM TB_EMP;

CREATE TABLE TB_EMP_COPYCOPY AS SELECT * FROM TB_EMP;

-- 복사 테이블 조회
SELECT  * FROM TB_EMP_COPY;
SELECT * FROM TB_EMP;


-- DROP TABLE
DROP TABLE TB_EMP_COPY;

--TRUNCATE TABLE
-- 구조는 냅두고 내부 데이터만 전체 삭제
TRUNCATE TABLE TB_EMP_COPY;


-- 예시 테이블

CREATE TABLE GOODS(
ID NUMBER(6) PRIMARY KEY,
G_NAME VARCHAR2(10) NOT NULL,
PRICE NUMBER(10) DEFAULT 1000,
REG_DATE DATE
);

SELECT * FROM GOODS;
INSERT INTO GOODS(ID,G_NAME,PRICE,REG_DATE) VALUES (1,' 선풍','120000',SYSDATE);
--INSERT INTO GOODS(ID,G_NAME,REG_DATE) VALUES (2,'달고나',SYSDATE);
INSERT INTO GOODS(ID,G_NAME,PRICE) VALUES (3,'후리',500);

-- 칼럼명 생략시 모든 컬럼으ㅔ 대해 순서대로 넣어야 함.
INSERT INTO GOODS VALUES(4,'세탁기', 10000,SYSDATE);


SELECT * FROM GOODS;




-- 수정 UPDATE 
UPDATE GOODS
SET G_NAME='냉장고'
WHERE ID=3;

UPDATE GOODS
SET G_NAME='콜라', PRICE=3000
WHERE ID=2;


UPDATE GOODS
SET PRICE=9999;
-- WHERE 절을 안쓰면 모든 PRICE가 9999로 바뀜
-- DML 은 복구가 쉽다.


--행을 삭제 DELETE 
DELETE FROM GOODS
WHERE ID=3;

-- 모든 행 삭제(WHERE절 안쓰면됨)
DELETE FROM GOODS;

--SELECT 조회(ALL은 생략 가능)
SELECT ALL
ISSUE_INSTI_NM 
FROM TB_CERTI
;

-- 중복 제거 distinct(select 뒤에 )
SELECT DISTINCT 
ISSUE_INSTI_NM 
FROM TB_CERTI
;

-- 모든 컬럼 조회
-- 실무에서는 사용 X
SELECT 
*
FROM TB_CERTI
;

-- 열 별칭 부여(alias)
SELECT
	EMP_NM AS "사원이름",-- AS 생략가능
	ADDR AS "사원 주소" -- 띄어쓰기 있을때는 "" 없으면 생략가능
FROM TB_EMP
;

SELECT
	EMP_NM 사원이름,
	ADDR  "사원 주소"
FROM TB_EMP
;

-- table이 여러개 있을경우 te.해서 별칭을 붙여
SELECT   
   te.EMP_NM 사원명,
   te.ADDR AS "사원의 거주지 주소"
FROM TB_EMP te
;

-- 문자열 연결하기

SELECT 
CERTI_NM ||'('|| ISSUE_INSTI_NM ||')' AS "자격증 정보"
FROM TB_CERTI tc 
;
