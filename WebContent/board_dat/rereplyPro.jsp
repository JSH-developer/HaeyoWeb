<%@page import="rereply.RereplyDAO"%>
<%@page import="rereply.RereplyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	int idx = Integer.parseInt(request.getParameter("idx"));
	int ridx = Integer.parseInt(request.getParameter("ridx"));
	String userid = request.getParameter("userid");
	String usernickname = request.getParameter("usernickname");
	String content = request.getParameter("content");
	
	RereplyBean rrb = new RereplyBean();
	rrb.setBr_idx(idx);
	rrb.setRp_idx(ridx);
	rrb.setId(userid);
	rrb.setNickname(usernickname);
	rrb.setContent(content);
	
	RereplyDAO rrdao = RereplyDAO.getRereplyDAO();
	rrdao.insertRereply("dat",rrb);
	

%>
