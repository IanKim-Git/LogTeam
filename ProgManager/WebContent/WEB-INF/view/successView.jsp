<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="topBar.jsp" flush="false" />

	 <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	 <title>${requestScope.title }</title>
     <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
     <link href='stylesheets/jquery.gridly.css' rel='stylesheet' type='text/css'>
     <link href='stylesheets/sample.css' rel='stylesheet' type='text/css'>
     <link rel="stylesheet" href="css/projectMenu.css" />
     <script src='https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.js' type='text/javascript'></script>
     <script src='javascripts/jquery.gridly.js' type='text/javascript'></script>
     <script src='javascripts/brickAddDelete.js' type='text/javascript'></script>
     <script src='javascripts/rainbow.js' type='text/javascript'></script>
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
			
		// ������Ʈ �����ϱ� ��ư�� Ŭ�������� project table�� ����Ǵ� ����
		$("#btn").click(function() {
    	 	var brick;
   			var pname = $("#pname").val();
   		 	alert($("#newproform").serialize());
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

		//������ �������� �Լ� ȣ��
		getData();

   });//end of ready()
</script>

<body>
    
    <div class='content' align="center" style="margin-top: 35px">
    	<h1><b> <font color="4682B4" style="font-style: oblique;">ProgManager!</font></b></h1>
    	<br><hr><br>
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
    <br><br><br><br><br>
        	
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
