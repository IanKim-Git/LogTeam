<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Account</title>
</head>
<script src="js/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//��� ȸ�� ����� �ҷ����� �Լ�
		function getAcs() {
			$.ajax({
				url : "allAcs.do", 
				type : "post",
				dataType : "json", 					//���������Ÿ��
				data : "pnum="+$("#ac_pnum").val(),
				success : function(data) {
					var table = "";
					$("#listTable tr:gt(0)").remove();
//	<th>��ȣ</th><th>����</th><th><font color="green"><b>+</b></font></th><th><font color="red"><b>-</b></font></th><th>����</th>
					var sumPlus = 0;
					var sumMinus = 0;
					$(data.list).each(function(index, item) {
						table += "<tr><td>" + (index + 1) + "</td><td>" + item.accontents + "</td><td>" +  item.acplus + "</td><td>" +  item.acminus + "</td>";
						table += "<td><input type='button' value='����' id='del' name='"+item.acnum+"'></td></tr>";
						sumPlus += item.acplus;
						sumMinus += item.acminus;
					});
					//���̺� �߰�
					$("#listTable tr:eq(0)").after(table);
					//��밡�ɱݾ� ���
					$("#acTotal").val(sumPlus-sumMinus);
				},
				error : function(err) {//����������
					alert(err + " : �ش� ������Ʈ���� ���������� ���� �ۼ����� �ʾҽ��ϴ�");
				}
			});//end of ajax
		} //end of getAcs()
		
		//���� ��ư�� ������ �� ȸ���� ����
		$(document).on("click", "#del", function() {
			$.ajax({
				url : "deleteAc.do", 
				type : "post",
				dataType : "text", 
				data : "acnum=" + $(this).attr("name"),	
				success : function(data) {
					if (data == "ok") {
						alert("���� ����");
						getAcs();
					} else {
						alert("���� ����");
					}
				},
				error : function(err) {//����������
					alert(err + " : ȸ�� ���� ���� ����");
				}
			});
		});//end of ȸ�� ���� 
		/*
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
						getAcs();							
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
		 */
		//ȸ����� ȭ�� �ʱ�ȭ
		getAcs();
	});//end of ready

</script>
<body>
	<h6>ȸ�����</h6>
	������Ʈ ��ȣ : ${requestScope.pnum}
	���� �̸��� : ${sessionScope.userData.uemail}<br>
	<form action="" id="acListForm">			
		<table id="listTable" cellspacing="0">
			<tr bgcolor="#FOFOF7">
				<th>��ȣ</th><th>����</th><th><font color="green"><b>+</b></font></th><th><font color="red"><b>-</b></font></th><th>����</th>
			</tr>
		</table>
	</form>
	��밡�ɱݾ� : <input type="text" id="acTotal" readonly="readonly" />
<%-- 	insert into account (ac_pnum, acnum, acplus, acminus, accontents)
		values (#{ac_pnum}, seq_ac.nextval, #{acplus}, #{acminus}, #{accontents}) --%>
	<form action="writeAc.do" id="acWriteForm" method="post">
		<input type="hidden" id="ac_pnum" name="ac_pnum" value="${requestScope.pnum}">
		<textarea id="accontents" name="accontents" rows="1" cols="40" ></textarea>
		<input type="text" id="acplus" name="acplus" />
		<input type="text" id="acminus" name="acminus" />
<!-- 		<textarea id="acplus" name="acplus" rows="1" cols="20" ></textarea>
		<textarea id="acminus" name="acminus" rows="1" cols="20" ></textarea> -->
		<input type="button" id="acWrite" value="���">
	</form>
</body>
</html>