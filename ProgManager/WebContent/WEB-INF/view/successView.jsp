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
			
		// 프로젝트 생성하기 버튼을 클릭했을때 project table에 저장되는 로직
		$("#btn").click(function() {
			$.ajax({
				url : "newProject.do",
				type : "post",
				dataType : "text",
				data : $("#newproform").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("프로젝트 생성 완료");
						$("input[type=text]").val("");	//text박스 모두 지우기
						$("input[type=password]").val("");
						$("#pleader").val(pleader);
						getData();							//모든레코드 검색하는 함수 호출
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
					var table = "";
					//기존에 있는 테이블 첫행만 빼고 지우기
					//http://www.w3schools.com/jquery/tryit.asp?filename=tryjquery_sel_gt
					$("#projectlistTable tr:gt(0)").remove();
					
					$(data.list).each(function(index, project) {
						table += "<tr><td>" + project.pnum + "</td><td>" + project.pname + "</td><td>" +  project.pmento + "</td>";
						table += "<td>" + project.pstart + "</td><td>" + project.pend + "</td><td>" + project.pleader + "</td><td>";
						table += "<input type='button' value='입장하기' id='enterProject' name='"+project.no+"'></td></tr>"
					});
					//테이블에 추가
					$("#projectlistTable tr:eq(0)").after(table);
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
						alert("삭제 실패")
					}
				},
				error : function(err) {//실패했을때
					alert(err + " : 학생정보 삭제 실패")
				}
			})
		});
		
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

		//레코드 가져오기는 함수 호출
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
                            <input type="button" id="Join" value="확인" />
                            <input type="reset" id="resetSpan" value="취소" />
                            <input type="button" id="leave" value="탈퇴" />
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
      <section class='example'>
        <div class='gridly'>

          <div class='brick small' >
          <br><br><font color='black' >ProgManager
          <br>
          	프로젝트 로그 관리 프로젝트
          	<br>
          	팀원<br>
          	박상태, 김용두, 황수남, 박다은
          	<br>
          	프로젝트 시작일 : 0000-00-00<br>
          	프로젝트 종료일 : 0000-00-00<br>
          	</font>
          
            <a class='delete' href='#'>&times;</a>          </div>
          <div class='brick small'>
            <a class='delete' href='#'>&times;</a>          </div>

        </div>
        <p class='actions'>
          <a class='button' href="javascript:ViewLayer();">프로젝트 생성하기</a>
        </p>
      </section>
    </div>
   	<div ><a id='nextLink' href='mainProject.html'>넘어가기</a></div>
    	
   	<div id="createProjectPop" align="center">
	   	<br>
	   	<font color="black" size="40" style="4">프로젝트 생성하기</font>
	   	<br>
	   	<br>
	   	<font color=white>프로젝트 이름 : </font><input type=text /><br>
	   	<font color=white>프로젝트 비밀번호 : </font><input type=text /><br>
	   	<font color=white>담당자 id : </font><input type=text /><br>
	   	<font color=white>프로젝트 시작 : </font><input type=text /><br>
	   	<font color=white>PM id : </font><input type=text /><br>
	   	
	   	<form name="newProject.do" id="newproform" method="post">
		Project Name <input type="text"  name="pname" /><br>
		Project PassWord <input type="password" name="ppw" /><br>
		Project Mendo ID <input type="text" name="pmento" /><br>
		Project Start Date <input type="text" name="pstart" /><br>
		Project End Date <input type="text" name="pend" /><br>
		Project Leader <input type="text" name="pleader" id="pleader" value="${requestScope.email}"/><br>
		<input type="button" value="생성하기" id="btn">
		</form>
	   	<br>
	   	<div align="center">
	   	<a class='add basicBtn' href='#'>만들기</a>
	   	<a class='cancel basicBtn' href="#">취소</a>
	   	</div>
	   	<br>
	   	<button id="ok"  onclick="registerProject()">확인</button>
	   	<button id="cancel" >취소</button>
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
	
</body>
</html>
