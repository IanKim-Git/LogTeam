<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Project Main</title>
     <script src='https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.js' type='text/javascript'></script>
     <script src="js/login.js"></script>

	 <link rel="stylesheet" href="css/style3.css" type="text/css" media="screen">
		
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


<body>
    
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
	<%-- 프 번호 - ${requestScope.pnum}<br>
	프 이름 - ${requestScope.pname}<br>
	유 이메일 - ${sessionScope.userData.uemail}<br> --%>
	
</body>
</html>
