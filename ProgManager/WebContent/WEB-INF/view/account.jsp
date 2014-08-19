<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="topBar.jsp" flush="false" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Account</title>
	<link href="css/kendo.common.min.css" rel="stylesheet" />
    <link href="css/kendo.default.min.css" rel="stylesheet" />
    <link href="css/kendo.dataviz.min.css" rel="stylesheet" />
    <link href="css/kendo.dataviz.default.min.css" rel="stylesheet" />
    <script src="js/jquery.min.js"></script>
    <script src="js/angular.min.js"></script>
    <script src="js/kendo.all.min.js"></script>
</head>

<script src="js/jquery-1.10.2.js"></script>
<script>var jb = jQuery.noConflict();</script>

<script type="text/javascript">
	jb(document).ready(function(){
		var acChartArray = null;
		
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
						table += "<tr><td>" + (index + 1) + "</td><td style='padding-left: 100px; padding-right: 100px'>" + item.accontents + 
								 "</td><td  style='padding-left: 50px; padding-right: 50px'>" +  item.acplus + "</td><td  style='padding-left: 50px; padding-right: 50px'>" +  item.acminus + "</td>";
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
		
		
		//�׷��� ä��� ���� ��� ȸ���� ���� �ҷ����� �Լ�
		function getAcsNums() {
			jb.ajax({
				url : "allAcs.do", 
				type : "post",
				dataType : "json",
				data : "pnum="+jb("#ac_pnum").val(),
				success : function(data) {
					//var acChartArray =new Array();
					acChartArray = new Array();
					jb(data.list).each(function(index, item) {
						if(item.acplus != 0)
							acChartArray.push(item.acplus);
						if(item.acminus != 0)
							acChartArray.push(0-item.acminus);
					});
					jb("#chartData").val(acChartArray);
					
					$(document).ready(createChart);
			        $(document).bind("kendo:skinChange", createChart);
				},
				error : function(err) {//����������
					alert(err + " : ȸ�� �ҷ����� ���� ����");
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
						//alert("���� ����");
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
			}else if(jb("#accontents").val() == "������ �Է��ϼ���"){
				alert("������ �Է��ϼ���.");
			}else{
//				jb("p").html("<font color='green'>�������</font>");
				jb.ajax({
					url : "writeAc.do",
					type : "post",
					dataType : "text", 				
					data : jb("#acWriteForm").serialize(),
					success : function(data) {
						if (data == "ok") {
							//alert("ȸ�� �ۼ� ����");
							jb("textarea").val("������ �Է��ϼ���");
							jb("input[type=text]").val(0);
							getAcs();
							getAcsNums();
						} else {
							alert("ȸ�� �ۼ� ����");
						}
					},
					error : function(data) {//200�� �� �Ѿ� ���� ��
						alert(data + ' : ȸ�� �ۼ� ����� ���� �߻�');
					}
					
				}); //end of ajax
			}//end of else
		});//end of ȸ�� �ۼ� ����
		
		//ȸ�� ���� �׸� �׸���
		function createChart() {
	        $("#chart").kendoChart({
	            title: {
	                text: "Team Account"
	            },
	            legend: {
	                visible: false
	            },
	            series: [{
	                type: "waterfall",
	                data: acChartArray,
	                labels: {
	                    visible: true
	                }
	            }],
	            categoryAxis: {
	                categories: []
	            },
	            axisDefaults: {
	                majorGridLines: {
	                    visible: false
	                }
	            }
	        });
	    }
		
		 
		//ȸ����� ȭ�� �ʱ�ȭ
		getAcs();
		getAcsNums();
		jb("#accontents").val("������ �Է��ϼ���");
	});//end of ready

</script>

<body>
	
	<div id="example" align="center">
    	<div class="demo-section k-content">
        	<div id="chart"></div>
    	</div>
	</div>

	<h6>ȸ�����</h6>
	<%-- ������Ʈ ��ȣ : ${requestScope.pnum}
	���� �̸��� : ${sessionScope.userData.uemail}<br> --%>
	
	<div style="margin: 0 auto; width: 1300px">
		<div style="float: left;">
	<form action="" id="acListForm">			
		<table id="listTable" cellspacing="3" cellpadding="0" align="center">
			<tr bgcolor="#FOFOF7">
				<th>��ȣ</th><th>����</th><th><font color="green"><b>+</b></font></th><th><font color="red"><b>-</b></font></th><th>����</th>
			</tr>
		</table>
	</form><br>
		</div>
		<div style="float: right;">
		<br><br><br>
	��밡�ɱݾ� : <input type="text" id="acTotal" readonly="readonly" /><br>
	<%--insert into account (ac_pnum, acnum, acplus, acminus, accontents)
		values (#{ac_pnum}, seq_ac.nextval, #{acplus}, #{acminus}, #{accontents}) --%>
	<form action="writeAc.do" id="acWriteForm" method="post">
		<input type="hidden" id="ac_pnum" name="ac_pnum" value="${requestScope.pnum}" align="middle">
		���� <textarea id="accontents" name="accontents" rows="1" cols="40" ></textarea><br>
		���� <input type="text" id="acplus" name="acplus" value="0"/>
		���� <input type="text" id="acminus" name="acminus" value="0"/>
		<input type="button" id="acWrite" value="���">
	</form>
	<p></p>
	</div>
	</div>

</body>
<jsp:include page="bottomMenu.jsp" flush="true"/>
</html>
