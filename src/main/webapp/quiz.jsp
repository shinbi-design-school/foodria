<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>クイズ</title>
<link rel="icon" href="images/favicon.ico" type="image/x-icon"> <!-- ファビコンの追加 -->
<link rel="stylesheet" href="style.css">
</head>
<body>

	<!-- クイズの問題文の表示 -->
	<div class="quiz_box">

	<!-- ホームボタンの追加 -->
		<div class="home-button-container">
			<form action="start.jsp" method="get">
				<!-- ホームページへ移動 -->
				<button type="submit" class="home-button">ホーム</button>
			</form>
		</div>

		<h1 class="question">${question}</h1>

		<!-- 回答の正誤判定と解説の表示 -->
		<c:if test="${not empty selectedAnswer}">
			<div
				style="border: 1px solid black; padding: 10px; background-color: #f9f9f9; margin-bottom: 20px;">
				<c:choose>
					<c:when test="${sound == 'correct'}">
						<p>
							<strong>正解！</strong>
						</p>
					</c:when>
					<c:otherwise>
						<p>
							<strong>残念、不正解。</strong>
						</p>
					</c:otherwise>
				</c:choose>
				<p>解説: ${explanation}</p>
			</div>
		</c:if>

		<!-- クイズの選択肢ボタン -->
		<div class="answer_box">
			<c:if test="${!showNextButton}">
				<form action="quiz" method="post">
					<div class="choices-grid">
						<c:forEach var="choice" items="${choices}">
							<button type="submit" name="answer" value="${choice}">${choice}</button>
						</c:forEach>
					</div>
					<input type="hidden" name="correctAnswer" value="${correctAnswer}">
				</form>
			</c:if>
		</div>

		<!-- 次の問題へ進むボタン -->
		<c:if test="${showNextButton}">
			<form action="quiz" method="get">
				<button id="next-btn" type="submit" name="nextQuestion">次の問題へ進む</button>
			</form>
		</c:if>

		<!-- 画像の表示 -->
		<div class="image_container">
			<div id="slider">
				<img class="slide active" src="images/mokomokoinu.png"
					alt="Dog Image 1" style="width: 100px; height: 100px;"> <img
					class="slide" src="images/mokomokoinu2.png" alt="Dog Image 2"
					style="width: 100px; height: 100px;">
			</div>
			<div id="vegetable-container">
				<!-- サーバーから渡された野菜画像を表示 -->
				<img id="random-vegetable" src="${vegetableImage}" alt="野菜"
					style="width: 50px; height: 50px; position: relative; left: 50px;">
			</div>
		</div>

	</div>



	<!-- 効果音の再生 -->
	<audio id="correctSound" src="audio/correct.mp3"></audio>
	<audio id="incorrectSound" src="audio/incorrect.mp3"></audio>

	<script>
    let soundType = '${sound}';
    const randomVegetableImage = document.getElementById('random-vegetable');
    if (soundType === 'correct') {
        // 正解音を再生
        document.getElementById('correctSound').play();
        // 野菜画像を犬の口元に移動させるアニメーション
        randomVegetableImage.style.transition = 'all 0.5s ease';
        randomVegetableImage.style.position = 'absolute';
        randomVegetableImage.style.left = '30px'; // 犬の口元に合わせて調整
        randomVegetableImage.style.top = '35px';
        // 0.5秒後にフェードアウト
        setTimeout(() => {
            randomVegetableImage.style.opacity = '0';
        }, 1000);
        // 1秒後に野菜画像を非表示
        setTimeout(() => {
            randomVegetableImage.style.display = 'none';
        }, 1500);
        // 犬の画像アニメーション
        let currentIndex = 0;
        const slides = document.querySelectorAll('.slide');
        function showNextSlide() {
            slides[currentIndex].classList.remove('active');
            currentIndex = (currentIndex + 1) % slides.length;
            slides[currentIndex].classList.add('active');
        }
        setInterval(showNextSlide, 300); // 犬の画像切り替えアニメーション
    } else if (soundType === 'incorrect') {
        // 不正解音を再生
        document.getElementById('incorrectSound').play();
    }
</script>

</body>
</html>