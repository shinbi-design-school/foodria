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
            text-align: center; color: white;
            text-shadow: 2px 2px 0 rgba(0, 0, 0, 1), -2px -2px 0 rgba(0, 0, 0, 1), 
                         2px -2px 0 rgba(0, 0, 0, 1), -2px 2px 0 rgba(0, 0, 0, 1);
        }
    </style>
</head>
<body>

<div class="button-container">
    <form action="quiz" method="get">
        <button type="submit" class="image-button">
            <img src="images/foodria_top.png" alt="クイズを開始する" style="width: 455px; height: 415px;">
        </button>
        <br>
        <h1>食べ物クイズへようこそ！</h1>
    </form>
</div>

<!-- BGM用のiframe (ページ遷移してもBGMを再生し続ける) -->
<iframe src="bgm.html" allow="autoplay" style="display:none;"></iframe>

</body>
</html>
