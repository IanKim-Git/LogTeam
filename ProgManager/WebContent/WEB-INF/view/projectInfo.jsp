<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

ȸ������? ${requestScope.puser.uemil}


	<br>&nbsp;&nbsp;&nbsp;
	<table id="projectlistTable" cellspacing="2" border="1" cellpadding="8" title="������Ʈ ����">
		<tr bgcolor="#FOFOF7">
			<th>������Ʈ ��ȣ</th><th>�̸�</th><th>�����</th><th>������</th><th>������</th><th>����</th><th>���Ῡ��</th>
			
			<tr><td>${requestScope.pnum}</td>
				<td>${requestScope.pinfo.pname}</td>
				<td>${requestScope.pinfo.pmento}</td>
				<td>${requestScope.pinfo.pstart}</td>
				<td>${requestScope.pinfo.pend}</td>
				<td>${requestScope.pinfo.pleader}</td>
				<td>${requestScope.pinfo.pterminate}</td>
			</tr>
		</tr>
	</table>


</body>
</html>