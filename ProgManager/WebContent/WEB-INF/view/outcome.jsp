<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="topBar.jsp" flush="false" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Outcome</title>
</head>

<script src="js/jquery-1.10.2.js"></script>
<script>var jb = jQuery.noConflict();</script>

<script type="text/javascript">
	$(document).ready(function(){
		
});//end of ready
</script>

<body>
<img src="./images/team.png" align="left" style="margin: 3% 0 0 2%; ">
	<h1>���������� : ���߿���</h1>
	������Ʈ ��ȣ : ${requestScope.pnum}
	���� �̸��� : ${sessionScope.userData.uemail}<br>
	
	<div class='contents' style="margin-top: 5px">
	<br><hr>
	<form action="attendaceInfo.do" id="attInfo" method="post">
    	<b> <font color="#9B2626" style="font-style: oblique;" size="5">${requestScope.meeting.sdate}</font><br><br>
    	<font color="#9B2626" style="font-style: oblique;" size="5">������Ʈ �� ��ȣ : &nbsp;&nbsp;</font><br><br>
    	<font color="#9B2626" style="font-style: oblique;" size="5">�Ⱓ : &nbsp;&nbsp;</font><br><br>
    	<font color="#9B2626" style="font-style: oblique;" size="5">������Ʈ ���� ��Ȳ:</font>&nbsp;&nbsp;
    </form>
    </div>
</body>

<jsp:include page="bottomMenu.jsp" flush="true"/>
</html>
