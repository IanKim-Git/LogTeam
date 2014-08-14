<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="topBar.jsp" flush="false" />
	<jsp:include page="leftMenu.jsp" flush="false" />
	
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Log List</title>
</head>

<script src="js/jquery-1.10.2.js"></script>
<script>var jb = jQuery.noConflict();</script>

<script type="text/javascript">
	jb(document).ready(function(){
		//��� �α׸� �ҷ����� �Լ�
		function getLogs() {
			jb.ajax({
				url : "allLogs.do", 
				type : "post",
				dataType : "json", 					//���������Ÿ��
				data : "pnum="+jb("#l_pnum").val(),
				success : function(data) {
					var table = "";
					jb("#listTable tr:gt(0)").remove();
//					<th>�α׹�ȣ</th><th>�ۼ���</th><th>�ۼ���</th><th>����</th><th>��������</th><th>���ο���</th><th>����</th>
					var count = data.list.length;
					//data.list�� �� ������ : [{no:��, name:��,...}, {no:��, name:��,...}, {no:��, name:��,...}, ...]
					jb(data.list).each(function(index, item) {//{no:��, name:��,...}
						table += "<tr><td>" + (count--) + "</td><td>" + item.l_uemail + "</td><td>" +  item.ldata + "</td><td>" +  item.ltext + "</td>";
						if(item.lpublic == 0){
							table += "<td>�����</td>";
						}else if(item.lpublic == 1){
							table += "<td>����</td>";
						}						
						table += "<td>" + item.ladmission + "</td><td><input type='button' value='����' id='del' name='"+item.lnum+"'></td></tr>";
					});
					//���̺� �߰�
					jb("#listTable tr:eq(0)").after(table);
				},
				error : function(err) {//����������
					alert(err + " : �ش� ������Ʈ���� �αװ� ���� �ۼ����� �ʾҽ��ϴ�");
				}
			});//end of ajax
		} //end of getLogs()
		
		//���� ��ư�� ������ �� �α� ����
		jb(document).on("click", "#del", function() {
			jb.ajax({
				url : "deleteLog.do", 
				type : "post",
				dataType : "text", 
				data : "lnum=" + jb(this).attr("name"),	//������ ������ ������ : <input type='button' value='����' id='del' name='"+item.no+"'>
				success : function(data) {
					if (data == "ok") {
						alert("���� ����");
						getLogs();
					} else {
						alert("���� ����");
					}
				},
				error : function(err) {//����������
					alert(err + " : �α� ���� ���� ����");
				}
			});
		});//end of �α� ����
		
		//�α� ���
		jb("#write").click(function() {
			jb.ajax({
				url : "write.do",
				type : "post",
				dataType : "text", 				
				data : jb("#writeForm").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("�α� �ۼ� ����");
						jb("textarea").val("");	
						getLogs();							
					} else if(data == "again") {
						alert("�α� �������θ� �����ϼ���.");
					} else {
						alert("�α� �ۼ� ����");
					}
				},
				error : function(data) {//200�� �� �Ѿ� ���� ��
					alert(data + ' : �α� �ۼ� ����� ���� �߻�');
				}
			}); //end of ajax
		})//end of �α� �ۼ� ����
		
		
		//�α�ȭ�� �ʱ�ȭ
		getLogs();
	});//end of ready
</script>
<body>
	<h6>�αװԽ���</h6>
	������Ʈ ��ȣ : ${requestScope.pnum}
	���� �̸��� : ${sessionScope.userData.uemail}<br>
	
	<form action="write.do" id="writeForm" method="post">
		<select id="lpublic" name="lpublic">
			<option value="-1">����</option>
			<option value="0">�����</option>
			<option value="1">����</option>
		</select><br>
		<input type="hidden" id="l_pnum" name="l_pnum" value="${requestScope.pnum}">
		<input type="hidden" id="l_uemail" name="l_uemail" value="${sessionScope.userData.uemail}">
		<textarea id="ltext" name="ltext" rows="5" cols="60" ></textarea>
		<input type="button" id="write" value="�α׵��">		
	</form>
	
	<form action="" id="logListForm">			
		<table id="listTable" cellspacing="0">
			<tr bgcolor="#FOFOF7">
				<th>�α׹�ȣ</th><th>�ۼ���</th><th>�ۼ���</th><th>����</th><th>��������</th><th>���ο���</th><th>����</th>
			</tr>
		</table>
	</form>
	
	
</body>
</html>