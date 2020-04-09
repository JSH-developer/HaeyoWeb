<%@page import="fileboard.FileboardDAO"%>
<%@page import="fileboard.FileboardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String uploadPath = request.getRealPath("/upload");
	int size = 20 * 1024 * 1024;  // 업로드 사이즈 제한 20M 이하
	MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "utf-8", new DefaultFileRenamePolicy());
	
	String category=multi.getParameter("category");
	String title=multi.getParameter("title");
	String content=multi.getParameter("content");
	int rcount=0;
	String userid=multi.getParameter("userid");
	String usernickname=multi.getParameter("usernickname");
	
	
	FileboardBean fb = new FileboardBean();
	fb.setCategory(category);
	fb.setTitle(title);
	fb.setContent(content);
	fb.setId(userid);
	fb.setNickname(usernickname);
	fb.setRcount(rcount);
	if(multi.getFilesystemName("file") != null){
		String file = multi.getFilesystemName("file");
		fb.setFile(file);
	}
	
	FileboardDAO fdao = FileboardDAO.getFileboardDAO();
	fdao.insertBoard("dat", fb);
%>
<script>
alert("글작성 완료");
location.href="datBoard.jsp?page=1";
</script>

</body>
</html>