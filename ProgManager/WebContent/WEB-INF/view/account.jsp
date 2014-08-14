<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="topBar.jsp" flush="false" />
	<jsp:include page="leftMenu.jsp" flush="false" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Account</title>
</head>

<script src="js/jquery-1.10.2.js"></script>
<script src="js/formValidation.js"></script>
<script>var jb = jQuery.noConflict();</script>
<script type="text/javascript">
	jb(document).ready(function(){
		//��� ȸ�� ����� �ҷ����� �Լ�
		function getAcs() {
			jb.ajax({
				url : "allAcs.do", 
				type : "post",
				dataType : "json", 					//���������Ÿ��
				data : "pnum="+jb("#ac_pnum").val(),
				success : function(data) {
					var table = "";
					jb("#listTable tr:gt(0)").remove();
//	<th>��ȣ</th><th>����</th><th><font color="green"><b>+</b></font></th><th><font color="red"><b>-</b></font></th><th>����</th>
					var sumPlus = 0;
					var sumMinus = 0;
					jb(data.list).each(function(index, item) {
						table += "<tr><td>" + (index + 1) + "</td><td>" + item.accontents + "</td><td>" +  item.acplus + "</td><td>" +  item.acminus + "</td>";
						table += "<td><input type='button' value='����' id='del' name='"+item.acnum+"'></td></tr>";
						sumPlus += item.acplus;
						sumMinus += item.acminus;
					});
					//���̺� �߰�
					jb("#listTable tr:eq(0)").after(table);
					//��밡�ɱݾ� ���
					jb("#acTotal").val(sumPlus-sumMinus);
				},
				error : function(err) {//����������
					alert(err + " : �ش� ������Ʈ���� ���������� ���� �ۼ����� �ʾҽ��ϴ�");
				}
			});//end of ajax
		} //end of getAcs()
		
		//���� ��ư�� ������ �� ȸ���� ����
		jb(document).on("click", "#del", function() {
			jb.ajax({
				url : "deleteAc.do", 
				type : "post",
				dataType : "text", 
				data : "acnum=" + jb(this).attr("name"),	
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
		
		//�ҵ濡 �Է��ϸ� ���⿡ �Է� �� �ϰ�
		jb("#acplus").keyup(function(){
			var isValid = isNumValid(jb("#acplus").val());
			if(!isValid){
				jb("p").html("<font color='red'>���ڸ� �Է��ϼ���.</font>");
				jb("#acplus").val("0");
			}else{
				jb("p").html("");
			}
			
		});
		
		//���⿡ �Է��ϸ� �ҵ濡 �Է� �� �ϰ�
		jb("#acminus").keyup(function(){
			var isValid = isNumValid(jb("#acminus").val());
			if(!isValid){
				jb("p").html("<font color='red'>���ڸ� �Է��ϼ���.</font>");
				jb("#acminus").val("0");
			}else{
				jb("p").html("");
				
			}
			
		});		
		
		jb("#accontents").click(function(){
			jb("#accontents").text("");
			jb("#accontents").val("");
		});
		
		jb("#accontents").blur(function(){
			if(jb("#accontents").val() == ""){
				jb("#accontents").val("������ �Է��ϼ���");
			}
			
		});
		
		//ȸ�� ���
		jb("#acWrite").click(function() {
			if(jb("#acminus").val() != 0 && jb("#acplus").val() !="0"){
				jb("p").html("<font color='red'>�����̳� ���� �� �� �ϳ��� �Է��ϼ���.</font>");
			}else if(jb("#acminus").val() =="0"&& jb("#acplus").val() =="0"){
				jb("p").html("<font color='red'>�����̳� ���� �� �� �ϳ��� �Է��ϼ���.</font>");
			}else{
//				jb("p").html("<font color='green'>�������</font>");
				jb.ajax({
					url : "writeAc.do",
					type : "post",
					dataType : "text", 				
					data : jb("#acWriteForm").serialize(),
					success : function(data) {
						if (data == "ok") {
							alert("ȸ�� �ۼ� ����");
							jb("textarea").val("������ �Է��ϼ���");
							jb("input[type=text]").val(0);
							getAcs();							
						} else {
							alert("ȸ�� �ۼ� ����");
						}
					},
					error : function(data) {//200�� �� �Ѿ� ���� ��
						alert(data + ' : ȸ�� �ۼ� ����� ���� �߻�');
					}
				}); //end of ajax
			}
			
		});//end of ȸ�� �ۼ� ����
		 
		//ȸ����� ȭ�� �ʱ�ȭ
		getAcs();
		jb("#accontents").val("������ �Է��ϼ���");
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
	</form><br>
	��밡�ɱݾ� : <input type="text" id="acTotal" readonly="readonly" /><br>
<%-- 	insert into account (ac_pnum, acnum, acplus, acminus, accontents)
		values (#{ac_pnum}, seq_ac.nextval, #{acplus}, #{acminus}, #{accontents}) --%>
	<form action="writeAc.do" id="acWriteForm" method="post">
		<input type="hidden" id="ac_pnum" name="ac_pnum" value="${requestScope.pnum}">
		���� <textarea id="accontents" name="accontents" rows="1" cols="40" ></textarea><br>
		���� <input type="text" id="acplus" name="acplus" value="0"/>
		���� <input type="text" id="acminus" name="acminus" value="0"/>
		<input type="button" id="acWrite" value="���">
	</form>
	<p></p>
</body>
</html>
