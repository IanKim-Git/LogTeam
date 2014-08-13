<%@page import="java.util.HashMap"%>
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
     <script src="js/formValidation.js"></script>
     <script src="javascripts/createProjectBtn.js"></script>
      
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
			$.ajax({
				url : "newProject.do",
				type : "post",
				dataType : "text",
				data : $("#newproform").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("������Ʈ ���� �Ϸ�");
						$("input[type=text]").val("");	//text�ڽ� ��� �����
						$("input[type=password]").val("");
						$("#pleader").val(pleader);
						getData();							//��緹�ڵ� �˻��ϴ� �Լ� ȣ��
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
					var table = "";
					//������ �ִ� ���̺� ù�ุ ���� �����
					//http://www.w3schools.com/jquery/tryit.asp?filename=tryjquery_sel_gt
					$("#projectlistTable tr:gt(0)").remove();
					
					$(data.list).each(function(index, project) {
						table += "<tr><td>" + project.pnum + "</td><td>" + project.pname + "</td><td>" +  project.pmento + "</td>";
						table += "<td>" + project.pstart + "</td><td>" + project.pend + "</td><td>" + project.pleader + "</td><td>";
						table += "<input type='button' value='�����ϱ�' id='enterProject' name='"+project.no+"'></td></tr>"
					});
					//���̺� �߰�
					$("#projectlistTable tr:eq(0)").after(table);
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
						alert("���� ����")
					}
				},
				error : function(err) {//����������
					alert(err + " : �л����� ���� ����")
				}
			})
		});
		
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
        <div id="container">
            <!-- Login Starts Here -->
            <div id="loginContainer">
                <a href="#" id="loginButton"><span>Logout</span><em></em></a>
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
                <a href="#" id="JoinButton"><span>Infom</span><em></em></a>
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
    </div>
    <div class='content' align="center">
    
     <h1><b> <font color="blue">ProgManager�� ���Ű� ȯ���մϴ�</font></b></h1>
      <br>
      <p>�ڽ��� ������Ʈ�� ������� �����ϼ���^^</p>
      <br>
      <hr>
      <h3> <font color="orange">��  �ڽ� ������Ʈ ��� ��</font></h3>
      <section class='example'>
        <div class='gridly'>

          <div class='brick small' >
          <br><br><font color='black' >ProgManager
          <br>
          	������Ʈ �α� ���� ������Ʈ
          	<br>
          	����<br>
          	�ڻ���, ����, Ȳ����, �ڴ���
          	<br>
          	������Ʈ ������ : 0000-00-00<br>
          	������Ʈ ������ : 0000-00-00<br>
          	</font>
          
            <a class='delete' href='#'>&times;</a>          </div>
          <div class='brick small'>
            <a class='delete' href='#'>&times;</a>          </div>

        </div>
        <p class='actions'>
          <a class='button' href="javascript:ViewLayer();">������Ʈ �����ϱ�</a>
        </p>
      </section>
    </div>
   	<div ><a id='nextLink' href='mainProject.html'>�Ѿ��</a></div>
    	
   	<div id="createProjectPop" align="center">
	   	<br>
	   	<font color="black" size="40" style="4">������Ʈ �����ϱ�</font>
	   	<br>
	   	<br>
	   	<font color=white>������Ʈ �̸� : </font><input type=text /><br>
	   	<font color=white>������Ʈ ��й�ȣ : </font><input type=text /><br>
	   	<font color=white>����� id : </font><input type=text /><br>
	   	<font color=white>������Ʈ ���� : </font><input type=text /><br>
	   	<font color=white>PM id : </font><input type=text /><br>
	   	
	   	<form name="newProject.do" id="newproform" method="post">
		Project Name <input type="text"  name="pname" /><br>
		Project PassWord <input type="password" name="ppw" /><br>
		Project Mendo ID <input type="text" name="pmento" /><br>
		Project Start Date <input type="text" name="pstart" /><br>
		Project End Date <input type="text" name="pend" /><br>
		Project Leader <input type="text" name="pleader" id="pleader" value="${requestScope.email}"/><br>
		<input type="button" value="�����ϱ�" id="btn">
		</form>
	   	<br>
	   	<div align="center">
	   	<a class='add basicBtn' href='#'>�����</a>
	   	<a class='cancel basicBtn' href="#">���</a>
	   	</div>
	   	<br>
	   	<button id="ok"  onclick="registerProject()">Ȯ��</button>
	   	<button id="cancel" >���</button>
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
	<hr>
	<br>
	<h2>��� ������Ʈ ���� ����</h2>
		<table cellspacing="0">
			<tr>
				<td style="text-align: right">
					<input type="button" value="��� �л� ���� ����">
				</td>
			</tr>
		</table>
		<table id="projectlistTable" cellspacing="0">
			<tr bgcolor="#FOFOF7">
				<th>������Ʈ ��ȣ</th><th>�̸�</th><th>�����</th><th>������</th><th>������</th><th>����</th><th>����</th>
			</tr>
			
		</table>
	
</body>
</html>
