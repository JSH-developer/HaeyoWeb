<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	MemberDAO mdao = MemberDAO.getMemberDAO();
	int chk = mdao.userCheck(id, pass);
	
	// 1 로그인 성공, 0 비밀번호 틀림, -1 아이디 없음
	if(chk == 1){out.print("success");session.setAttribute("id", id);}
	else if(chk==0){out.print("passerr");}
	else if(chk==-1){out.print("iderr");}
	else{out.print("err");}
	
%>
