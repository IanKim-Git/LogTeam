<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>UpdateInfo Test(view/jsp)</title>
</head>
<script src="js/jquery-1.10.2.js"></script>
<script src="js/formValidation.js"></script>
<script type="text/javascript">
	$(document).ready(function(){	
		nflag = true;
		//비밀번호 확인
		/*
		1. 반드시 입력*
		*/
		$("#pw").keyup(function(){
			var isValid = isPasswordValid($("#pw").val());
			if(!isValid){
				$("#pwValidation").html("<font color='red'>비밀번호는 반드시 4-20자의 숫자, 영대소문자, 특수문자여야 합니다. </font>");
				pflag = false;
			}else{
				$("#pwValidation").html("<font color='blue'>사용 가능한 비밀번호입니다.</font>");
				pflag = true;
			}
			
		});//end of password validaion
		
		//비밀번호 재확인
		/*
		1. 반드시 입력*
		2. 비밀번호 일치하는지 검사*
		*/
		$("#pwAgain").keyup(function(){
			if(!isPasswordValid($("#pw").val()) || $("#pw").val() != $("#pwAgain").val()){
				$("#pw2Validation").html("<font color='red'>비밀번호가 일치하지 않습니다. 다시 입력하세요.</font>");
				pflag2 = false;
			}else{
				$("#pw2Validation").html("<font color='blue'>사용 가능한 비밀번호 입니다.</font>");
				pflag2 = true;
			} 
		});//end of reentered password validaion
		
		//이름 확인
		/*
		1. 반드시 입력*
		*/
		$("#name").keyup(function(){
			if($("#name").val() == ""){
				$("#nameValidation").html("<font color='red'>이름은 반드시 입력하셔야 합니다.</font>");
				nflag = false;
			}else{
				$("#nameValidation").html("<font color='blue'>이름 입력 완료</font>");
				nflag = true;
			}
		});//end of name validation
				
		$("#reset").click(function(){
			$("span").html("");
//			$("input[type=text]").val("");
			$("#name").val("");
			$("#phone").val("");
			$("input[type=password]").val("");
//			eflag = false;
			pflag = false;
			pflag2 = false;
			nflag = false;
		});//end of reset button
		 
		$("#submitted").click(function(){
			if(!pflag || !pflag2 || !nflag){
				alert("회원 정보를 다시 입력하십시오");
				return false;
			}else{
				alert("개인 정보 변경 성공!");
			}
		});//end of signIn button
	
	});//end of ready

</script>
<body>
	<h4>개인 정보 변경 화면</h4>
	<form action="update.do" method="post" id="updateForm">
		* ID(e-mail) 
		<input type="text" value="${sessionScope.userData.uemail}" disabled="disabled"><br>
		<input type="hidden" name="email" id="email" value="${sessionScope.userData.uemail}"/>
		* Password 
		<input type="password" name="pw" id="pw"><span id="pwValidation"></span><br>
		* Reenter Password 
		<input type="password" id="pwAgain" ><span id="pw2Validation"></span><br> 
		* Name 
		<input type="text" name="name" id="name" value="${sessionScope.userData.uname}"><span id="nameValidation"></span><br>
		Phone Number(ex.000-0000-0000) 
		<input type="text" name="phone" id="phone" value="${sessionScope.userData.uphone}"><br>
		<input type="submit" value="확인" id="submitted">
		
	</form>
	<form action="cancel.do" method="post" id="cancelBtn">
		<input type="hidden" name="oldemail" id="oldemail" value="${sessionScope.userData.uemail}"/>
		<input type="submit" value="취소" id="reset"><br>
	</form>
</body>
</html>