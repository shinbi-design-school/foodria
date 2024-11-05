<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
<title>クイズ開始</title>
<link rel="icon" href="images/favicon.ico" type="image/x-icon">
<!-- ファビコンの追加 -->
<link rel="stylesheet" href="style.css">
<style>
.orange-text {
	display: inline; /* 画像と同じ行に配置 */
}

.button-container {
	text-align: center; /* ボタンを中央に配置 */
	margin-top: 20px; /* タイトルとの間にスペースを作る */
}

.image-button {
	border: none; /* ボタンの枠線を消す */
	background: transparent; /* ボタンの背景を透明にする */
	cursor: pointer; /* カーソルをポインタにする */
}
/* ホバー時のスタイル */
.image-button:hover {
	background: transparent; /* ホバー時の背景を透明に */
	outline: none; /* ホバー時のアウトラインを消す */
}

h1 {
	text-align: center; /* 中央揃え */
	color: white; /* 文字色を白に */
	text-shadow: 2px 2px 0 rgba(0, 0, 0, 1), /* 黒の縁取り */
                -2px -2px 0 rgba(0, 0, 0, 1), /* 黒の縁取り */
                2px -2px 0 rgba(0, 0, 0, 1), /* 黒の縁取り */
                -2px 2px 0 rgba(0, 0, 0, 1); /* 黒の縁取り */
}
</style>
</head>
<body>

	<div class="button-container">
		<form action="quiz" method="get">
			<button type="submit" class="image-button">
				<img src="images/foodria_top.png" alt="クイズを開始する"
					style="width: 455px; height: 415px;">
				<!-- 画像ボタン -->
			</button>
			<br>
			<h1>食べ物クイズへようこそ！</h1>
			</br>
			<!-- タイトルを追加 -->
		</form>
	</div>
	<audio id="bgm" src="audio/Kokage_De_Yuttari-1(Slow).mp3" loop autoplay></audio>
	<script>
		const bgm = document.getElementById('bgm');
		bgm.volume = 0.4; // 音量は0.0（無音）から1.0（最大音量）まで
	</script>
</body>
</html>

