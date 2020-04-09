<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	int ridx=Integer.parseInt(request.getParameter("ridx"));

	ReplyDAO rdao = ReplyDAO.getReplyDAO();
	rdao.deleteReply("jj",ridx);
%>
