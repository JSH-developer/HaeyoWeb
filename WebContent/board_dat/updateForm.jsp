<%@page import="fileboard.FileboardBean"%>
<%@page import="fileboard.FileboardDAO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>해요-친구찾기</title>
<link rel="stylesheet" href="../css/top.css">
<link rel="stylesheet" href="../css/bottom.css">
<link rel="stylesheet" href="../css/frame.css">
<link rel="stylesheet" href="../css/list_dat.css">

</head>
<body>
<!-- 헤더, 네비게이션 -->
<jsp:include page="../inc/top.jsp"/>
<div id="wrap1">
<aside>
<h1>골라보기</h1>
   	<a href="datBoard.jsp?page=1"><button class="cate">전체보기</button></a><br>
</aside>
<article>
<h1>글을 수정해요</h1>
<%
	int idx = Integer.parseInt(request.getParameter("idx"));
	int bpage = Integer.parseInt(request.getParameter("page"));
	String standard=request.getParameter("standard");
	String scontent=request.getParameter("scontent");
	
	String id = (String)session.getAttribute("id");

	FileboardDAO fdao = FileboardDAO.getFileboardDAO();
	FileboardBean fb = fdao.getBean("dat",idx);
	MemberDAO mdao = MemberDAO.getMemberDAO();
%>
<form action="updatePro.jsp" method="post">
<table>
<tr><td><input type="text" name="category" value="자료" readonly></td></tr>
<tr><td><input type="text" placeholder="제목" name="title" value="<%=fb.getTitle()%>"></td></tr>
<tr><td><input type="text" placeholder="닉네임" name="usernickname" value="<%=mdao.getNickname(id)%>" readonly></td></tr>
<tr><td><input type="text" placeholder="아이디" name="userid" value="<%=id%>" readonly></td></tr>
<tr><td><input type="text" name="content" placeholder="간단한 코멘트를 남겨주세요" value="<%=fb.getContent()%>"></td></tr>
<input type="hidden" name="file" value="<%=fb.getFile()%>"><input type="hidden" name="standard" value="<%=standard%>"><input type="hidden" name="scontent" value="<%=scontent%>">
</table>
<input type="hidden" value="<%=idx%>" name="idx">
<input type="hidden" name="page" value="<%=bpage%>">
<input type="button" onclick="location.href='datBoard.jsp?page=1'" value="목록가기">
<input type="submit" value="수정하기">
</form>
</article>
</div>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>

</body>
</html>