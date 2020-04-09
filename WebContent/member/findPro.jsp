<%@page import="mail.GoogleAuthentication"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.activation.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String email = request.getParameter("email");

	MemberDAO mdao = MemberDAO.getMemberDAO();
%>
<%
	
	boolean is_email = mdao.idEmailCheck(id, email);
	
	if(is_email){
		
		//임시비밀번호 생성
		String new_pass = "";
		for(int i = 0; i < 8; i++){
		 //char upperStr = (char)(Math.random() * 26 + 65);
		 char lowerStr = (char)(Math.random() * 26 + 97);
		 if(i%2 == 0){
		  new_pass += (int)(Math.random() * 10);
		 }else{
		  new_pass += lowerStr;
		 }
		}
		
		// 임시 비밀번호로 업데이트
		mdao.updatePass(id, new_pass);
		
		//메일보내기
		String receiver = request.getParameter("email");
		String subject = "[해요] 임시 비밀번호 발송 메일입니다. 임시 비밀번호를 확인해 주세요!";
		String content = "<h1>임시 비밀번호 : " + new_pass + "</h1><br><br><br> 해요 커뮤니티 사이트를 이용해주셔서 감사합니다!";

		try {
			Properties properties = System.getProperties();
			properties.put("mail.smtp.starttls.enable", "true"); // gmail은 무조건 true 고정
			properties.put("mail.smtp.host", "smtp.gmail.com"); // smtp 서버 주소
			properties.put("mail.smtp.auth", "true"); // gmail은 무조건 true 고정
			properties.put("mail.smtp.port", "587"); // gmail 포트
			Authenticator auth = new GoogleAuthentication();
			Session s = Session.getDefaultInstance(properties, auth);
			//Session s = Session.getdefultInstance(properties, auth);
			Message message = new MimeMessage(s);
			Address sender_address = new InternetAddress("zndn887@naver.com");
			Address receiver_address = new InternetAddress(receiver);
			message.setHeader("content-type", "text/html;charset=UTF-8");
			message.setFrom(sender_address);
			message.addRecipient(Message.RecipientType.TO, receiver_address);
			message.setSubject(subject);
			message.setContent(content, "text/html;charset=UTF-8");
			message.setSentDate(new java.util.Date());
			Transport.send(message);
			out.println("<script>alert('임시비밀번호가 발송되었습니다!');location.href='../main/main.jsp';</script>");
		} catch (Exception e) {
			e.printStackTrace();
			out.println("<script>alert('Eroor');history.back();</script>");
		}
	}else{
		out.println("<script>alert('입력하신 정보가 올바르지 않습니다.');history.back();</script>");
		
	}
%>
	
	
