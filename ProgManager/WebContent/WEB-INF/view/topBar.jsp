<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
     <meta http-equiv="X-UA-Compatible" content="text/html" charset="EUC-KR">
	 <title>${requestScope.title }</title>
     <link rel="stylesheet" href="css/topBar.css" />
     <script src='https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.js' type='text/javascript'></script>
     <script src="js/login.js"></script>
     <script src="js/formValidation.js"></script>
<!-- 	 <script src="js/jquery-1.10.2.js"></script> -->

</head>


<script type="text/javascript">

	$(document).ready(	function() {
		var pleader = $("#pleader").val();
		
		var pflag = false;
		var pflag2 = false;
		var nflag = false;
		
		
		//비밀번호 확인
		/*
		1. 반드시 입력*
		*/
		$("#pw2").keyup(function(){
			var isValid = isPasswordValid($("#pw2").val());
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
			if(!isPasswordValid($("#pw2").val()) || $("#pw2").val() != $("#pwAgain").val()){
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
				
		$("#resetSpan").click(function(){
			$("#idValidation").html("");
			$("#pwValidation").html("");
			$("#pw2Validation").html("");
			$("#nameValidation").html("");
			eflag = false;
			pflag = false;
			pflag2 = false;
			nflag = false;
			
		});//end of reset button

		
		function deleteJoinForm() {
			$("#idValidation").html("");
			$("#pwValidation").html("");
			$("#pw2Validation").html("");
			$("#nameValidation").html("");
			$("#email2").val("");
			$("#pw2").val("");
			$("#pwAgain").val("");
			$("#name").val("");
			$("#phone").val("");
			eflag = false;
			pflag = false;
			pflag2 = false;
			nflag = false;
			$('#JoinButton').removeClass('active');
			$('#JoinBox').hide();
		}
		
		$("#Join").click(function(){
			nflag=true;
			if(!pflag || !pflag2 || !nflag){
				alert("회원가입 정보를 다시 입력하십시오");
				return false;
			}
			$.ajax({
				url : "update.do",
				type : "post",
				dataType : "text", 
				data : $("#JoinForm").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("회원 정보 변경 성공!");
					} else {
						alert("회원 정보 변경 실패");
					}
					deleteJoinForm();
				},
				error : function(data) {
					alert(data + ' : 회원 정보 변경 로직 실행시 에러 발생');
				}
			}); //end of ajax
		});//end of Join button
		
		
		$("#leave").click(function(){
			if(!pflag || !pflag2){
				alert("비밀 번호를 다시 입력하십시오");
				return false;
			}
			$.ajax({
				url : "delete.do",
				type : "post",
				dataType : "text", 
				data : $("#JoinForm").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("회원 탈퇴 성공!");
						history.go(-1);
					} else {
						alert("회원 탈퇴 실패");
					}
					deleteJoinForm();
				},
				error : function(data) {
					alert(data + ' : 회원 탈퇴 로직 실행시 에러 발생');
				}
			}); //end of ajax
		});//end of Join button
		
		//프로필 사진 올리기 아작스
		$("#uphotoUP").click(function(){
			
			var data = new FormData();
	        $.each($('#uphoto')[0].files, function(i, file) {
	            data.append('name', $("#email2").val());
	        	data.append('file-' + i, file);
	        });
	        
	        
			$.ajax({
				url : "uPhotoUpload.do",
				type : "post",
				dataType : "text", 
				data : data,
				processData: false,
	            contentType: false,
				success : function(data) {
					if (data == "ok") {
						alert("사진 업로드 성공!");
					} else {
						alert("사진 업로드 실패");
					}
				},
				error : function(data) {
					alert(data + ' : 프로필 사진 등록 로직 실행시 에러 발생');
				}
			}); //end of ajax
		});//end of Join button
		
   });//end of ready()
</script>


<body>
     <div id="bar">
        <!-- Login Starts Here -->
    	<div id="loginContainer">
    		<%-- <img id="barUserPhoto" src="./ProgFile/uphoto/${requestScope.photo}" width="100" height="100" border="3" style="margin: 61px 5px 5px 25px;"> --%>
    		<img id="barUserPhoto" src="${sessionScope.userData.uphoto}" width="50" height="50" border="3" style="margin: -5px 5px 5px 5px;">
    		
	        <a href="#" id="loginButton"><span>Logout</span><em></em></a>
	        <div id="loginBox">                
	            <form action="idPwCheck.do" method="post" id="loginForm">
	                    <fieldset id="body">
		                    <fieldset>
		                        <label for="email">Email Address</label>
		                        <input type="text" name="email" id="email" />
		                    </fieldset>
		                    <fieldset>
		                         <label for="password">Password</label>
		                         <input type="password" name="pw" id="pw" />
		                    </fieldset>
		                    <input type="submit" id="login" value="로그인" />
	                    </fieldset>
	             </form>
	         </div>
                <a href="#" id="JoinButton"><span>Inform</span><em></em></a>
                <div style="clear:both"></div>
       			<div id="JoinBox">
       				<form action="insert.do" method="post" id="JoinForm">
                        <fieldset id="body">
                        	<fieldset>
                                <label for="email2">ID(e-mail)</label>
                               <input type="text" value="${requestScope.email}" disabled="disabled"/>
                               <input type="hidden" name="email2" id="email2" value="${requestScope.email}"/>
                            </fieldset>
                            <fieldset>
                                <label for="name">name</label>
                                <input type="text" name="name" id="name" value="${requestScope.name}"/><br><span id="nameValidation"></span>
                            </fieldset>
                            <fieldset>
                                <label for="password2">Password</label>
                                <input type="password" name="pw2" id="pw2"/><br><span id="pwValidation"></span>
                            </fieldset>
                            <fieldset>
                                <label for="pwAgain">Reenter Password</label>
                                <input type="password" name="pwAgain" id="pwAgain"/><br><span id="pw2Validation"></span>
                            </fieldset>
                            <fieldset>
                                <label for="phone">Phone Number(ex.000-0000-0000)</label>
                                <input type="text" name="phone" id="phone" value="${requestScope.phone}">
                            </fieldset>
                            <fieldset>
                                <label for="photo">Profile Photo</label>
                                <form action="uPhotoUpload.do" method="post" id="uPhotoUpload" enctype="multipart/form-data">
									<input type="file" name="uphoto" id="uphoto"/>
								</form>
                            </fieldset>
                            <input type="button" id="Join" value="확인" />
                            <input type="reset" id="resetSpan" value="취소" />
                            <input type="button" id="leave" value="탈퇴" />
                            <input type="button" id="uphotoUP" value="사진"/>
                        </fieldset>
                    </form>
       			</div>
      </div>
            <!-- Join Ends Here -->
    </div>
</body>
</html>