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
	int bpage = Integer.parseInt(request.getParameter("page"));

	int idx = Integer.parseInt(request.getParameter("idx"));
	String category=request.getParameter("category");
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	String userid=request.getParameter("userid");
	String usernickname=request.getParameter("usernickname");
	
	String standard=request.getParameter("standard");
	String scontent=request.getParameter("scontent");
	
	BoardBean bb = new BoardBean();
	bb.setCategory(category);
	bb.setTitle(title);
	bb.setContent(content);
	bb.setId(userid);
	bb.setNickname(usernickname);
	
	BoardDAO bdao = BoardDAO.getBoardDAO();
	bdao.updateContent("kw",bb,idx);
%>
<script>
alert("수정하기");
</script>
<% 
if(standard.equals("null") && scontent.equals("null")){
	out.print("<script>location.href='readForm.jsp?page="+bpage+"&idx="+idx+"'</script>");			
}else{
	out.print("<script>location.href='readSearchForm.jsp?page="+bpage+"&idx="+idx+"&standard="+standard+"&scontent="+scontent+"'</script>");
}
%>
</body>
</html>