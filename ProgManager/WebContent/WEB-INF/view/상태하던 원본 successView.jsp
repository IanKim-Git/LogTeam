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

		// 프로젝트 생성하기 버튼을 클릭했을때 project table에 저장되는 로직
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
						alert("프로젝트 생성 완료");
						getData();							//모든레코드 검색하는 함수 호출				
				    	document.getElementById("createProjectPop").style.display="none";
				    	brick = "<div class='brick small'><br><br><font color='black'>"+pname+
				    		+"</font><br><br></div>";
				        event.preventDefault();
				        event.stopPropagation();
				        $('.gridly').append(brick);
				        $('.gridly').gridly();
					} else {
						alert("가입 실패");
					}
				},
				error : function(data) {
					alert(data + ' : 가입로직 실행시 에러 발생');
				}
				
			}); //end of ajax
		});//end of 가입로직

		// 해당 유저의 email로 등록된 모든 프로젝트 검색 후 출력
		function getData() {
			$.ajax({
				url : "getProjectList.do",
				data : "uemail=" + $("#pleader").val(),
				type : "post",
				dataType : "json", 					//결과데이터타입
				success : function(data) {
					document.getElementById("gridly").innerHTML="<div class='brick small' ><br><br><font color='black'>ProgManager<br><b>I'm Mento.</b></font></div>";					

					$(data.list).each(function(index, project) {
						//alert(JSON.stringify(project));
						var fullProjectInfo = JSON.stringify(project);//value="+JSON.stringify(project)+"
						var simpleProjectInfo = project.pnum + project.pname;
						//alert(simpleProjectInfo);
						
		                  document.getElementById("gridly").innerHTML+=
		                	  "<div class='brick small' id="+project.pnum+" value="+JSON.stringify(project)+"><br><br><font color='black' >"+
		                	  "<div id='contents"+project.pnum+"'>"+project.pname+"</div><br></font></div>";
		                  
		                  $('.gridly').gridly();
		               });
					
					//테이블에 추가
				},
				error : function(err) {//실패했을때
					alert(err + " : 모든 프로젝트 정보 불러오기 실패");
				}
			}); //end of ajax
		}//end of getData()
			
		$(document).on("click", "#enterProject", function() {
			$.ajax({
				url : "enterProjectMain.do", 
				type : "post",
				dataType : "text", 
				data : "pnum=" + $(this).attr("pnum") + "&uemail=" + $("#pleader").val(),	//서버에 전송할 데이터
				success : function(data) {
					if (data == "ok") {
						alert("삭제 성공");
						getData();
					} else {
						alert("삭제 실패");
					}
				},
				error : function(err) {//실패했을때
					alert(err + " : 학생정보 삭제 실패");
				}
			});
		});

		//레코드 가져오기는 함수 호출
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
                            <input type="submit" id="login" value="로그인" />
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
                            <input type="button" id="Join" value="가입" />
                            <input type="reset" id="resetSpan" value="취소" />
                        </fieldset>
                    </form>
       			</div>
            </div>
            <!-- Join Ends Here -->
        </div>
    </div>
    <div class='content' align="center">
    
     <h1><b> <font color="blue">ProgManager에 오신걸 환영합니다</font></b></h1>
      <br>
      <p>자신의 프로젝트를 내맘대로 정렬하세요^^</p>
      <br>
      <hr>
      <h3> <font color="orange">◆  자신 프로젝트 목록 ◆</font></h3>
      <div id="projectList">
	      <section class='example'>
	        <div class='gridly' id='gridly'>
	        </div>
          </section>
  		</div>
        <p class='actions'>
          <a class='button' href="javascript:ViewLayer();">프로젝트 생성하기</a>
        </p>
 
    </div>
   	<div ><a id='nextLink' href='mainProject.html'>넘어가기</a></div>
    	
   	<div id="createProjectPop" align="center">
	   	<br>
	   	<font color="black" size="40" style="4">프로젝트 생성하기</font>
	   	<br>
	   	<br>

	   	<form name="newProject.do" id="newproform" method="post">
			Project Name <input type="text"  name="pname" id="pname" /><br>
			Project PassWord <input type="password" name="ppw" /><br>
			Project Mendo ID <input type="text" name="pmento" /><br>
			Project Start Date <input type="text" name="pstart" /><br>
			Project End Date <input type="text" name="pend" /><br>
			Project Leader <input type="text" name="pleader" id="pleader" value="${requestScope.email}"/><br>
		<br>
		<br>
		<input class='basicBtn' type="button" value="생성하기" id="btn">
		<input class='cancel basicBtn' type="button" value="취소" id="btn2">
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
	<hr>
	<br>
	<h2>모든 프로젝트 정보 보기</h2>
		<table cellspacing="0">
			<tr>
				<td style="text-align: right">
					<input type="button" value="모든 학생 정보 보기">
				</td>
			</tr>
		</table>
		<table id="projectlistTable" cellspacing="0">
			<tr bgcolor="#FOFOF7">
				<th>프로젝트 번호</th><th>이름</th><th>담당자</th><th>시작일</th><th>종료일</th><th>팀장</th><th>입장</th>
			</tr>
			
		</table>
	
	<!-- <a href="WEB-INF/view/updateInfo.jsp">개인정보 변경 화면</a> -->
	<!-- <input type="button" value="수정하기"	Onclick="location.href='updateInfo.jsp'"> -->
	<form action="sendEmail.do" id="userEmail" method="post">
		<input type="submit" value="개인정보 변경하기"/>
		<input type="hidden" name="email" id="email" value="${requestScope.email}"/>
	</form>
		
	
</body>
</html>
