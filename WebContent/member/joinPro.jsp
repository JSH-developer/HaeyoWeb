<%@page import="com.mysql.jdbc.Blob"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/top.css">
<link rel="stylesheet" href="../css/bottom.css">
<link rel="stylesheet" href="../css/frame.css">
<title>Insert title here</title>
</head>
<body>
<!-- 헤더, 네비게이션 -->
<jsp:include page="../inc/top.jsp"/>
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String nickname = request.getParameter("nickname");
	String gender = request.getParameter("gender");
	String pcode = request.getParameter("pcode");
	String address1 = request.getParameter("address1") + " " + request.getParameter("address3");
	String address2 = request.getParameter("address2") + " " + request.getParameter("address3");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	
	MemberBean mb = new MemberBean();
	mb.setId(id);
	mb.setPass(pass);
	mb.setNickname(nickname);
	mb.setGender(gender);
	mb.setPcode(pcode);
	mb.setAddress1(address1);
	mb.setAddress2(address2);
	mb.setPhone(phone);
	mb.setEmail(email);
	
	MemberDAO md = MemberDAO.getMemberDAO();
	md.joinMember(mb);
%>
<script>
alert("회원가입이 완료되었습니다  ^__^");
location.href="../main/main.jsp";
</script>
</body>
</html>