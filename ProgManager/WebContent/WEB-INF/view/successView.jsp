<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	 <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	 <title>${requestScope.title }</title>
     <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
     <link href='stylesheets/jquery.gridly.css' rel='stylesheet' type='text/css'>
     <link href='stylesheets/sample.css' rel='stylesheet' type='text/css'>
     <link rel="stylesheet" href="css/style3.css" />
     <script src='https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.js' type='text/javascript'></script>
     <script src='javascripts/jquery.gridly.js' type='text/javascript'></script>
     <script src='javascripts/brickAddDelete.js' type='text/javascript'></script>
     <script src='javascripts/rainbow.js' type='text/javascript'></script>
     <script src="js/login.js"></script>
     <script src="js/formValidation.js"></script>
     <script src="javascripts/createProjectBtn.js"></script>
<!-- 	 <script src="js/jquery-1.10.2.js"></script> -->

</head>

<%
	String email = (String)request.getAttribute("email");
	String pw = (String)request.getAttribute("pw");
	String name = (String)request.getAttribute("name");
	String phone = (String)request.getAttribute("phone");
	
	HashMap userData = new HashMap();
	userData.put("uemail", email);
	userData.put("upw", pw);
	userData.put("uname", name);
	userData.put("uphone", phone);
	session.setAttribute("userData", userData);
%>


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
			
		// ������Ʈ �����ϱ� ��ư�� Ŭ�������� project table�� ����Ǵ� ����
		$("#btn").click(function() {
    	 	var brick;
   			var pname = $("#pname").val();
   		 	alert(pname);
			$.ajax({
				url : "newProject.do",
				type : "post",
				dataType : "text",
				data : $("#newproform").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("������Ʈ ���� �Ϸ�");
						getData();							//��緹�ڵ� �˻��ϴ� �Լ� ȣ��				
				    	document.getElementById("createProjectPop").style.display="none";
				    	//brick = "<div class='brick small'><br><br><font color='black'>"+pname+
				    	//	+"</font><br><br></div>";
				        //event.preventDefault();
				        //event.stopPropagation();
				        //$('.gridly').append(brick);
				        //$('.gridly').gridly();
				        
					} else {
						alert("������Ʈ ���� ����");
					}
				},
				error : function(data) {
					alert(data + ' : ���Է��� ����� ���� �߻�');
				}
			}); //end of ajax
		});//end of ���Է���
		
		//������Ʈ �����ϱ� ��ư ����
		$("#Joinbtn").click(function() {
    	 	var brick;
   			var pname = $("#pname").val();
   		 	alert(pname);
			$.ajax({
				url : "newParticipation.do",
				type : "post",
				dataType : "text",
				data : $("#joinproform").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("������Ʈ ���� ����");
						getData();							//��緹�ڵ� �˻��ϴ� �Լ� ȣ��				
				    	document.getElementById("joinProjectPop").style.display="none";
				    	//brick = "<div class='brick small'><br><br><font color='black'>"+pname+"</font><br><br></div>";
				        //event.preventDefault();
				        //event.stopPropagation();
				        //$('.gridly').append(brick);
				        //$('.gridly').gridly();
					} else {
						alert("������Ʈ ���� ����");
					}
				},
				error : function(data) {
					alert(data + ' : ������Ʈ ���� ���� ���� ����');
				}
			}); //end of ajax
		});//end of ���Է���

		// �ش� ������ email�� ��ϵ� ��� ������Ʈ �˻� �� ���
		function getData() {
			$.ajax({
				url : "getProjectList.do",
				data : "uemail=" + $("#pleader").val(),
				type : "post",
				dataType : "json", 					//���������Ÿ��
				success : function(data) {
					document.getElementById("gridly").innerHTML="<div class='brick small' ><br><br><font color='black'><b>I'm Mento.</b></font></div>";					

					$(data.list).each(function(index, project) {
						//alert(JSON.stringify(project));
						fullProjectInfo = JSON.stringify(project);//value="+JSON.stringify(project)+"
						simpleProjectInfo = project.pnum + project.pname;
						//alert(simpleProjectInfo);
						
						
		                document.getElementById("gridly").innerHTML+=
		                	  "<div class='brick small' id="+project.pnum+"><br><br><font color='black' >"+
		                	  		"<div id='content_s"+project.pnum+"' style='display:table-cell; vertical-align:middle; font-size: 1.3em;'>"+project.pname+"</div><br>"+
		                	  		"<div id='content_l"+project.pnum+"' style='display:none; font-size: 1.2em;'>"+
		                	  			"������Ʈ ��ȣ : "+project.pnum+"<br>"+	"������Ʈ �̸� : "+project.pname+"<br>"+
		                	  			"���� : "+project.pmento+"<br>"+  		"�Ⱓ : <br>"+project.pstart+"~"+project.pend+"<br>"+
		                	  			"���� : "+project.pleader+"<br>"+  		"</div><br></font>"+
		                	  		"<a class='enter' href='#' id="+project.pnum+">[�����ϱ�]</a>"+
		                	  			"<form action='enterProjectMain.do' id='enterProject"+project.pnum+"' method='post'>"+
	                	  				"<input type='hidden' id='pnum' name='pnum' value='"+project.pnum+"'/>"+
	                	  				"<input type='hidden' id='pname' name='pname' value='"+project.pname+"'/></form>"+
	                	  		"</div>";
	           
		                  
		                $('.gridly').gridly();
		               });
					
					//���̺� �߰�
				},
				error : function(err) {//����������
					alert(err + " : ��� ������Ʈ ���� �ҷ����� ����");
				}
			}); //end of ajax
		}//end of getData()

		
		
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
			}); //end of ajax
		});//end of Join button

		//���ڵ� ��������� �Լ� ȣ��
		getData();

   });//end of ready()
</script>


<body>
    <div id="bar">
        <!-- Login Starts Here -->
    	<div id="loginContainer">
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
		                    <input type="submit" id="login" value="�α���" />
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
                            <input type="button" id="Join" value="Ȯ��" />
                            <input type="reset" id="resetSpan" value="���" />
                            <input type="button" id="leave" value="Ż��" />
                        </fieldset>
                    </form>
       			</div>
      </div>
            <!-- Join Ends Here -->
    </div>
    
    <div class='content' align="center" style="margin-top: 35px">
    	<h1><b> <font color="4682B4" style="font-style: oblique;">ProgManager!</font></b></h1>
    	<br>
    	<hr>
    	<div id="projectList">
    		<section class='example'>
	    		<div class='gridly' id='gridly'></div>
	    		</section>
  	  	</div>
  	  	<br>
    	<hr>
        <p class='actions' style="float: left;">
          <a class='button' href="javascript:ViewCreateLayer();" >������Ʈ ����</a>
        </p>
        <p class='actions' style="float: right;">
          <a class='button' href="javascript:ViewJoinLayer();">������Ʈ ����</a>
        </p>
    </div>
        	
   	<div id="createProjectPop" align="center">
	   	<br><font color="black" size="30" style="4">������Ʈ �����ϱ�</font><br><br>

	   	<form name="newProject.do" id="newproform" method="post">
			Name :<input type="text"  name="pname" id="pname" /><br>
			PassWord :<input type="password" name="ppw" /><br>
			Mento ID :<input type="text" name="pmento" /><br>
			Start Date :<input type="text" name="pstart" /><br>
			End Date :<input type="text" name="pend" /><br>
			Leader :<input type="text" name="pleader" id="pleader" value="${requestScope.email}"/><br>
		<br>
		<br>
		<input class='basicBtn' type="button" value="�����ϱ�" id="btn">
		<input class='cancel basicBtn' type="button" value="���" id="btn2">
		</form>
	   	<br><br>
   	</div>
   	
   	<div id="joinProjectPop" align="center">
	   	<br><font color="black" size="30" style="4">������Ʈ �����ϱ�</font>
	   	<br><br>

	   	<form name="joinProject.do" id="joinproform" method="post">
			Project Number :     <input type="text"  name="pnum" id="pnum" /><br>
			Project PassWord : <input type="password" name="ppw" /><br>
			<input type="hidden" name="uemail" value="${requestScope.email}">
		<br>
		<br>
		<input class='basicJoinBtn' type="button" value="�����ϱ�" id="Joinbtn">
		<input class='cancel basicJoinBtn' type="button" value="���" id="Joinbtn2">
		</form>
	   	<br><br>
   	</div>
   	
    <script> 
      function ViewCreateLayer(){
        document.getElementById("createProjectPop").style.display='inline'
     }
      function registerProject(){
    	  document.getElementById("createProjectPop").style.display='none'
      }
      function ViewJoinLayer(){
          document.getElementById("joinProjectPop").style.display='inline'
       }
	</script> 	
	<br>
	
</body>
</html>
