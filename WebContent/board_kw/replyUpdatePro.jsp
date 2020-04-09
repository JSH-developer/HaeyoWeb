<%@page import="reply.ReplyDAO"%>
<%@page import="reply.ReplyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	int idx = Integer.parseInt(request.getParameter("idx"));
	int rp_idx=Integer.parseInt(request.getParameter("rp_idx"));
	String rp_content = request.getParameter("rp_content");
	String userid = request.getParameter("userid");
	String usernickname = request.getParameter("usernickname");
	
	ReplyBean rb = new ReplyBean();
	rb.setIdx(rp_idx);
	rb.setContent(rp_content);
	rb.setId(userid);
	rb.setNickname(usernickname);
	
	ReplyDAO rdao = ReplyDAO.getReplyDAO();
	rdao.updateReply("kw",rb);

%>
