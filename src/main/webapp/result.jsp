<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>結果</title>
    <style>
        body {
            background-image: url('images/foodria.png'); /* 背景画像のパス */
            background-size: cover; /* 画像を全体に表示 */
            background-position: center; /* 画像を中央に配置 */
            background-repeat: no-repeat; /* 画像を繰り返さない */
            display: flex;
            flex-direction: column;
            align-items: center; /* 中央揃え */
            justify-content: center; /* 中央揃え */
            height: 100vh; /* ビューポートの高さに合わせる */
            margin: 0; /* マージンをリセット */
        }
        #vegetable-container {
            display: flex;
            flex-wrap: wrap; /* 複数の野菜画像を並べる */
            justify-content: center; /* 中央揃え */
        }
        .vegetable {
            width: 50px; /* 野菜画像のサイズ */
            height: 50px; /* 野菜画像のサイズ */
            margin: 5px; /* 野菜画像の間隔 */
        }
    </style>
</head>
<body>
    <h1>あなたのスコア: ${score}問/10問</h1>
    <div id="vegetable-container"></div>
    <form action="quiz" method="get" style="text-align: center;">
        <button type="submit" name="start" value="true">もう一度プレイする</button>
        <div>
            <img src="images/animal.gif" alt="犬">
            <img id="food" src="images/food.gif" alt="食べ物">
        </div>
    </form>
    <audio id="bgm" src="Kokage_De_Yuttari-1(Slow).mp3" loop autoplay></audio>
    <script>
      const bgm = document.getElementById('bgm');
      bgm.volume = 0.2; // 音量は0.0（無音）から1.0（最大音量）まで
    </script>

    <script>
        const score = ${score}; // サーバーからスコアを取得
        const vegetableContainer = document.getElementById('vegetable-container');

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

