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
		//��й�ȣ Ȯ��
		/*
		1. �ݵ�� �Է�*
		*/
		$("#pw").keyup(function(){
			var isValid = isPasswordValid($("#pw").val());
			if(!isValid){
				$("#pwValidation").html("<font color='red'>��й�ȣ�� �ݵ�� 4-20���� ����, ����ҹ���, Ư�����ڿ��� �մϴ�. </font>");
				pflag = false;
			}else{
				$("#pwValidation").html("<font color='blue'>��� ������ ��й�ȣ�Դϴ�.</font>");
				pflag = true;
			}
			
		});//end of password validaion
		
		//��й�ȣ ��Ȯ��
		/*
		1. �ݵ�� �Է�*
		2. ��й�ȣ ��ġ�ϴ��� �˻�*
		*/
		$("#pwAgain").keyup(function(){
			if(!isPasswordValid($("#pw").val()) || $("#pw").val() != $("#pwAgain").val()){
				$("#pw2Validation").html("<font color='red'>��й�ȣ�� ��ġ���� �ʽ��ϴ�. �ٽ� �Է��ϼ���.</font>");
				pflag2 = false;
			}else{
				$("#pw2Validation").html("<font color='blue'>��� ������ ��й�ȣ �Դϴ�.</font>");
				pflag2 = true;
			} 
		});//end of reentered password validaion
		
		//�̸� Ȯ��
		/*
		1. �ݵ�� �Է�*
		*/
		$("#name").keyup(function(){
			if($("#name").val() == ""){
				$("#nameValidation").html("<font color='red'>�̸��� �ݵ�� �Է��ϼž� �մϴ�.</font>");
				nflag = false;
			}else{
				$("#nameValidation").html("<font color='blue'>�̸� �Է� �Ϸ�</font>");
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
				alert("ȸ�� ������ �ٽ� �Է��Ͻʽÿ�");
				return false;
			}else{
				alert("���� ���� ���� ����!");
			}
		});//end of signIn button
	
	});//end of ready

</script>
<body>
	<h4>���� ���� ���� ȭ��</h4>
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
		<input type="submit" value="Ȯ��" id="submitted">
		
	</form>
	<form action="cancel.do" method="post" id="cancelBtn">
		<input type="hidden" name="oldemail" id="oldemail" value="${sessionScope.userData.uemail}"/>
		<input type="submit" value="���" id="reset"><br>
	</form>
</body>
</html>