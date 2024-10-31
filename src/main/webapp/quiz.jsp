<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <h1 class="question">${question}</h1>

    <!-- 回答の正誤判定と解説の表示 -->
    <c:if test="${not empty selectedAnswer}">
        <div style="border: 1px solid black; padding: 10px; background-color: #f9f9f9; margin-bottom: 20px;">
            <c:choose>
                <c:when test="${sound == 'correct'}">
                    <p><strong>正解！</strong></p>
                </c:when>
                <c:otherwise>
                    <p><strong>残念、不正解。</strong></p>
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
        <img src="images/animal.gif" alt="犬">
        <img id="food" src="images/food.gif" alt="食べ物">
    </div>
</div>

<!-- 効果音の再生 -->
<audio id="correctSound" src="audio/correct.mp3"></audio>
<audio id="incorrectSound" src="audio/incorrect.mp3"></audio>

    <audio id="bgm" src="audio/Kokage_De_Yuttari-1(Slow).mp3" loop autoplay></audio>
<script>
  const bgm = document.getElementById('bgm');
  bgm.volume = 0.2; // 音量は0.0（無音）から1.0（最大音量）まで
</script>

<c:if test="${not empty sound}">
    <script>
        // JavaScriptでの効果音再生制御
        let soundType = '${sound}';
        if (soundType === 'correct') {
            document.getElementById('correctSound').play();
        } else if (soundType === 'incorrect') {
            document.getElementById('incorrectSound').play();
        }
    </script>
</c:if>

</body>
</html>
