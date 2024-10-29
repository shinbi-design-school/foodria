<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>クイズ開始</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .orange-text {
            color: orange; /* オレンジ色に設定 */
        }
        .button-container {
          /* タイトルとの間にスペースを作る */
            text-align: center; /* ボタンを中央に配置 */
        }
    </style>
</head>
<body>
    <h1>食べ物クイズ<span class="orange-text">「フードリア」</span>へようこそ！</h1>
    <div class="button-container">
        <form action="quiz" method="get">
            <button type="submit">クイズを開始する</button>
        </form>
    </div>
</body>
</html>
