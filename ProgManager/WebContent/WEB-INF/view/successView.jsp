<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>${requestScope.title }</title>
</head>
<%
	String email = (String)request.getAttribute("email");
	String pw = (String)request.getAttribute("pw");
	String name = (String)request.getAttribute("name");
	String phone = (String)request.getAttribute("phone");
	
	HashMap userData = new HashMap();
	userData.put("uemail", email);
	userData.put("upw", pw);
	userData.put("uname", name);
	userData.put("uphone", phone);
	session.setAttribute("userData", userData);

%>
<script src="js/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(document).ready(	function() {
			
		var pleader = $("#pleader").val();
			
		// ������Ʈ �����ϱ� ��ư�� Ŭ�������� project table�� ����Ǵ� ����
		$("#btn").click(function() {
			$.ajax({
				url : "newProject.do",
				type : "post",
				dataType : "text", 
				data : $("#newproform").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("������Ʈ ���� �Ϸ�");
						$("input[type=text]").val("");	//text�ڽ� ��� �����
						$("input[type=password]").val("");
						$("#pleader").val(pleader);
						getData();							//��緹�ڵ� �˻��ϴ� �Լ� ȣ��
					} else {
						alert("���� ����");
					}
				},
				error : function(data) {
					alert(data + ' : ���Է��� ����� ���� �߻�');
				}
			}); //end of ajax
		});//end of ���Է���

		// �ش� ������ email�� ��ϵ� ��� ������Ʈ �˻� �� ���
		function getData() {
			$.ajax({
				url : "getProjectList.do",
				data : "uemail=" + $("#pleader").val(),
				type : "post",
				dataType : "json", 					//���������Ÿ��
				success : function(data) {
					var table = "";
					//������ �ִ� ���̺� ù�ุ ���� �����
					//http://www.w3schools.com/jquery/tryit.asp?filename=tryjquery_sel_gt
					$("#projectlistTable tr:gt(0)").remove();
					
					$(data.list).each(function(index, project) {
						table += "<tr><td>" + project.pnum + "</td><td>" + project.pname + "</td><td>" +  project.pmento + "</td>";
						table += "<td>" + project.pstart + "</td><td>" + project.pend + "</td><td>" + project.pleader + "</td><td>";
						table += "<form action='enterProjectMain.do' id='enterProject' method='post'><input type='submit' value='�����ϱ�'/>";
						table += "<input type='hidden' id='pnum' name='pnum' value='"+project.pnum+"'/>";
						table += "<input type='hidden' id='uemail' name='uemail' value='"+$("#curUser").val()+"'/></form>";
						
					});
					//���̺� �߰�
					$("#projectlistTable tr:eq(0)").after(table);
				},
				error : function(err) {//����������
					alert(err + " : ��� ������Ʈ ���� �ҷ����� ����");
				}
			}); //end of ajax
		}//end of getData()
		

		//���ڵ� ��������� �Լ� ȣ��
		getData();

	});//end of ready()
</script>

<body>
	�̸��� - ${requestScope.email}<br>
	��й�ȣ - ${requestScope.pw}<br>
	�̸� - ${requestScope.name}<br>
	��ȭ��ȣ - ${requestScope.phone}<br>
	
	<br><hr><br>
	
	<h2>New Project</h2>
	<input type="hidden" id="curUser" name="curUser" value="${requestScope.email}">
	<form name="newProject.do" id="newproform" method="post">
		Project Name <input type="text"  name="pname" /><br>
		Project PassWord <input type="password" name="ppw" /><br>
		Project Mendo ID <input type="text" name="pmento" /><br>
		Project Start Date <input type="text" name="pstart" /><br>
		Project End Date <input type="text" name="pend" /><br>
		Project Leader <input type="text" name="pleader" id="pleader" value="${requestScope.email}"/><br>
		<input type="button" value="�����ϱ�" id="btn">
	</form>
	
	<input type="button" value="�׽�Ʈ" onclick="">
	
	<h2>��� ������Ʈ ���� ����</h2>
		<table cellspacing="0">
			<tr>
				<td style="text-align: right">
					<input type="button" value="��� �л� ���� ����">
				</td>
			</tr>
		</table>
		<table id="projectlistTable" cellspacing="0">
			<tr bgcolor="#FOFOF7">
				<th>������Ʈ ��ȣ</th><th>�̸�</th><th>�����</th><th>������</th><th>������</th><th>����</th><th>����</th>
			</tr>
			
		</table>
	
	<!-- <a href="WEB-INF/view/updateInfo.jsp">�������� ���� ȭ��</a> -->
	<!-- <input type="button" value="�����ϱ�"	Onclick="location.href='updateInfo.jsp'"> -->
	<form action="sendEmail.do" id="userEmail" method="post">
		<input type="submit" value="�������� �����ϱ�"/>
	</form>
		
	
</body>
</html>
