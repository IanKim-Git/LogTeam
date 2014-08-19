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
		
		//모든 회계 목록을 불러오는 함수
		function getAcs() {
			jb.ajax({
				url : "allAcs.do", 
				type : "post",
				dataType : "json", 					//결과데이터타입
				data : "pnum="+jb("#ac_pnum").val(),
				success : function(data) {
					var table = "";
					jb("#listTable tr:gt(0)").remove();
					//	<th>번호</th><th>내역</th><th><font color="green"><b>+</b></font></th><th><font color="red"><b>-</b></font></th><th>삭제</th>
					var sumPlus = 0;
					var sumMinus = 0;
					jb(data.list).each(function(index, item) {
						table += "<tr><td>" + (index + 1) + "</td><td style='padding-left: 100px; padding-right: 100px'>" + item.accontents + 
								 "</td><td  style='padding-left: 50px; padding-right: 50px'>" +  item.acplus + "</td><td  style='padding-left: 50px; padding-right: 50px'>" +  item.acminus + "</td>";
						table += "<td><input type='button' value='삭제' id='del' name='"+item.acnum+"'></td></tr>";
						sumPlus += item.acplus;
						sumMinus += item.acminus;
					});
					//테이블에 추가
					jb("#listTable tr:eq(0)").after(table);
					//사용가능금액 계산
					jb("#acTotal").val(sumPlus-sumMinus);
				},
				error : function(err) {//실패했을때
					alert(err + " : 해당 프로젝트에는 공지사항이 아직 작성되지 않았습니다");
				}
			});//end of ajax
		} //end of getAcs()
		
		
		//그래프 채우기 위해 모든 회계의 값만 불러오는 함수
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
				error : function(err) {//실패했을때
					alert(err + " : 회계 불러오기 로직 에러");
				}
			});//end of ajax
		} //end of getAcs()
		
		
		//삭제 버튼을 눌렀을 때 회계목록 삭제
		jb(document).on("click", "#del", function() {
			jb.ajax({
				url : "deleteAc.do", 
				type : "post",
				dataType : "text", 
				data : "acnum=" + jb(this).attr("name"),	
				success : function(data) {
					if (data == "ok") {
						//alert("삭제 성공");
						getAcs();
					} else {
						alert("삭제 실패");
					}
				},
				error : function(err) {//실패했을때
					alert(err + " : 회계 정보 삭제 실패");
				}
			});
		});//end of 회계 삭제 
		
		//소득에 입력하면 지출에 입력 못 하게
		jb("#acplus").keyup(function(){
			var isValid = isNumValid(jb("#acplus").val());
			if(!isValid){
				jb("p").html("<font color='red'>숫자를 입력하세요.</font>");
				jb("#acplus").val("0");
			}else{
				jb("p").html("");
			}
			
		});
		
		//지출에 입력하면 소득에 입력 못 하게
		jb("#acminus").keyup(function(){
			var isValid = isNumValid(jb("#acminus").val());
			if(!isValid){
				jb("p").html("<font color='red'>숫자를 입력하세요.</font>");
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
				jb("#accontents").val("내용을 입력하세요");
			}
			
		});
		
		//회계 등록
		jb("#acWrite").click(function() {
			if(jb("#acminus").val() != 0 && jb("#acplus").val() !="0"){
				jb("p").html("<font color='red'>수입이나 지출 둘 중 하나만 입력하세요.</font>");
			}else if(jb("#acminus").val() =="0"&& jb("#acplus").val() =="0"){
				jb("p").html("<font color='red'>수입이나 지출 둘 중 하나를 입력하세요.</font>");
			}else if(jb("#accontents").val() == "내용을 입력하세요"){
				alert("내용을 입력하세요.");
			}else{
//				jb("p").html("<font color='green'>정상실행</font>");
				jb.ajax({
					url : "writeAc.do",
					type : "post",
					dataType : "text", 				
					data : jb("#acWriteForm").serialize(),
					success : function(data) {
						if (data == "ok") {
							//alert("회계 작성 성공");
							jb("textarea").val("내용을 입력하세요");
							jb("input[type=text]").val(0);
							getAcs();
							getAcsNums();
						} else {
							alert("회계 작성 실패");
						}
					},
					error : function(data) {//200이 안 넘어 왔을 때
						alert(data + ' : 회계 작성 실행시 에러 발생');
					}
					
				}); //end of ajax
			}//end of else
		});//end of 회계 작성 로직
		
		//회계 막대 그림 그리기
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
		
		 
		//회계관리 화면 초기화
		getAcs();
		getAcsNums();
		jb("#accontents").val("내용을 입력하세요");
	});//end of ready

</script>

<body>
	
	<div id="example" align="center">
    	<div class="demo-section k-content">
        	<div id="chart"></div>
    	</div>
	</div>

	<h6>회계관리</h6>
	<%-- 프로젝트 번호 : ${requestScope.pnum}
	유저 이메일 : ${sessionScope.userData.uemail}<br> --%>
	
	<div style="margin: 0 auto; width: 1300px">
		<div style="float: left;">
	<form action="" id="acListForm">			
		<table id="listTable" cellspacing="3" cellpadding="0" align="center">
			<tr bgcolor="#FOFOF7">
				<th>번호</th><th>내역</th><th><font color="green"><b>+</b></font></th><th><font color="red"><b>-</b></font></th><th>삭제</th>
			</tr>
		</table>
	</form><br>
		</div>
		<div style="float: right;">
		<br><br><br>
	사용가능금액 : <input type="text" id="acTotal" readonly="readonly" /><br>
	<%--insert into account (ac_pnum, acnum, acplus, acminus, accontents)
		values (#{ac_pnum}, seq_ac.nextval, #{acplus}, #{acminus}, #{accontents}) --%>
	<form action="writeAc.do" id="acWriteForm" method="post">
		<input type="hidden" id="ac_pnum" name="ac_pnum" value="${requestScope.pnum}" align="middle">
		내용 <textarea id="accontents" name="accontents" rows="1" cols="40" ></textarea><br>
		수입 <input type="text" id="acplus" name="acplus" value="0"/>
		지출 <input type="text" id="acminus" name="acminus" value="0"/>
		<input type="button" id="acWrite" value="등록">
	</form>
	<p></p>
	</div>
	</div>

</body>
<jsp:include page="bottomMenu.jsp" flush="true"/>
</html>
