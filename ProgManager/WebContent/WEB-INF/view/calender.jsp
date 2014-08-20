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
			alert(x.title);
			$.ajax({
				url : "sendSchedule.do",
				data : "pnum="+$("#pnum").val()+"&sdate="+x.start+"&edate="+x.end+"&stext="+x.description+"&stitle="+x.title,
				type:"post",
				dataType:"text",
				success:function(data){
					if(data=="ok"){
						alert("등록 성공!!");
					} else{
						alert("실패임ㅡ,.ㅡ");
					}
				},
				error:function(data){
					alert("등록 로직 실패");
				} 
			});
		}
	 	data:[
    	      {
    	    	  id:1,
    	    	  start: new Date("2014/8/18 8:00 AM"),
    	    	  end: new Date("2014/8/18 9:00 AM"),
    	    	  title: "StartDate"
    	      },
    	      {
    	    	  id:2,
    	    	  start: new Date("2014/8/19 5:00 AM"),
    	    	  end: new Date("2014/8/19 8:00 AM"),
    	    	  title: "EndDate"
    	      }
    	 ]
		var scheduleJsonList=null;
		$.ajax({
			url : "getSchedule.do",
			data : "pnum="+$('#pnum').val(),
			type : "post",
			dataType : "json", 					//결과데이터타입
			success : function(data) {
				//alert(data.list.length);    // data 갯수 
					    $("#scheduler").kendoScheduler({
					        date: new Date("2014/8/17"),
					        views: ["month", "day" ],
					        save: function(e) {
					            sendSchedule(e.event);
					            alert("나왔넹");
					        }
					    });
					    var scheduler = $("#scheduler").data("kendoScheduler");
					    $(data.list).each(function(index,schedule){
					    	scheduler.dataSource.add({
					    		start:new Date(schedule.sdate),
					    		end: new Date(schedule.edate),
					    		title:schedule.stitle,
					    		description:schedule.stext
					    	});
					    });
					    
				

			},
			error : function(err) {//실패했을때
				alert(err + " : 모든 프로젝트 정보 불러오기 실패");
			}
		}); //end of ajax
	});
</script>
</head>
<body>
	<h6>캘린더</h6>
	
<div align="center">
    <div id="scheduler" style=" width:90%"></div>
</div>

 	<jsp:include page="bottomMenu.jsp" flush="true"/>
 	<input type="hidden" id="pnum" value="${requestScope.pnum}" />

</body>
</html>