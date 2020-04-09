<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	BoardDAO bdao = BoardDAO.getBoardDAO();
%>
<title>해요-친구찾기</title>
<link rel="stylesheet" href="../css/top.css">
<link rel="stylesheet" href="../css/bottom.css">
<link rel="stylesheet" href="../css/frame.css">
<link rel="stylesheet" href="../css/main.css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
<!-- 헤더, 네비게이션 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 본문 -->
<div id="wrap1">
<aside>
<h1>HAEYO</h1>
	<button class="cate" id="cateH">H</button><br>
	<button class="cate" id="cateA">A</button><br>
	<button class="cate" id="cateE">E</button><br>
	<button class="cate" id="cateY">Y</button><br>
	<button class="cate" id="cateO">O</button><br>
</aside>
<article>
<h1>HAEYO <i>Aria Social Community</i></h1>
<fieldset id="kkfield">
<legend>경기 최신글</legend>
<table class="main_tb" id="kkMain" >
<tr><th>글번호</th><th>분류</th><th>글제목</th><th>닉네임</th><th>조회수</th><th>작성날짜</th></tr>
<%
		out.print(bdao.readMainBoard("kk")	);	
%>
</table>
</fieldset>

<fieldset id="ksfield">
<legend>경상 최신글</legend>
<table class="main_tb" id="ksMain" >
<tr><th>글번호</th><th>분류</th><th>글제목</th><th>닉네임</th><th>조회수</th><th>작성날짜</th></tr>
<%
		out.print(bdao.readMainBoard("ks")	);	
%>
</table>
</fieldset>

<fieldset id="kwfield">
<legend>강원 최신글</legend>
<table class="main_tb" id="kwMain" >
<tr><th>글번호</th><th>분류</th><th>글제목</th><th>닉네임</th><th>조회수</th><th>작성날짜</th></tr>
<%
		out.print(bdao.readMainBoard("kw")	);	
%>
</table>
</fieldset>

<fieldset id="jjfield">
<legend>제주 최신글</legend>
<table class="main_tb" id="jjMain" >
<tr><th>글번호</th><th>분류</th><th>글제목</th><th>닉네임</th><th>조회수</th><th>작성날짜</th></tr>
<%
		out.print(bdao.readMainBoard("jj")	);	
%>
</table>
</fieldset>

<fieldset id="jrfield">
<legend>전라 최신글</legend>
<table class="main_tb" id="jrMain" >
<tr><th>글번호</th><th>분류</th><th>글제목</th><th>닉네임</th><th>조회수</th><th>작성날짜</th></tr>
<%
		out.print(bdao.readMainBoard("jr")	);	
%>
</table>
</fieldset>

<fieldset id="ccfield">
<legend>충청 최신글</legend>
<table class="main_tb" id="ccMain" >
<tr><th>글번호</th><th>분류</th><th>글제목</th><th>닉네임</th><th>조회수</th><th>작성날짜</th></tr>
<%
		out.print(bdao.readMainBoard("cc")	);	
%>
</table>
</fieldset>

</article>	
</div>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>

</body>
</html>