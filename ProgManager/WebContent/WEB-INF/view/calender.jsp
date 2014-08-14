<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Project Main</title>
	
    <link rel="stylesheet" href="css/style3.css" type="text/css" media="screen">
    <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.js' type='text/javascript'></script>
    <script src="js/login.js"></script>
	<script src="js/formValidation.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript"></script>
	<script src="js/cufon-yui.js" type="text/javascript"></script>
	<script src="js/BabelSans_500.font.js" type="text/javascript"></script>
	<script src="js/jquery.easing.1.3.js" type="text/javascript"></script> 
	
	
	
	<link rel="stylesheet" href="cal_file/css/core.css" type="text/css" />
	<link rel="stylesheet" href="cal_file/css/cupertino/jquery-ui.cupertino.css" type="text/css" />
		
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.1/jquery-ui.min.js"></script>
    <script src="cal_file/js/jMonthCalendar.js" type="text/javascript"></script>


	<style type="text/css" media="screen">
		#jMonthCalendar .Meeting { background-color: #DDFFFF;}
		#jMonthCalendar .Birthday { background-color: #DD00FF;}
		#jMonthCalendar #Event_3 { background-color:#0000FF; }
	</style>
	
	
	<script type="text/javascript">
        $().ready(function() {
			var options = {
				onMonthChanging: function(dateIn) {
					//this could be an Ajax call to the backend to get this months events
					//var events = [ 	{ "EventID": 7, "StartDate": new Date(2009, 1, 1), "Title": "10:00 pm - EventTitle1", "URL": "#", "Description": "This is a sample event description", "CssClass": "Birthday" },
					//				{ "EventID": 8, "StartDate": new Date(2009, 1, 2), "Title": "9:30 pm - this is a much longer title", "URL": "#", "Description": "This is a sample event description", "CssClass": "Meeting" }
					//];
					//$.jMonthCalendar.ReplaceEventCollection(events);
					return true;
				},
				onEventLinkClick: function(event) { 
					alert("event link click");
					return true; 
				},
				onEventBlockClick: function(event) { 
					alert("block clicked");
					return true; 
				},
				onEventBlockOver: function(event) {
					//alert(event.Title + " - " + event.Description);
					return true;
				},
				onEventBlockOut: function(event) {
					return true;
				},
				onDayLinkClick: function(date) { 
					alert(date.toLocaleDateString());
					return true; 
				},
				onDayCellClick: function(date) { 
					alert(date.toLocaleDateString());
					return true; 
				}
			};
			
			
			var events = [ 	{ "EventID": 1, "StartDateTime": "new Date(2009, 5, 29)", "EndDateTime": "new Date(2009, 6, 3)", "Title": "10:00 pm - EventTitle1", "URL": "#", "Description": "This is a sample event description" },
							{ "EventID": 6, "StartDateTime": "new Date(2009, 5, 29)", "EndDateTime": "new Date(2009, 6, 3)", "Title": "10:00 pm - EventTitle6", "URL": "#", "Description": "This is a sample event description" },
							{ "EventID": 7, "StartDateTime": new Date(2009, 5, 12), "Title": "10:00 pm - EventTitle7", "URL": "#", "Description": "This is a sample event description" },
							{ "EventID": 3, "StartDateTime": "2009-05-28T12:30:00.0000000", "Title": "This is a much longer title", "URL": "#", "Description": "This is a sample event description", "CssClass": "Meeting" },
							{ "EventID": 4, "StartDateTime": new Date(2009, 5, 13), "Title": "This is a much longer title", "URL": "#", "Description": "This is a sample event description", "CssClass": "Meeting" },
							{ "EventID": 5, "StartDateTime": "2009-06-03", "EndDateTime": "2009-06-14", "Title": "This is a much longer title", "URL": "#", "Description": "This is a sample event description", "CssClass": "Meeting" }
			];
			
						
			$.jMonthCalendar.Initialize(options, events);
			
			
			
			
			var extraEvents = [	{ "EventID": 8, "StartDateTime": new Date(2009, 3, 11), "Title": "10:00 pm - EventTitle1", "URL": "#", "Description": "This is a sample event description", "CssClass": "Birthday" },
								{ "EventID": 9, "StartDateTime": new Date(2009, 3, 20), "Title": "9:30 pm - this is a much longer title", "URL": "#", "Description": "This is a sample event description", "CssClass": "Meeting" }
			];
			
			$("#Button").click(function() {					
				$.jMonthCalendar.AddEvents(extraEvents);
			});
			
			$("#ChangeMonth").click(function() {
				$.jMonthCalendar.ChangeMonth(new Date(2009, 7, 7));
			});
        });
    </script>
    
    
	
	
	
	
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
		                    <input type="submit" id="login" value="로그인" />
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
                            <input type="button" id="Join" value="확인" />
                            <input type="reset" id="resetSpan" value="취소" />
                            <input type="button" id="leave" value="탈퇴" />
                        </fieldset>
                    </form>
       			</div>
      </div>
            <!-- Join Ends Here -->
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
		
		<center>
			<div id="jMonthCalendar"></div>
	
			<button id="Button">Add More Events</button>
	
			<button id="ChangeMonth">Change Month to August 2009</button>
		</center>


	</div>
	
	
	
	<%-- 프 번호 - ${requestScope.pnum}<br>
	프 이름 - ${requestScope.pname}<br>
	유 이메일 - ${sessionScope.userData.uemail}<br> --%>
	
</body>
</html>
