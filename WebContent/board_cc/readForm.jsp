<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="rereply.RereplyDAO"%>
<%@page import="rereply.RereplyBean"%>
<%@page import="reply.ReplyBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="board.BoardDAO"%>
<html>
<head>
<title>해요-친구찾기</title>
<link rel="stylesheet" href="../css/top.css">
<link rel="stylesheet" href="../css/bottom.css">
<link rel="stylesheet" href="../css/frame.css">
<link rel="stylesheet" href="../css/list_cc.css">
<link rel="stylesheet" href="../css/read_cc.css">
<%
	request.setCharacterEncoding("UTF-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	int bpage = Integer.parseInt(request.getParameter("page"));
	String bcategory = request.getParameter("category");
	
	BoardDAO bdao = BoardDAO.getBoardDAO();
	bdao.countRead("cc",idx);
	
	ReplyDAO rdao = ReplyDAO.getReplyDAO();
	RereplyDAO rrdao = RereplyDAO.getRereplyDAO();
	int ridx=0;
	int rridx=0;
	
	MemberDAO mdao = MemberDAO.getMemberDAO();
	String id = (String)session.getAttribute("id");
%>
<script src="../js/jquery.js"></script>
<script>

$(function(){
	//댓글 쓰기 & 이동 --> 이동 아직 안함
	$("#rep_fr_btn").on("click",function(){
		var idx = $('#idx').val();
		var userid = $('#userid').val();
		var usernickname = $('#usernickname').val();
		var content = $('#content').val();
		if(userid=="null"){
			alert("로그인이 필요합니다");
			return;
		}
		$.ajax({
			url : 'replyPro.jsp?idx='+idx+'&userid='+userid+'&usernickname='+usernickname+'&content='+content,
			type : 'post',
			success: function(){
				location.reload();
			},
			error : function() {
				console.log("실패");
				}
			});
	});
	
	// 댓글 수정 폼 표시
	$(".rp_update_btn").on("click",function(){
		var btn_id = "#"+$(this).attr('id'); 
		var state = $(btn_id).closest("span").children("form.rfr1").css("display");
		if(state == 'none'){
			$(btn_id).closest("span").children("form.rfr1").show();
			$(btn_id).closest("span").children("form.rfr2").hide();
		}else{ 
			$(btn_id).closest("span").children("form.rfr1").hide();
			$(btn_id).closest("span").children("form.rfr2").hide();
		}
	});
	// 댓글 수정하기
	$("form.rfr1>input[type=button]").on("click",function(){
		var form_id = "#"+$(this).parents("form").attr('id');
		var idx = $(form_id+">.idx").val();
		var rp_idx = $(form_id+">.rp_idx").val();
		var userid =  $(form_id+">.userid").val();
		var usernickname = $(form_id+">.usernickname").val();
		var rp_content = $(form_id+">.rp_content").val();
		$.ajax({
			url : 'replyUpdatePro.jsp?idx='+idx+'&userid='+userid+'&usernickname='+usernickname+'&rp_content='+rp_content+'&rp_idx='+rp_idx,
			type : 'post',
			success: function(){
				location.reload();
			},
			error : function() {
				console.log("실패");
				}
			});
	});
	
	//댓글 삭제
	$(".rp_del_btn").on("click",function(){
		var span_id = "#"+$(this).parents("span").attr('id');
		var ridx = $(span_id+">.whatridx").val();
		var is_delete = confirm("삭제하시겠습니까?\n(※대댓글이 달린 댓글은 삭제가 불가능합니다.)");
		if(is_delete){
			$.ajax({
				url : 'replyDeletePro.jsp?ridx='+ridx,
				type : 'post',
				success: function(){
					location.reload();
				},
				error : function() {
					console.log("실패");
					}
				});
		}else{
		}
	});
	
	// 글 삭제
	$("#con_delete_btn").on("click",function(){
		var is_delete = confirm("정말로 삭제하시겠습니까?\n(※댓글이 달린 글은 삭제가 불가능합니다.)");
		var idx = $('#idx').val();
		if(is_delete){
			location.href="deletePro.jsp?idx="+idx;
		}else{
			
		}
	});
	
	// 대댓글 폼 표시
	$(".rp_ans_btn").on("click",function(){
		var btn_id = "#"+$(this).attr('id'); 
		var state = $(btn_id).closest("span").children("form.rfr2").css("display");
		if(state == 'none'){
			$(btn_id).closest("span").children("form.rfr2").show();
			$(btn_id).closest("span").children("form.rfr1").hide();
		}else{ 
			$(btn_id).closest("span").children("form.rfr2").hide();
			$(btn_id).closest("span").children("form.rfr1").hide();
		}
	});
	
	//대댓글 쓰기
	$("form.rfr2>input[type=button]").on("click",function(){
		var form_id = "#"+$(this).parents("form").attr('id');
		var idx = $(form_id+">.idx").val();
		var ridx = $(form_id+">.ridx").val();
		var userid = $(form_id+">.userid").val();
		var usernickname = $(form_id+">.usernickname").val();
		var content = $(form_id+">.rep_write").val();
		if(userid=="null"){
			alert("로그인이 필요합니다");
			return;
		}
		$.ajax({
			url : 'rereplyPro.jsp?idx='+idx+'&userid='+userid+'&usernickname='+usernickname+'&content='+content+'&ridx='+ridx,
			type : 'post',
			success: function(){
				location.reload();
			},
			error : function() {
				console.log("실패");
				}
			});
	});
	
	// 대댓글 수정 폼표시
	$(".rrp_update_btn").on("click",function(){
		var btn_id = "#"+$(this).attr('id'); 
		var state = $(btn_id).closest("span").children("form.rrfr1").css("display");
		if(state == 'none'){
			$(btn_id).closest("span").children("form.rrfr1").show();
		}else{ 
			$(btn_id).closest("span").children("form.rrfr1").hide();	
		}
	});
	
	// 대댓글 수정하기
	$("form.rrfr1>input[type=button]").on("click",function(){
		var form_id = "#"+$(this).parents("form").attr('id');
		var rrp_idx = $(form_id+">.rrp_idx").val();
		var userid =  $(form_id+">.userid").val();
		var usernickname = $(form_id+">.usernickname").val();
		var rrp_content = $(form_id+">.rep_write").val();
		$.ajax({
			url : 'rereplyUpdatePro.jsp?rrp_idx='+rrp_idx+'&userid='+userid+'&usernickname='+usernickname+'&rrp_content='+rrp_content,
			type : 'post',
			success: function(){
				location.reload();
			},
			error : function() {
				console.log("실패");
				}
			});
	})
	
	// 대댓글 삭제
	$(".rrp_del_btn").on("click",function(){
		var span_id = "#"+$(this).parents("span").attr('id');
		var rridx = $(span_id+">.whatrridx").val();
		var is_delete = confirm("삭제하시겠습니까?");
		if(is_delete){
			$.ajax({
				url : 'rereplyDeletePro.jsp?rridx='+rridx,
				type : 'post',
				success: function(){
					location.reload();
				},
				error : function() {
					console.log("실패");
					}
				});
		}else{
		}
	});
	
	//게시글 좋아요
	$("a.blike").on("click",function(){
		var idx= $('#idx').val();
		var userid= $('#userid').val();
		if(userid == "null"){
			alert("로그인이 필요합니다.")
			return;
		}
		$.ajax({
			url : 'likePro.jsp?idx='+idx+'&id=' + userid,
			type : 'post',
			success : function(data) {
		    	  	if($.trim(data)=="success"){
		    	  		alert("추천하였습니다.")
		    	  		location.reload();
					}else if($.trim(data)=="fail"){
						alert("이미 추천하거나 비추천한 게시물 입니다.")
					}else{
						alert("error")
					}
				}, error : function() {
						console.log("실패");
				}
			});
		
		
	});
	$("a.bunlike").on("click",function(){
		var idx= $('#idx').val();
		var userid= $('#userid').val();
		if(userid == "null"){
			alert("로그인이 필요합니다.")
			return;
		}
		$.ajax({
			url : 'unlikePro.jsp?idx='+idx+'&id=' + userid,
			type : 'post',
			success : function(data) {
		    	  	if($.trim(data)=="success"){
		    	  		alert("비추천하였습니다.")
		    	  		location.reload();
					}else if($.trim(data)=="fail"){
						alert("이미 추천하거나 비추천한 게시물 입니다.")
					}else{
						alert("error")
					}
				}, error : function() {
						console.log("실패");
				}
			});
		
		
	});
	// 댓글 좋아요
	$("a.rlike").on("click",function(){
		var span_id = "#"+$(this).parents("span").attr('id');
		var ridx = $(span_id+">.whatridx").val();
		var userid= $('#userid').val();
		if(userid == "null"){
			alert("로그인이 필요합니다.")
			return;
		}
		$.ajax({
			url : 'rlikePro.jsp?ridx='+ridx+'&id=' + userid,
			type : 'post',
			success : function(data) {
		    	  	if($.trim(data)=="success"){
		    	  		alert("추천하였습니다.")
		    	  		location.reload();
					}else if($.trim(data)=="fail"){
						alert("이미 추천하거나 비추천한 댓글 입니다.")
					}else{
						alert("error")
					}
				}, error : function() {
						console.log("실패");
				}
			});
	});
	$("a.runlike").on("click",function(){
		var span_id = "#"+$(this).parents("span").attr('id');
		var ridx = $(span_id+">.whatridx").val();
		var userid= $('#userid').val();
		if(userid == "null"){
			alert("로그인이 필요합니다.")
			return;
		}
		$.ajax({
			url : 'runlikePro.jsp?ridx='+ridx+'&id=' + userid,
			type : 'post',
			success : function(data) {
		    	  	if($.trim(data)=="success"){
		    	  		alert("비추천하였습니다.")
		    	  		location.reload();
					}else if($.trim(data)=="fail"){
						alert("이미 추천하거나 비추천한 댓글 입니다.")
					}else{
						alert("error")
					}
				}, error : function() {
						console.log("실패");
				}
			});
	});
	
	//현재 페이지 표시
	$("#p<%=bpage%>").css("font-size","25px");
	
	//현재 리스트 표시
	$("#tr<%=idx%>").css("background-color","#cfd2e8");
	
	
});

</script>

</head>
<body>
<!-- 헤더, 네비게이션 -->
<jsp:include page="../inc/top.jsp"/>
<div id="wrap1">
<aside>
	<h1>골라보기</h1>
    	<a href="ccBoard.jsp?page=1"><button class="cate">전체보기</button></a><br>
    	<a href="ccBoard.jsp?page=1&category=잡담"><button class="cate">잡답해요</button></a><br>
    	<a href="ccBoard.jsp?page=1&category=모임"><button class="cate" >같이해요</button></a><br>
      	<a href="ccBoard.jsp?page=1&category=홍보"><button class="cate">홍보해요</button></a><br>
      	<a href="ccBoard.jsp?page=1&category=거래"><button class="cate" >거래해요</button></a><br>
      	<a href="ccBoard.jsp?page=1&category=베스트"><button class="cate">베스트</button></a><br>
</aside>
<article>
<table class="rf">
<%
	out.print(bdao.readContent("cc",idx));
%>
<tr><td><a class="blike" ><img src='../images/smile.png' class='sicon' width='25' height='25'></a> <%=bdao.countBoardLike("cc", idx) %>  <a class="bunlike" ><img src='../images/sad.png' class='sicon' width='25' height='25'></a> <%=bdao.countBoardUnlike("cc", idx) %></td></tr>
</table>

<!-- 버튼 모음 -->
<button onclick="location.href='ccBoard.jsp?page=<%=bpage%>'">목록가기</button>  
<%  if( bdao.getIdFromIdx("cc", idx).equals(id) ){%>
	<button onclick="location.href='updateForm.jsp?page=<%=bpage%>&idx=<%=idx%>'">수정하기</button> 	
	<button id="con_delete_btn">삭제하기</button>
<% }%>

<!-- 댓글 -->
<form id="rep_fr" name="reply_fr" action="replyPro.jsp" method="post">
<textarea name="content" id="content" class="rep_write" placeholder="댓글을 작성하세요"></textarea>
<input type="hidden" name="userid" id="userid" value="<%=session.getAttribute("id")%>">
<input type="hidden" name="usernickname" id="usernickname" value="<%=mdao.getNickname((String)session.getAttribute("id"))%>">
<input type="hidden" name="idx" id="idx" value="<%=idx%>">
<input type="hidden" name="page" value="<%=bpage%>">
<input type="button" value="댓글작성" id="rep_fr_btn">
</form>
<div id="rep_div">
<%
//날짜 형식 맞추기 위한 초석
SimpleDateFormat df_basic = new SimpleDateFormat("yyyy.MM.dd");
SimpleDateFormat df_time = new SimpleDateFormat("HH:mm");
Timestamp today = new Timestamp(System.currentTimeMillis()); //날짜비교 연산을 위한 오늘 날짜
String ts = null;

// 댓글
	List<ReplyBean> rbs = rdao.readReply("cc",idx);
	for(int i=rbs.size()-1; i>=0; i--){
 		if( df_basic.format(today).equals(df_basic.format(rbs.get(i).getRegtime()))){
 			ts=df_time.format(rbs.get(i).getRegtime());
 		}else{
 			ts=df_basic.format(rbs.get(i).getRegtime());
 		}
		ridx=rbs.get(i).getIdx();
		out.println("<span id='rp"+(i+1)+"'><div class='rp_contents'>"+rbs.get(i).getContent()+"</div><input type='hidden' class='whatridx' value='"+
		rbs.get(i).getIdx()+"'>"+"<span class='whatid'>" + rbs.get(i).getNickname() + "<br>" +ts+"</span>");
		out.println("<div class='rp_like'><a class='rlike'><img src='../images/smile.png' class='sicon' width='25' height='25'></a> "+rdao.countReplyLike("cc", rbs.get(i).getIdx()) +" <a class='runlike' ><img src='../images/sad.png' class='sicon' width='25' height='25'></a> "+rdao.countReplyUnlike("cc", rbs.get(i).getIdx()) +"</div><br>");
		if(rbs.get(i).getId().equals(id) ){
			out.println("<button class='rp_del_btn' id='rp_del_btn"+(+rbs.get(i).getIdx())+"' >삭제</button> <button class='rp_update_btn' id='rp_update_btn"+(i+1)+"'>수정</button>");	
		}
		out.println("<button class='rp_ans_btn' id='rp_ans_btn"+(+rbs.get(i).getIdx())+"' >답글</button></form>");
// 		댓글을 수정하는 폼
		out.println("<form name='fr_reupdate' class='rfr1' id='rfr1"+rbs.get(i).getIdx()+"' action='replyUpdatePro.jsp' method='post'><input type='hidden' name='rp_idx' class='rp_idx' value='"+rbs.get(i).getIdx()+"'>"+ 
				"<input type='hidden' name='idx' class='idx' value='"+idx+"'>"+
				"<input type='hidden' name='page' value='"+bpage+"'>"+
				"<textarea name='rp_content' class='rp_content' class='rep_write'>"+rbs.get(i).getContent()+"</textarea>"+
				"<input type='hidden' name='userid' class='userid' value='"+id+"' readonly>"+
				"<input type='hidden' name='usernickname' class='usernickname' value='"+mdao.getNickname(id)+"' readonly>"+
				"<input type='button' value='완료'></form>");
// 		대댓글을 입력하는 폼
		out.println("<form name='fr_rerewrite' class='rfr2' id='rfr2"+rbs.get(i).getIdx()+"' action='rereplyPro.jsp' method='post'><input type='hidden' name='rrp_idx'>"+
				"<input type='hidden' class='idx' name='idx' value='"+idx+"'>"+
				"<input type='hidden' name='page' value='"+bpage+"'>"+
				"<input type='hidden' class='ridx' name='ridx' value='"+rbs.get(i).getIdx()+"'>"+
				"<textarea name='content' class='rep_write' placeholder='대댓글을 작성하세요'></textarea>"+
				"<input type='hidden' class='userid' name='userid' value='"+id+"' readonly>"+
				"<input type='hidden'  class='usernickname' name='usernickname' value='"+mdao.getNickname(id)+"' readonly>"+
				"<input type='button' value='완료'></form></span>");

		//for문을 사용하여 대댓글 출력!
				List<RereplyBean> rrbs = rrdao.readRereply("cc",ridx);
				for(int j=rrbs.size()-1;j>=0;j--){
					rridx=rrbs.get(j).getIdx();
					if( df_basic.format(today).equals(df_basic.format(rrbs.get(j).getRegtime()))){
			 			ts=df_time.format(rrbs.get(j).getRegtime());
			 		}else{
			 			ts=df_basic.format(rrbs.get(j).getRegtime());
			 		}
					out.print("<span  id='sprrp"+(j+1)+"'> <strong>@"+rbs.get(i).getNickname() +"</strong>"+"<input type='hidden' class='whatrridx' value='"+rrbs.get(j).getIdx()+"'>"+"<br>"+rrbs.get(j).getContent()+"<span class='whatid'>"+rrbs.get(j).getNickname()+"<br>"+ts+"</span><br>");
					if(rrbs.get(j).getId().equals(id) ){
						out.print("<button class='rrp_del_btn' id='rrp_del_btn"+(+rrbs.get(j).getIdx())+"' >삭제</button> <button class='rrp_update_btn' id='rrp_update_btn"+(j+1)+"'>수정</button></form>");
					}						
//			 		댓글을 수정하는 폼
					out.println("<form name='fr_rereupdate' class='rrfr1' id='rffr1"+rrbs.get(j).getIdx()+"' action='rereplyUpdatePro.jsp' method='post'><input type='hidden' name='rrp_idx' value='"+rrbs.get(j).getIdx()+"'>"+ 
							"<input type='hidden' class='idx' name='idx' value='"+idx+"'>"+
							"<input type='hidden' name='page' value='"+bpage+"'>"+
							"<input type='hidden' class='rrp_idx' name='rrp_index' value='"+rrbs.get(j).getIdx()+"'>"+
							"<textarea name='rrp_content' class='rep_write'>"+rrbs.get(j).getContent()+"</textarea>"+
							"<input type='hidden'  class='userid' name='userid' value='"+id+"' readonly>"+
							"<input type='hidden'  class='usernickname'name='usernickname' value='"+mdao.getNickname(id)+"' readonly>"+
							"<input type='button' value='완료'></form></span>");
				}
	}
%>	
</div>

<!-- 페이지에 해당하는 목록 불러오기 -->
<table class="bd" id="ccBoard" >
<tr><th>글번호</th><th>분류</th><th>글제목</th><th>닉네임</th><th>조회수</th><th>작성날짜</th></tr>
<%
	if(bcategory!=null){
		out.print(bdao.categoryBoard("cc",bpage,bcategory));
	}else{
		out.print(bdao.readBoard("cc",bpage));	
	}
%>
</table>

<div id="page_box">
<%
	int cidx=0;
	if(bcategory != null){
		cidx = bdao.countCategoryIdx("cc", bcategory);
	}else{
		cidx = bdao.countIdx("cc");	
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
					out.println("<a href='ccBoard.jsp?page="+pages.get(i)+"&category="+bcategory+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
				}else{
					out.println("<a href='ccBoard.jsp?page="+pages.get(i)+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
				}
			}
		}else{
			for(int i=page_size-1;i>=page_size-(1+9);i--){ // 10페이지 출력
				if(bcategory != null){
					out.println("<a href='ccBoard.jsp?page="+pages.get(i)+"&category="+bcategory+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
				}else{
					out.println("<a href='ccBoard.jsp?page="+pages.get(i)+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
				}
			}
			out.println("<span> ... </span>");
			if(bcategory != null){
				out.println("<a href='ccBoard.jsp?page="+(page_size)+"&category="+bcategory+"' id='p"+(page_size)+"'>"+(page_size)+"</a>");
			}else{
				out.println("<a href='ccBoard.jsp?page="+(page_size)+"' id='p"+(page_size)+"'>"+(page_size)+"</a>");
			}
			
			if(bcategory != null){
				out.println("<a href='ccBoard.jsp?page="+( ((bpage+5)>=page_size) ? page_size:bpage+5 )+"&category="+bcategory+"'>  다음-> </a>");
			}else{
				out.println("<a href='ccBoard.jsp?page="+( ((bpage+5)>=page_size) ? page_size:bpage+5 )+"'>  다음-> </a>");
			}
			
			
		}
	}else if(bpage>=page_size-8){ //끝페이지에서 9번째 부터는 Out Of Index가 발생할 수 있으므로  방지하기위해
		if(bcategory != null){
			out.println("<a href='ccBoard.jsp?page="+(bpage-5)+"&category="+bcategory+"'> <-이전  </a>");
		}else{
			out.println("<a href='ccBoard.jsp?page="+(bpage-5)+"'> <-이전  </a>");
		}
		if(bcategory != null){
			out.println("<a href='ccBoard.jsp?page=1&category="+bcategory+"' id='p1'>1</a>");
		}else{
			out.println("<a href='ccBoard.jsp?page=1 id='p1'>1</a>");
		}
		
		
		out.println("<span> ... </span>");
		for(int i=9;i>=0;i--){ // 끝에서 부터 10개까지 출력
			if(bcategory != null){
				out.println("<a href='ccBoard.jsp?page="+pages.get(i)+"&category="+bcategory+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
			}else{
				out.println("<a href='ccBoard.jsp?page="+pages.get(i)+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
			}
		}
	
	
	}else{ // 현재페이지를 기준으로 앞 뒤로 4개의 페이지씩 출력
		if(bcategory != null){
			out.println("<a href='ccBoard.jsp?page="+(bpage-5)+"&category="+bcategory+"'> <-이전 | </a>");
		}else{
			out.println("<a href='ccBoard.jsp?page="+(bpage-5)+"'> <-이전 | </a>");
		}
		if(bcategory != null){
			out.println("<a href='ccBoard.jsp?page=1&category="+bcategory+"' id='p1'>1</a>");
		}else{
			out.println("<a href='ccBoard.jsp?page=1' id='p1'>1</a>");
		}
		
		out.println("<span> ... </span>");
		for(int i=page_size-bpage+4;i>=page_size-bpage-4;i--){ //9개 연속 출력
			if(bcategory != null){
				out.println("<a href='ccBoard.jsp?page="+pages.get(i)+"&category="+bcategory+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
			}else{
				out.println("<a href='ccBoard.jsp?page="+pages.get(i)+"' id='p"+pages.get(i)+"'>"+pages.get(i)+"</a>");
			}
		}
		out.println("<span> ... </span>");
		if(bcategory != null){
			out.println("<a href='ccBoard.jsp?page="+(page_size)+"&category="+bcategory+"' id='p"+(page_size)+"'>"+(page_size)+"</a>");
		}else{
			out.println("<a href='ccBoard.jsp?page="+(page_size)+"' id='p"+(page_size)+"'>"+(page_size)+"</a>");
		}
		if(bcategory != null){
			out.println("<a href='ccBoard.jsp?page="+( ((bpage+5)>=page_size) ? page_size:bpage+5 )+"&category="+bcategory+"'> | 다음-> </a>");
		}else{
			out.println("<a href='ccBoard.jsp?page="+( ((bpage+5)>=page_size) ? page_size:bpage+5 )+"'> | 다음-> </a>");
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