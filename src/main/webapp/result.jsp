<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>結果</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            background-image: url('images/foodria.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        #vegetable-container {
            display: flex;
            flex-wrap: wrap;
        }
        .vegetable {
            width: 50px;
            height: 50px;
            margin: 5px;
        }
        /* 犬の画像と「が食べた野菜：」を横並びに */
        h2 {
            display: flex;
            align-items: center; /* テキストと犬の画像を垂直中央揃え */
            gap: 10px; /* 画像とテキストの間にスペースを追加 */
        }
        .dog-image {
            width: 100px; /* 犬画像のサイズ調整 */
            height: auto;
        }
    </style>
</head>
<body>
<div class="quiz_box">
    <h1>あなたのスコア: ${score}</h1>
    <h2><img class="dog-image" src="images/mokomokoinu.png" alt="犬">が食べた野菜：</h2>
    <div id="vegetable-container">
        <c:forEach var="vegetableImage" items="${eatenVegetables}">
            <img class="vegetable" src="${vegetableImage}" alt="野菜">
        </c:forEach>
    </div>
    <form action="quiz" method="get">
        <button type="submit" name="start" value="true">もう一度プレイする</button>
    </form>
</div>
</body>
</html>
