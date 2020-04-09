<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%MemberDAO mdao = MemberDAO.getMemberDAO(); %>
 <link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
  <header>

<div id="home_title">H A E Y O</div>
<%String id=(String)session.getAttribute("id");
if(id==null){%>
<div id="login_box"><a href="../member/login.jsp"><img src="../images/login.png" width="25" height="25"> 로그인</a> | <a href="../member/join.jsp"><img src="../images/join.png" width="25" height="25"> 회원가입</a></div>
<%}else{%>
<div id="login_box"><%=mdao.getNickname((String)session.getAttribute("id"))%>(<%=session.getAttribute("id")%>)님  <a href="../member/userForm.jsp?id=<%=session.getAttribute("id")%>"><img src="../images/info.png" width="25" height="25"> 회원정보보기</a> | <a href="../member/logout.jsp"><img src="../images/logout.png" width="25" height="25"> 로그아웃</a></div>
<%}%>

</header>
   
	<nav>
   	      <ul>
   	         <li><a href="../main/main.jsp" class="menu0">Home</a></li>
   	         <li><a href="../board_kk/kkBoard.jsp?page=1" class="menu1">경기</a>
   	         <ul class="submenu submenu1">
   	         	<li><a href="../board_kk/kkBoard.jsp?page=1&category=잡담">잡담해요</a></li>
   	         	<li><a href="../board_kk/kkBoard.jsp?page=1&category=모임">같이해요</a></li>
   	         	<li><a href="../board_kk/kkBoard.jsp?page=1&category=홍보">홍보해요</a></li>
   	         	<li><a href="../board_kk/kkBoard.jsp?page=1&category=거래">거래해요</a></li>
   	         	<li><a href="../board_kk/kkBoard.jsp?page=1&category=베스트">베스트</a></li>
   	         </ul>
   	         </li>
   	         <li><a href="../board_ks/ksBoard.jsp?page=1" class="menu2">경상</a>
   	         <ul class="submenu submenu2">
   	         	<li><a href="../board_ks/ksBoard.jsp?page=1&category=잡담">잡담해요</a></li>
   	         	<li><a href="../board_ks/ksBoard.jsp?page=1&category=모임">같이해요</a></li>
   	         	<li><a href="../board_ks/ksBoard.jsp?page=1&category=홍보">홍보해요</a></li>
   	         	<li><a href="../board_ks/ksBoard.jsp?page=1&category=거래">거래해요</a></li>
   	         	<li><a href="../board_ks/ksBoard.jsp?page=1&category=베스트">베스트</a></li>
   	         </ul>
   	         </li>
   	         <li><a href="../board_kw/kwBoard.jsp?page=1" class="menu3">강원</a>
   	         <ul class="submenu submenu3">
   	         	<li><a href="../board_kw/kwBoard.jsp?page=1&category=잡담">잡담해요</a></li>
   	         	<li><a href="../board_kw/kwBoard.jsp?page=1&category=모임">같이해요</a></li>
   	         	<li><a href="../board_kw/kwBoard.jsp?page=1&category=홍보">홍보해요</a></li>
   	         	<li><a href="../board_kw/kwBoard.jsp?page=1&category=거래">거래해요</a></li>
   	         	<li><a href="../board_kw/kwBoard.jsp?page=1&category=베스트">베스트</a></li>
   	         </ul>
   	         </li>
   	         <li><a href="../board_jj/jjBoard.jsp?page=1" class="menu4">제주</a>
   	         <ul class="submenu submenu4">
   	         	<li><a href="../board_jj/jjBoard.jsp?page=1&category=잡담">잡담해요</a></li>
   	         	<li><a href="../board_jj/jjBoard.jsp?page=1&category=모임">같이해요</a></li>
   	         	<li><a href="../board_jj/jjBoard.jsp?page=1&category=홍보">홍보해요</a></li>
   	         	<li><a href="../board_jj/jjBoard.jsp?page=1&category=거래">거래해요</a></li>
   	         	<li><a href="../board_jj/jjBoard.jsp?page=1&category=베스트">베스트</a></li>
   	         </ul>
   	         </li>
   	         <li><a href="../board_jr/jrBoard.jsp?page=1" class="menu5">전라</a>
   	         <ul class="submenu submenu5">
   	         	<li><a href="../board_jr/jrBoard.jsp?page=1&category=잡담">잡담해요</a></li>
   	         	<li><a href="../board_jr/jrBoard.jsp?page=1&category=모임">같이해요</a></li>
   	         	<li><a href="../board_jr/jrBoard.jsp?page=1&category=홍보">홍보해요</a></li>
   	         	<li><a href="../board_jr/jrBoard.jsp?page=1&category=거래">거래해요</a></li>
   	         	<li><a href="../board_jr/jrBoard.jsp?page=1&category=베스트">베스트</a></li>
   	         </ul>
   	         </li>
   	         <li><a href="../board_cc/ccBoard.jsp?page=1" class="menu6">충청</a>
   	         <ul class="submenu submenu6">
   	         	<li><a href="../board_cc/ccBoard.jsp?page=1&category=잡담">잡담해요</a></li>
   	         	<li><a href="../board_cc/ccBoard.jsp?page=1&category=모임">같이해요</a></li>
   	         	<li><a href="../board_cc/ccBoard.jsp?page=1&category=홍보">홍보해요</a></li>
   	         	<li><a href="../board_cc/ccBoard.jsp?page=1&category=거래">거래해요</a></li>
   	         	<li><a href="../board_cc/ccBoard.jsp?page=1&category=베스트">베스트</a></li>
   	         </ul>
   	         </li>
   	         <li><a href="../board_gal/galBoard.jsp?page=1" class="menu7">갤러리</a>
	   	         <ul class="submenu submenu7">
	   	         	<li><a href="../board_gal/galBoard.jsp?page=1&category=자유">자유갤러리</a></li>
	   	         	<li><a href="../board_gal/galBoard.jsp?page=1&category=인물">인물갤러리</a></li>
	   	         	<li><a href="../board_gal/galBoard.jsp?page=1&category=음식">음식갤러리</a></li>
	   	         	<li><a href="../board_gal/galBoard.jsp?page=1&category=동물">동물갤러리</a></li>
	   	         	<li><a href="../board_gal/galBoard.jsp?page=1&category=풍경">풍경갤러리</a></li>
	   	         </ul>
   	         </li>
   	         <li><a href="../board_dat/datBoard.jsp?page=1" class="menu8">자료실</a></li>
   	      </ul>
   	      <a id="pull" href="#">Menu</a>
   	  </nav>
   	  

