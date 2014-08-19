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