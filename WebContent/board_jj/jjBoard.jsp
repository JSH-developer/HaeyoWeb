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
	String bcategory=request.getParameter("category");
	BoardDAO bdao = BoardDAO.getBoardDAO();
%>
<link rel="stylesheet" href="../css/top.css">
<link rel="stylesheet" href="../css/bottom.css">
<link rel="stylesheet" href="../css/frame.css">
<link rel="stylesheet" href="../css/list_jj.css">

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
    	<a href="jjBoard.jsp?page=1"><button class="cate">전체보기</button></a><br>
    	<a href="jjBoard.jsp?page=1&category=잡담"><button class="cate">잡답해요</button></a><br>
    	<a href="jjBoard.jsp?page=1&category=모임"><button class="cate">같이해요</button></a><br>
      	<a href="jjBoard.jsp?page=1&category=홍보"><button class="cate">홍보해요</button></a><br>
      	<a href="jjBoard.jsp?page=1&category=거래"><button class="cate">거래해요</button></a><br>
      	<a href="jjBoard.jsp?page=1&category=베스트"><button class="cate">베스트</button></a><br>
</aside>
<article>
<h3>제주</h3>
<table class="bd" id="jjBoard" >
<tr><th>글번호</th><th>분류</th><th>글제목</th><th>닉네임</th><th>조회수</th><th>작성날짜</th></tr>
<%
	out.print(bdao.categoryBoard("jj",1,"공지"));
	if(bcategory!=null){
		out.print(bdao.categoryBoard("jj",bpage,bcategory));
	}else{
		out.print(bdao.readBoard("jj",bpage));	
	}
%>
</table>
<button class="wbtn" onclick="location.href='writeForm.jsp'">글쓰기</button><br>
<!-- 검색 -->
<form id="searchbar" action="searchBoard.jsp?page=1" method="post">
<select name="standard"><option value="opt_tt">제목</option><option value="opt_nn">닉네임</option><option value="opt_ct">내용</option></select>
<input type="text" name="scontent" placeholder="전체에서 검색을 실시합니다.">
<input type="hidden" name="page" value="<%=bpage%>">
<input type="submit" value="검색" class="sbtn">
</form>

<div id="page_box">
<%
	int cidx=0;
	if(bcategory != null){
		cidx = bdao.countCategoryIdx("jj", bcategory);
	}else{
		cidx = bdao.countIdx("jj");	
	}
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
				if(bcategory != null){
					out.println("<a href='jjBoard.jsp?page="+pages.get(i)+"&category="+bcategory+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
				}else{
					out.println("<a href='jjBoard.jsp?page="+pages.get(i)+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
				}
			}
		}else{
			for(int i=page_size-1;i>=page_size-(1+9);i--){ // 10페이지 출력
				if(bcategory != null){
					out.println("<a href='jjBoard.jsp?page="+pages.get(i)+"&category="+bcategory+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
				}else{
					out.println("<a href='jjBoard.jsp?page="+pages.get(i)+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
				}
			}
			out.println("<span> ... </span>");
			if(bcategory != null){
				out.println("<a href='jjBoard.jsp?page="+(page_size)+"&category="+bcategory+"' id='p"+(page_size)+"'>"+(page_size)+"</a>");
			}else{
				out.println("<a href='jjBoard.jsp?page="+(page_size)+"' id='p"+(page_size)+"'>"+(page_size)+"</a>");
			}
			
			if(bcategory != null){
				out.println("<a href='jjBoard.jsp?page="+( ((bpage+5)>=page_size) ? page_size:bpage+5 )+"&category="+bcategory+"'>  다음 </a>");
			}else{
				out.println("<a href='jjBoard.jsp?page="+( ((bpage+5)>=page_size) ? page_size:bpage+5 )+"'>  다음 </a>");
			}
			
			
		}
	}else if(bpage>=page_size-8){ //끝페이지에서 9번째 부터는 Out Of Index가 발생할 수 있으므로  방지하기위해
		if(bcategory != null){
			out.println("<a href='jjBoard.jsp?page="+(bpage-5)+"&category="+bcategory+"'> 이전  </a>");
		}else{
			out.println("<a href='jjBoard.jsp?page="+(bpage-5)+"'> 이전  </a>");
		}
		if(bcategory != null){
			out.println("<a href='jjBoard.jsp?page=1&category="+bcategory+"' id='p1'>1</a>");
		}else{
			out.println("<a href='jjBoard.jsp?page=1' id='p1'>1</a>");
		}
		
		
		out.println("<span> ... </span>");
		for(int i=9;i>=0;i--){ // 끝에서 부터 10개까지 출력
			if(bcategory != null){
				out.println("<a href='jjBoard.jsp?page="+pages.get(i)+"&category="+bcategory+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
			}else{
				out.println("<a href='jjBoard.jsp?page="+pages.get(i)+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
			}
		}
	
	
	}else{ // 현재페이지를 기준으로 앞 뒤로 4개의 페이지씩 출력
		if(bcategory != null){
			out.println("<a href='jjBoard.jsp?page="+(bpage-5)+"&category="+bcategory+"'> 이전  </a>");
		}else{
			out.println("<a href='jjBoard.jsp?page="+(bpage-5)+"'> 이전  </a>");
		}
		if(bcategory != null){
			out.println("<a href='jjBoard.jsp?page=1&category="+bcategory+"' id='p1'>1</a>");
		}else{
			out.println("<a href='jjBoard.jsp?page=1' id='p1'>1</a>");
		}
		
		out.println("<span> ... </span>");
		for(int i=page_size-bpage+4;i>=page_size-bpage-4;i--){ //9개 연속 출력
			if(bcategory != null){
				out.println("<a href='jjBoard.jsp?page="+pages.get(i)+"&category="+bcategory+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
			}else{
				out.println("<a href='jjBoard.jsp?page="+pages.get(i)+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
			}
		}
		out.println("<span> ... </span>");
		if(bcategory != null){
			out.println("<a href='jjBoard.jsp?page="+(page_size)+"&category="+bcategory+"' id='p"+(page_size)+"'>"+(page_size)+"</a>");
		}else{
			out.println("<a href='jjBoard.jsp?page="+(page_size)+"' id='p"+(page_size)+"'>"+(page_size)+"</a>");
		}
		if(bcategory != null){
			out.println("<a href='jjBoard.jsp?page="+(bpage+5)+"&category="+bcategory+"'> 다음 </a>");
		}else{
			out.println("<a href='jjBoard.jsp?page="+(bpage+5)+"'> 다음 </a>");
		}
		
		
	}
%>
</div>	
</article>
</div>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>

</body>
</html>