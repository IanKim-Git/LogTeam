<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
     <meta http-equiv="X-UA-Compatible" content="text/html" charset="EUC-KR">
	 <title>${requestScope.title }</title>
     <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
     <link href='stylesheets/jquery.gridly.css' rel='stylesheet' type='text/css'>
     <link href='stylesheets/sample.css' rel='stylesheet' type='text/css'>
     <link rel="stylesheet" href="css/style.css" />
     <script src='https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.js' type='text/javascript'></script>
     <script src='javascripts/jquery.gridly.js' type='text/javascript'></script>
     <script src='javascripts/brickAddDelete.js' type='text/javascript'></script>
     <script src='javascripts/rainbow.js' type='text/javascript'></script>
     <script src="js/login.js"></script>
     <script src="javascripts/createProjectBtn.js"></script>
<!-- 	 <script src="js/jquery-1.10.2.js"></script> -->
</head>

<script type="text/javascript">
	$(document).ready(	function() {
		var pleader = $("#pleader").val();
		
		var fullProjectInfo;
		var simpleProjectInfo;

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
				    	brick = "<div class='brick small'><br><br><font color='black'>"+pname+
				    		+"</font><br><br></div>";
				        event.preventDefault();
				        event.stopPropagation();
				        $('.gridly').append(brick);
				        $('.gridly').gridly();
					} else {
						alert("���� ����");
					}
				},
				error : function(data) {
					alert(data + ' : ���Է��� ����� ���� �߻�');
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
		                	  		"������Ʈ ��ȣ : "+project.pnum+"<br>"+
		                	  		"������Ʈ �̸� : "+project.pname+"<br>"+
		                	  		"���� : "+project.pmento+"<br>"+
		                	  		"�Ⱓ : <br>"+project.pstart+
		                	  		"~"+project.pend+"<br>"+
		                	  		"���� : "+project.pleader+"<br>"+
		                	  		"</div><br></font></div>";
		                  
		                $('.gridly').gridly();
		               });
					
					//���̺� �߰�
				},
				error : function(err) {//����������
					alert(err + " : ��� ������Ʈ ���� �ҷ����� ����");
				}
			}); //end of ajax
		}//end of getData()
			
		$(document).on("click", "#enterProject", function() {
			$.ajax({
				url : "enterProjectMain.do", 
				type : "post",
				dataType : "text", 
				data : "pnum=" + $(this).attr("pnum") + "&uemail=" + $("#pleader").val(),	//������ ������ ������
				success : function(data) {
					if (data == "ok") {
						alert("���� ����");
						getData();
					} else {
						alert("���� ����");
					}
				},
				error : function(err) {//����������
					alert(err + " : �л����� ���� ����");
				}
			});
		});

		//���ڵ� ��������� �Լ� ȣ��
		getData();
		

	});//end of ready()
</script>

<body>
   
    <div id="bar">
        <div id="container">
            <!-- Login Starts Here -->
            <div id="loginContainer">
                <a href="#" id="loginButton"><span>Login</span><em></em></a>
                <div style="clear:both"></div>
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
            </div>
            <!-- Login Ends Here -->
        </div>
         <div id="container">
            <!-- Join Starts Here -->
            <div id="JoinContainer">
                <a href="#" id="JoinButton"><span>Sign in</span><em></em></a>
                <div style="clear:both"></div>
       			<div id="JoinBox">
       				<form action="insert.do" method="post" id="JoinForm">
                        <fieldset id="body">
                            <fieldset>
                                <label for="email2">ID(e-mail)</label>
                                <input type="text" name="email2" id="email2"/><br><span id="idValidation"></span>
                            </fieldset>
                            <fieldset>
                                <label for="password2">Password</label>
                                <input type="password" name="pw2" id="pw2"/><span id="pwValidation"></span>
                            </fieldset>
                            <fieldset>
                                <label for="pwAgain">Reenter Password</label>
                                <input type="password" name="pwAgain" id="pwAgain"/><span id="pw2Validation"></span>
                            </fieldset>
                            <fieldset>
                                <label for="name">Name</label>
                                <input type="text" name="name" id="name"/><span id="nameValidation"></span>
                            </fieldset>
                            <fieldset>
                                <label for="phone">Phone Number(ex.000-0000-0000)</label>
                                <input type="text" name="phone" id="phone">
                            </fieldset>
                            <input type="button" id="Join" value="����" />
                            <input type="reset" id="resetSpan" value="���" />
                        </fieldset>
                    </form>
       			</div>
            </div>
            <!-- Join Ends Here -->
        </div>
    </div>
    
    <div class='content' align="center">
    	<h1><b> <font color="blue" style="font-style: oblique;">ProgManager!</font></b></h1>
    	<br>
    	<hr>
    	<h3> <font color="orange"> �������� ������Ʈ </font></h3>
    	<div id="projectList">
    		<section class='example'>
	    		<div class='gridly' id='gridly'></div>
	    		</section>
  	  	</div>
        <p class='actions'>
          <a class='button' href="javascript:ViewLayer();">������Ʈ �����ϱ�</a>
        </p>
    </div>
        	
   	<div id="createProjectPop" align="center">
	   	<br>
	   	<font color="black" size="30" style="4">������Ʈ �����ϱ�</font>
	   	<br>
	   	<br>

	   	<form name="newProject.do" id="newproform" method="post">
			Project Name :     <input type="text"  name="pname" id="pname" /><br>
			Project PassWord : <input type="password" name="ppw" /><br>
			Project Mento ID : <input type="text" name="pmento" /><br>
			Start Date : 	   <input type="text" name="pstart" /><br>
			End Date : 		   <input type="text" name="pend" /><br>
			Leader : 		   <input type="text" name="pleader" id="pleader" value="${requestScope.email}"/><br>
		<br>
		<br>
		<input class='basicBtn' type="button" value="�����ϱ�" id="btn">
		<input class='cancel basicBtn' type="button" value="���" id="btn2">
		</form>
	   	<br>

	   	<br>
   	</div>
    <script> 
      function ViewLayer(){
        document.getElementById("createProjectPop").style.display='inline'
     }
      function registerProject(){
    	  document.getElementById("createProjectPop").style.display='none'
      }
   </script> 
	
	<br>
	
</body>
</html>
