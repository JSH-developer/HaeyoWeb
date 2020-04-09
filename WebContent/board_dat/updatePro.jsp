<%@page import="fileboard.FileboardDAO"%>
<%@page import="fileboard.FileboardBean"%>
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
	String file=request.getParameter("file");
	String userid=request.getParameter("userid");
	String usernickname=request.getParameter("usernickname");
	
	String standard=request.getParameter("standard");
	String scontent=request.getParameter("scontent");
	
	FileboardBean fb = new FileboardBean();
	fb.setCategory(category);
	fb.setTitle(title);
	fb.setContent(content);
	fb.setFile(file);
	fb.setId(userid);
	fb.setNickname(usernickname);
	
	FileboardDAO fdao = FileboardDAO.getFileboardDAO();
	fdao.updateContent("dat",fb,idx);
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