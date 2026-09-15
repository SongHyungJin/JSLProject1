document.addEventListener(
    "DOMContentLoaded",
    function () {

        const petalsLayer =
            document.getElementById(
                "heroPetals"
            );

        if (!petalsLayer) {
            return;
        }

        /* 기존 꽃잎 제거 */
        petalsLayer.innerHTML = "";

        /*
         * 꽃잎 개수
         *
         * 너무 많으면 화면이 지저분하고
         * 브라우저 부하도 생겨서 25개 정도
         */
        const COUNT = 25;

        for (
            let i = 0;
            i < COUNT;
            i++
        ) {

            const petal =
                document.createElement(
                    "span"
                );

            petal.className =
                "petal";

            /* 꽃잎 크기 */
            const size =
                7 +
                Math.random() * 12;

            /* 시작 높이 */
            const top =
                Math.random() * 90;

            /* 속도 */
            const duration =
                7 +
                Math.random() * 7;

            /* 시작 시점 */
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
                0.45 +
                Math.random() * 0.45;

            petalsLayer.appendChild(
                petal
            );
        }
    }
);