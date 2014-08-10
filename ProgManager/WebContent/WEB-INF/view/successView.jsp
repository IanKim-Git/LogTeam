<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>${requestScope.title }</title>
</head>

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
						table += "<input type='button' value='�����ϱ�' id='enterProject' name='"+project.no+"'></td></tr>"
					});
					//���̺� �߰�
					$("#projectlistTable tr:eq(0)").after(table);
				},
				error : function(err) {//����������
					alert(err + " : ��� ������Ʈ ���� �ҷ����� ����");
				}
			}); //end of ajax
		}//end of getData()
			
		$(document).on("click", "#enterProject", function() {
			$.ajax({
				url : "enterProjectMain.do", 
				type : "post",
				dataType : "text", 
				data : "pnum=" + $(this).attr("pnum") + "&uemail=" + $("#pleader").val(),	//������ ������ ������
				success : function(data) {
					if (data == "ok") {
						alert("���� ����");
						getData();
					} else {
						alert("���� ����")
					}
				},
				error : function(err) {//����������
					alert(err + " : �л����� ���� ����")
				}
			})
		});

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
		<input type="hidden" name="email" id="email" value="${requestScope.email}"/>
	</form>
		
	
</body>
</html>
