-- ============================================================
--  places 테이블에 google_place_id 컬럼 추가
--  용도: 구글 Places 점포를 "찜"할 때 우리 DB에 저장하되, 같은 점포가 중복 저장되지 않도록
--        구글의 place_id 를 키로 사용한다. (점포정보=Places, 찜/루트=우리 DB 하이브리드)
--  실행: SQL Developer 에서 프로젝트 계정 접속 → 실행 → COMMIT
--  ※ 기존(수동 입력) 점포들은 google_place_id 가 NULL 로 남는다(정상). Oracle 유니크는 NULL 중복 허용.
-- ============================================================

ALTER TABLE places ADD google_place_id VARCHAR2(300);

ALTER TABLE places ADD CONSTRAINT places_gpid_uk UNIQUE (google_place_id);

COMMIT;

-- (확인용)
-- SELECT id, name, category, region, google_place_id FROM places ORDER BY id;
