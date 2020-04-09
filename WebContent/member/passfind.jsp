<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>해요-친구찾기</title>
<link rel="stylesheet" href="../css/top.css">
<link rel="stylesheet" href="../css/bottom.css">
<script src="../js/jquery.js"></script>
<style>
form{
text-align: center;
font-family: 'Jua', sans-serif;
height:670px;
font-size: 20px;
}

input[type=text], input[type=email]{
	padding-left:10px;
	margin:10px;
	height: 40px;
	width: 490px;
}

input[type=submit], input[type=button]{
	text-align: center;
	height: 50px;
	margin-bottom:10px;
	width: 500px;
	display:inline-block;
	font-family: 'Jua', sans-serif;
	font-size: 20px;
	background: #76cf9d;
	color: white;
	border:none;
}

</style>
</head>
<body>
<!-- 헤더, 네비게이션 -->
<jsp:include page="../inc/top.jsp"/>

<form action="findPro.jsp" method="post">
<h1>비밀번호 찾기 해요</h1>
<input type="text" placeholder="아이디" name="id" id="id"><br>
<input type="email" placeholder="이메일" name="email" id="email"><br>
<div id="email_check"></div>
<input type="submit" id="find_btn" value="찾기">
</form>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>

</body>
</html>