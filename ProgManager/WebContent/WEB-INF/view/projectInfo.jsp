<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Project Information</title>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/init.js" type="text/javascript"></script>
<script src="js/jquery-1.10.2.js"></script>
</head>

<body>
	<h6>������Ʈ ȭ��</h6>
	������Ʈ ��ȣ : ${requestScope.pnum}
	���� �̸��� : ${sessionScope.userData.uemail}<br>
	
	<div class='contents' align="left" style="margin-top: 40px">
    	<b> <font color="4682B4" style="font-style: oblique;">������Ʈ �̸� </font><br><br>
    	<font color="4682B4" style="font-style: oblique;">������Ʈ �� ��ȣ : </font><br><br>
    	<font color="4682B4" style="font-style: oblique;">�Ⱓ : </font><br><br>
    	<font color="4682B4" style="font-style: oblique;">���൵ :</font></b>
    	
    	<div class="wrap">
			<div class="bar">
				<div class="percent">
					<span style="width: 100%;"></span>
				</div>
				<div class="circle">
					<span>0%</span>
				</div>
			</div>
			<div class="text">
				<input type="text" class="input" value="0" />
			</div>			
		</div>
		
		<b><font color="4682B4" style="font-style: oblique;">���� ���� : &nbsp;</font></b>
		
		<form action="" id="logListForm">			
		<table align="left" border="2" id="listTable" cellspacing="3">
			<tr bgcolor="87CEEB">
				<th>�� ��</th><th>�г���</th><th>�ڵ��� ��ȣ</th><th>����</th>
			</tr>
		</table>
	</form>
    </div>	
    
</body>
</html>