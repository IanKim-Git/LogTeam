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

<<<<<<< HEAD
	<style type="text/css" media="screen">
		#jMonthCalendar .Meeting { background-color: #DDFFFF;}
		#jMonthCalendar .Birthday { background-color: #DD00FF;}
		#jMonthCalendar #Event_3 { background-color:#0000FF; }
	</style>
	
    <script type="text/javascript">
        $().ready(function() {
			var options = {
				onMonthChanging: function(dateIn) {
					//this could be an Ajax call to the backend to get this months events
					//var events = [ 	{ "EventID": 7, "StartDate": new Date(2009, 1, 1), "Title": "10:00 pm - EventTitle1", "URL": "#", "Description": "This is a sample event description", "CssClass": "Birthday" },
					//				{ "EventID": 8, "StartDate": new Date(2009, 1, 2), "Title": "9:30 pm - this is a much longer title", "URL": "#", "Description": "This is a sample event description", "CssClass": "Meeting" }
					//];
					//$.jMonthCalendar.ReplaceEventCollection(events);
					return true;
				},
				onEventLinkClick: function(event) { 
					alert("event link click");
					return true; 
				},
				onEventBlockClick: function(event) { 
					alert("block clicked");
					return true; 
				},
				onEventBlockOver: function(event) {
					//alert(event.Title + " - " + event.Description);
					return true;
				},
				onEventBlockOut: function(event) {
					return true;
				},
				onDayLinkClick: function(date) { 
					alert(date.toLocaleDateString());
					return true; 
				},
				onDayCellClick: function(date) { 
					alert(date.toLocaleDateString());
					return true; 
				}
			};
			var events = [ 	{ "EventID": 1, "StartDateTime": "new Date(2009, 5, 29)", "EndDateTime": "new Date(2009, 6, 3)", "Title": "10:00 pm - EventTitle1", "URL": "#", "Description": "This is a sample event description" },
							{ "EventID": 6, "StartDateTime": "new Date(2009, 5, 29)", "EndDateTime": "new Date(2009, 6, 3)", "Title": "10:00 pm - EventTitle6", "URL": "#", "Description": "This is a sample event description" },
							{ "EventID": 7, "StartDateTime": new Date(2009, 5, 12), "Title": "10:00 pm - EventTitle7", "URL": "#", "Description": "This is a sample event description" },
							{ "EventID": 3, "StartDateTime": "2009-05-28T12:30:00.0000000", "Title": "This is a much longer title", "URL": "#", "Description": "This is a sample event description", "CssClass": "Meeting" },
							{ "EventID": 4, "StartDateTime": new Date(2009, 5, 13), "Title": "This is a much longer title", "URL": "#", "Description": "This is a sample event description", "CssClass": "Meeting" },
							{ "EventID": 5, "StartDateTime": "2009-06-03", "EndDateTime": "2009-06-14", "Title": "This is a much longer title", "URL": "#", "Description": "This is a sample event description", "CssClass": "Meeting" }
			];	
			$.jMonthCalendar.Initialize(options, events);
			
			var extraEvents = [	{ "EventID": 8, "StartDateTime": new Date(2009, 3, 11), "Title": "10:00 pm - EventTitle1", "URL": "#", "Description": "This is a sample event description", "CssClass": "Birthday" },
								{ "EventID": 9, "StartDateTime": new Date(2009, 3, 20), "Title": "9:30 pm - this is a much longer title", "URL": "#", "Description": "This is a sample event description", "CssClass": "Meeting" }
			];
			
			$("#Button").click(function() {					
				$.jMonthCalendar.AddEvents(extraEvents);
			});
			
			$("#ChangeMonth").click(function() {
				$.jMonthCalendar.ChangeMonth(new Date(2009, 7, 7));
			});
        });
    </script>
    
   
   <!--  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
	<script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
 <!--    
   <style>
    label, input { display:block; }
    input.text { margin-bottom:12px; width:95%; padding: .4em; }
    fieldset { padding:0; border:0; margin-top:25px; }
    h1 { font-size: 1.2em; margin: .6em 0; }
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; }
   </style>
   
     <script>
  $(function() {
	  alert(4);
    var dialog, form;
  
    function addSchedule() {
    	

      dialog.dialog( "close" );
      return valid;
    }
 
    dialog = $( "#registerSche" ).dialog({
      autoOpen: false,
      height: 400,
      width: 350,
      modal: true,
      buttons: {
        "등록하기": addSchedule,
           취소하기: function() {
          dialog.dialog( "close" );
        }
      },
      close: function() {
        form[ 0 ].reset();
        allFields.removeClass( "ui-state-error" );
      }
    });
 
    form = dialog.find( "form" ).on( "submit", function( event ) {
      event.preventDefault();
      addUser();
    });
 
    $( "#scheduleBtn" ).button().on( "click", function() {
      dialog.dialog( "open" );
    });
    alert(5);
  });
  </script> -->
  
    
=======
    <script src="kendo_file/angular.min.js"></script>
    <script src="kendo_file/kendo.all.min.js"></script>
    <script src="kendo_file/console.js"></script>
>>>>>>> branch 'pst_calendar' of https://github.com/IanKim-Git/LogTeam.git
</head>
<script type="text/javascript">
	$(document).ready(function(){
		function getData() {
			$.ajax({
				url : "getSchedule.do",
				data : "pnum=" + requestScope.pnum,
				type : "post",
				dataType : "json", 					//결과데이터타입
				success : function(data) {
					
					alert(data);
					
					
/* 					document.getElementById("gridly").innerHTML="<div class='brick small' ><br><br><font color='black'><b>I'm Mento.</b></font></div>";					

					$(data.list).each(function(index, project) {
						//alert(JSON.stringify(project));
						fullProjectInfo = JSON.stringify(project);//value="+JSON.stringify(project)+"
						simpleProjectInfo = project.pnum + project.pname;
						//alert(simpleProjectInfo);
						
						
		                document.getElementById("gridly").innerHTML+=
		                	  "<div class='brick small' id="+project.pnum+"><br><br><font color='black' >"+
		                	  		"<div id='content_s"+project.pnum+"' style='display:table-cell; vertical-align:middle; font-size: 1.3em;'>"+project.pname+"</div><br>"+
		                	  		"<div id='content_l"+project.pnum+"' style='display:none; font-size: 1.2em;'>"+
		                	  			"프로젝트 번호 : "+project.pnum+"<br>"+	"프로젝트 이름 : "+project.pname+"<br>"+
		                	  			"멘토 : "+project.pmento+"<br>"+  		"기간 : <br>"+project.pstart+"~"+project.pend+"<br>"+
		                	  			"팀장 : "+project.pleader+"<br>"+  		"</div><br></font>"+
		                	  		"<a class='enter' href='#' id="+project.pnum+">[입장하기]</a>"+
		                	  			"<form action='enterProjectMain.do' id='enterProject"+project.pnum+"' method='post'>"+
	                	  				"<input type='hidden' id='pnum' name='pnum' value='"+project.pnum+"'/>"+
	                	  				"<input type='hidden' id='pname' name='pname' value='"+project.pname+"'/></form>"+
	                	  				
	                	  		"</div>";
	           
		                  
		                $('.gridly').gridly(); */
		               });
					//테이블에 추가
				},
				error : function(err) {//실패했을때
					alert(err + " : 모든 프로젝트 정보 불러오기 실패");
				}
			}); //end of ajax
		}//end of getData()
		getData();
		
	});
</script>

<body>
	<h6>캘린더</h6>

    <div id="scheduler"></div>
<script>
$(function() {
    $("#scheduler").kendoScheduler({
        date: new Date("2014/8/17"),
    });
    var scheduler = $("#scheduler").data("kendoScheduler");
    var dataSource = new kendo.data.SchedulerDataSource({
    	data:[
    	      {
    	    	  id:1,
    	    	  start: new Date("2014/8/18 8:00 AM"),
    	    	  end: new Date("2014/8/18 9:00 AM"),
    	    	  title: "Interview"
    	      },
    	      {
    	    	  id:2,
    	    	  start: new Date("2014/8/19 5:00 AM"),
    	    	  end: new Date("2014/8/19 8:00 AM"),
    	    	  title: "InterView2"
    	      }
    	 ]
    });
	scheduler.setDataSource(dataSource);
});
</script>


 	<jsp:include page="bottomMenu.jsp" flush="true"/>

</body>
</html>
