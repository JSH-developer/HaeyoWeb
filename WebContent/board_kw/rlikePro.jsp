<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int ridx = Integer.parseInt(request.getParameter("ridx"));
	String id =(String)session.getAttribute("id");
	
	ReplyDAO rdao = ReplyDAO.getReplyDAO();
	if(rdao.isLike("kw", id, ridx)){
		rdao.likeUp("kw", id, ridx);
		out.println("success");
		return;
	}else{
		out.println("fail");
	}

%>
