-- ============================================================
--  미국 3개 도시 시드 데이터 (뉴욕 / 샌프란시스코 / LA)
--  실행: SQL Developer 에서 프로젝트 계정 접속 → 전체 실행(F5) → 반드시 COMMIT
--
--  규칙(코드와 일치해야 동작):
--   - region   : newyork / sanfrancisco / la  (BestRoute 지역 드롭다운 값과 동일)
--   - category : restaurant / cafe / shop / attraction  (체크 제약 준수)
--   - id       : places_seq.NEXTVAL
--   - rating   : number(2,1) 소수 한 자리 (0~5)
--   - 좌표     : 실제 근사값 (추천 동선·지도가 이 값으로 계산됨)
-- ============================================================

-- ============================ 뉴욕 (newyork) ============================
INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Katz''s Delicatessen', 'restaurant', 'newyork', 40.7223000, -73.9874000, '뉴욕 대표 파스트라미 샌드위치', '08:00-22:30', NULL, 1, 4.6);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Joe''s Pizza', 'restaurant', 'newyork', 40.7305000, -74.0020000, '뉴욕 스타일 조각 피자 노포', '10:00-04:00', NULL, 1, 4.5);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Blue Bottle Coffee (Rockefeller)', 'cafe', 'newyork', 40.7590000, -73.9787000, '스페셜티 커피 카페', '07:00-19:00', NULL, 1, 4.3);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Stumptown Coffee', 'cafe', 'newyork', 40.7456000, -73.9887000, '분위기 좋은 로스터리 카페', '06:00-20:00', NULL, 1, 4.2);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Macy''s Herald Square', 'shop', 'newyork', 40.7509000, -73.9890000, '대형 백화점', '10:00-21:00', NULL, 0, 4.1);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Central Park', 'attraction', 'newyork', 40.7829000, -73.9654000, '뉴욕 대표 도심 공원', '06:00-01:00', NULL, 0, 4.8);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Statue of Liberty', 'attraction', 'newyork', 40.6892000, -74.0445000, '자유의 여신상', '09:00-17:00', NULL, 0, 4.7);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'The Metropolitan Museum of Art', 'attraction', 'newyork', 40.7794000, -73.9632000, '메트로폴리탄 미술관', '10:00-17:00', NULL, 0, 4.8);

-- ======================= 샌프란시스코 (sanfrancisco) =======================
INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Tartine Bakery', 'cafe', 'sanfrancisco', 37.7614000, -122.4241000, '유명 베이커리 카페', '08:00-17:00', NULL, 1, 4.5);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Blue Bottle Coffee (Ferry Building)', 'cafe', 'sanfrancisco', 37.7956000, -122.3933000, '페리 빌딩의 스페셜티 커피', '07:00-19:00', NULL, 1, 4.3);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'House of Prime Rib', 'restaurant', 'sanfrancisco', 37.7916000, -122.4220000, '프라임 립 전문 레스토랑', '17:00-22:00', NULL, 1, 4.6);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Ferry Building Marketplace', 'shop', 'sanfrancisco', 37.7955000, -122.3937000, '먹거리·상점이 모인 마켓', '10:00-19:00', NULL, 0, 4.5);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Golden Gate Bridge', 'attraction', 'sanfrancisco', 37.8199000, -122.4783000, '샌프란시스코 상징 금문교', '상시', NULL, 0, 4.8);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Fisherman''s Wharf', 'attraction', 'sanfrancisco', 37.8080000, -122.4177000, '해안가 관광 명소', '상시', NULL, 0, 4.4);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Golden Gate Park', 'attraction', 'sanfrancisco', 37.7694000, -122.4862000, '넓은 도심 공원', '05:00-24:00', NULL, 0, 4.7);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Pier 39', 'shop', 'sanfrancisco', 37.8087000, -122.4098000, '상점·먹거리 부두', '10:00-21:00', NULL, 0, 4.3);

-- ============================ LA (la) ============================
INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'In-N-Out Burger (Hollywood)', 'restaurant', 'la', 34.0983000, -118.3267000, '캘리포니아 대표 버거', '10:30-01:00', NULL, 1, 4.5);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Grand Central Market', 'restaurant', 'la', 34.0505000, -118.2489000, '다양한 먹거리 시장', '08:00-22:00', NULL, 1, 4.5);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Blue Bottle Coffee (Arts District)', 'cafe', 'la', 34.0396000, -118.2320000, '아츠 디스트릭트 카페', '07:00-18:00', NULL, 1, 4.3);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Alfred Coffee', 'cafe', 'la', 34.0837000, -118.3650000, '인기 감성 카페', '07:00-19:00', NULL, 1, 4.2);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'The Grove', 'shop', 'la', 34.0722000, -118.3576000, '야외 쇼핑몰', '10:00-21:00', NULL, 0, 4.4);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Griffith Observatory', 'attraction', 'la', 34.1184000, -118.3004000, 'LA 야경·전망 명소', '12:00-22:00', NULL, 0, 4.7);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Santa Monica Pier', 'attraction', 'la', 34.0089000, -118.4973000, '산타모니카 해변 부두', '상시', NULL, 0, 4.5);

INSERT INTO places (id, name, category, region, latitude, longitude, description, business_hours, image_url, reservable, rating)
VALUES (places_seq.NEXTVAL, 'Hollywood Walk of Fame', 'attraction', 'la', 34.1016000, -118.3267000, '할리우드 명예의 거리', '상시', NULL, 0, 4.3);

-- ============================================================
COMMIT;

-- (확인용) 지역·카테고리별 개수
-- SELECT region, category, COUNT(*) FROM places WHERE region IN ('newyork','sanfrancisco','la') GROUP BY region, category ORDER BY region, category;
