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
<%MemberDAO mdao = MemberDAO.getMemberDAO();
String id =(String)session.getAttribute("id");

if(id == null){
	out.println("<script>alert('로그인이 필요합니다');history.back();</script>");
	return;
}

%>
<h1>글을 작성해요</h1>
<form id="fr" action="writePro.jsp" method="post" enctype="multipart/form-data">
<table>
<tr><td>
<select name="category">
	<option value="자유">자유</option>
	<option value="인물">인물</option>
	<option value="음식">음식</option>
	<option value="동물">동물</option>
	<option value="풍경">풍경</option>
</select>
</td></tr>
<tr><td><input type="text" placeholder="제목" name="title" required maxlength="50"></td></tr>
<tr><td><input type="text" placeholder="닉네임" name="usernickname" value="<%=mdao.getNickname((String)session.getAttribute("id"))%>" readonly></td></tr>
<tr><td><input type="text" placeholder="아이디" name="userid" value="<%=session.getAttribute("id")%>" readonly></td></tr>
<tr><td><input type="text" placeholder="간단한 코멘트를 남겨주세요" name="content" required></td></tr>
<tr><td><input type="file" name="file" accept="image/*" required></td></tr>
</table>
<input type="button" onclick="location.href='galBoard.jsp?page=1'" value="목록가기">
<input type="submit" value="작성하기">
</form>
</article>
</div>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>


</body>
</html>