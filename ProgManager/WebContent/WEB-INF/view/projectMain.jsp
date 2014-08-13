<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Project Main</title>
     <script src='https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.js' type='text/javascript'></script>
     <script src="js/login.js"></script>

	 <link rel="stylesheet" href="css/style2.css" type="text/css" media="screen">
		
	 <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
	 <script src="js/cufon-yui.js" type="text/javascript"></script>
	 <script src="js/BabelSans_500.font.js" type="text/javascript"></script>
	 <script src="js/jquery.easing.1.3.js" type="text/javascript"></script> 
	 <script type="text/javascript">
			$(function() {
				Cufon.replace('a, span').CSS.ready(function() {
					var $menu 		= $("#slidingMenu");
					var $selected	= $menu.find('li:first');
					var $moving		= $('<li />',{
						className	: 'move',
						top			: $selected[0].offsetTop + 'px',
						width		: $selected[0].offsetWidth + 'px'
					});
					$('#slidingMenuDesc > div').each(function(i){
						var $this = $(this);
						$this.css('top',$menu.find('li:nth-child('+parseInt(i+2)+')')[0].offsetTop + 'px');
					});
					$menu.bind('mouseleave',function(){
							moveTo($selected,400);
						  })
						 .append($moving)
						 .find('li')
						 .not('.move')
						 .bind('mouseenter',function(){
							var $this = $(this);
							var offsetLeft = $this.offset().left - 20;
							//slide in the description
							$('#slidingMenuDesc > div:nth-child('+ parseInt($this.index()) +')').stop(true).animate({'width':offsetLeft+'px'},400, 'easeOutExpo');
							//move the absolute div to this item
							moveTo($this,400);
						  })
						  .bind('mouseleave',function(){
							var $this = $(this);
							var offsetLeft = $this.offset().left - 20;
							//slide out the description
							$('#slidingMenuDesc > div:nth-child('+ parseInt($this.index()) +')').stop(true).animate({'width':'0px'},400, 'easeOutExpo');
						  });;
					function moveTo($elem,speed){
						$moving.stop(true).animate({
							top		: $elem[0].offsetTop + 'px',
							width	: $elem[0].offsetWidth + 'px'
						}, speed, 'easeOutExpo');
					}
				}) ;
			});
		</script>
		<style>
		a{ color:#FF9900}
          span.reference{
              position:fixed;
              left:10px;
              bottom:10px;
              font-size:14px;
          }
          span.reference a{
              color:#aaa;
              text-decoration:none;
          }
		</style>
     


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

    
    <div id="menubar">
		<ul id="slidingMenu" class="slidingMenu">
			<!-- 프로젝트 정보 -->
			<li><form action="projectInfo.do" id="projectInfo" onclick="onprojectInfo()" method="post">
					<input type="hidden" name="enterProInfoPnum" value="${requestScope.pnum}">
					<a href="#">Info</a>
			</form></li>
			
			<!-- 공지사항 -->
			<li><form action="announcement.do" id="announcement" onclick="onannouncement()" method="post">
					<input type="hidden" name="enterAnnPnum" value="${requestScope.pnum}">
					<a href="#">Announcement</a>	
			</form></li>
			
			<!-- 캘린더 -->
			<li><form action="calender.do" id="calender" onclick="calender()" method="post">
					<input type="hidden" name="enterCalPnum" value="${requestScope.pnum}">
					<a href="#">Calendar</a>
			</form></li>
			
			<!-- 로그게시판 -->
			<li><form action="logList.do" id="logList" onclick="onlogList()" method="post">
					<input type="hidden" name="enterLogPnum" value="${requestScope.pnum}">
					<a href="#">Log board</a>
			</form></li>
			
			<!-- 팀원성과도 -->
			<li><form action="outcome.do" id="outcome" onclick="onoutcome()" method="post">
					<input type="hidden" name="enterOutPnum" value="${requestScope.pnum}">
					<a href="#">Achievement</a>
			</form></li>
			
			<!-- 회계관리 -->
			<li><form action="account.do" id="account" onclick="onaccount()" method="post">
				<input type="hidden" name="enterAccPnum" value="${requestScope.pnum}">
				<a href="#">Account</a>
			</form></li>
			
			</ul>
	</div>
		<script type="text/javascript">
		function onprojectInfo(){
			$("#projectInfo").submit();
		}
		function onannouncement(){
			$("#announcement").submit();
		}
		function calender(){
			$("#calender").submit();
		}
		function onlogList(){
			$("#logList").submit();
		}
		function onoutcome(){
			$("#outcome").submit();
		}
		function onaccount(){
			$("#account").submit();
		}
	</script>
	
	<div id="contents">
	
	
	</div>
	
	
	<%-- 프 번호 - ${requestScope.pnum}<br>
	프 이름 - ${requestScope.pname}<br>
	유 이메일 - ${sessionScope.userData.uemail}<br> --%>
	
</body>
</html>
