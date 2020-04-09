<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	
	String category=request.getParameter("category");
	String title=request.getParameter("title");
	String userpass=request.getParameter("userpass");
	String content=request.getParameter("content");
	int rcount=0;
	String userid=request.getParameter("userid");
	String usernickname=request.getParameter("usernickname");
	
	BoardBean bb = new BoardBean();
	bb.setCategory(category);
	bb.setTitle(title);
	bb.setContent(content);
	bb.setId(userid);
	bb.setNickname(usernickname);
	bb.setRcount(rcount);
	
	BoardDAO bdao = BoardDAO.getBoardDAO();
	bdao.insertBoard("cc",bb);
%>
<script>
alert("글작성 완료");
location.href="ccBoard.jsp?page=1";
</script>

</body>
</html>