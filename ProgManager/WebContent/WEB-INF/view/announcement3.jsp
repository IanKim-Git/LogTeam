<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="topBar.jsp" flush="false" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Announcement</title>
<link href="kendo_file/examples-offline.css" rel="stylesheet">
    <link href="kendo_file/kendo.common.min.css" rel="stylesheet">
    <link href="kendo_file/kendo.rtl.min.css" rel="stylesheet">
    <link href="kendo_file/kendo.default.min.css" rel="stylesheet">
    <link href="kendo_file/kendo.dataviz.min.css" rel="stylesheet">
    <link href="kendo_file/kendo.dataviz.default.min.css" rel="stylesheet">
    <script src="kendo_file/jquery.min.js"></script>

    <script src="kendo_file/angular.min.js"></script>
    <script src="kendo_file/kendo.all.min.js"></script>
</head>
<!-- <script src="js/jquery-1.10.2.js"></script> -->
<script>var jb = jQuery.noConflict();</script>


<body>

	<%-- <h6>��������</h6>
	������Ʈ ��ȣ : ${requestScope.pnum}
	���� �̸��� : ${sessionScope.userData.uemail}<br> --%>
	<br><br><br><br>
	<div></div>
	 <div id="example">
		<div id="grid"></div>
			<script>
            jb(document).ready(function(){
        		//��� ���������� �ҷ����� �Լ�
        		function getAns() {
        			jb.ajax({
        				url : "allAns.do", 
        				type : "post",
        				dataType : "json", 					//���������Ÿ��
        				data : "pnum="+jb("#an_pnum").val(),
        				success : function(data) {
        					var table = "";
        					jb("#listTable tr:gt(0)").remove();
//        					<th>��ȣ</th><th>����</th><th>��¥</th><th>�����</th><th>�߿䵵</th><th>����</th>
        					var count = data.list.length;

        					//data.list�� �� ������ : [{no:��, name:��,...}, {no:��, name:��,...}, {no:��, name:��,...}, ...]
        					jb(data.list).each(function(index, item) {//{no:��, name:��,...}
        						table += "<tr><td>" + (count--) + "</td><td>" + item.ancontent + "</td><td>" +  item.andate + "</td><td>" +  item.an_uemail + "</td>";
        						if(item.animportance == 3){
        							table += "<td>��</td>";
        						}else if(item.animportance == 2){
        							table += "<td>��</td>";
        						}else if(item.animportance == 1){
        							table += "<td>��</td>";
        						}
        						if($("#an_uemail").val() == item.an_uemail){
        							table += "<td><input type='button' value='����' id='del' name='"+item.annum+"'></td></tr>";
        						}
        					});
        					//���̺��� �߰�
        					jb("#listTable tr:eq(0)").after(table);
        					
        				},
        				error : function(err) {//����������
        					alert(err + " : �ش� ������Ʈ���� ���������� ���� �ۼ����� �ʾҽ��ϴ�");
        				}
        			});//end of ajax
        		} //end of getAns()
        		
        		//���� ��ư�� ������ �� �������� ����
        		jb(document).on("click", "#del", function() {
        			jb.ajax({
        				url : "deleteAn.do", 
        				type : "post",
        				dataType : "text", 
        				data : "annum=" + jb(this).attr("name"),	//������ ������ ������ : <input type='button' value='����' id='del' name='"+item.no+"'>
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
        		jb("#anWrite").click(function() {
        			if(jb("#ancontent").val() == ""){
        				alert("������ �Է��ϼ���.");
        			}else{
        				jb.ajax({
        					url : "writeAn.do",
        					type : "post",
        					dataType : "text", 				
        					data : jb("#anWriteForm").serialize(),
        					success : function(data) {
        						if (data == "ok") {
        							alert("�������� �ۼ� ����");
        							jb("textarea").val("");	
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
        			}
        		});//end of �������� �ۼ� ����
        		
        	});//end of ready
            </script>
        </div>
  	<br><hr><br><br>
</body>
<jsp:include page="bottomMenu.jsp" flush="true"/>
</html>