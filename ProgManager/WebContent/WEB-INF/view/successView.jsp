<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�α��� ���� ȭ��</title>
</head>
<body>
	�̸��� - ${requestScope.email}<br>
	��й�ȣ - ${requestScope.pw}<br>
	�̸� - ${requestScope.name}<br>
	��ȭ��ȣ - ${requestScope.phone}<br>
	
	<br><hr><br>
	
	<h2>New Project</h2>
	<form action="newProject.do" method="post">
		Project Name <input type="text"  name="pname" /><br>
		Project PassWord <input type="password" name="ppw" /><br>
		Project Mendo ID <input type="text" name="pmento" /><br>
		Project Start Date <input type="text" name="pstart" /><br>
		Project End Date <input type="text" name="pend" /><br>
		Project Leader <input type="text" name="pleader" /><br>
		<input type="submit" value="�����ϱ�">
	</form>
	
</body>
</html>