<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");

MemberDAO md = MemberDAO.getMemberDAO();
MemberBean mb = md.getUserInfo(id);
if(!id.equals((String)session.getAttribute("id"))){
	out.println("<script>alert('접근권한이 없습니다!'); history.back();</script>");
}
%>
<title>해요-친구찾기</title>
<link rel="stylesheet" href="../css/top.css">
<link rel="stylesheet" href="../css/bottom.css">
<link rel="stylesheet" href="../css/frame.css">
<style>
div{
	text-align:center;
}
form{
	text-align: center;
	font-family: 'Jua', sans-serif;
}
span{
	display:inline-block;
	font-size:16px;
	margin-bottom:10px;
}
div#email_check{
	padding-left:20px;
	color:#a61e3b;
}
p{
	text-align: left;
	display:inline-block;
	width: 500px;
	height: 40px;
	margin:10px;
}
label{
	color:#77a6f2;
	display: inline-block;
	width:100px;
	margin-left:0px;
	text-align: right;
}
input[type=text],input[type=email],input[type=password]{
	
	padding-left:10px;
	margin:10px;
	height: 40px;
	width: 490px;
}
input[type=submit], input[type=button]{
	text-align: center;
	height: 50px;
	margin-bottom:10px;
	width: 500px;
	display:inline-block;
	font-family: 'Jua', sans-serif;
	font-size: 20px;
	background: #77a6f2;
	color: white;
	border:none;
}

</style>
<script src="../js/jquery.js"></script>
<script>
$(function(){
		$("#pass").blur(function(){
			var user_pass = $('#pass').val();
		 	var getCheck= RegExp(/^[a-zA-Z0-9]{6,15}$/);
		 	if(!getCheck.test(user_pass) || user_pass.search(/[0-9]/g)<0 || user_pass.search(/[a-z]/ig)<0){
		 		$("#pass_check").text("비밀번호의 형식은 영숫자를 혼합한 6~15자리 입니다. ");
				$("#pass_check").css("color", "red");
		     }else{
		    	 $("#pass_check").css("display", "none"); 
		     }
		});
		$("#pass2").blur(function(){
			var user_pass = $('#pass').val();
			var getCheck= RegExp(/^[a-zA-Z0-9]{6,15}$/);
			var user_pass2 = $('#pass2').val();
		 	if(user_pass != user_pass2){
		 		$("#pass2_check").text("비밀번호를 다시 확인해주세요");
				$("#pass2_check").css("color", "red");
		     }else if(user_pass2 == "" || !getCheck.test(user_pass2) || user_pass2.search(/[0-9]/g)<0 || user_pass2.search(/[a-z]/ig)<0 ){
		    	 $("#pass2_check").text("비밀번호를 다시 확인해주세요");
					$("#pass2_check").css("color", "red");
		     }else{
		     
	    	 	$("#pass2_check").text("비밀번호가 일치합니다.");
				$("#pass2_check").css("color", "blue");
		     }
		});
		$("#nickname").blur(function() {
		 	var user_nn = $('#nickname').val();
		 	
		 	$.ajax({
				url : 'confirmName.jsp?name='+ user_nn,
				type : 'post',
				success : function(data) {
					if(user_nn == "<%=mb.getNickname()%>"){
				 		$("#nickname_check").text("기존의 닉네임으로 사용합니다.");
						$("#nickname_check").css("color", "green");
						$('input:checkbox[id="dup_ckbx2"]').prop("checked", true);
				      }else if(user_nn.length<3 || user_nn.length>8){
				 		$("#nickname_check").text("닉네임의 3~8자리로 입력하여야 합니다.");
						$("#nickname_check").css("color", "red");
						$('input:checkbox[id="dup_ckbx2"]').prop("checked", false);
				      }else{
				    	  if($.trim(data)=="dup"){
								$("#nickname_check").text("사용중인 닉네임입니다");
								$("#nickname_check").css("color", "red");
								$('input:checkbox[id="dup_ckbx2"]').prop("checked", false);
							}else{
								$("#nickname_check").text("사용가능한 닉네임입니다");
								$("#nickname_check").css("color", "blue");
								$('input:checkbox[id="dup_ckbx2"]').prop("checked", true);
							}
				      }
					}, error : function() {
							console.log("실패");
					}
				});
			});
		
	});	
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
// 다음 우편번호 API
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}

//체크
function checkAll(){
	
	var re= /^[a-zA-Z0-9]{6,15}$/

 	if(!re.test(document.updateform.pass.value)) {
 		alert("비밀번호 형식이 올바르지 않습니다.");
		document.updateform.pass.focus();
        return false;
    }
	
	if(document.updateform.pass.value.trim().length == 0){
		alert("비밀번호를 입력해주세요");
		document.updateform.pass.focus();
		return false;
	}
	if(!document.updateform.dup_ckbx2.checked){
		alert("닉네임을 확인해주세요.");
		document.updateform.nickname.focus();
		return false;
	}
	if(document.updateform.email.value.trim().length == 0){
		alert("이메일 주소를 입력해주세요");
		document.updateform.email.focus();
		return false;
	}
	if(document.updateform.pass.value != document.updateform.pass2.value){
		alert("비밀번호 확인이 일치하지 않습니다.");
		document.updateform.pass2.focus();
		return false;
	}
}

</script>

</head>
<body>
<!-- 헤더, 네비게이션 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 본문 -->
<%
	String[]  add1 = null;
	String[]  add2 = null;
	String remainadd = " ";
	
	
	
%>
<div>
<form name="updateform" action="userUpdatePro.jsp" method="post" onsubmit="return checkAll()">
<h1>수 정 해 요</h1>
<label>회원번호</label> <input type="text" name="idx" value="<%=mb.getIdx() %>" readonly><br>
<label>아이디</label> <input type="text" name="id" value="<%=mb.getId() %>" readonly><br>
<label for="pass">새비밀번호 </label> <input type="password" placeholder="*비밀번호를 입력하세요" name="pass" id="pass"><br>
<div id="pass_check"></div>
<label for="pass2">새비밀번호확인</label> <input type="password" placeholder="*비밀번호를 재입력하세요" name="pass2" id="pass2"><br>
<div id="pass2_check"></div>
<label for="nickname">닉네임 </label> <input type="text" placeholder="닉네임을 입력하세요" name="nickname" id="nickname" value="<%=mb.getNickname() %>"><input type="checkbox" id="dup_ckbx2" name="dup_ckbx2" hidden="hidden"><br>
<div id="nickname_check"></div>
<label>성별 </label> <p><input type="radio" name="gender" value="man" <%if(mb.getGender().equals("man")) out.print("checked");%>>남<input type="radio" name="gender" value="woman" <%if(mb.getGender().equals("woman")) out.print("checked"); %>>여</p><br>
<label>&nbsp;</label><input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
<label for="pcode">우편번호 </label> <input type="text" id="sample4_postcode" name="pcode" id="pcode" placeholder="우편번호" readonly="readonly" value="<%=mb.getPcode() %>"><br>
<label>도로명주소 </label> <input type="text" id="sample4_roadAddress" name="address1" placeholder="도로명주소" readonly="readonly" value="<%if(!mb.getAddress1().trim().equals("")){
add1 = mb.getAddress1().split(" "); for(int i=0; i<add1.length-2;i++){out.print(add1[i]+" ");} out.print(add1[add1.length-2]+" ");
remainadd = add1[add1.length -1];
}else{
out.print(" ");
} %>"><br>
<label>지번주소 </label> <input type="text" id="sample4_jibunAddress" name="address2" placeholder="지번주소" readonly="readonly" value="<% if(!mb.getAddress1().trim().equals("")){
add2 = mb.getAddress2().split(" "); for(int i=0; i<add2.length-2;i++){out.print(add2[i]+" ");} out.print(add2[add2.length-1]+" ");	
}else{
out.print(" ");
} %>"><br>
<span id="guide" style="color:#999;display:none"></span>
<label for="sample4_detailAddress">상세주소 </label> <input type="text" id="sample4_detailAddress" name="address3" placeholder="상세주소" value="<%=remainadd %>"><br>
<label for="phone">폰번호 </label> <input type="text" placeholder="전화번호를 입력하세요" name="phone" id="phone" value="<%=mb.getPhone() %>"><br>
<label for="email">이메일주소</label><input type="email" placeholder="이메일을 입력하세요" name="email" id="email" value="<%=mb.getEmail() %>"><br>
<div id="email_check">이메일이 올바르지 않으면 비밀번호 찾기시 어려움이 있을 수 있습니다.</div>
<label>&nbsp;</label><input type="submit" value="수정하기">
</form>
</div>
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>

</body>
</html>