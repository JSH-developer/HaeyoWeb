<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDAO mdao = MemberDAO.getMemberDAO();
	String user_id = (String)session.getAttribute("id");
	
	mdao.deleteMember(user_id);
	session.invalidate();	
%>
<script>
	alert("다음에 또 만나요!");
	location.href="../main/main.jsp";
</script>