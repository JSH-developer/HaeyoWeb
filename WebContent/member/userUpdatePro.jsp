<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
	md.updateMember(mb);
%>
<script>
alert("수정완료!");
location.href="userForm.jsp?id=<%=mb.getId()%>";
</script>

</body>
</html>