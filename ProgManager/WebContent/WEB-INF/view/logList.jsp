<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="topBar.jsp" flush="false" />
	
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Log List</title>
</head>

<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/jQuery.MultiFile.min.js"></script>
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
						div += "<div class='eachLog' id='"+ item.lnum +"'><fieldset>";
						//�α� div
					 	div += "<div class='logContent' id='logContent"+ item.lnum +"'><table class='logTable'><tr>";
					 	jb(data.ulist).each(function(index, uitem){
					 		if(item.l_uemail == uitem.uemail){
					 			div += "<td><img id='userProfilePhoto' src='" + uitem.uphoto + "' width='50' height='50' border='3' style='margin: -5px 5px 5px 5px;'></td></td>";
					 		}
					 	});
					 	div += "<td>"+ item.l_uemail +"</td><td></td></tr>";

					 	div += "<tr><td></td><td>"+ item.ltext +"<br></td><td></td></tr>";
						
					 	div += "<tr><td></td><td>";
						if(item.lphoto != ""){
							div += "<img id='logPhoto' src='"+ item.lphoto +"' title='"+ item.lphotoname +"' width='70%' height='70%' border='0' ><br>";
						}
						div += "</td></tr>";
						
						div +="<tr><td></td><td>";
						if(item.lfile != ""){
							div += "<a href=\"down.do?lfile="+ item.lfile +"\" >" + item.lfilename + "</a>";
						}
						div += "</td><td></td></tr><tr>";
						
						if(item.lpublic == 0){
							div += "<td>��������</td>";
						}else if(item.lpublic == 1){
							div += "<td>��κ���</td>";
						}
						div += "<td>"+ item.ldata + "</td><td><span>";
						
						//�� ���� �� �� ��ư ���
						jb(data.jlist).each(function(index, jitem){
							if(jitem.j_uemail == jb("#l_uemail").val() && jitem.j_lnum == item.lnum){
								flag += 1;
								msg = "�� �Ϸ� : ";
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
						div += "</span></td></tr></table></div><hr>";
						//div += "<td><input type='button' value='�ڸ�Ʈ ���' id='addLc' name='"+ item.lnum +"'></td></tr></table></div>";
						
						//�ش� �α��� �ڸ�Ʈ ��� div
						div += "<div class='lcContent'>";
						div += "<table><tbody id='commentBody'>";
						jb(data.clist).each(function(index, citem) {//{no:��, name:��,...}
							if(citem.c_lnum == item.lnum){
								div += "<tr><td> &nbsp; <td>";
								div +="<td>";
								jb(data.ulist).each(function(index, uitem){
							 	if(citem.c_uemail == uitem.uemail){
							 			div += "<img id='userCommentProfilePhoto' src='" + uitem.uphoto + "' width='30' height='30' border='3' style='margin: -5px 5px 5px 5px;'>";
							 		}
							 	});
								div+="</td>";
								div += "<td>"+citem.c_uemail+"</td>";
								div += "<td align='left' width='650'>"+citem.ctext+"</td>";
								div += "<td align='right'>"+ citem.cdate +"</td>";
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
						div += "<table><tfoot id='writeComment"+ item.lnum +"'><tr><td><textarea id='ctext"+ item.lnum +"' name='ctext' rows='2' cols=120% ></textarea></td>";
						div += "<td><input type='button' id='writeLc' value='���'></td></tr></tfoot></table>";
						
						div += "</form></div>";
						
						div += "</fieldset></div><br>";
					});
					
					jb("#setLogs").html(div);
					jb(".uemail").val(jb("#l_uemail").val());
					
					/* //���� ����� ����
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
						
					}); */
				},
				error : function(err) {//����������
					alert(err + " : �ش� ������Ʈ���� �αװ� ���� �ۼ����� �ʾҽ��ϴ�");
				}
				
			});//end of ajax
		} //end of getLogs()
		
		jb("#lphoto").MultiFile({
			max: 1, //���ε� �ִ� ���� ���� (�������� ������ ���Ѵ�)
	        accept: 'jpg|JPG|jpeg|JPEG|png|PNG|gif|GIF|', //����� Ȯ����(�������� ������ ��� Ȯ���� ���)
	        STRING: { //Multi-lingual support : �޽��� ���� ����
	            duplicate : "$file �� �̹� ���õ� �����Դϴ�.", 
	            denied : "$ext ��(��) ���ε� �Ҽ� ���� ����Ȯ�����Դϴ�.",
	            selected:'$file �� �����߽��ϴ�.', 
	            toomany: "���ε��� �� �ִ� �ִ� ������ $max�� �Դϴ�."
	        }
		});
		
		//�α� ��� : with photo
		jb("#write").click(function() {
			var data = new FormData();
			var url = "write.do";
			var fileFlag = 0;
			
			data.append('l_pnum', jb("#l_pnum").val());
			data.append('l_uemail', jb("#l_uemail").val());
			data.append('ltext', jb("#ltext").val());
			data.append('lpublic', jb("#lpublic").val());
			
			if(jb("#lphoto")[0].files.length > 0){
				jb.each(jb("#lphoto")[0].files, function(i, file) {
			    	data.append('file-' + i, file);
				});
				url = "writePhoto.do";
				fileFlag += 1;
			}
			
			if(jb("#lfile")[0].files.length > 0){
				jb.each(jb("#lfile")[0].files, function(i, file) {
		    	data.append('lfile-' + i, file);
				}); 
				url = "writeFile.do";
				fileFlag += 1;
			}
			
			if(fileFlag == 2){
				url = "writePhotoFile.do";
			}
			
			if(jb("#ltext").val() == ""){
				alert("������ �Է��ϼ���.");
			}else{
				jb.ajax({
					url : url,
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
<%-- 	<h6>�αװԽ���</h6>
	������Ʈ ��ȣ : ${requestScope.pnum}
	���� �̸��� : ${sessionScope.userData.uemail}<br> --%>
	<br><br>
	<!-- �α� ȭ�� -->
	<div id="logsView" align="left" style="margin-left: 15%;margin-right: 15%;">
		
			<!-- �α� ���â -->
			<div id="writeLog">
				<fieldset>
					<form action="write.do" id="writeForm" method="post" enctype="multipart/form-data">
						<input type="hidden" id="l_pnum" name="l_pnum" value="${requestScope.pnum}">
						<input type="hidden" id="l_uemail" name="l_uemail" value="${sessionScope.userData.uemail}">
						  <table id="logFormTable">
							<tr>
								<td>
									<select id="lpublic" name="lpublic">
										<option value="-1">����</option>
										<option value="0">��������</option>
										<option value="1">��κ���</option>
									</select>
								</td>
							</tr>
							<tr>
								<td  colspan="2">
									<textarea id="ltext" name="ltext" rows="5" cols=120% ></textarea>
								</td>
								<td>
									<input type="button" id="write" value="�α׵��">
								</td>
							</tr>
							<tr>
								<td>
									<label for="photo">Log Photo</label>
									<div><input type="file" name="lphoto" id="lphoto" /></div>
								</td>
								<td>
									<label for="file">Log File</label>
									<div><input type="file" name="lfile" id="lfile"/></div>
								</td>
							</tr>
						</table>				
					</form>
				</fieldset>
			</div><!-- end of writeLog -->
			<br>
			
			<!-- �α� ��� : ���������� setLogs ���δ� �ּ� ó�� or ���� -->
			<div id="logsList">
				<!-- jQuery �Լ� ����� ���ؼ� ���� -->
				<div id="setLogs">
				
					<c:forEach items="${requestScope.logsList}" var="logs" >
						<div class="eachLog" id="${logs.lnum}">
							<fieldset>	
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
												<img id="logPhoto" src="${logs.lphoto}" title="${logs.lphotoname}" width="70%" border="0" ><br>
											</td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td><input type="button" value="���ϴٿ�" onclick="location.href='http://www.naver.com'">������</td>
											<td></td>
										</tr>
										<tr>
											<c:if test="${logs.lpublic == 0}"><td>��������</td></c:if>
											<c:if test="${logs.lpublic == 1}"><td>��κ���</td></c:if>
											<td>${logs.ldata}</td>
											<td>
												<span>
													<input type='button' class='judge' id='like' value='���ƿ�' name='2'>
													<input type='button' class='judge' id='soso' value='�����׷���' name='1'>
													<input type='button' class='judge' id='hate' value='�Ⱦ��' name='-1'>
												</span>
											</td>
										</tr>
									</table>
								</div><!-- end of logContent -->
								<hr>
								<!-- �ڸ�Ʈ ��� -->
								
								<div class="lcContent">
									<table >
										<tbody id="commentBody">
											<c:forEach items="${requestScope.commentsList}" var="comment">
												<c:if test="${comment.c_lnum == logs.lnum }">
													<tr>
														<td> &nbsp; <td>
														<td>
															<img id="userProfilePhoto" src="${sessionScope.userData.uphoto}" width="30" height="30" border="3" style="margin: -5px 5px 5px 5px;">
														</td>
														<td>${comment.c_uemail }</td>
														<td align="left" width="650">${comment.ctext}</td>
														<td align="right">${comment.cdate}</td>
														<c:if test="${comment.c_uemail == sessionScope.userData.uemail}">
															<td><input type="button" value="����" id="del" name="${comment.cnum}"></td>
														</c:if>
													</tr>
												</c:if>
											</c:forEach><!-- end of comment loop -->
										</tbody>
									</table>					
								</div><!-- end of lcContent -->
									
								
								<!-- �ڸ�Ʈ �Է�â -->
								<div class="lcWrite">
									<form action="writeLc.do" class="writeLcForm" id="writeLcForm${logs.lnum}" method="post">
										<input type="hidden" id="c_lnum${logs.lnum}" name="c_lnum" value="${logs.lnum}">
										<input type="hidden" id="c_uemail${logs.lnum}" name="c_uemail" value="${sessionScope.userData.uemail}">
										<input type="hidden" id="c_l_pnum${logs.lnum}" name="c_l_pnum" value="${logs.l_pnum}">
										
										<table>
											<tfoot id="writeComment${logs.lnum}">
												<tr>
													<td> &nbsp; <td>
													<td><textarea id="ctext${logs.lnum}" name="ctext" rows="2" cols="135"></textarea></td>
													<td><input type="button" id="writeLc" value="���"></td>
												</tr>
											</tfoot>
										</table>
									</form>
								</div><!-- end of lcWrite -->
							</fieldset>
						</div><!-- end of eachLog -->
						<br>
					</c:forEach><!-- end of log loop -->
				
				</div><!-- end of setLogs -->
			</div><!-- end of logsList -->		
	</div><!-- end of logsView -->	
	<br><br><br><br><br><br><br><br>
</body>
<jsp:include page="bottomMenu.jsp" flush="true"/>
</html>
