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

<%-- <%
	String email = (String)request.getAttribute("email");
	String pw = (String)request.getAttribute("pw");
	String name = (String)request.getAttribute("name");
	String phone = (String)request.getAttribute("phone");
	String photo = (String)request.getAttribute("photo");
	
	HashMap userData = new HashMap();
	userData.put("uemail", email);
	userData.put("upw", pw);
	userData.put("uname", name);
	userData.put("uphone", phone);
	userData.put("uphoto", photo);
	session.setAttribute("userData", userData);
	���� �̸��� : ${sessionScope.userData.uemail}<br>
%> --%>


<script type="text/javascript">

	$(document).ready(	function() {
			
		// ������Ʈ �����ϱ� ��ư�� Ŭ�������� project table�� ����Ǵ� ����
		$("#btn").click(function() {
    	 	var brick;
   			var pname = $("#pname").val();
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
				    	$(".overlay").hide();
					} else {
						alert("������Ʈ ���� ����");
					}
				},
				error : function(data) {
					alert(data + ' : ���Է��� ����� ���� �߻�');
				}
			}); //end of ajax
		});//end of ���Է���
		
		$("#btn2").click(function() {
   			$(".overlay").hide();
		});
		$("#Joinbtn2").click(function() {
   			$(".overlay").hide();
		});
		
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
				    	$(".overlay").hide();
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
					
			var cpstart;
			var cpend;
			
			$.ajax({
				url : "getProjectList.do",
				data : "uemail=" + $("#pleader").val(),
				type : "post",
				dataType : "json", 					//���������Ÿ��
				success : function(data) {
					//document.getElementById("gridly").innerHTML="<div class='brick small' ><br><br><font color='black'><b>I'm Mentor.</b></font></div>";
					document.getElementById("gridly").innerHTML="";

					$(data.list).each(function(index, project) {
						//alert(JSON.stringify(project));
						fullProjectInfo = JSON.stringify(project);//value="+JSON.stringify(project)+"
						simpleProjectInfo = project.pnum + project.pname;
						//alert(simpleProjectInfo);
						cpstart = project.pstart.substring(0,4) +"-"+ project.pstart.substring(5,7) +"-"+ project.pstart.substring(8,10);
						cpend = project.pend.substring(0,4) +"-"+ project.pend.substring(5,7) +"-"+ project.pend.substring(8,10);
						
		                document.getElementById("gridly").innerHTML+=
		                	  "<div class='brick small' id="+project.pnum+"><br><br><font color='black' >"+
		                	  		"<div id='content_s"+project.pnum+"' style='display:table-cell; vertical-align:middle; font-size: 1.3em;'>"+project.pname+"</div><br>"+
		                	  		"<div id='content_l"+project.pnum+"' style='display:none; font-size: 1.2em;'>"+
		                	  			"<big>������Ʈ ��ȣ : "+project.pnum+"</big><br>"+	"<big>������Ʈ �̸� : "+project.pname+"</big><br>"+
		                	  			"���� : "+project.pmento+"<br>"+  		"�Ⱓ : "+cpstart+"~"+cpend+"<br>"+
		                	  			"���� : "+project.pleader+"<br>"+  		"</div><br></font>"+
		                	  		"<a class='enter' href='#' id="+project.pnum+">&nbsp;GO&nbsp;</a>"+
		                	  			"<form action='projectInfo.do' id='enterProject"+project.pnum+"' method='post'>"+
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
	<br><br><br>
    
    <div class='content' align="center" style="margin-top: 35px">
    	<h1><img src="./images/ProgManager.png"></h1>
    	<hr><br>

    	<div id="projectList" style="right: 500px;">
    		<section class='example'>
	    		<div class='gridly' id='gridly'></div>
	    	</section>
  	  	</div>
  	  	<hr>
  	  	
        <p class='actions' style="float: left;">
          <a class='button' href="javascript:ViewCreateLayer();javascript:viewLayer();" style="font-size: 40px;font-family: fantasy;">����</a>
        </p>
        <p class='actions' style="float: right;">
          <a class='button' href="javascript:ViewJoinLayer();javascript:viewLayer();" style="font-size: 40px; font-family: fantasy;">����</a>
        </p>
    </div>
    <br><br><br><br><br>
    
   	<div id="createProjectPop" align="center">
	   	<br><font color="#686060" size="27" style="4; font-family: fantasy; font-weight: bolder;" >���ο� ������Ʈ</font>
	   	<br><br>

	   	<form name="newProject.do" id="newproform" method="post">
	   	<table style="margin: 0 0 0 120px; color: #686060;">
			<tr><td>�� �� :</td><td><input type="text"  name="pname" id="pname" /></td></tr>
			<tr><td>��й�ȣ :</td><td><input type="password" name="ppw" /></td></tr>
			<tr><td>���� ID :</td><td><input type="text" name="pmento" /></td></tr>
			<tr><td>������ :</td><td><input type="text" name="pstart" /></td></tr>
			<tr><td>������ :</td><td><input type="text" name="pend" /></td></tr>
			<tr><td>���� :</td><td><input type="text" name="pleader" id="pleader" value="${sessionScope.userData.uemail}"/></td></tr>
		</table>
		<br>
		<input class='basicBtn' type="button" value="  ����  " id="btn">
		<input class='cancel basicBtn' type="button" value="  ���  " id="btn2">
		</form>
	   	<br><br> 
   	</div>
   	
   	<div id="joinProjectPop" align="center">
	   	<br><font color="#686060" size="27" style="4; font-family: fantasy;font-weight: bolder;" >������Ʈ ����</font>
	   	<br><br>

	   	<form name="joinProject.do" id="joinproform" method="post">
		<table style="margin: 9px 0 0 80px; color: #686060;">
			<tr><td>������Ʈ ��ȣ :   </td><td><input type="text"  name="pnum" id="pnum" /></td></tr>
			<tr></tr>
			<tr><td>������Ʈ ��й�ȣ : </td><td><input type="password" name="ppw" /></td></tr>
			<tr><td></td><td><input type="hidden" name="uemail" value="${sessionScope.userData.uemail}"></td></tr>
		</table>
		<br>
		<input class='basicJoinBtn' type="button" value=" �����ϱ� " id="Joinbtn">
		<input class='cancel basicJoinBtn' type="button" value="  ���  " id="Joinbtn2">
		</form>
	   	<br><br>
   	</div>
   	
   	<div class="overlay" id="overlay"></div>

	<script> 
      function ViewCreateLayer(){
        document.getElementById("createProjectPop").style.display='block';
     }
      function registerProject(){
    	  document.getElementById("createProjectPop").style.display='none';
      }
      function ViewJoinLayer(){
          document.getElementById("joinProjectPop").style.display='block';
      }
      function joinProject(){
    	  document.getElementById("joinProjectPop").style.display='none';
      }
      function viewLayer(){
    	  document.getElementById("overlay").style.display="inline";
      }
      function hideLayer(){
    	  document.getElementById("overlay").style.display="none";
      }
	</script> 	
	<br>
	
</body>
</html>






