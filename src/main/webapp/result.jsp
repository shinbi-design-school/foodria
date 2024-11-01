<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>結果</title>
    <link rel="icon" href="images/favicon.ico" type="image/x-icon"> <!-- ファビコンの追加 -->
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
        h2 {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .dog-image {
            width: 100px;
            height: auto;
        }
        button {
            background: transparent;
            border: none;
            cursor: pointer;
        }
        button img {
            width: 250px;
            height: auto;
            display: block;
        }
        .score-low {
            color: red;
        }
        .score-high {
            color: blue;
        }
    </style>
</head>
<body>
<div class="quiz_box">
    <h1>あなたのスコア: <span id="score-value">${score}</span>問/10問</h1> <!-- スコア部分を <span> に変更 -->
    <h2><img class="dog-image" src="images/mokomokoinu.png" alt="犬">が食べた野菜：</h2>
    <div id="vegetable-container">
        <c:forEach var="vegetableImage" items="${eatenVegetables}">
            <img class="vegetable" src="${vegetableImage}" alt="野菜">
        </c:forEach>
    </div>
    <form action="quiz" method="get">
        <button type="submit" name="start" value="true">
            <img src="images/boy.png" alt="もう一度始める">
        </button>
    </form>
    
        
        	<!-- ホームボタンの追加 -->
		<div class="home-button-container">
			<form action="start.jsp" method="get">
				<!-- ホームページへ移動 -->
				<button type="submit" class="home-button">ホーム</button>
			</form>
			
			
    <audio id="bgm" src="audio/Kokage_De_Yuttari-1(Slow).mp3" loop autoplay></audio>
    <script>
        const score = ${score}; // サーバーからスコアを取得
        const scoreValue = document.getElementById('score-value');
        // スコアに応じて文字色を変更
        if (score <= 5) {
            scoreValue.classList.add('score-low');
        } else {
            scoreValue.classList.add('score-high');
        }
    </script>
</div>
</body>
</html>



