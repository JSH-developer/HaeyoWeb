<%@page import="reply.ReplyDAO"%>
<%@page import="board.BoardDAO"%>
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
	BoardDAO bdao = BoardDAO.getBoardDAO();

	request.setCharacterEncoding("UTF-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	
	bdao.deleteContent("kw",idx);
%>

<script>
location.href="kwBoard.jsp?page=1"
</script>

</body>
</html>