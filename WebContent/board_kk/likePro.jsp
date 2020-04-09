<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	String id =(String)session.getAttribute("id");
	
	BoardDAO bdao = BoardDAO.getBoardDAO();
	if(bdao.isLike("kk", id, idx)){
		bdao.likeUp("kk", id, idx);
		out.println("success");
		return;
	}else{
		out.println("fail");
	}

%>
