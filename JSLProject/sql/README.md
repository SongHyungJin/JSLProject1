# DB 설정 SQL (실행 순서대로)

SQL Developer 에서 프로젝트 계정으로 접속 후, 아래 순서대로 실행하고 각 파일 끝의 COMMIT 까지 실행하세요.
(테이블 자체는 팀의 스키마 생성 SQL로 먼저 만들어져 있어야 합니다.)

| 순서 | 파일 | 내용 | 필수 여부 |
|------|------|------|-----------|
| 01 | 01_add_users_status.sql | users 테이블에 status 컬럼 추가 | **필수** (없으면 로그인 실패) |
| 02 | 02_add_places_google_id.sql | places 에 google_place_id 컬럼 추가 | **필수** (구글 점포 찜 저장/중복방지) |
| 03 | 03_sample_places.sql | 서울·교토·도쿄 시연용 점포 | 선택 (추천 루트 데모용) |
| 04 | 04_sample_places_us.sql | 뉴욕·샌프란시스코·LA 시연용 점포 | 선택 |
| 05 | 05_fill_place_images.sql | 이미지가 빈 점포에 썸네일 채우기 | 선택 (썸네일 데모용) |

## 주의
- 01, 02 는 앱 동작에 필요한 스키마 변경이라 반드시 먼저 실행하세요.
- 03~05 는 데모용 데이터라 실제 데이터가 있으면 건너뛰어도 됩니다.
- region/category 값은 코드와 일치해야 합니다
  (region: seoul/busan/tokyo/osaka/kyoto/newyork/sanfrancisco/la, category: restaurant/cafe/shop/attraction/etc).
