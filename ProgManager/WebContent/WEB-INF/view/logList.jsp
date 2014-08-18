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
				data : "pnum="+jb("#l_pnum").val() +"&uemail="+jb("#l_uemail").val(),
				success : function(data) {
					var div = "";
					jb("#setLogs").children().remove();
					var flag = 0;
					var msg = "";
					jb(data.list).each(function(index, item) {//{no:��, name:��,...}
						div += "<div class='eachLog' id='"+ item.lnum +"'>";
						//�α� div
					 	div += "<div class='logContent' id='logContent"+ item.lnum +"'><table class='logTable'><tr>";
					 	jb(data.ulist).each(function(index, uitem){
					 		if(item.l_uemail == uitem.uemail){
					 			div += "<td><img id='userProfilePhoto' src='" + uitem.uphoto + "' width='50' height='50' border='3' style='margin: -5px 5px 5px 5px;'></td></td>";
					 		}
					 	});
					 	
					 	
					 	div += "<td>"+ item.l_uemail +"</td><td></td></tr>";
					 	
					 	div += "<tr><td></td><td>"+ item.ltext +"<br></td><td></td></tr>";
						div += "<tr><td></td>";
						div += "<td><img id='logPhoto' src='"+ item.lphoto +"' width='80%' height='80%' border='0' style='margin: -5px 5px 5px 5px;'><br>";
						div += "<td></td></tr><tr>";
						if(item.lpublic == 0){
							div += "<td>�����</td>";
						}else if(item.lpublic == 1){
							div += "<td>����</td>";
						}
						div += "<td>"+ item.ladmission +"</td><td><span>"+ item.ldata + "</span> <span>";
						
						//�� ���� �� �� ��ư ���
						jb(data.jlist).each(function(index, jitem){
							if(jitem.j_uemail == jb("#l_uemail").val() && jitem.j_lnum == item.lnum){
								flag += 1;
								msg = "�̹� ���ϼ̽��ϴ� : ";
								if(jitem.jscore == 2){
									msg += "���ƿ�";
								}else if(jitem.jscore == 1){
									msg += "�����׷���";
								}else if(jitem.jscore == -1){
									msg += "�Ⱦ��";
								}
							}
						});
						
						if(flag > 0){
							div += msg;
						}else{
							div += "<form action='evaluation.do' class='evaluationForm' id='evaluationForm"+ item.lnum +"' method='post'>";
							div += "<input type='hidden' class='uemail' id='j_uemail"+ item.lnum +"' name='j_uemail'>";
							div += "<input type='hidden' class='j_lnum' id='j_lnum"+ item.lnum +"' name='j_lnum' value='"+ item.lnum +"'>";
							div += "<input type='hidden' id='j_l_pnum"+ item.lnum +"' name='j_l_pnum' value="+jb("#l_pnum").val()+">";
							div += "<input type='button' class='judge' id='like' value='���ƿ�' name='2'>"+
									"<input type='button' class='judge' id='soso' value='�����׷���' name='1'>"+
									"<input type='button' class='judge' id='hate' value='�Ⱦ��' name='-1'>";
							div += "</form>";
						}
						flag = 0; //flag �ʱ�ȭ
						msg = ""; //msg �ʱ�ȭ
						div += "</span></td></tr></table></div>";
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
						
						div += "</div>";
					});
					jb("#setLogs").html(div);
					jb(".uemail").val(jb("#l_uemail").val());
					
					//���� ����� ����
					jb(data.list).each(function(indext, item){
						
						if(item.lpublic == 1){
							jb("#"+item.lnum).css({"display":"block"});
						}else if(item.lpublic == 0){
							if(item.l_uemail != jb("#l_uemail").val()){
								jb("#"+item.lnum).css({"display":"none"});
							}else if(item.l_uemail == jb("#l_uemail").val()){
								jb("#"+item.lnum).css({"display":"block"});
							}
						}
						
					});
				},
				error : function(err) {//����������
					alert(err + " : �ش� ������Ʈ���� �αװ� ���� �ۼ����� �ʾҽ��ϴ�");
				}
				
			});//end of ajax
		} //end of getLogs()
		
		//�α� ��� : with photo
		jb("#write").click(function() {
			var data = new FormData();
			data.append('l_pnum', jb("#l_pnum").val());
			data.append('l_uemail', jb("#l_uemail").val());
			data.append('ltext', jb("#ltext").val());
			data.append('lpublic', jb("#lpublic").val());
			jb.each($("#lphoto")[0].files, function(i, file) {
			    	data.append('file-' + i, file);
			});
			if(jb("#ltext").val() == ""){
				alert("������ �Է��ϼ���.");
			}else{
				jb.ajax({
					url : "write.do",
					type : "post",
					dataType : "text", 				
					data : data,
					processData: false,
		            contentType: false,
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
		 
		//�� ���� ����
		jb(document).on("click", ".judge", function() {
			jb.ajax({
				url : "evaluation.do", 
				type : "post",
				dataType : "text", 
				data : jb("#"+jb(this).parent().attr("id")).serialize() + "&jscore=" + jb(this).attr("name"),
				success : function(data) {
					if (data == "ok") {
						alert("�� ����");
						getLogs();
					} else {
						alert("�� ����");
					}
				},
				error : function(err) {//����������
					alert(err + " : �� ����");
				}
			});  
		});//end of ��
		 		
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
				<form action="write.do" id="writeForm" method="post" enctype="multipart/form-data">
					<input type="hidden" id="l_pnum" name="l_pnum" value="${requestScope.pnum}">
					<input type="hidden" id="l_uemail" name="l_uemail" value="${sessionScope.userData.uemail}">
					<table >
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
							<td>
								<label for="photo">Log Photo</label><br>
								<!-- <form action="lPhotoUpload.do" method="post" id="lphotoUpload" enctype="multipart/form-data"> -->
								<input type="file" name="lphoto" id="lphoto"/>
								<!-- </form> -->
							</td>
						</tr>
						<tr><td></td></tr>
						<tr>
							<td></td>
						</tr>
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
					<c:forEach items="${requestScope.logsList}" var="logs" >
						<div class="eachLog" id="${logs.lnum}">
							<!-- �α׳��� -->
							<div class="logContent">
								<table class="logTable">
									<tr>
										<td>
											<img id="userProfilePhoto" src="${sessionScope.userData.uphoto}" width="50" height="50" border="3" style="margin: -5px 5px 5px 5px;">
										</td>
										<td>${logs.l_uemail}</td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td>${logs.ltext}<br></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td>
											<img id="logPhoto" src="${logs.lphoto}" width="80%" height="80%" border="0" style="margin: -5px 5px 5px 5px;"><br>
										</td>
										<td></td>
									</tr>
									<tr>
										<c:if test="${logs.lpublic == 0}"><td>�����</td></c:if>
										<c:if test="${logs.lpublic == 1}"><td>����</td></c:if>
										<td>${logs.ladmission}</td>
										<td>
											<span>${logs.ldata}</span>
											<span>
												<!-- �� �κ� -->
											</span>
										</td>
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
							</c:forEach><!-- end of comment loop -->
							
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
					
						</div><!-- end of eachLog -->
					
					</c:forEach><!-- end of log loop -->
				</div><!-- end of setLogs -->
				
			</div><!-- end of logsList -->		
		</fieldset>	
	</div><!-- end of logsView -->	
</body>
</html>
