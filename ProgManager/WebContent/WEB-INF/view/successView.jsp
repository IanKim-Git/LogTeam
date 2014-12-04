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
	유저 이메일 : ${sessionScope.userData.uemail}<br>
%> --%>


<script type="text/javascript">

	$(document).ready(	function() {
			
		// 프로젝트 생성하기 버튼을 클릭했을때 project table에 저장되는 로직
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
						alert("프로젝트 생성 완료");
						getData();							//모든레코드 검색하는 함수 호출				
				    	document.getElementById("createProjectPop").style.display="none";
				    	$(".overlay").hide();
					} else {
						alert("프로젝트 생성 실패");
					}
				},
				error : function(data) {
					alert(data + ' : 가입로직 실행시 에러 발생');
				}
			}); //end of ajax
		});//end of 가입로직
		
		$("#btn2").click(function() {
   			$(".overlay").hide();
		});
		$("#Joinbtn2").click(function() {
   			$(".overlay").hide();
		});
		
		//프로젝트 참여하기 버튼 로직
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
						alert("프로젝트 참여 성공");
						getData();							//모든레코드 검색하는 함수 호출				
				    	document.getElementById("joinProjectPop").style.display="none";
				    	$(".overlay").hide();
					} else {
						alert("프로젝트 참여 실패");
					}
				},
				error : function(data) {
					alert(data + ' : 프로젝트 참여 로직 실행 에러');
				}
			}); //end of ajax
		});//end of 가입로직

		// 해당 유저의 email로 등록된 모든 프로젝트 검색 후 출력
		function getData() {
					
			var cpstart;
			var cpend;
			
			$.ajax({
				url : "getProjectList.do",
				data : "uemail=" + $("#pleader").val(),
				type : "post",
				dataType : "json", 					//결과데이터타입
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
		                	  			"<big>프로젝트 번호 : "+project.pnum+"</big><br>"+	"<big>프로젝트 이름 : "+project.pname+"</big><br>"+
		                	  			"멘토 : "+project.pmento+"<br>"+  		"기간 : "+cpstart+"~"+cpend+"<br>"+
		                	  			"팀장 : "+project.pleader+"<br>"+  		"</div><br></font>"+
		                	  		"<a class='enter' href='#' id="+project.pnum+">&nbsp;GO&nbsp;</a>"+
		                	  			"<form action='projectInfo.do' id='enterProject"+project.pnum+"' method='post'>"+
	                	  				"<input type='hidden' id='pnum' name='pnum' value='"+project.pnum+"'/>"+
	                	  				"<input type='hidden' id='pname' name='pname' value='"+project.pname+"'/></form>"+
	                	  		"</div>";	           
		                $('.gridly').gridly();
		               });
					//테이블에 추가
				},
				error : function(err) {//실패했을때
					alert(err + " : 모든 프로젝트 정보 불러오기 실패");
				}
			}); //end of ajax
		}//end of getData()
		
		//데이터 가져오는 함수 호출
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
          <a class='button' href="javascript:ViewCreateLayer();javascript:viewLayer();" style="font-size: 40px;font-family: fantasy;">새로</a>
        </p>
        <p class='actions' style="float: right;">
          <a class='button' href="javascript:ViewJoinLayer();javascript:viewLayer();" style="font-size: 40px; font-family: fantasy;">같이</a>
        </p>
    </div>
    <br><br><br><br><br>
    
   	<div id="createProjectPop" align="center">
	   	<br><font color="#686060" size="27" style="4; font-family: fantasy; font-weight: bolder;" >새로운 프로젝트</font>
	   	<br><br>

	   	<form name="newProject.do" id="newproform" method="post">
	   	<table style="margin: 0 0 0 120px; color: #686060;">
			<tr><td>이 름 :</td><td><input type="text"  name="pname" id="pname" /></td></tr>
			<tr><td>비밀번호 :</td><td><input type="password" name="ppw" /></td></tr>
			<tr><td>멘토 ID :</td><td><input type="text" name="pmento" /></td></tr>
			<tr><td>시작일 :</td><td><input type="text" name="pstart" /></td></tr>
			<tr><td>종료일 :</td><td><input type="text" name="pend" /></td></tr>
			<tr><td>팀장 :</td><td><input type="text" name="pleader" id="pleader" value="${sessionScope.userData.uemail}"/></td></tr>
		</table>
		<br>
		<input class='basicBtn' type="button" value="  생성  " id="btn">
		<input class='cancel basicBtn' type="button" value="  취소  " id="btn2">
		</form>
	   	<br><br> 
   	</div>
   	
   	<div id="joinProjectPop" align="center">
	   	<br><font color="#686060" size="27" style="4; font-family: fantasy;font-weight: bolder;" >프로젝트 참여</font>
	   	<br><br>

	   	<form name="joinProject.do" id="joinproform" method="post">
		<table style="margin: 9px 0 0 80px; color: #686060;">
			<tr><td>프로젝트 번호 :   </td><td><input type="text"  name="pnum" id="pnum" /></td></tr>
			<tr></tr>
			<tr><td>프로젝트 비밀번호 : </td><td><input type="password" name="ppw" /></td></tr>
			<tr><td></td><td><input type="hidden" name="uemail" value="${sessionScope.userData.uemail}"></td></tr>
		</table>
		<br>
		<input class='basicJoinBtn' type="button" value=" 참여하기 " id="Joinbtn">
		<input class='cancel basicJoinBtn' type="button" value="  취소  " id="Joinbtn2">
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






