<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>結果</title>
    <style>
        body {
            background-image: url('images/foodria.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        #vegetable-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .vegetable {
            width: 50px;
            height: 50px;
            margin: 5px;
        }
        .score-low {
            color: red; /* スコアが5以下のときの色 */
        }
        .score-high {
            color: blue; /* スコアが5以上のときの色 */
        }
        button {
            background: transparent; /* 背景を透過に */
            border: none; /* ボーダーを消す */
            cursor: pointer; /* カーソルをポインタに */
        }
        button img {
            width: 250px;
            height: auto;
            display: block; /* 画像をブロック要素に */
        }
    </style>
</head>
<body>
    <h1>あなたのスコア: <span id="score-value">${score}</span>問/10問</h1>
    <div id="vegetable-container"></div>
    <form action="quiz" method="get" style="text-align: center;">
        <button type="submit" name="start" value="true">
            <img src="images/boy.png" alt="もう一度始める"> <!-- 画像ボタン -->
        </button>
        <div>
            <img src="images/animal.gif" alt="犬">
            <img id="food" src="images/food.gif" alt="食べ物">
        </div>
    </form>
    <audio id="bgm" src="audio/Kokage_De_Yuttari-1(Slow).mp3" loop autoplay></audio>
    <script>
        const bgm = document.getElementById('bgm');
        bgm.volume = 0.2;
    </script>

    <script>
        const score = ${score}; // サーバーからスコアを取得
        const vegetableContainer = document.getElementById('vegetable-container');
        const scoreValue = document.getElementById('score-value');

        // スコアに応じて文字色を変更
        if (score <= 5) {
            scoreValue.classList.add('score-low');
        } else {
            scoreValue.classList.add('score-high');
        }

        const vegetableImages = [
            'images/food.gif', // トマト
            'images/watermelon1.gif', // スイカ
            'images/carrot1.gif', // ニンジン
            'images/chestnut1.gif', // クリ
            'images/sweetp1.gif', // さつまいも
            'images/potato1.gif', // じゃがいも
            'images/pumpkin2.gif', // かぼちゃ
            'images/grape2.gif', // ぶどう
            'images/radish9.gif', // 大根
            'images/eggplant2.gif' // ナス
        ];

        for (let i = 0; i < score; i++) {
            const vegetableImg = document.createElement('img');
            const randomIndex = Math.floor(Math.random() * vegetableImages.length);
            vegetableImg.src = vegetableImages[randomIndex]; // ランダムに野菜画像を選択
            vegetableImg.alt = '野菜';
            vegetableImg.className = 'vegetable';
            vegetableContainer.appendChild(vegetableImg);
        }
    </script>
</body>
</html>

