<%@page import="java.io.File"%>
<%@page import="fileboard.FileboardDAO"%>
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
	FileboardDAO fdao = FileboardDAO.getFileboardDAO();

	request.setCharacterEncoding("UTF-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	
	String filename = fdao.getFileFromIdx("gal", idx);
	fdao.deleteContent("gal",idx);
%>
<%
	String uploadPath = request.getRealPath("/upload") + "/";
	String uploadedFile = uploadPath + filename;
	String uploadedThumbFile = uploadPath+ "thumb_" + filename;
	File file = new File(uploadedFile);
	File thumb_file = new File(uploadedThumbFile);
	if( file.exists()){
		file.delete();
	}
	if( thumb_file.exists() ){
		thumb_file.delete();
	}
%>

<script>
location.href="galBoard.jsp?page=1"
</script>

</body>
</html>