<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
 <link rel="stylesheet" href="footer_menu/demo.css?v=2">

</head>

<script type="text/javascript">
   
	function onidPwCheck(){
		$("#idPwCheck").submit();
	}
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
	/* function onoutcome(){
		$("#outcome").submit();
	} */
	function onaccount(){
		$("#account").submit();
	}
</script>


<body>
    
  <div id="dock-wrapper">
    <div class="dock">
      <div class="dock-front" align="center">
    	    <img src="footer_menu/arrow-up.png" alt="Arrow Up" id="arrow-up" />
      </div>
      <div class="dock-top" align="center">
    	    <img src="footer_menu/arrow-down.png" alt="Arrow Down" id="arrow-down" />
      </div>
    </div>
    
    <div class="item">
    	<img src="footer_menu/iconmonstr-home-6-icon-64.png" width="60" onclick="onidPwCheck()"/>
    	<img src="footer_menu/iconmonstr-info-2-icon-64.png" width="60" onclick="onprojectInfo()"/>
    	<img src="footer_menu/iconmonstr-megaphone-3-icon-64.png" width="60" onclick="onannouncement()"/>
    	<img src="footer_menu/iconmonstr-calendar-4-icon-64.png" width="60" onclick="calender()"/>
    	<img src="footer_menu/iconmonstr-note-19-icon-64.png" width="60" onclick="onlogList()"/>
       	<!-- <img src="footer_menu/iconmonstr-line-chart-3-icon-64.png" width="60" onclick="onoutcome()"/>  -->
      	<img src="footer_menu/iconmonstr-coin-2-icon-64.png" width="60" onclick="onaccount()"/>     	 	

 	    <form action="idPwCheck.do" id="idPwCheck" onclick="onidPwCheck()" method="post">
 			<input type="hidden" name="email" value="${sessionScope.userData.uemail}">
			<input type="hidden" name="pw" value="${sessionScope.userData.upw }">
		</form>
		<form action="projectInfo.do" id="projectInfo" onclick="onprojectInfo()" method="post">
			<input type="hidden" name="pnum" value="${requestScope.pnum}">
		</form>
		<form action="announcement.do" id="announcement" onclick="onannouncement()" method="post">
			<input type="hidden" name="enterAnnPnum" value="${requestScope.pnum}">
		</form>
    	<form action="calender.do" id="calender" onclick="calender()" method="post">
			<input type="hidden" name="enterCalPnum" value="${requestScope.pnum}">
		</form>
    	<form action="logList.do" id="logList" onclick="onlogList()" method="post">
			<input type="hidden" name="enterLogPnum" value="${requestScope.pnum}">
		</form>
    	<%-- <form action="outcome.do" id="outcome" onclick="onoutcome()" method="post">
			<input type="hidden" name="enterOutPnum" value="${requestScope.pnum}">
		</form> --%>
		<form action="account.do" id="account" onclick="onaccount()" method="post">
			<input type="hidden" name="enterAccPnum" value="${requestScope.pnum}">
		</form>
    </div>
  </div>
  
  <script>!window.jQuery && document.write(unescape('%3Cscript src="footer_menu/jquery-1.7.2.min.js"%3E%3C/script%3E'))</script>
  <script src="footer_menu/demo.js"></script>
  <script src="footer_menu/modernizr.custom.34807.js"></script>
  <script> if(!Modernizr.csstransforms3d) document.getElementById('information').style.display = 'block'; </script>
	
	
</body>
</html>
