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
					var div = "";
					var input = "";
					var table = "";
					jb("#setLogs").children().remove();
					/*
					<div class="logContent">
						<table id="logTable">
							<tr>
								<td>�ۼ���</td>
								<td>����</td>
								<td>�ۼ���</td>
								<td>��������</td>
								<td>���ο���</td>
							</tr>
						</table>
					</div>
					<div class='lcContent'>
						<form action="writeLc.do" id="writeLcForm" method="post">
							<input type="hidden" id="c_lnum" name="c_lnum" value="">
							<input type="hidden" id="c_uemail" name="c_uemail" value="">
							<input type="hidden" id="c_l_pnum" name="c_l_pnum" value="">
							<table>
								<tbody id="commentBody">
								</tbody>
								<tfoot id="writeComment">
									<tr>
										<td><textarea id="ctext" name="ctext" rows="2" cols="30"></textarea></td>
										<td><input type="button" id="writeLc" value="�ڸ�Ʈ���"></td>
									</tr>
								</tfoot>
							</table>
						</form>
					</div><!-- end of comment -->
					
					div += "<div class='lcContent'><form action='writeLc.do' id='writeLcForm' method='post'></form></div>";
					input = "<input type='hidden' id='c_lnum' name='c_lnum'><input type='hidden' id='c_uemail' name='c_uemail'><input type='hidden' id='c_l_pnum' name='c_l_pnum'>";
					jb("#writeLcForm").html(input);
					jb("#c_lnum").val(item.lnum);
					jb("#c_uemail").val() = jb("#l_uemail").val();
					jb("#c_l_pnum").val(item.l_pnum);
					table = "<table><tbody id='commentBody'></tbody><tfoot id='writeComment'><tr>"+
							"<td><textarea id='ctext' name='ctext' rows='2' cols='30'></textarea></td>"+
							"<td><input type='button' id='writeLc' value='�ڸ�Ʈ���'></td></tr></tfoot></table>";
					jb()
						
					
				
					*/
					 jb(data.list).each(function(index, item) {//{no:��, name:��,...}
						div += "<div class='logContent' id='"+ item.lnum +"'><table id='logTable'><tr><td>"+ item.l_uemail +"</td><td>"+ item.ltext +"</td>";
						
						div += "<td>"+ item.ldata + "</td>";
						if(item.lpublic == 0){
							div += "<td>�����</td>";
						}else if(item.lpublic == 1){
							div += "<td>����</td>";
						}
						div += "<td>"+ item.ladmission +"</td></tr></table></div>";
						div += "<div class='lcContent'><form action='writeLc.do' id='writeLcForm' method='post'></form></div>";
						//div += "<td><input type='button' value='�ڸ�Ʈ ���' id='addLc' name='"+ item.lnum +"'></td></tr></table></div>";
						/*
						<form id='lcWriteForm' method='post' action=''>
							<input type='hidden' id='c_lnum' name='c_lnum' value=''>
							<input type='hidden' id='c_l_pnum' name='c_l_pnum' value=''>
							<input type='button' value='�ڸ�Ʈ ���' id='addLc'>
						</form>
						*/
//						getLcs(item.lnum, item.l_pnum);
					});
					jb("#setLogs").html(div); 
				},
				error : function(err) {//����������
					alert(err + " : �ش� ������Ʈ���� �αװ� ���� �ۼ����� �ʾҽ��ϴ�");
				}
			});//end of ajax
		} //end of getLogs()
		
		//�ڸ�Ʈ ��� �ʱ�ȭ(�ϴ� �ڸ�Ʈ�� ������)
		function getLcs(c_lnum, c_l_pnum){
			jb.ajax({
				url : "allLcs.do", 
				type : "post",
				dataType : "json", 		
				data : "lnum="+c_lnum+"&pnum="+c_l_pnum,
				success : function(data) {
					var comments = "";
					/*
					<tbody id="commentBody">
						<tr>
							<td>-��</td>
							<td>�ۼ���</td>
							<td>����</td>
							<td>�ۼ���</td>
							<td>�ڸ�Ʈ����</td>
						</tr>
						<tr>
							<td>-��</td>
							<td>�ۼ���</td>
							<td>����</td>
							<td>�ۼ���</td>
							<td>�ڸ�Ʈ����</td>
						</tr>
					</tbody>
					*/
					 jb(data.list).each(function(index, item) {//{no:��, name:��,...}
						
					});
					return comments;
				},
				error : function(err) {//����������
					alert(err + " : �ش� ������Ʈ���� �ڸ�Ʈ�� ���� �ۼ����� �ʾҽ��ϴ�");
				}
			});//end of ajax
		}//end of getLcs()
		
		/* 
		//�ڸ�Ʈ ��� ��ư�� ������ �� �ڸ�Ʈ ���
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
		 */
		//�α� ���
		jb("#write").click(function() {
			if(jb("#ltext").val() == ""){
				alert("������ �Է��ϼ���.");
			}else{
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
			}
		});//end of �α� �ۼ� ����
		
		
		//�α�ȭ�� �ʱ�ȭ
		getLogs();
	});//end of ready
</script>
<body>
	<h6>�αװԽ���</h6>
	������Ʈ ��ȣ : ${requestScope.pnum}
	���� �̸��� : ${sessionScope.userData.uemail}<br>
	
	<!-- �α� ȭ�� -->
	<div id="logsView" align="left">
		<fieldset>
			<!-- �α� ���â -->
			<div id="writeLog">
				<form action="write.do" id="writeForm" method="post">
					<input type="hidden" id="l_pnum" name="l_pnum" value="${requestScope.pnum}">
					<input type="hidden" id="l_uemail" name="l_uemail" value="${sessionScope.userData.uemail}">
					<table>
						<!-- ���� -->
						<tr>
							<th rowspan="5">
								<textarea id="ltext" name="ltext" rows="5" cols="60" ></textarea>
							</th>
						</tr>
						<!-- �������� -->
						<tr>
							<td>
							<select id="lpublic" name="lpublic">
								<option value="-1">����</option>
								<option value="0">�����</option>
								<option value="1">����</option>
							</select>
							</td>
						</tr>
						<tr><td></td></tr>
						<tr><td></td></tr>
						<!-- ��Ϲ�ư -->
						<tr>
							<td>
								<input type="button" id="write" value="�α׵��">
							</td>
						</tr>
					</table>				
				</form>
			</div><!-- end of writeLog -->
			
			
			<!-- �α� ��� -->
			<div id="logsList">
				<!-- jQuery �Լ� ����� ���ؼ� ���� -->
				<div id="setLogs">
					
					<!-- �α׸��� �ڸ�Ʈ â�� �޷��� �Ѵ�. -->
					<!-- �ڸ�Ʈ ��� ��ư�� ������ �ڸ�Ʈ ����� �񵿱�� �ٲ��� �Ѵ�. -->
					<!-- �ڸ�Ʈ�� �ۼ��ڸ� ������ �� �ִ�. -->
					<!-- <table id="listTable" cellspacing="0">
						<tr bgcolor="#FOFOF7" >
							<th>�α׹�ȣ</th><th>�ۼ���</th><th>�ۼ���</th><th>����</th><th>��������</th><th>���ο���</th><th>�ڸ�Ʈ���</th>
						</tr>
					</table> -->
					<div class="logContent">
						<table id="logTable">
							<tr>
								<td>�ۼ���</td>
								<td>����</td>
								<td>�ۼ���</td>
								<td>��������</td>
								<td>���ο���</td>
							</tr>
						</table>
					</div>
					<!-- jb("")
						 jb(".logContent").after(".lcContent");
						 jb("#c_lnum").val(c_lnum);
						 jb("#c_uemail").val(c_uemail);
						 jb("#c_l_pnum").val(c_l_pnum);
						 jb("#commentBody").html();
					
					 -->
					<div class='lcContent'>
						<form action="writeLc.do" id="writeLcForm" method="post">
							<input type="hidden" id="c_lnum" name="c_lnum" value="">
							<input type="hidden" id="c_uemail" name="c_uemail" value="">
							<input type="hidden" id="c_l_pnum" name="c_l_pnum" value="">
							<table>
								<tbody id="commentBody">
									<tr>
										<td>-��</td>
										<td>�ۼ���</td>
										<td>����</td>
										<td>�ۼ���</td>
										<td>�ڸ�Ʈ����</td>
									</tr>
									<tr>
										<td>-��</td>
										<td>�ۼ���</td>
										<td>����</td>
										<td>�ۼ���</td>
										<td>�ڸ�Ʈ����</td>
									</tr>
								</tbody>
								<tfoot id="writeComment">
									<tr>
										<td><textarea id="ctext" name="ctext" rows="2" cols="30"></textarea></td>
										<td><input type="button" id="writeLc" value="�ڸ�Ʈ���"></td>
									</tr>
								</tfoot>
							</table>
						</form>
					</div><!-- end of comment -->
					
				</div><!-- end if setLogs -->
				
			</div><!-- end of logsList -->	
			
			
			
		</fieldset>	
	</div><!-- end of logsView -->	
</body>
</html>
