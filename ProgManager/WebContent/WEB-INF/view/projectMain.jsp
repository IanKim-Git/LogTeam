<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Project Main</title>
</head>
<body>
This is project Main<br>

�� ��ȣ - ${requestScope.pnum}<br>
�� �̸��� - ${sessionScope.userData.uemail}<br>
<!-- ������Ʈ ���� -->
<form action="projectInfo.do" id="projectInfo" method="post">
	<input type="submit" value="������Ʈ ����">
	<input type="hidden" name="enterProInfoPnum" value="${requestScope.pnum}">
</form>
<!-- �������� -->
<form action="announcement.do" id="announcement" method="post">
	<input type="submit" value="��������">
	<input type="hidden" name="enterAnnPnum" value="${requestScope.pnum}">
</form>
<!-- Ķ���� -->
<form action="calender.do" id="calender" method="post">
	<input type="submit" value="Ķ����">
	<input type="hidden" name="enterCalPnum" value="${requestScope.pnum}">
</form>
<!-- �αװԽ��� -->
<form action="logList.do" id="logList" method="post">
	<input type="submit" value="�αװԽ���">
	<input type="hidden" name="enterLogPnum" value="${requestScope.pnum}">
</form>
<!-- ���������� -->
<form action="outcome.do" id="outcome" method="post">
	<input type="submit" value="����������">
	<input type="hidden" name="enterOutPnum" value="${requestScope.pnum}">
</form>
<!-- ȸ����� -->
<form action="account.do" id="account" method="post">
	<input type="submit" value="ȸ�����">
	<input type="hidden" name="enterAccPnum" value="${requestScope.pnum}">
</form>
</body>
</html>
