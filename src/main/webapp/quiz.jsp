<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>クイズ</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="quiz_box">
    <h1 class="question">${question}</h1>

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
            <p>解説: ${explanation}</p> <!-- 解説を表示 -->
        </div>
    </c:if>

<div class="answer_box">
    <c:if test="${!showNextButton}">
        <form action="quiz" method="post">
            <c:forEach var="choice" items="${choices}">
                <div class="answer">
                    <button type="submit" name="answer" value="${choice}">${choice}</button>
                </div>
            </c:forEach>
            <input type="hidden" name="correctAnswer" value="${correctAnswer}">
        </form>
    </c:if>

    <!-- 次の問題へ進むボタン -->
    <c:if test="${showNextButton}">
        <form action="quiz" method="get">
            <button id="next-btn" type="submit" name="nextQuestion">次の問題へ進む</button>
        </form>
    </c:if>
</div>


    <img src="images/animal.gif" alt="犬">
    <img id="food" src="images/food.gif" alt="食べ物">
</div>


    <audio id="correctSound" src="correct.mp3"></audio>
    <audio id="incorrectSound" src="incorrect.mp3"></audio>

    <c:if test="${not empty sound}">
        <script>
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