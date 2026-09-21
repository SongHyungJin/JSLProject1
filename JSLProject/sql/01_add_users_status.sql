-- ============================================================
--  users 테이블에 status 컬럼 추가 (로그인/탈퇴/복구 기능이 요구하는 컬럼)
--  실행: SQL Developer 에서 프로젝트 계정으로 접속 → 실행 → COMMIT
--
--  원인: UsersDAO.loginByEmail 이 "... AND status = 'ACTIVE'" 로 status 를 참조하는데
--        users 테이블에 해당 컬럼이 없어 로그인이 실패함.
--  DEFAULT 'ACTIVE' NOT NULL 로 추가하면 기존 가입 계정도 즉시 로그인 가능해짐.
-- ============================================================

ALTER TABLE users ADD status VARCHAR2(20) DEFAULT 'ACTIVE' NOT NULL;

-- (선택) DAO가 사용하는 값만 허용하는 체크 제약
ALTER TABLE users ADD CONSTRAINT users_status_ck CHECK (status IN ('ACTIVE','WITHDRAWN'));

COMMIT;

-- (확인용) 컬럼과 기존 회원 상태 확인
-- SELECT id, email, nickname, status FROM users;
