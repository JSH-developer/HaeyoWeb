<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id=request.getParameter("id");
	MemberDAO mdao = MemberDAO.getMemberDAO();
	boolean dup = mdao.idDupCheck(id);
	if(dup){
		out.print("dup");
	}else{
		out.print("nodup");
	}
%>
