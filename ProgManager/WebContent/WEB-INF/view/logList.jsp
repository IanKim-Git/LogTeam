<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Log List</title>
</head>
<script src="js/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//모든 로그를 불러오는 함수
		function getLogs() {
			$.ajax({
				url : "allLogs.do", 
				type : "post",
				dataType : "json", 					//결과데이터타입
				data : "pnum="+$("#l_pnum").val(),
				success : function(data) {
					var table = "";
					$("#listTable tr:gt(0)").remove();
//					<th>로그번호</th><th>작성자</th><th>작성일</th><th>내용</th><th>공개여부</th><th>승인여부</th><th>삭제</th>
					
					//data.list로 온 데이터 : [{no:값, name:값,...}, {no:값, name:값,...}, {no:값, name:값,...}, ...]
					$(data.list).each(function(index, item) {//{no:값, name:값,...}
						table += "<tr><td>" + (index+1) + "</td><td>" + item.l_uemail + "</td><td>" +  item.ldata + "</td><td>" +  item.ltext + "</td>";
						table += "<td>" + item.lpublic + "</td><td>" + item.ladmission + "</td><td>";
						table += "<input type='button' value='삭제' id='del' name='"+item.lnum+"'></td></tr>";
					});
					//테이블에 추가
					$("#listTable tr:eq(0)").after(table);
				},
				error : function(err) {//실패했을때
					alert(err + " : 해당 프로젝트에는 로그가 아직 작성되지 않았습니다");
				}
			});//end of ajax
		} //end of getLogs()
		
		//삭제 버튼을 눌렀을 때 로그 삭제
		$(document).on("click", "#del", function() {
			$.ajax({
				url : "deleteLog.do", 
				type : "post",
				dataType : "text", 
				data : "lnum=" + $(this).attr("name"),	//서버에 전송할 데이터 : <input type='button' value='삭제' id='del' name='"+item.no+"'>
				success : function(data) {
					if (data == "ok") {
						alert("삭제 성공");
						getLogs();
					} else {
						alert("삭제 실패");
					}
				},
				error : function(err) {//실패했을때
					alert(err + " : 로그 정보 삭제 실패");
				}
			});
		});//end of 로그 삭제
		
		//로그 등록
		$("#write").click(function() {
			$.ajax({
				url : "write.do",
				type : "post",
				dataType : "text", 				
				data : $("#writeForm").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("로그 작성 성공");
						$("textarea").val("");	
						getLogs();							
					} else {
						alert("로그 작성 실패");
					}
				},
				error : function(data) {//200이 안 넘어 왔을 때
					alert(data + ' : 로그 작성 실행시 에러 발생');
				}
			}); //end of ajax
		})//end of 로그 작성 로직
		
		
		//로그화면 초기화
		getLogs();
	});//end of ready
</script>
<body>
	<h6>로그게시판</h6>
	프로젝트 번호 : ${requestScope.pnum}
	유저 이메일 : ${sessionScope.userData.uemail}<br>
	
	<form action="write.do" id="writeForm" method="post">
		<input type="hidden" id="l_pnum" name="l_pnum" value="${requestScope.pnum}">
		<input type="hidden" id="l_uemail" name="l_uemail" value="${sessionScope.userData.uemail}">
		<textarea id="ltext" name="ltext" rows="5" cols="60" ></textarea>
		<input type="button" id="write" value="로그등록">		
	</form>
	
	<form action="" id="logListForm">			
		<table id="listTable" cellspacing="0">
			<tr bgcolor="#FOFOF7">
				<th>로그번호</th><th>작성자</th><th>작성일</th><th>내용</th><th>공개여부</th><th>승인여부</th><th>삭제</th>
			</tr>
		</table>
	</form>
	
	
</body>
</html>