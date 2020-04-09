<%@page import="rereply.RereplyDAO"%>
<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	int rridx=Integer.parseInt(request.getParameter("rridx"));

	RereplyDAO rdao = RereplyDAO.getRereplyDAO();
	rdao.deleteRereply("jr",rridx);
%>
