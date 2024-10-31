<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>クイズ開始</title>
     <link rel="icon" href="images/favicon.ico" type="image/x-icon"> <!-- ファビコンの追加 -->
    <link rel="stylesheet" href="style.css">
    <style>
        .orange-text {
            color: red; /* オレンジ色に設定 */
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
    </style>
</head>
<body>
    <h1>食べ物クイズ<span class="orange-text">「フードリア」</span>へようこそ！</h1>
    <div class="button-container">
        <form action="quiz" method="get">
            <button type="submit" class="image-button">
                <img src="images/quiz_woman.png" alt="クイズを開始する" style="width: 250px; height: auto;"> <!-- 画像ボタン -->
            </button>
        </form>
    </div>
    <audio id="bgm" src="audio/Kokage_De_Yuttari-1(Slow).mp3" loop autoplay></audio>
    <script>
      const bgm = document.getElementById('bgm');
      bgm.volume = 0.2; // 音量は0.0（無音）から1.0（最大音量）まで
    </script>
</body>
</html>
