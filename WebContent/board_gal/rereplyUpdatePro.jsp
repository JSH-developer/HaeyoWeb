<%@page import="rereply.RereplyDAO"%>
<%@page import="rereply.RereplyBean"%>
<%@page import="reply.ReplyDAO"%>
<%@page import="reply.ReplyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	int rrp_idx=Integer.parseInt(request.getParameter("rrp_idx"));
	String rrp_content = request.getParameter("rrp_content");
	String userid = request.getParameter("userid");
	String usernickname = request.getParameter("usernickname");
	
	RereplyBean rrb = new RereplyBean();
	rrb.setIdx(rrp_idx);
	rrb.setContent(rrp_content);
	rrb.setId(userid);
	rrb.setNickname(usernickname);
	
	RereplyDAO rrdao = RereplyDAO.getRereplyDAO();
	rrdao.updateRereply("gal",rrb);

%>
