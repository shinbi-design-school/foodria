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
            background-image: url('images/background.jpg'); /* 背景画像のパス */
            background-size: cover; /* 画像を全体に表示 */
            background-position: center; /* 画像を中央に配置 */
            background-repeat: no-repeat; /* 画像を繰り返さない */
        }
        #tomato-container {
            display: flex;
            flex-wrap: wrap; /* 複数のトマト画像を並べる */
        }
        .tomato {
            width: 50px; /* トマト画像のサイズ */
            height: 50px; /* トマト画像のサイズ */
            margin: 5px; /* トマト画像の間隔 */
        }
    </style>
</head>
<body>
    <h1>あなたのスコア: ${score}</h1>
    <div id="tomato-container"></div>
    <form action="quiz" method="get">
        <button type="submit" name="start" value="true">もう一度プレイする</button>
        <img src="images/animal.gif" alt="犬">
        <img id="food" src="images/food.gif" alt="食べ物">
    </form>

    <script>
        const score = ${score}; // サーバーからスコアを取得
        const tomatoContainer = document.getElementById('tomato-container');

        for (let i = 0; i < score; i++) {
            const tomatoImg = document.createElement('img');
            tomatoImg.src = 'images/food.gif'; // トマト画像のパス
            tomatoImg.alt = 'トマト';
            tomatoImg.className = 'tomato';
            tomatoContainer.appendChild(tomatoImg);
        }
    </script>
</body>
</html>
