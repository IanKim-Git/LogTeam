<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="topBar.jsp" flush="true" />
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Calendar</title>
	<link href="kendo_file/examples-offline.css" rel="stylesheet">
    <link href="kendo_file/kendo.common.min.css" rel="stylesheet">
    <link href="kendo_file/kendo.rtl.min.css" rel="stylesheet">
    <link href="kendo_file/kendo.default.min.css" rel="stylesheet">
    <link href="kendo_file/kendo.dataviz.min.css" rel="stylesheet">
    <link href="kendo_file/kendo.dataviz.default.min.css" rel="stylesheet">
    <script src="kendo_file/jquery.min.js"></script>

    <script src="kendo_file/angular.min.js"></script>
    <script src="kendo_file/kendo.all.min.js"></script>
    <script src="kendo_file/console.js"></script>

    <script type="text/javascript">
	$(document).ready(function(){
		function sendSchedule(x){
			$.ajax({
				url : "sendSchedule.do",
				data : "pnum="+$("#pnum").val()+"&sdate="+x.start+"&edate="+x.end+"&stext="+x.description+"&stitle="+x.title
						+"&flag="+x.isAllDay,
				type:"post",
				dataType:"text",
				success:function(data){
					if(data=="ok"){
					} else{
					}
				},
				error:function(data){
					alert("��� ���� ����");
				} 
			});
		}
		function deleteSchedule(x){
			$.ajax({
				url:"deleteSchedule.do",
				data:"snum="+x,
				type:"post",
				dataType:"text",
				success:function(data){
					if(data=="ok"){
					}else{
					}
				},
				error:function(data){
				}
			});
		}
		function updateSchedule(x){
			$.ajax({
				url:"updateSchedule.do",
				data: "snum="+x
				
			});
		}
		function checkUpdate(x){
			$.ajax({
				url:"checkUpdate.do",
				data:"snum="+x.id+"&stitle="+x.title+"&stext="+x.description+"&sdate="+x.start+"&edate="+x.end,
				type:"post",
				dataType:"text",
				success:function(data){
					if(data=="ok"){
						
					}else{
					}
				},
				error:function(data){
				}
			});
		}
		
		var scheduleJsonList=null;
		$.ajax({
			url : "getSchedule.do",
			data : "pnum="+$('#pnum').val(),
			type : "post",
			dataType : "json", 					//���������Ÿ��
			success : function(data) {
				//alert(data.list.length);    // data ���� 
					    $("#scheduler").kendoScheduler({
					        date: new Date("2014/8/17"),
					        views: ["month", "day" ],
					        save: function(e) {
					        	alert(e.event.isAllDay);
					            sendSchedule(e.event);
					            checkUpdate(e.event);
					        },
					    	remove: function(e) {
					    		alert(e.event.id);
					    		deleteSchedule(e.event.id);
					        },
					        resizeEnd: function(e){
					        	updateSchedule(e);
					        }
					    });
					    var scheduler = $("#scheduler").data("kendoScheduler");
					    $(data.list).each(function(index,schedule){
					    	scheduler.dataSource.add({
					    		id:schedule.snum,
					    		start:new Date(schedule.sdate),
					    		end: new Date(schedule.edate),
					    		title:schedule.stitle,
					    		description:schedule.stext
					    	});
					    });
			},
			error : function(err) {//����������
				alert(err + " : ��� ������Ʈ ���� �ҷ����� ����");
			}
		}); //end of ajax
	});
</script>
</head>
<body>
	<h6>Ķ����</h6>
	<br><br><br>
<div align="center">
    <div id="scheduler" style=" width:90%"></div>
</div>

 	<jsp:include page="bottomMenu.jsp" flush="true"/>
 	<input type="hidden" id="pnum" value="${requestScope.pnum}" />

</body>
</html>