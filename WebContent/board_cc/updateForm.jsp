<%@page import="member.MemberDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>해요-친구찾기</title>
<link rel="stylesheet" href="../css/top.css">
<link rel="stylesheet" href="../css/bottom.css">
<link rel="stylesheet" href="../css/frame.css">
<link rel="stylesheet" href="../css/write_cc.css">

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<script>
/* summernote에서 이미지 업로드시 실행할 함수 */
function sendFile(file, editor) {
   // 파일 전송을 위한 폼생성
	data = new FormData();
    data.append("uploadFile", file);
    $.ajax({ // ajax를 통해 파일 업로드 처리
        data : data,
        type : "POST",
        url : "summernote_imageUpload.jsp",
        cache : false,
        contentType : false,
        processData : false,
        success : function(data) { // 처리가 성공할 경우
           // 에디터에 이미지 출력
//         	$(editor).summernote('editor.insertImage', data.url);
        	var image = $('<img>').attr('src', '' + data.url).attr('style',"width:500px; hieght:500px;"); // 에디터에 img 태그로 저장을 하기 위함
            $('#summernote').summernote("insertNode", image[0]); // summernote 에디터에 img 태그를 보여줌
        }
    });
};


$(document).ready(function() {
  $('#summernote').summernote({
      placeholder: '',
      height: 600,
      callbacks: { // 콜백을 사용
	          // 이미지를 업로드할 경우 이벤트를 발생
			onImageUpload: function(files, editor, welEditable) {
				    sendFile(files[0], this);
			}
      },
      lang: 'ko-KR',
      toolbar: [
                  // [groupName, [list of button]]
                  ['Font Style', ['fontname']],
                  ['style', ['bold', 'italic', 'underline']],
                  ['font', ['strikethrough']],
                  ['fontsize', ['fontsize']],
                  ['color', ['color']],
                  ['para', ['paragraph']],
                  ['height', ['height']],
                  ['Insert', ['picture']],
                  ['Insert', ['link']],
                  ['Misc', ['fullscreen']]
               ]
  });
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
    	<a href="ccBoard.jsp?page=1&category=모임"><button class="cate">같이해요</button></a><br>
      	<a href="ccBoard.jsp?page=1&category=홍보"><button class="cate">홍보해요</button></a><br>
      	<a href="ccBoard.jsp?page=1&category=거래"><button class="cate">거래해요</button></a><br>
      	<a href="ccBoard.jsp?page=1&category=베스트"><button class="cate">베스트</button></a><br>
</aside>
<article>
<h1>글을 수정해요</h1>
<%
	int idx = Integer.parseInt(request.getParameter("idx"));
	int bpage = Integer.parseInt(request.getParameter("page"));
	String standard=request.getParameter("standard");
	String scontent=request.getParameter("scontent");
	
	String id = (String)session.getAttribute("id");

	BoardDAO bdao = BoardDAO.getBoardDAO();
	BoardBean bb = bdao.getBean("cc",idx);
	MemberDAO mdao = MemberDAO.getMemberDAO();
%>
<form action="updatePro.jsp" method="post">
<table>
<tr><td>
<select name="category">
	<%if(id.equals("admin")){ %><option value="공지"<% if(bb.getCategory().equals("잡담")){%>selected<%}%> >공지</option><%} %>
	<option value="잡담"<% if(bb.getCategory().equals("잡담")){%>selected<%}%> >잡담</option>
	<option value="모임"<% if(bb.getCategory().equals("모임")){%>selected<%}%>>모임</option>
	<option value="홍보"<% if(bb.getCategory().equals("홍보")){%>selected<%}%>>홍보</option>
	<option value="거래"<% if(bb.getCategory().equals("거래")){%>selected<%}%>>거래</option>
</select>
</td></tr>
<tr><td><input type="text" placeholder="제목" name="title" value="<%=bb.getTitle()%>"></td></tr>
<tr><td><input type="text" placeholder="닉네임" name="usernickname" value="<%=mdao.getNickname(id)%>" readonly></td></tr>
<tr><td><input type="text" placeholder="아이디" name="userid" value="<%=id%>" readonly></td></tr>
<tr><td><textarea id="summernote" name="content"><%=bb.getContent()%></textarea></td></tr>
<input type="hidden" name="standard" value="<%=standard%>"><input type="hidden" name="scontent" value="<%=scontent%>">
</table>
<input type="hidden" value="<%=idx%>" name="idx">
<input type="hidden" name="page" value="<%=bpage%>">
<input type="button" onclick="location.href='ccBoard.jsp?page=1'" value="목록가기">
<input type="submit" value="수정하기">
</form>
</article>
</div>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>

</body>
</html>