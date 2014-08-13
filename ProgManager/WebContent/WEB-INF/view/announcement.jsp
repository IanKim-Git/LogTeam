<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Announcement</title>
</head>
<script src="js/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//��� ���������� �ҷ����� �Լ�
		function getAns() {
			$.ajax({
				url : "allAns.do", 
				type : "post",
				dataType : "json", 					//���������Ÿ��
				data : "pnum="+$("#an_pnum").val(),
				success : function(data) {
					var table = "";
					$("#listTable tr:gt(0)").remove();
//					<th>��ȣ</th><th>����</th><th>��¥</th><th>�����</th><th>�߿䵵</th><th>����</th>
					var count = data.list.length;
					//data.list�� �� ������ : [{no:��, name:��,...}, {no:��, name:��,...}, {no:��, name:��,...}, ...]
					$(data.list).each(function(index, item) {//{no:��, name:��,...}
						table += "<tr><td>" + (count--) + "</td><td>" + item.ancontent + "</td><td>" +  item.andate + "</td><td>" +  item.an_uemail + "</td>";
						if(item.animportance == 3){
							table += "<td>��</td><td>";
						}else if(item.animportance == 2){
							table += "<td>��</td><td>";
						}else if(item.animportance == 1){
							table += "<td>��</td><td>";
						}						
						table += "<input type='button' value='����' id='del' name='"+item.annum+"'></td></tr>";
					});
					//���̺� �߰�
					$("#listTable tr:eq(0)").after(table);
				},
				error : function(err) {//����������
					alert(err + " : �ش� ������Ʈ���� ���������� ���� �ۼ����� �ʾҽ��ϴ�");
				}
			});//end of ajax
		} //end of getAns()
		
		//���� ��ư�� ������ �� �������� ����
		$(document).on("click", "#del", function() {
			$.ajax({
				url : "deleteAn.do", 
				type : "post",
				dataType : "text", 
				data : "annum=" + $(this).attr("name"),	//������ ������ ������ : <input type='button' value='����' id='del' name='"+item.no+"'>
				success : function(data) {
					if (data == "ok") {
						alert("���� ����");
						getAns();
					} else {
						alert("���� ����");
					}
				},
				error : function(err) {//����������
					alert(err + " : �������� ���� ���� ����");
				}
			});
		});//end of �������� ����
		
		//�������� ���
		$("#anWrite").click(function() {
			$.ajax({
				url : "writeAn.do",
				type : "post",
				dataType : "text", 				
				data : $("#anWriteForm").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("�������� �ۼ� ����");
						$("textarea").val("");	
						getAns();							
					} else if(data == "again") {
						alert("�������� �߿䵵�� �����ϼ���.");
					} else {
						alert("�������� �ۼ� ����");
					}
				},
				error : function(data) {//200�� �� �Ѿ� ���� ��
					alert(data + ' : �������� �ۼ� ����� ���� �߻�');
				}
			}); //end of ajax
		});//end of �������� �ۼ� ����
		
		
		//�������� ȭ�� �ʱ�ȭ
		getAns();
	});//end of ready
</script>
<body>

	<h6>��������</h6>
	������Ʈ ��ȣ : ${requestScope.pnum}
	���� �̸��� : ${sessionScope.userData.uemail}<br>
	<form action="writeAn.do" id="anWriteForm" method="post">
		<select id="animportance" name="animportance">
			<option value="-1">����</option>
			<option value="3">��</option>
			<option value="2">��</option>
			<option value="1">��</option>
		</select><br>
		<input type="hidden" id="an_pnum" name="an_pnum" value="${requestScope.pnum}">
		<input type="hidden" id="an_uemail" name="an_uemail" value="${sessionScope.userData.uemail}">
		<textarea id="ancontent" name="ancontent" rows="5" cols="60" ></textarea>
		<input type="button" id="anWrite" value="���">		
	</form>
	
	<form action="" id="anListForm">			
		<table id="listTable" cellspacing="0">
			<tr bgcolor="#FOFOF7">
				<th>��ȣ</th><th>����</th><th>��¥</th><th>�����</th><th>�߿䵵</th><th>����</th>
			</tr>
		</table>
	</form>
</body>
</html>