-- ============================================================
--  places 시연용 데이터 (추천 루트/지도 테스트용)
--  실행: SQL Developer 에서 프로젝트 계정으로 접속 → 워크시트에 붙여넣기 → 전체 실행(F5)
--        → 마지막의 COMMIT; 까지 반드시 실행!  (커밋 안 하면 앱에서 조회 안 됨)
--
--  * id        : places_seq.NEXTVAL 사용 (스키마의 시퀀스)
--  * category  : restaurant / cafe / shop / attraction  (체크 제약 준수, etc 제외)
--  * region    : seoul / kyoto / tokyo  (코드의 지도중심 CITY_CENTER 키와 일치)
--  * latitude/longitude : 실제 좌표 근사값 (number(10,7))
--  * rating    : number(2,1) 이므로 소수 한 자리 (0~5)
--  * created_at/updated_at : DEFAULT CURRENT_TIMESTAMP 라서 생략
-- ============================================================

-- ============================ 서울 (seoul) ============================
INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '명동교자', 'restaurant', 'seoul', 37.5636000, 126.9850000, '칼국수와 만두로 유명한 명동 노포', '10:30-21:30', NULL, 1, 4.5);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '광장시장 먹자골목', 'restaurant', 'seoul', 37.5701000, 126.9997000, '빈대떡·마약김밥 등 전통시장 먹거리', '09:00-22:00', NULL, 1, 4.3);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '어니언 안국', 'cafe', 'seoul', 37.5760000, 126.9856000, '한옥을 개조한 감성 베이커리 카페', '08:00-22:00', NULL, 1, 4.6);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '스타벅스 더종로R', 'cafe', 'seoul', 37.5704000, 126.9910000, '대형 리저브 로스터리 카페', '07:00-22:00', NULL, 1, 4.2);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '롯데백화점 본점', 'shop', 'seoul', 37.5654000, 126.9820000, '명동 대표 백화점', '10:30-20:00', NULL, 0, 4.1);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '경복궁', 'attraction', 'seoul', 37.5796000, 126.9770000, '조선의 정궁, 대표 고궁', '09:00-18:00', NULL, 0, 4.8);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '북촌한옥마을', 'attraction', 'seoul', 37.5826000, 126.9850000, '전통 한옥이 모인 골목', '상시', NULL, 0, 4.5);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '남산서울타워', 'attraction', 'seoul', 37.5512000, 126.9882000, '서울 야경 전망 명소', '10:00-23:00', NULL, 0, 4.6);

-- ============================ 교토 (kyoto) ============================
INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '이치란 교토점', 'restaurant', 'kyoto', 35.0036000, 135.7681000, '진한 돈코츠 라멘 전문점', '10:00-23:00', NULL, 1, 4.4);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '니시키 시장', 'shop', 'kyoto', 35.0050000, 135.7649000, '교토의 부엌이라 불리는 먹거리 시장', '09:00-18:00', NULL, 0, 4.3);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '아라비카 아라시야마', 'cafe', 'kyoto', 35.0130000, 135.6770000, '강변 뷰의 스페셜티 커피', '08:00-18:00', NULL, 1, 4.6);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '스타벅스 니넨자카점', 'cafe', 'kyoto', 34.9971000, 135.7823000, '전통 가옥을 살린 이색 스타벅스', '08:00-20:00', NULL, 1, 4.5);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '기요미즈데라', 'attraction', 'kyoto', 34.9949000, 135.7850000, '청수사, 교토를 대표하는 사찰', '06:00-18:00', NULL, 0, 4.8);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '아라시야마 대나무숲', 'attraction', 'kyoto', 35.0170000, 135.6720000, '대나무가 우거진 산책로', '상시', NULL, 0, 4.7);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '후시미 이나리 신사', 'attraction', 'kyoto', 34.9671000, 135.7727000, '천 개의 붉은 도리이로 유명', '상시', NULL, 0, 4.8);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '킨카쿠지(금각사)', 'attraction', 'kyoto', 35.0394000, 135.7292000, '금빛 누각으로 유명한 사찰', '09:00-17:00', NULL, 0, 4.7);

-- ============================ 도쿄 (tokyo) ============================
INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '이치란 시부야점', 'restaurant', 'tokyo', 35.6595000, 139.7005000, '개인 부스에서 즐기는 돈코츠 라멘', '10:00-23:00', NULL, 1, 4.4);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '츠키지 장외시장', 'restaurant', 'tokyo', 35.6654000, 139.7707000, '해산물과 초밥으로 유명한 시장', '05:00-14:00', NULL, 1, 4.5);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '블루보틀 아오야마', 'cafe', 'tokyo', 35.6659000, 139.7127000, '일본 1호점 스페셜티 커피', '08:00-19:00', NULL, 1, 4.4);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '긴자 상점가', 'shop', 'tokyo', 35.6716000, 139.7649000, '도쿄의 고급 쇼핑 거리', '11:00-20:00', NULL, 0, 4.3);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '시부야 스크램블 교차로', 'attraction', 'tokyo', 35.6595000, 139.7004000, '세계적으로 유명한 교차로', '상시', NULL, 0, 4.5);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '센소지(아사쿠사)', 'attraction', 'tokyo', 35.7148000, 139.7967000, '도쿄에서 가장 오래된 사찰', '06:00-17:00', NULL, 0, 4.7);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '도쿄타워', 'attraction', 'tokyo', 35.6586000, 139.7454000, '도쿄의 상징적인 전망 타워', '09:00-23:00', NULL, 0, 4.6);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, '메이지 신궁', 'attraction', 'tokyo', 35.6764000, 139.6993000, '도심 속 숲과 신사', '05:00-18:00', NULL, 0, 4.6);

-- ============================================================
COMMIT;

-- (확인용) 지역·카테고리별 개수
-- SELECT region, category, COUNT(*) FROM places GROUP BY region, category ORDER BY region, category;
