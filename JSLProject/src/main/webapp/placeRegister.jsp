<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
    관리자 점포 등록 폼. (방법 2)
    반드시 /admin/place/form.do 로 접근 (컨트롤러가 관리자 권한 확인).
    저장은 /admin/place/insert.do (POST) 로 전송된다.
--%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>점포 등록 (관리자)</title>
    <style>
        body { font-family: system-ui, "Noto Sans KR", sans-serif; background:#f5f7fb; margin:0; }
        .box { max-width: 640px; margin: 32px auto; background:#fff; border:1px solid #e6e9f0;
               border-radius:10px; padding:24px; }
        h1 { font-size:20px; margin-top:0; }
        label { display:block; margin:12px 0 4px; font-weight:600; font-size:14px; }
        input, select, textarea {
            width:100%; padding:9px; border:1px solid #ccd2e0; border-radius:6px; box-sizing:border-box; font-size:14px;
        }
        .row { display:flex; gap:10px; }
        .row > div { flex:1; }
        .btn { background:#4c6ef5; color:#fff; border:none; padding:11px 18px; border-radius:6px;
               cursor:pointer; font-size:15px; margin-top:18px; }
        .msg { margin:14px 0; padding:10px 12px; border-radius:6px; font-size:14px; }
        .ok { background:#ebfbee; color:#2b8a3e; border:1px solid #b2f2bb; }
        .warn { background:#fff0f0; color:#c92a2a; border:1px solid #ffc9c9; }
        .muted { color:#868e96; font-size:12px; margin-top:4px; }
    </style>
</head>
<body>
<div class="box">
    <h1>🏬 점포 등록 (관리자)</h1>

    <% String result = request.getParameter("result"); %>
    <% if ("success".equals(result)) { %>
        <div class="msg ok">점포가 등록되었습니다. 계속 추가할 수 있어요.</div>
    <% } else if ("fail".equals(result)) { %>
        <div class="msg warn">등록에 실패했습니다. 입력값(이름·지역·좌표)을 확인해 주세요.</div>
    <% } %>

    <form method="post" action="<%= request.getContextPath() %>/admin/place/insert.do">

        <label for="name">이름 *</label>
        <input type="text" id="name" name="name" required>

        <div class="row">
            <div>
                <label for="category">카테고리 *</label>
                <select id="category" name="category">
                    <option value="restaurant">식당 (restaurant)</option>
                    <option value="cafe">카페 (cafe)</option>
                    <option value="shop">상점 (shop)</option>
                    <option value="attraction">관광지 (attraction)</option>
                    <option value="etc">기타 (etc)</option>
                </select>
            </div>
            <div>
                <label for="region">지역 *</label>
                <select id="region" name="region">
                    <option value="seoul">한국 - 서울</option>
                    <option value="busan">한국 - 부산</option>
                    <option value="tokyo">일본 - 도쿄</option>
                    <option value="osaka">일본 - 오사카</option>
                    <option value="kyoto">일본 - 교토</option>
                    <option value="newyork">미국 - 뉴욕</option>
                    <option value="sanfrancisco">미국 - 샌프란시스코</option>
                    <option value="la">미국 - LA</option>
                </select>
            </div>
        </div>

        <div class="row">
            <div>
                <label for="latitude">위도(latitude) *</label>
                <input type="number" step="0.0000001" id="latitude" name="latitude" placeholder="예: 37.5665" required>
            </div>
            <div>
                <label for="longitude">경도(longitude) *</label>
                <input type="number" step="0.0000001" id="longitude" name="longitude" placeholder="예: 126.9780" required>
            </div>
        </div>
        <p class="muted">※ 좌표는 구글 지도에서 장소 우클릭 → 좌표 복사로 얻을 수 있어요. 추천 동선·지도가 이 값으로 계산됩니다.</p>

        <div class="row">
            <div>
                <label for="rating">평점 (0~5)</label>
                <input type="number" step="0.1" min="0" max="5" id="rating" name="rating" value="0" placeholder="예: 4.5">
            </div>
            <div>
                <label for="businessHours">영업시간</label>
                <input type="text" id="businessHours" name="businessHours" placeholder="예: 10:00-22:00">
            </div>
        </div>

        <label for="imageUrl">이미지 URL (선택)</label>
        <input type="text" id="imageUrl" name="imageUrl" placeholder="https://...">

        <label for="description">설명 (선택)</label>
        <textarea id="description" name="description" rows="3"></textarea>

        <label style="font-weight:normal; margin-top:12px;">
            <input type="checkbox" name="reservable" style="width:auto;"> 예약 가능한 점포
        </label>

        <button type="submit" class="btn">점포 등록</button>
    </form>
</div>
</body>
</html>
