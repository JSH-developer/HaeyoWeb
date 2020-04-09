<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String name=request.getParameter("name");
	MemberDAO mdao = MemberDAO.getMemberDAO();
	boolean dup = mdao.nameDupCheck(name);
	if(dup){
		out.print("dup");
	}else{
		out.print("nodup");
	}
%>
