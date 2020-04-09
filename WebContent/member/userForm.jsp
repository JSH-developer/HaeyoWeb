<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>해요-친구찾기</title>
<link rel="stylesheet" href="../css/top.css">
<link rel="stylesheet" href="../css/bottom.css">
<link rel="stylesheet" href="../css/frame.css">
<style>
body{
zoom: 1 !important;
}
#user_info{
	text-align:left;
	width: 700px;
	height: auto;
 	margin-left:530px; 
	font-family:'jua', sans-serif;
}
.info_tag{
	display: block;
	width:500px;
	margin-bottom: 10px;
	color: gray;
}
.info{
	display: block;
	width:100%;
	margin-bottom: 10px;
	border-bottom: 0.5px solid #c2c2c2;
}
button{
	float:left;
	margin-top: 15px;
	text-align: center;
	height: 45px;
	margin-bottom:0px;
	width: 100%;
	display:inline-block;
	font-family: 'Jua', sans-serif;
	font-size: 18px;
	color:white;
	background: #77a6f2;
	border:none;
	border-radius: 15px;	
}
.udel{
	margin-top:5px;
	margin-bottom:5px;
	background: #ff2e40;
}
button:hover,button:active{
	background-color: white;
	color:#77a6f2;
	border:1px double #77a6f2;
	transition-duration: 0.3s;
}
.udel:hover,.udel:active{
	color: #ff2e40;
	border:1px double #ff2e40;
	transition-duration: 0.3s;
}
</style>
<script>
function userDel(){
	var is_bye = confirm("정말로 탈퇴하실 건가요? ㅠㅠ");
	if(is_bye){
		location.href="userDelete.jsp";	
	}
}
</script>

</head>
<body>
<!-- 헤더, 네비게이션 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 본문 -->
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");

MemberDAO md = MemberDAO.getMemberDAO();
MemberBean mb = md.getUserInfo(id);
if(!id.equals((String)session.getAttribute("id"))){
	out.println("<script>alert('접근권한이 없습니다!'); history.back();</script>");
}
%>

<div id="user_info">
<h1>나 의 정 보</h1>
<span class='info_tag'>회원번호 </span> <span class='info'><%=mb.getIdx() %></span><br>
<span class='info_tag'>아이디 </span> <span class='info'><%=mb.getId() %></span><br>
<span class='info_tag'>닉네임 </span> <span class='info'><%=mb.getNickname() %></span><br>
<span class='info_tag'>성별 </span> <span class='info'><%=mb.getGender() %></span><br>
<span class='info_tag'>우편번호 </span> <span class='info'><%=mb.getPcode() %></span><br>
<span class='info_tag'>도로명주소 </span> <span class='info'><%=mb.getAddress1() %></span><br>
<span class='info_tag'>지번주소 </span> <span class='info'><%=mb.getAddress2() %></span><br>
<span class='info_tag'>폰번호 </span> <span class='info'><%=mb.getPhone() %></span><br>
<span class='info_tag'>이메일 </span> <span class='info'><%=mb.getEmail() %></span><br>
<span class='info_tag'>가입일자 </span> <span class='info'><%=mb.getRegtime() %></span><br>
<button onclick="location.href='userUpdateForm.jsp?id=<%=session.getAttribute("id")%>'">회원정보수정</button><br>
<button class='udel' onclick='userDel()'>회원탈퇴하기</button><br>
</div>

<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>

</body>
</html>