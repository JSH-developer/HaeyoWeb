<%@page import="reply.ReplyDAO"%>
<%@page import="reply.ReplyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	int idx = Integer.parseInt(request.getParameter("idx"));
	String userid = request.getParameter("userid");
	String usernickname = request.getParameter("usernickname");
	String content = request.getParameter("content");
	String id =(String)session.getAttribute("id");
	
	ReplyBean rb = new ReplyBean();
	rb.setBr_idx(idx);
	rb.setId(userid);
	rb.setNickname(usernickname);
	rb.setContent(content);
	
	ReplyDAO rdao = ReplyDAO.getReplyDAO();
	rdao.insertReply("kw",rb);
%>

