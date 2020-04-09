<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int ridx = Integer.parseInt(request.getParameter("ridx"));
	String id =(String)session.getAttribute("id");
	
	ReplyDAO rdao = ReplyDAO.getReplyDAO();
	if(rdao.isLike("cc", id, ridx)){
		rdao.likeDown("cc", id, ridx);
		out.println("success");
		return;
	}else{
		out.println("fail");
	}

%>
