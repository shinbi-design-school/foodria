<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>クイズ開始</title>
<link rel="icon" href="images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Kosugi+Maru&family=M+PLUS+Rounded+1c&display=swap" rel="stylesheet">
<style>
.orange-text { display: inline; }
.button-container { text-align: center; margin-top: 20px; }
.image-button { border: none; background: transparent; cursor: pointer; }
.image-button:hover { background: transparent; outline: none; }
h1 {
	text-align: center;
	color: white;
	text-shadow: 2px 2px 0 rgba(0, 0, 0, 1), -2px -2px 0 rgba(0, 0, 0, 1),
				 2px -2px 0 rgba(0, 0, 0, 1), -2px 2px 0 rgba(0, 0, 0, 1);
}
</style>
</head>
<body>

<div class="button-container">
    <form id="startQuizForm" action="quiz" method="get">
        <button type="submit" class="image-button">
            <img src="images/foodria_top.png" alt="クイズを開始する" style="width: 455px; height: 415px;">
            <!-- 画像ボタン -->
        </button>
        <br>
        <h1>食べ物クイズへようこそ！</h1>
    </form>
</div>

<!-- 効果音 -->
<audio id="startSound" src="audio/start_sound.mp3"></audio> <!-- 効果音ファイルを指定 -->

<script>
    // 画像ボタンを押した際に効果音を再生
    document.getElementById('startQuizForm').addEventListener('submit', function(event) {
        event.preventDefault(); // デフォルトのフォーム送信を一時停止
        const startSound = document.getElementById('startSound');
        startSound.volume = 0.3; // 音量を30%に設定
        startSound.currentTime = 0; // 再生位置をリセット
        startSound.play();

        // 効果音再生が終わった後にページ遷移
        startSound.onended = function() {
            document.getElementById('startQuizForm').submit();
        };
    });
</script>

</body>
</html>

