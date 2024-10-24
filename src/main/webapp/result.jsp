<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>結果</title>
</head>
<body>
    <h1>あなたのスコア: ${score}</h1>
    <form action="quiz" method="get">
        <button type="submit" name="start" value="true">もう一度プレイする</button>
    </form>
</body>
</html>
