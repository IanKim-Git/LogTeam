<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
     <meta http-equiv="X-UA-Compatible" content="text/html" charset="EUC-KR">
	 <title>PLog Project : Project Select</title>
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
		
		
		//��й�ȣ Ȯ��
		/*
		1. �ݵ�� �Է�*
		*/
		$("#pw2").keyup(function(){
			var isValid = isPasswordValid($("#pw2").val());
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
			if(!isPasswordValid($("#pw2").val()) || $("#pw2").val() != $("#pwAgain").val()){
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
				alert("ȸ������ ������ �ٽ� �Է��Ͻʽÿ�");
				return false;
			}
			$.ajax({
				url : "update.do",
				type : "post",
				dataType : "text", 
				data : $("#JoinForm").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("ȸ�� ���� ���� ����!");
					} else {
						alert("ȸ�� ���� ���� ����");
					}
					deleteJoinForm();
				},
				error : function(data) {
					alert(data + ' : ȸ�� ���� ���� ���� ����� ���� �߻�');
				}
			}); //end of ajax
		});//end of Join button
		
		
		$("#leave").click(function(){
			if(!pflag || !pflag2){
				alert("��� ��ȣ�� �ٽ� �Է��Ͻʽÿ�");
				return false;
			}
			$.ajax({
				url : "delete.do",
				type : "post",
				dataType : "text", 
				data : $("#JoinForm").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("ȸ�� Ż�� ����!");
						history.go(-1);
					} else {
						alert("ȸ�� Ż�� ����");
					}
					deleteJoinForm();
				},
				error : function(data) {
					alert(data + ' : ȸ�� Ż�� ���� ����� ���� �߻�');
				}
			}); //leave of ajax
		});//leave of Join button
		
		$("#loginButton").click(function(){
			alert(11111);
		});//end of Join button
		
		//������ ���� �ø��� ���۽�
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
						alert("���� ���ε� ����!");
					} else {
						alert("���� ���ε� ����");
					}
				},
				error : function(data) {
					alert(data + ' : ������ ���� ��� ���� ����� ���� �߻�');
				}
			}); //end of ajax
		});//end of profile button
		
		$("#loginButton").click(function(){
			
			alert("Thank You, Surf by again.");
		    //location.href = '/WEB-INF/view/logout.jsp';
			location.href = "<%=request.getContextPath()%>/logout.jsp";
		    //location.href = './index.html';
		    //location.href = '/logout.do';
			//window.location.replace("./index.html");
			//response.sendRedirect("logout.jsp");
			/* $.ajax({
				url : "sessLogout.do", 					//������ ��û�� ����
				type : "post",							//method���
				dataType : "text", 					//����Ǵ� ������ Ÿ��
				//data : "email=" + $("#email2").val(),	//������ ������ ������ no=�Էµ� ������
				//success : function(data) {},
				error : function(err) { //���� ���������� �ڵ� ����Ǵ� ����� ���� �Լ�(���� ��ü�� ���� ���� ��ü�� �ε����ϰ� �� �� ��쿡 ����)
					alert(err + " : �α׾ƿ� ����! �ٽ� �õ��غ�����..");
				}				
			});//end of ajax	 */
		});//end of Join button
		
		
   });//end of ready()
</script>


<body>
     <div id="bar">
        <!-- Login Starts Here -->
    	<div id="loginContainer">
    		<%-- <img id="barUserPhoto" src="./ProgFile/uphoto/${requestScope.photo}" width="100" height="100" border="3" style="margin: 61px 5px 5px 25px;"> --%>
    		<img id="barUserPhoto" src="${sessionScope.userData.uphoto}" width="50" height="50" border="2" style="margin: -6px 5px 3px 5px; color: #FFFFFF">
    		<!-- <img src="./images/PM_redGlow.png" height="65" style="margin: -8px 0 0 6px;"> -->
    		<%-- <input value="${sessionScope.userData.uphoto}"> --%>
	        <a href="#" id="loginButton"><span>Sign out</span><em></em></a>
	        
            <a href="#" id="JoinButton"><span>Inform</span><em></em></a>
            <div style="clear:both"></div>
   			<div id="JoinBox">
   				<form action="insert.do" method="post" id="JoinForm">
                    <fieldset id="body">
                    	<fieldset>
                            <label for="email2">ID(e-mail)</label>
                           <input type="text" value="${sessionScope.userData.uemail}" disabled="disabled"/>
                           <input type="hidden" name="email2" id="email2" value="${sessionScope.userData.uemail}"/>
                        </fieldset>
                        <fieldset>
                            <label for="name">name</label>
                            <input type="text" name="name" id="name" value="$${sessionScope.userData.uname}"/><br><span id="nameValidation"></span>
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
                            <input type="text" name="phone" id="phone" value="${sessionScope.userData.uphone}">
                        </fieldset>
                        <fieldset>
                            <label for="photo">Profile Photo</label>
                            <form action="uPhotoUpload.do" method="post" id="uPhotoUpload" enctype="multipart/form-data">
					<input type="file" name="uphoto" id="uphoto"/>
				</form>
                        </fieldset>
                        <input type="button" id="Join" value="Ȯ��" />
                        <input type="reset" id="resetSpan" value="���" />
                        <input type="button" id="leave" value="Ż��" />
                        <input type="button" id="uphotoUP" value="����"/>
                    </fieldset>
                </form>
   			</div>
      </div>
            <!-- Join Ends Here -->
    </div>
</body>
</html>
