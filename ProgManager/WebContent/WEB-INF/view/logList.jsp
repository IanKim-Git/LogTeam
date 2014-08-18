<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		var vLnum;
		var vCtext;
		//��� �α׸� �ҷ����� �Լ�
		function getLogs() {
			jb.ajax({
				url : "allLogs.do", 
				type : "post",
				dataType : "json", 					//���������Ÿ��
				data : "pnum="+jb("#l_pnum").val(),
				success : function(data) {
					var div = "";
					jb("#setLogs").children().remove();
//					alert(data.clist.length);
					jb(data.list).each(function(index, item) {//{no:��, name:��,...}
						//�α� div
					 	div += "<div class='logContent' id='"+ item.lnum +"'><table id='logTable'><tr><td>��  </td><td>"+ item.l_uemail +"</td><td>"+ item.ltext +"</td></tr>";
						div += "<tr>";
						if(item.lpublic == 0){
							div += "<td>�����</td>";
						}else if(item.lpublic == 1){
							div += "<td>����</td>";
						}
						div += "<td>"+ item.ladmission +"</td><td>"+ item.ldata + "</td></tr></table></div>";
						//div += "<td><input type='button' value='�ڸ�Ʈ ���' id='addLc' name='"+ item.lnum +"'></td></tr></table></div>";
						
						//�ش� �α��� �ڸ�Ʈ ��� div
						div += "<div class='lcContent'>";
						div += "<table><tbody id='commentBody'>";
						jb(data.clist).each(function(index, citem) {//{no:��, name:��,...}
							if(citem.c_lnum == item.lnum){
								div += "<tr><td>��</td>";
								div += "<td>"+citem.c_uemail+"</td>";
								div += "<td>"+citem.ctext+"</td>";
								div += "<td>"+ citem.cdate +"</td>";
								if(citem.c_uemail == jb("#l_uemail").val()){
									div += "<td><input type='button' value='����' id='del' name='"+citem.cnum+"'></td></tr>";
								}
							}	
						});	
						div += "</tbody></table></div>";
						
						//�ڸ�Ʈ �ۼ�â div
						div += "<div class='lcWrite'><form action='writeLc.do' class='writeLcForm' id='writeLcForm"+ item.lnum +"' method='post'>";
						div += "<input type='hidden' class='c_lnum' id='c_lnum"+ item.lnum +"' name='c_lnum' value='"+ item.lnum +"'>";
						div += "<input type='hidden' class='uemail' id='c_uemail"+ item.lnum +"' name='c_uemail'>";
						div += "<input type='hidden' id='c_l_pnum"+ item.lnum +"' name='c_l_pnum' value="+jb("#l_pnum").val()+">";
						div += "<table><tfoot id='writeComment"+ item.lnum +"'><tr><td><textarea id='ctext"+ item.lnum +"' name='ctext' rows='2' cols='30'></textarea></td>";
						div += "<td><input type='button' id='writeLc' value='�ڸ�Ʈ���'></td></tr></tfoot></table>";
						
						div += "</form></div>";
					});
					jb("#setLogs").html(div);
					jb(".uemail").val(jb("#l_uemail").val());
				},
				error : function(err) {//����������
					alert(err + " : �ش� ������Ʈ���� �αװ� ���� �ۼ����� �ʾҽ��ϴ�");
				}
			});//end of ajax
		} //end of getLogs()
		
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
		
		//�ڸ�Ʈ ���� ��ư�� ������ �� �ڸ�Ʈ ����
		jb(document).on("click", "#del", function() {
//			alert(jb(this).attr("name") + "���� ����");
			jb.ajax({
				url : "deleteLc.do", 
				type : "post",
				dataType : "text", 
				data : "cnum=" + jb(this).attr("name"),
				success : function(data) {
					if (data == "ok") {
						alert("���� ����");
						getLogs();
					} else {
						alert("���� ����");
					}
				},
				error : function(err) {//����������
					alert(err + " : �ڸ�Ʈ ���� ���� ����");
				}
			}); 
		});//end of �ڸ�Ʈ ����
				 
		//�ڸ�Ʈ ��� ��ư�� ������ �� �ڸ�Ʈ ���
		jb(document).on("click", "#writeLc", function() {
			vLnum = "#"+jb(this).parent().parent().parent().parent().parent().attr("id"); //�ڸ�Ʈ ����ϴ� form�� id ����
			vCtext = "#"+jb(this).parent().parent().parent().attr("id"); // �ڸ�Ʈ �Է�â�� �ִ� table�� id ����
//			alert(jb(vLnum).serialize() + " ��� ����");
//			alert(vCtext);
//			alert(jb(vCtext + " textarea").attr("id"));
			if(jb(vCtext + " textarea").val() == ""){
				alert("������ �Է��ϼ���");
			}else{
				jb.ajax({
					url : "writeLc.do", 
					type : "post",
					dataType : "text", 
					data : jb(vLnum).serialize(),	
					success : function(data) {
						if (data == "ok") {
							alert("��� ����");
							getLogs();
						} else {
							alert("��� ����");
						}
					},
					error : function(err) {//����������
						alert(err + " : �ڸ�Ʈ ���� ��� ����");
					}
				}); 
			}
		 });//end of �ڸ�Ʈ ���
		 		
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
					
					<%-- �α׸��� �ڸ�Ʈ â�� �޷��� �Ѵ�.
					�ڸ�Ʈ ��� ��ư�� ������ �ڸ�Ʈ ����� �񵿱�� �ٲ��� �Ѵ�.
					�ڸ�Ʈ�� �ۼ��ڸ� ������ �� �ִ�. --%>
					<c:forEach items="${requestScope.logsList}" var="logs">
						<!-- �α׳��� -->
						<div class="logContent">
							<table id="logTable">
								<tr>
									<td>��  </td>
									<td>${logs.l_uemail}</td>
									<td>${logs.ltext}</td>
								</tr>
								<tr>
									<c:if test="${logs.lpublic == 0}"><td>�����</td></c:if>
									<c:if test="${logs.lpublic == 1}"><td>����</td></c:if>
									<td>${logs.ladmission}</td>
									<td>${logs.ldata}</td>
								</tr>
							</table>
						</div><!-- end of logContent -->
						
						<!-- �ڸ�Ʈ ��� -->
						<c:forEach items="${requestScope.commentsList}" var="comment">
							<c:if test="${comment.c_lnum == logs.lnum }">
								<div class="lcContent">
									<table>
											<tbody id="commentBody">
												<tr>
													<td>-��</td>
													<td>${comment.c_uemail }</td>
													<td>${comment.ctext}</td>
													<td>${comment.cdate}</td>
													<c:if test="${comment.c_uemail == sessionScope.userData.uemail}">
														<td><input type="button" value="����" id="del" name="${comment.cnum}"></td>
													</c:if>
												</tr>
											</tbody>
										</table>					
								</div><!-- end of lcContent -->
							</c:if>
						</c:forEach>
						
						<!-- �ڸ�Ʈ �Է�â -->
						<div class="lcWrite">
							<form action="writeLc.do" class="writeLcForm" id="writeLcForm${logs.lnum}" method="post">
								<input type="hidden" id="c_lnum${logs.lnum}" name="c_lnum" value="${logs.lnum}">
								<input type="hidden" id="c_uemail${logs.lnum}" name="c_uemail" value="${sessionScope.userData.uemail}">
								<input type="hidden" id="c_l_pnum${logs.lnum}" name="c_l_pnum" value="${logs.l_pnum}">
								
								<table>
									<tfoot id="writeComment${logs.lnum}">
										<tr>
											<td><textarea id="ctext${logs.lnum}" name="ctext" rows="2" cols="30"></textarea></td>
											<td><input type="button" id="writeLc" value="�ڸ�Ʈ���"></td>
										</tr>
									</tfoot>
								</table>
							</form>
						</div><!-- end of lcWrite -->
					
					</c:forEach><!-- end of log loop -->
					
				</div><!-- end of setLogs -->
				
			</div><!-- end of logsList -->		
		</fieldset>	
	</div><!-- end of logsView -->	
</body>
</html>
