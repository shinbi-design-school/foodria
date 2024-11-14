<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>結果</title>
<link rel="icon" href="images/favicon.ico" type="image/x-icon">
<!-- ファビコンの追加 -->
<link rel="stylesheet" href="style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Kosugi+Maru&family=M+PLUS+Rounded+1c&display=swap"
	rel="stylesheet">
<style>
body {
	background-image: url('images/foodria.png');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
}

#fruit-container {
	display: flex;
	flex-wrap: wrap;
	text-align: center;
	margin-bottom: 20px;
}

.fruit {
	width: 60px;
	height: 60px;
	margin: 3px;
}

h2 {
	display: flex;
	align-items: center;
	gap: 5px;
}

.dog-image {
	width: 80px;
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
		<!-- ホームボタンの追加 -->
		<div class="home-button-container">
			<form action="start.jsp" method="get">
				<!-- ホームページへ移動 -->
				<button type="submit" class="home-button">ホーム</button>
			</form>
		</div>
		<h1>
			あなたのスコア: <span id="score-value">${score}</span>問/10問
		</h1>
		<!-- スコア部分を <span> に変更 -->
		<h2>
			<img class="dog-image" src="images/mokomokoinu.png" alt="犬">が食べた果物：
		</h2>
		<div id="fruit-container">
			<c:forEach var="fruitImage" items="${eatenFruits}">
				<img class="fruit" src="${fruitImage}" alt="果物">
			</c:forEach>
		</div>

		<form action="quiz" method="get">
			<button type="submit" name="start" value="true">
				<img src="images/boy.png" alt="もう一度始める"
					style="width: 80px; height: 80px;>
        </button>
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



