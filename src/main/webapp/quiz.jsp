<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>クイズ</title>
<link rel="icon" href="images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Kosugi+Maru&family=M+PLUS+Rounded+1c&display=swap"
	rel="stylesheet">
</head>
<body>

	<div class="quiz_box">
		<!-- ホームボタンの追加 -->
		<div class="home-button-container">
			<form action="start.jsp" method="get">
				<button type="submit" class="home-button">ホーム</button>
			</form>
		</div>

		<!-- クイズの問題文の表示 -->
		<h1 class="question">${question}</h1>

		<!-- 回答の正誤判定と解説の表示 -->
		<c:if test="${not empty selectedAnswer}">
			<div
				style="max-width: 530px; background-color: #fff887; border: 7px dotted #e66529; border-radius: 1em; padding: 5px; font-size: 18px;">
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
				<div class="explanation-text">
					<p>解説: ${explanation}</p>
				</div>
			</div>
		</c:if>

		<!-- クイズの選択肢ボタン -->
		<div class="answer_box">
			<c:if test="${!showNextButton}">
				<form action="quiz" method="post">
					<div class="choices-grid">
						<c:forEach var="choice" items="${choices}">
							<button type="submit" name="answer" value="${choice}"
								class="choice-button">${choice}</button>
						</c:forEach>
					</div>
					<input type="hidden" name="correctAnswer" value="${correctAnswer}">
				</form>
			</c:if>
		</div>

		<!-- 次の問題へ進むボタン -->
		<div class="nextQuestion">
			<c:if test="${showNextButton}">
				<form action="quiz" method="get">
					<button id="next-btn" type="submit" name="nextQuestion">次の問題へ進む</button>
				</form>
			</c:if>
		</div>

		<!-- 画像の表示 -->
		<div class="image_container">
			<div id="slider">
				<img class="slide active" src="images/mokomokoinu.png"
					alt="Dog Image 1" style="width: 100px; height: 100px;"> <img
					class="slide" src="images/mokomokoinu2.png" alt="Dog Image 2"
					style="width: 100px; height: 100px;">
			</div>
			<div id="fruit-container">
				<img id="random-fruit" src="${fruitImage}" alt="果物"
					style="width: 60px; height: 60px; position: relative; top: 30px;">
			</div>
		</div>
	</div>

	<!-- 効果音とBGMの再生 -->
	<audio id="correctSound" src="audio/correct.mp3"></audio>
	<audio id="incorrectSound" src="audio/incorrect.mp3"></audio>
	<audio id="hoverSound" src="audio/hover.mp3"></audio>
	<audio id="bgm" src="audio/Kokage_De_Yuttari-1(Slow).mp3" loop autoplay></audio>

	<script>

    // BGMの音量設定
    const bgm = document.getElementById('bgm');
    bgm.volume = 0.5;

    // 効果音の音量設定
    const correctSound = document.getElementById('correctSound');
    correctSound.volume = 0.1;

    const incorrectSound = document.getElementById('incorrectSound');
    incorrectSound.volume = 0.1;

    const hoverSound = document.getElementById('hoverSound');
    hoverSound.volume = 0.4;

    // 効果音の再生
    let soundType = '${sound}';
    const randomFruitImage = document.getElementById('random-fruit');

    if (soundType === 'correct') {
        correctSound.currentTime = 0;
        correctSound.play();
        randomFruitImage.style.transition = 'all 0.5s ease';
        randomFruitImage.style.position = 'absolute';
        randomFruitImage.style.left = '30px';
        randomFruitImage.style.top = '35px';
        
        setTimeout(() => {
            randomFruitImage.style.opacity = '0';
        }, 1000);
        
        setTimeout(() => {
            randomFruitImage.style.display = 'none';
        }, 1500);
        
        let currentIndex = 0;
        const slides = document.querySelectorAll('.slide');
        function showNextSlide() {
            slides[currentIndex].classList.remove('active');
            currentIndex = (currentIndex + 1) % slides.length;
            slides[currentIndex].classList.add('active');
        }
        setInterval(showNextSlide, 250);
    } else if (soundType === 'incorrect') {
        incorrectSound.currentTime = 0;
        incorrectSound.play();
    }

    // 選択肢ボタンにマウスオーバー時の効果音を追加
    document.querySelectorAll('.choice-button').forEach(button => {
        button.addEventListener('mouseover', () => {
            hoverSound.currentTime = 0;
            hoverSound.play();
        });
    });

    
</script>

</body>
</html>
