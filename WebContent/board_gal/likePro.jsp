<%@page import="fileboard.FileboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	String id =(String)session.getAttribute("id");
	
	FileboardDAO fdao = FileboardDAO.getFileboardDAO();
	if(fdao.isLike("gal", id, idx)){
		fdao.likeUp("gal", id, idx);
		out.println("success");
		return;
	}else{
		out.println("fail");
	}

%>