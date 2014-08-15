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
		var lnumArray = [];
		var pnum = jb("#l_pnum").val();
		var length = 0;
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
					length = data.list.length;
					jb(data.list).each(function(index, item) {//{no:��, name:��,...}
						//�α� div
					 	div += "<div class='logContent' id='"+ item.lnum +"'><table id='logTable'><tr><td>"+ item.l_uemail +"</td><td>"+ item.ltext +"</td></tr>";
						
						div += "<tr><td>"+ item.ldata + "</td>";
						if(item.lpublic == 0){
							div += "<td>�����</td>";
						}else if(item.lpublic == 1){
							div += "<td>����</td>";
						}
						div += "<td>"+ item.ladmission +"</td></tr></table></div>";
						//div += "<td><input type='button' value='�ڸ�Ʈ ���' id='addLc' name='"+ item.lnum +"'></td></tr></table></div>";
						
						//�ش� �α��� �ڸ�Ʈ div
						div += "<div class='lcContent'><form action='writeLc.do' class='writeLcForm' id='writeLcForm"+ item.lnum +"' method='post'>";
						vLnum = "#writeLcForm"+ item.lnum;
						div += "<input type='hidden' class='c_lnum' id='c_lnum"+ item.lnum +"' name='c_lnum' value='"+ item.lnum +"'>";
						div += "<input type='hidden' class='uemail' id='c_uemail"+ item.lnum +"' name='c_uemail'>";
						div += "<input type='hidden' id='c_l_pnum"+ item.lnum +"' name='c_l_pnum' value="+jb("#l_pnum").val()+">";
						
						div += "<table><tbody id='commentBody'></tbody></table>";
						div += "<table><tfoot id='writeComment'><tr><td><textarea id='ctext' name='ctext' rows='2' cols='30'></textarea></td>";
						div += "<td><input type='button' id='writeLc' value='�ڸ�Ʈ���'></td></tr></tfoot></table>";
						
						div += "</form></div>";
						//"+getLcs(item.lnum, item.l_pnum)+"
						//lnumArray[index] = item.lnum;
						jb("#lnumList").after("<li class='lnumforc'>"+ item.lnum +"</li>");
						 
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
					jb(".uemail").val(jb("#l_uemail").val());
					lnumArray = jb(".lnumforc").toArray();
					//alert(lnumArray);
//					vLnum = lnumArray;
//					alert(vLnum[0]);
				},
				error : function(err) {//����������
					alert(err + " : �ش� ������Ʈ���� �αװ� ���� �ۼ����� �ʾҽ��ϴ�");
				}
			});//end of ajax
		} //end of getLogs()
		//alert(vLnum);
		//�ڸ�Ʈ ��� �ʱ�ȭ(�ϴ� �ڸ�Ʈ�� ������) �� ������Ʈ�� �ش� �α�
		function getLcs(c_lnum, c_l_pnum){
			var comment = "";
/* 			comment += "<tr><td>��</td>";
			comment += "<td>�ۼ���</td>";
			comment += "<td>����</td>";
			comment += "<td>�ۼ���</td>";
			comment += "<td>c_lnum : "+c_lnum+"</td>";
			comment += "<td>c_l_pnum : "+c_l_pnum+"</td>";
			comment += "<td><input type='button' value='����' id='del' name='+item.cnum+'></td></tr>";
			
			comment += "<tr><td>��</td>";
			comment += "<td>�ۼ���</td>";
			comment += "<td>����</td>";
			comment += "<td>�ۼ���</td>";
			comment += "<td>c_lnum : "+c_lnum+"</td>";
			comment += "<td>c_l_pnum : "+c_l_pnum+"</td>";
			comment += "<td><input type='button' value='����' id='del' name='+item.cnum+'></td></tr>";
			return comment; */			
			jb.ajax({
				url : "allLcs.do", 
				type : "post",
				dataType : "json", 		
				data : "c_lnum="+c_lnum+"&c_l_pnum="+c_l_pnum,
				success : function(data) {
					
					jb(data.list).each(function(index, item) {//{no:��, name:��,...}
						comment += "<tr><td>��</td>";
						comment += "<td>"+item.c_uemail+"</td>";
						comment += "<td>"+item.ctext+"</td>";
						comment += "<td>"+ item.cdate +"</td>";
						comment += "<td><input type='button' value='����' id='del' name='"+item.cnum+"'></td></tr>";
					});	
					return comment;
				},
				error : function(err) {//����������
					alert(err + " : �ش� ������Ʈ���� �ڸ�Ʈ�� ���� �ۼ����� �ʾҽ��ϴ�");
				}
			});//end of ajax 
		}//end of getLcs()
		//"+getLcs(item.lnum, item.l_pnum)+"
		
		
		//�ڸ�Ʈ ���� ��ư�� ������ �� �ڸ�Ʈ ����
		jb(document).on("click", "#del", function() {
			alert(jb(this).attr("name") + "���� ����");
			/* jb.ajax({
				url : "deleteLc.do", 
				type : "post",
				dataType : "text", 
				data : "cnum=" + jb(this).attr("name"),	//������ ������ ������ : <input type='button' value='����' id='del' name='"+item.no+"'>
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
			});  */
		});//end of �ڸ�Ʈ ����
				 
		//�ڸ�Ʈ ��� ��ư�� ������ �� �ڸ�Ʈ ���
		
		jb(document).on("click", "#writeLc", function() {
			vLnum = "#"+jb(this).parent().parent().parent().parent().parent().attr("id");
			alert(jb(vLnum).serialize() + " ��� ����");
			/* jb.ajax({
				url : "deleteLog.do", 
				type : "post",
				dataType : "text", 
				data : "lnum=" + jb(this).attr("name"),	//������ ������ ������ : <input type='button' value='����' id='del' name='"+item.no+"'>
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
			}); */
		});//end of �α� ����
		 
		 
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
		var comms = "";
		/* for(var i=0; i<length; i++){
			comms += getLcs(lnumArray[i], jb("#l_pnum").val());
		}
		comms = getLcs(lnumArray[0], jb("#l_pnum").val()); */
		
		//alert(lnumArray);
//		alert(jb(".c_lnum").val());
		//alert(length);
	});//end of ready
</script>
<body>
	
	<h6>�αװԽ���2</h6>
	������Ʈ ��ȣ : ${requestScope.pnum}
	���� �̸��� : ${sessionScope.userData.uemail}<br>
	<%-- �ڸ�Ʈ : ${requestScope.commentsList[0]}<br>
	�α� : ${requestScope.logsList[0] }<br> --%>
	
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
			<%-- �ڸ�Ʈ : ${requestScope.commentsList[0]}<br>
				�α� : ${requestScope.logsList[0] }<br> --%>
			<!-- 
				for loop
				�α� ��
					for loop
					���
					end loop
					��� �Է�
				end loop
				 -->
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
					<c:forEach items="${requestScope.logsList}" var="logs">
						<div class="logContent">
							<table id="logTable">
								<tr>
									<%-- <td>�ۼ���</td>
									<td>����</td>
									<td>�ۼ���</td>
									<td>��������</td>
									<td>���ο���</td> --%>
									<td>${logs. }</td>
									<td>����</td>
									<td>�ۼ���</td>
									<td>��������</td>
									<td>���ο���</td>
								</tr>
							</table>
						</div>
					
						<div class="lcContent">
							<table>
									<tbody id="commentBody">
										<tr>
											<td>-��</td>
											<td>�ۼ���</td>
											<td>����</td>
											<td>�ۼ���</td>
											<td>�ڸ�Ʈ����</td>
										</tr>
									</tbody>
								</table>					
						</div><!-- end of lcContent -->
	
						<div class="lcWrite">
							<form action="writeLc.do" id="writeLcForm" method="post">
								<input type="hidden" id="c_lnum" name="c_lnum" value="">
								<input type="hidden" id="c_uemail" name="c_uemail" value="">
								<input type="hidden" id="c_l_pnum" name="c_l_pnum" value="">
								
								<table>
									<tfoot id="writeComment">
										<tr>
											<td><textarea id="ctext" name="ctext" rows="2" cols="30"></textarea></td>
											<td><input type="button" id="writeLc" value="�ڸ�Ʈ���"></td>
										</tr>
									</tfoot>
								</table>
							</form>
						</div><!-- end of lcWrite -->
					</c:forEach>
				</div><!-- end of setLogs -->
				
			</div><!-- end of logsList -->	
			
			
			
		</fieldset>	
	</div><!-- end of logsView -->	
	<div style="display:none;">
		<p id="lnumList"/>
	</div>
</body>
</html>