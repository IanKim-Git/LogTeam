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
    <script id="editor" type="text/x-kendo-template">
	<div align="center" >
   <p>
       <label><b>�̸�:</b> <input name="title" /></label>
   </p>
	<br>
   <p>
       <label>Start: <input data-role="datetimepicker" name="start" /></label>
   </p>
	<br>
   <p>
       <label>End: <input data-role="datetimepicker" name="end" /></label>
   </p>
	<br>
	<p>
		<label><b>����: </b><input name="description" /></label>
	</p>
	<br>
	<p>
	<label><b> ���� ���� : </b> 
		<input type="radio" name="Selecting" value="meeting" id="meeting" onclick="addData()"/>����
		<input type="radio" name="Selecting" value="schedule" id="schedule" onclick="deleteData()"/>����
	</label>
	<div id="hidden_div"><br>
<br><label>Latitude : &nbsp<input id='lati' name='lati'/><br><br>Longitude : <input id='longi' name='longi'/></label>
	</div>
	</div>
	</script>
    <script type="text/javascript">
    function deleteData(){
		$("#hidden_div").html("");
	}
 	function addData(){
 		$("#hidden_div").html("");
 		$("#hidden_div").append("<br><label>Latitude : &nbsp<input id='lati' name='lati'/><br><br>Longitude : <input id='longi' name='longi'/></label>");
 	}
	$(document).ready(function(){
		
		function sendSchedule(x){
			if(x.Selecting=="meeting" || x.Selecting=="schedule"){
				$.ajax({
					url : "sendSchedule.do",
					data : "pnum="+$("#pnum").val()+"&number="+x.id+"&sdate="+x.start+"&edate="+x.end+"&stext="
							+x.description+"&stitle="+x.title+"&flag="+x.Selecting
							+"&lati="+$("#lati").val()+"&longi="+$("#longi").val(),
					type:"post",
					dataType:"text",
					success:function(data){
						if(data=="ok"){
						} else{
						}
					},
					error:function(data){
					} 
				});
			}else{
				alert("���� Ȥ�� ������ �������ּ���");
			}
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
		function deleteMeeting(x){
			$.ajax({
				url:"deleteMeeting.do",
				data:"mnum="+x,
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
				data : "pnum="+$("#pnum").val()+"&number="+x.id+"&sdate="+x.start+"&edate="+x.end
						+"&stext="+x.description+"&stitle="+x.title+"&flag="+x.Selecting
						+"&lati="+$("#lati").val()+"&longi="+$("#longi").val(),
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
		$("#scheduler").kendoScheduler({
		        date: new Date(),
		        views: ["month"],
				editable:{
					confirmation:"�����Ͻǰ̴ϱ�?",
		    		resize:false,
		    		move:false,
		    		template:$("#editor").html()
				},
				edit: function(e){
					if(e.event.Selecting!="meeting"){
						$("#hidden_div").html("");
					}
					/* if(e.event.Selecting=="meeting"){
				 		$("#hidden_div").append("<br><label>Latitude : &nbsp<input id='lati' name='lati'/><br><br>Longitude : <input id='longi' name='longi'/></label>");
					}
					document.getElementById("meeting").checked=true;
					document.getElementById("schedule").checked=false; */
				},
		        save: function(e) {
	            	sendSchedule(e.event);
		        },
		        update: function(e){
	    			updateSchedule(e.event);
		        },
		    	remove: function(e) {
		    		if(e.event.Selecting=="schedule"){
		    			deleteSchedule(e.event.id);	
		    		}else{
		    			deleteMeeting(e.event.id);
		    		}
		        },
				resources:[{
             	    field:"Selecting",
             	    name:"selectFlag",
             	    dataColorField:"key",
             	    dataSource:[
             	               {text:"Schedule", value:"schedule", key:"#aabbcc"},
             	               {text:"Meeting", value:"meeting", key:"green"}
             		]
				}]
		    });
		var scheduleJsonList=null;
		$.ajax({
			url : "getSchedule.do",
			data : "pnum="+$('#pnum').val(),
			type : "post",
			dataType : "json", 					//���������Ÿ��
			success : function(data) {
			    var scheduler = $("#scheduler").data("kendoScheduler");
			    $(data.list).each(function(index,schedule){
			    	scheduler.dataSource.add({
			    		id:schedule.snum,
			    		start:new Date(schedule.sdate),
			    		end: new Date(schedule.edate),
			    		title:schedule.stitle,
			    		description:schedule.stext,
			    		Selecting:"schedule"
			    	});
			    });
			},
			error : function(err) {//����������
			//	alert(err + " : ��� ������Ʈ ���� �ҷ����� ����!!");
			}
			
		}); //end of ajax
		$.ajax({
			url : "getMeeting.do",
			data : "pnum="+$('#pnum').val(),
			type : "post",
			dataType : "json", 					//���������Ÿ��
			success : function(data) {
			    var scheduler = $("#scheduler").data("kendoScheduler");
			    $(data.list).each(function(index,meeting){
			    	scheduler.dataSource.add({
			    		id:meeting.mnum,
			    		start:new Date(meeting.mdate),
			    		end: new Date(meeting.mdate),
			    		title:meeting.mcontent,
			    		description:meeting.mplace,
			    		lati:meeting.mLati,
			    		longi:meeting.mLongi,
			    		Selecting:"meeting"
			    	});

			    });
			},
			error : function(err) {//����������
			//	alert(err + " : ��� ������Ʈ ���� �ҷ����� ����??");
			}
		});
	});
</script>
</head>

<body>

<br><br>
<img src="./images/calendar.png" align="left" style="margin: 3% 0 0 7%; ">
	
<div align="center" style="margin-top: 7%">
   <div id="scheduler" style=" width:85%"></div>
</div>
 	<jsp:include page="bottomMenu.jsp" flush="true"/>
 	<input type="hidden" id="pnum" value="${requestScope.pnum}" />
 	

</body>
</html>
