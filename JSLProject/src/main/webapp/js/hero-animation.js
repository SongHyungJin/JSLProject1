document.addEventListener("DOMContentLoaded", function () {

    const heroScene = document.getElementById("heroScene");
    const particleLayer = document.getElementById("heroPetals");

    const params = new URLSearchParams(window.location.search);

    const heroSeason = params.get("heroSeason");
    const heroTime = params.get("heroTime");

    const now = new Date();

    const month = now.getMonth() + 1;
    const hour = now.getHours();

    let season;
    let time;


    /* =========================================
       1. 실제 계절 자동 선택

       봄   : 3 ~ 5월
       여름 : 6 ~ 8월
       가을 : 9 ~ 11월
       겨울 : 12 ~ 2월
    ========================================= */

    if (month >= 3 && month <= 5) {

        season = "spring";

    } else if (month >= 6 && month <= 8) {

        season = "summer";

    } else if (month >= 9 && month <= 11) {

        season = "autumn";

    } else {

        season = "winter";

    }


    /* =========================================
       2. URL 계절 테스트 기능

       ?heroSeason=spring
       ?heroSeason=summer
       ?heroSeason=autumn
       ?heroSeason=winter
    ========================================= */

    if (
        heroSeason === "spring" ||
        heroSeason === "summer" ||
        heroSeason === "autumn" ||
        heroSeason === "winter"
    ) {

        season = heroSeason;

    }


    /* =========================================
       3. 시간 자동 선택
    ========================================= */

    if (
        heroTime === "morning" ||
        heroTime === "day" ||
        heroTime === "evening" ||
        heroTime === "night"
    ) {

        time = heroTime;

    } else {

        // 아침 : 05:00 ~ 10:59
        if (hour >= 5 && hour < 11) {

            time = "morning";

        }

        // 낮 : 11:00 ~ 16:59
        else if (hour >= 11 && hour < 17) {

            time = "day";

        }

        // 저녁 : 17:00 ~ 19:59
        else if (hour >= 17 && hour < 20) {

            time = "evening";

        }

        // 밤 : 20:00 ~ 04:59
        else {

            time = "night";

        }

    }


    /* =========================================
       4. Hero 배경 적용
    ========================================= */

    if (heroScene) {

        heroScene.classList.remove(

            "spring-morning",
            "spring-day",
            "spring-evening",
            "spring-night",

            "summer-morning",
            "summer-day",
            "summer-evening",
            "summer-night",

            "autumn-morning",
            "autumn-day",
            "autumn-evening",
            "autumn-night",

            "winter-morning",
            "winter-day",
            "winter-evening",
            "winter-night"

        );

        const heroClass = season + "-" + time;

        heroScene.classList.add(heroClass);

        console.log(
            "[Travel Route Hero]",
            "month =", month,
            "season =", season,
            "time =", time,
            "class =", heroClass
        );

    }


    /* =========================================
       5. 메인 카드 계절 이미지 적용
    ========================================= */

    const restaurantImage =
        document.getElementById("restaurantSeasonImage");

    const shopImage =
        document.getElementById("shopSeasonImage");

    const cafeImage =
        document.getElementById("cafeSeasonImage");

    const cityImage =
        document.getElementById("citySeasonImage");

    const cafeRouteImage =
        document.getElementById("cafeRouteSeasonImage");

    const natureImage =
        document.getElementById("natureSeasonImage");


    /*
       restaurantSeasonImage에만 context path를 저장해두고
       나머지 이미지에서도 공통으로 사용
    */

    let contextPath = "";

    if (restaurantImage) {

        contextPath =
            restaurantImage.dataset.contextPath || "";

    }


    const imageBase =
        contextPath + "/images/main-season/";


    /* =========================================
       카테고리 카드
    ========================================= */

    if (restaurantImage) {

        restaurantImage.style.backgroundImage =
            "url('" +
            imageBase +
            "restaurant-" +
            season +
            ".png')";

    }


    if (shopImage) {

        shopImage.style.backgroundImage =
            "url('" +
            imageBase +
            "shop-" +
            season +
            ".png')";

    }


    if (cafeImage) {

        cafeImage.style.backgroundImage =
            "url('" +
            imageBase +
            "cafe-" +
            season +
            ".png')";

    }


    /* =========================================
       추천 여행 루트
    ========================================= */

    if (cityImage) {

        cityImage.style.backgroundImage =
            "url('" +
            imageBase +
            "city-" +
            season +
            ".png')";

    }


    if (cafeRouteImage) {

        cafeRouteImage.style.backgroundImage =
            "url('" +
            imageBase +
            "cafe-route-" +
            season +
            ".png')";

    }


    if (natureImage) {

        natureImage.style.backgroundImage =
            "url('" +
            imageBase +
            "nature-" +
            season +
            ".png')";

    }


    console.log(
        "[Travel Route Main Cards]",
        "season =", season,
        "imageBase =", imageBase
    );


    /* =========================================
       6. 파티클 초기화
    ========================================= */

    if (!particleLayer) {

        return;

    }

    particleLayer.innerHTML = "";

    const COUNT = 25;


    /* =========================================
       봄 - 벚꽃잎
    ========================================= */

    if (season === "spring") {

        for (let i = 0; i < COUNT; i++) {

            const petal =
                document.createElement("span");

            petal.className = "petal";

            const size =
                7 + Math.random() * 12;

            const top =
                Math.random() * 90;

            const duration =
                7 + Math.random() * 7;

            const delay =
                -Math.random() * 14;

            petal.style.width =
                size + "px";

            petal.style.height =
                size * 0.68 + "px";

            petal.style.top =
                top + "%";

            petal.style.animationDuration =
                duration + "s";

            petal.style.animationDelay =
                delay + "s";

            petal.style.opacity =
                0.45 + Math.random() * 0.45;

            particleLayer.appendChild(petal);

        }

    }


    /* =========================================
       여름 - 초록 나뭇잎
    ========================================= */

    if (season === "summer") {

        for (let i = 0; i < COUNT; i++) {

            const leaf =
                document.createElement("span");

            leaf.className =
                "summer-leaf";

            const size =
                9 + Math.random() * 13;

            const top =
                Math.random() * 90;

            const duration =
                8 + Math.random() * 8;

            const delay =
                -Math.random() * 16;

            leaf.style.width =
                size + "px";

            leaf.style.height =
                size * 0.55 + "px";

            leaf.style.top =
                top + "%";

            leaf.style.animationDuration =
                duration + "s";

            leaf.style.animationDelay =
                delay + "s";

            leaf.style.opacity =
                0.35 + Math.random() * 0.45;

            particleLayer.appendChild(leaf);

        }

    }


    /* =========================================
       가을 - 단풍잎
    ========================================= */

    if (season === "autumn") {

        const colors = [

            "#d84315",
            "#e65100",
            "#ef6c00",
            "#f57c00",
            "#c62828",
            "#ff8f00"

        ];

        for (let i = 0; i < COUNT; i++) {

            const leaf =
                document.createElement("span");

            leaf.className =
                "autumn-leaf";

            const size =
                10 + Math.random() * 15;

            const top =
                Math.random() * 85;

            const duration =
                8 + Math.random() * 8;

            const delay =
                -Math.random() * 16;

            leaf.style.width =
                size + "px";

            leaf.style.height =
                size + "px";

            leaf.style.top =
                top + "%";

            leaf.style.animationDuration =
                duration + "s";

            leaf.style.animationDelay =
                delay + "s";

            leaf.style.opacity =
                0.45 + Math.random() * 0.45;

            leaf.style.backgroundColor =
                colors[
                    Math.floor(
                        Math.random() *
                        colors.length
                    )
                ];

            particleLayer.appendChild(leaf);

        }

    }


    /* =========================================
       겨울 - 눈
    ========================================= */

    if (season === "winter") {

        const SNOW_COUNT = 45;

        for (let i = 0; i < SNOW_COUNT; i++) {

            const snow =
                document.createElement("span");

            snow.className =
                "winter-snow";

            const size =
                3 + Math.random() * 7;

            const left =
                Math.random() * 100;

            const duration =
                7 + Math.random() * 9;

            const delay =
                -Math.random() * 16;

            snow.style.width =
                size + "px";

            snow.style.height =
                size + "px";

            snow.style.left =
                left + "%";

            snow.style.animationDuration =
                duration + "s";

            snow.style.animationDelay =
                delay + "s";

            snow.style.opacity =
                0.4 + Math.random() * 0.55;

            particleLayer.appendChild(snow);

        }

    }

});