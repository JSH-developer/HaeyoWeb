<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>해요-친구찾기</title>
<%
	request.setCharacterEncoding("UTF-8");
	int bpage=Integer.parseInt(request.getParameter("page"));
	BoardDAO bdao = BoardDAO.getBoardDAO();
	
	String standard=request.getParameter("standard");
	String scontent=request.getParameter("scontent");
	
%>
<link rel="stylesheet" href="../css/top.css">
<link rel="stylesheet" href="../css/bottom.css">
<link rel="stylesheet" href="../css/frame.css">
<link rel="stylesheet" href="../css/list_jr.css">

<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<script src="../js/jquery.js"></script>
<script>
$(function(){
	// 현재 페이지 표시
	$("#p<%=bpage%>").css("font-size","25px");
});
</script>


</head>
<body>
<!-- 헤더, 네비게이션 -->
<jsp:include page="../inc/top.jsp"/>
<div id="wrap1">
<aside>
	<h1>골라보기</h1>
    	<a href="jrBoard.jsp?page=1"><button class="cate">전체보기</button></a><br>
    	<a href="jrBoard.jsp?page=1&category=잡담"><button class="cate">잡답해요</button></a><br>
    	<a href="jrBoard.jsp?page=1&category=모임"><button class="cate">같이해요</button></a><br>
      	<a href="jrBoard.jsp?page=1&category=홍보"><button class="cate">홍보해요</button></a><br>
      	<a href="jrBoard.jsp?page=1&category=거래"><button class="cate">거래해요</button></a><br>
      	<a href="jrBoard.jsp?page=1&category=베스트"><button class="cate">베스트</button></a><br>
</aside>
<article>
<h3>전라</h3>
<table class="bd" id="jrBoard" >
<tr><th>글번호</th><th>분류</th><th>글제목</th><th>닉네임</th><th>조회수</th><th>작성날짜</th></tr>
<%
	out.print(bdao.categoryBoard("jr",1,"공지"));
	out.print(bdao.searchBoard("jr",bpage,standard,scontent));
%>
</table>
<button class="wbtn" onclick="location.href='writeForm.jsp'">글쓰기</button><br>
<!-- 검색 -->
<form action="searchBoard.jsp?page=1" method="post" id="searchbar">
<select name="standard"><option value="opt_tt">제목</option><option value="opt_nn">닉네임</option><option value="opt_ct">내용</option></select><input type="text" name="scontent" placeholder="전체에서 검색을 실시합니다.">
<input type="hidden" name="page" value="<%=bpage%>">
<input type="submit" value="검색" class="sbtn">
</form>

<div id="page_box">
<%
	int cidx=0;
	cidx = bdao.countsearchIdx("jr", standard, scontent);	
	int row=20; // 행 출력 값 변경, 
	int max_page=0;
	if(cidx%row==0){// row개 출력 기준	
		max_page += cidx/row;
	}else{
		max_page += (cidx/row+1);
	}
	List<Integer> pages = new ArrayList<Integer>();
	while(max_page>0){
		pages.add(max_page);
		max_page--;
	}
	int page_size = pages.size();
	
	// 화면의 11개의 페이지 메뉴가 출력되도록 설계하는중...
	if(bpage<10){ // 10이상부터 형식이 바뀜
		if(page_size<=10){
			for(int i=page_size-1;i>=0;i--){
					out.println("<a href='searchBoard.jsp?page="+pages.get(i)+"&standard="+standard+"&scontent="+scontent+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
			}
		}else{
			for(int i=page_size-1;i>=page_size-(1+9);i--){ // 10페이지 출력
					out.println("<a href='searchBoard.jsp?page="+pages.get(i)+"&standard="+standard+"&scontent="+scontent+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
			}
			out.println("<span> ... </span>");
				out.println("<a href='searchBoard.jsp?page="+(page_size)+"&standard="+standard+"&scontent="+scontent+"' id='p"+(page_size)+"'>"+(page_size)+"</a>");
				out.println("<a href='searchBoard.jsp?page="+( ((bpage+5)>=page_size) ? page_size:bpage+5 ) +"&standard="+standard+"&scontent="+scontent+"'>  다음 </a>");
			
			
		}
	}else if(bpage>=page_size-8){ //끝페이지에서 9번째 부터는 Out Of Index가 발생할 수 있으므로  방지하기위해
			out.println("<a href='searchBoard.jsp?page="+(bpage-5)+"&standard="+standard+"&scontent="+scontent+"'> 이전  </a>");
			out.println("<a href='searchBoard.jsp?page=1&standard="+ standard +"&scontent="+ scontent + "' id='p1'>1</a>");
		
		out.println("<span> ... </span>");
		for(int i=9;i>=0;i--){ // 끝에서 부터 10개까지 출력
				out.println("<a href='searchBoard.jsp?page="+pages.get(i)+"&standard="+standard+"&scontent="+scontent+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
		}
	
	}else{ // 현재페이지를 기준으로 앞 뒤로 4개의 페이지씩 출력
			out.println("<a href='searchBoard.jsp?page="+(bpage-5)+"&standard="+standard+"&scontent="+scontent+"'> 이전 </a>");
			out.println("<a href='searchBoard.jsp?page=1&standard="+ standard +"&scontent="+ scontent + "' id='p1'>1</a>");
		
		out.println("<span> ... </span>");
		for(int i=page_size-bpage+4;i>=page_size-bpage-4;i--){ //9개 연속 출력
				out.println("<a href='searchBoard.jsp?page="+pages.get(i)+"&standard="+standard+"&scontent="+scontent+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
		}
		out.println("<span> ... </span>");
			out.println("<a href='searchBoard.jsp?page="+(page_size)+"&standard="+standard+"&scontent="+scontent+"' id='p"+(page_size)+"'>"+(page_size)+"</a>");
			out.println("<a href='searchBoard.jsp?page="+( ((bpage+5)>=page_size) ? page_size:bpage+5 )+"&standard="+standard+"&scontent="+scontent+"'> 다음 </a>");
		
	}
%>
</div>	
</article>
</div>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>

</body>
</html>