<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");

	String fileName = request.getParameter("file");
	String uploadPath = request.getRealPath("/upload");
	
	String fileName2 = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");

	java.io.File file = new java.io.File(uploadPath +"/" +fileName);  //서버상의 존재하는 파일명
	byte b[] = new byte[(int)file.length()];
	response.setHeader("Content-Disposition", "attachment;filename="+fileName2);
	response.setHeader("Content-Type", "image/jpg");

	if(file.isFile()){
		 BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
		 BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
	 	int read = 0;
	 while((read = fin.read(b)) != -1){
	  	outs.write(b, 0, read);
	 }
	 	outs.close();
	 	fin.close();
	}
%>
