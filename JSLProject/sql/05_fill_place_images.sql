-- ============================================================
--  시드 점포에 썸네일(image_url) 채우기 (데모용)
--  실행: SQL Developer 에서 실행 → COMMIT
--
--  * image_url 이 비어있는 점포에만, 점포 id 기반의 안정적인 플레이스홀더 이미지를 넣는다.
--    (Lorem Picsum: 같은 id면 항상 같은 사진이 나옴. 인터넷 연결 필요.)
--  * 실제 사진으로 바꾸고 싶으면 각 점포의 image_url 을 원하는 이미지 주소로 UPDATE 하면 된다.
--  * 관리자 등록 화면(placeRegister.jsp)에서 새로 넣는 점포는 이미지 URL 을 직접 입력할 수 있다.
-- ============================================================

UPDATE places
   SET image_url = 'https://picsum.photos/seed/place' || id || '/400/300'
 WHERE image_url IS NULL;

COMMIT;

-- (확인용) 채워진 이미지 URL 보기
-- SELECT id, name, image_url FROM places ORDER BY id;
