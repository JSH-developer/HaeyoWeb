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
<link rel="stylesheet" href="../css/write_gal.css">

</head>
<body>
<!-- 헤더, 네비게이션 -->
<jsp:include page="../inc/top.jsp"/>
<div id="wrap1">
<aside>
	<h1>골라보기</h1>
    	<a href="galBoard.jsp?page=1"><button class="cate">전체보기</button></a><br>
    	<a href="galBoard.jsp?page=1&category=자유"><button class="cate">자유</button></a><br>
    	<a href="galBoard.jsp?page=1&category=인물"><button class="cate">인물</button></a><br>
      	<a href="galBoard.jsp?page=1&category=음식"><button class="cate">음식</button></a><br>
      	<a href="galBoard.jsp?page=1&category=동물"><button class="cate">동물</button></a><br>
      	<a href="galBoard.jsp?page=1&category=풍경"><button class="cate">풍경</button></a><br>
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
	FileboardBean fb = fdao.getBean("gal",idx);
	MemberDAO mdao = MemberDAO.getMemberDAO();
%>
<form action="updatePro.jsp" method="post">
<table>
<tr><td>
<select name="category">
	<option value="자유"<% if(fb.getCategory().equals("자유")){%>selected<%}%>>자유</option>
	<option value="인물"<% if(fb.getCategory().equals("인물")){%>selected<%}%>>인물</option>
	<option value="음식"<% if(fb.getCategory().equals("음식")){%>selected<%}%>>음식</option>
	<option value="동물"<% if(fb.getCategory().equals("동물")){%>selected<%}%>>동물</option>
	<option value="풍경"<% if(fb.getCategory().equals("풍경")){%>selected<%}%>>풍경</option>
</select>
</td></tr>
<tr><td><input type="text" placeholder="제목" name="title" value="<%=fb.getTitle()%>"></td></tr>
<tr><td><input type="text" placeholder="닉네임" name="usernickname" value="<%=mdao.getNickname(id)%>" readonly></td></tr>
<tr><td><input type="text" placeholder="아이디" name="userid" value="<%=id%>" readonly></td></tr>
<tr><td><input type="text" name="content" placeholder="간단한 코멘트를 남겨주세요" value="<%=fb.getContent()%>"></td></tr>
<input type="hidden" name="file" value="<%=fb.getFile()%>"><input type="hidden" name="standard" value="<%=standard%>"><input type="hidden" name="scontent" value="<%=scontent%>">
</table>
<input type="hidden" value="<%=idx%>" name="idx">
<input type="hidden" name="page" value="<%=bpage%>">
<input type="button" onclick="location.href='galBoard.jsp?page=1'" value="목록가기">
<input type="submit" value="수정하기">
</form>
</article>
</div>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>

</body>
</html>