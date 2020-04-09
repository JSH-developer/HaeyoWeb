<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>해요-친구찾기</title>
<link rel="stylesheet" href="../css/top.css">
<link rel="stylesheet" href="../css/bottom.css">
<style>
form{
	text-align: center;
	font-family: 'Jua', sans-serif;
	height:670px;
	font-size: 20px;
}

input[type=text], input[type=password]{
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
<script src="../js/jquery.js"></script>
<script>
$(function(){
	$("input[type=button]#login_btn").click(function() {
	 	var user_id = $('#id').val();
		var user_pass = $('#pass').val();
		var referrer =  document.referrer;
	 	$.ajax({
			url : 'loginPro.jsp?id='+ user_id+'&pass=' + user_pass,
			type : 'post',
			success : function(data) {
		    	  	if($.trim(data)=="success"){
		    	  		location.href=referrer;
					}else if($.trim(data)=="passerr"){
						$("#log_check").text("비밀번호를 다시 확인해주세요");
						$("#log_check").css("color", "red");
					}else if($.trim(data)=="iderr"){
						$("#log_check").text("아이디를 다시 확인해주세요");
						$("#log_check").css("color", "red");
					}else{
						$("#log_check").text("권한이 없습니다");
						$("#log_check").css("color", "red");
					}
				}, error : function() {
						console.log("실패");
				}
			});
		});
	$("form").keydown(function(key) {
		if (key.keyCode == 13) {
			$('input[type=button]#login_btn').click();
		}
	});
});	
</script>
</head>
<body>
<%
// 로그인 상태에서 로그인 페이지 접근시 뒤로가기 실행
String id = (String)session.getAttribute("id");
if(id!=null){%>
	<script>history.back();</script>
<%}%>
<!-- 헤더, 네비게이션 -->
<jsp:include page="../inc/top.jsp"/>

<form>
<h1>로 그 인 해 요</h1>
<input type="text" placeholder="아이디" name="id" id="id" ><br>
<input type="password" placeholder="비밀번호" name="pass" id="pass"><br>
<div id="log_check"></div>
<input type="button" id="login_btn" value="로그인"><br>
<input type="button" onclick="location.href='passfind.jsp'" value="비밀번호찾기">
</form>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>

</body>
</html>