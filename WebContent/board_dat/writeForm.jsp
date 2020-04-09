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
<link rel="stylesheet" href="../css/write_dat.css">
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
<tr><td><input type="text" name="category" value="자료" readonly></td></tr>
<tr><td><input type="text" placeholder="제목" name="title" required></td></tr>
<tr><td><input type="text" placeholder="닉네임" name="usernickname" value="<%=mdao.getNickname((String)session.getAttribute("id"))%>" readonly></td></tr>
<tr><td><input type="text" placeholder="아이디" name="userid" value="<%=session.getAttribute("id")%>" readonly></td></tr>
<tr><td><input type="text" placeholder="간단한 코멘트를 남겨주세요" name="content" required></td></tr>
<tr><td><input type="file" name="file" required></td></tr>
</table>
<input type="button" onclick="location.href='datBoard.jsp?page=1'" value="목록가기">
<input type="submit" value="작성하기">
</form>
</article>
</div>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>


</body>
</html>