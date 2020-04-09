<%@page import="java.io.File"%>
<%@page import="fileboard.FileboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	FileboardDAO fdao = FileboardDAO.getFileboardDAO();

	request.setCharacterEncoding("UTF-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	
	String filename = fdao.getFileFromIdx("dat", idx);
	fdao.deleteContent("dat",idx);
%>
<%
	String uploadPath = request.getRealPath("/upload") + "/";
	String uploadedFile = uploadPath + filename;
	File file = new File(uploadedFile);
	if( file.exists()){
		file.delete();
	}
%>
<script>
location.href="datBoard.jsp?page=1"
</script>

