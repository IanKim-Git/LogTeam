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
<body>
  
    <div id="bar">
        <!-- Login Starts Here -->
    	<div id="loginContainer">
	        <a href="#" id="loginButton"><span>Login</span><em></em></a>
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
 
	        <a href="#" id="JoinButton"><span>Sign in</span><em></em></a>
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
    
    <div id="menubar">
		<ul id="slidingMenu" class="slidingMenu">
			<li>
				<form action="projectInfo.do" id="projectInfo" onclick="post()" method="post">
				<input type="hidden" name="enterProInfoPnum" value="${requestScope.pnum}">
				<a href="#">home</a>
				</form>
			 <!-- <a href="http://localhost/ProgManager/projectInfo.do" >Home</a> -->
			</li>
			<li><a href="#">Info</a></li>
			<li><a href="#">Announcement</a></li>
			<li><a href="#">Calendar</a></li>
			<li><a href="#">Log board</a></li>
			<li><a href="#">Achievement</a></li>
			<li><a href="#">Account</a></li>
			</ul>
	</div>
	<script type="text/javascript">
		function post(){
			
			$("#projectInfo").submit();
		}
	</script>
	
	<div id="contents">
	
	
	</div>
	
	This is project Main<br>

	프 번호 - ${requestScope.pnum}<br>
	프 이름 - ${requestScope.pname}<br>
	유 이메일 - ${sessionScope.userData.uemail}<br>
	<!-- 프로젝트 정보 -->
	<form action="projectInfo.do" id="projectInfo" method="post">
		<input type="submit" value="프로젝트 정보">
		<input type="hidden" name="enterProInfoPnum" value="${requestScope.pnum}">
	</form>
	<!-- 공지사항 -->
	<form action="announcement.do" id="announcement" method="post">
		<input type="submit" value="공지사항">
		<input type="hidden" name="enterAnnPnum" value="${requestScope.pnum}">
	</form>
	<!-- 캘린더 -->
	<form action="calender.do" id="calender" method="post">
		<input type="submit" value="캘린더">
		<input type="hidden" name="enterCalPnum" value="${requestScope.pnum}">
	</form>
	<!-- 로그게시판 -->
	<form action="logList.do" id="logList" method="post">
		<input type="submit" value="로그게시판">
		<input type="hidden" name="enterLogPnum" value="${requestScope.pnum}">
	</form>
	<!-- 팀원성과도 -->
	<form action="outcome.do" id="outcome" method="post">
		<input type="submit" value="팀원성과도">
		<input type="hidden" name="enterOutPnum" value="${requestScope.pnum}">
	</form>
	<!-- 회계관리 -->
	<form action="account.do" id="account" method="post">
		<input type="submit" value="회계관리">
		<input type="hidden" name="enterAccPnum" value="${requestScope.pnum}">
	</form>
</body>
</html>
