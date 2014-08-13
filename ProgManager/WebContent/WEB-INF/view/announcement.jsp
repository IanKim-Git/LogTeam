<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Announcement</title>
</head>
<script src="js/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//모든 공지사항을 불러오는 함수
		function getAns() {
			$.ajax({
				url : "allAns.do", 
				type : "post",
				dataType : "json", 					//결과데이터타입
				data : "pnum="+$("#an_pnum").val(),
				success : function(data) {
					var table = "";
					$("#listTable tr:gt(0)").remove();
//					<th>번호</th><th>내용</th><th>날짜</th><th>등록자</th><th>중요도</th><th>삭제</th>
					var count = data.list.length;
					//data.list로 온 데이터 : [{no:값, name:값,...}, {no:값, name:값,...}, {no:값, name:값,...}, ...]
					$(data.list).each(function(index, item) {//{no:값, name:값,...}
						table += "<tr><td>" + (count--) + "</td><td>" + item.ancontent + "</td><td>" +  item.andate + "</td><td>" +  item.an_uemail + "</td>";
						if(item.animportance == 3){
							table += "<td>상</td><td>";
						}else if(item.animportance == 2){
							table += "<td>중</td><td>";
						}else if(item.animportance == 1){
							table += "<td>하</td><td>";
						}						
						table += "<input type='button' value='삭제' id='del' name='"+item.annum+"'></td></tr>";
					});
					//테이블에 추가
					$("#listTable tr:eq(0)").after(table);
				},
				error : function(err) {//실패했을때
					alert(err + " : 해당 프로젝트에는 공지사항이 아직 작성되지 않았습니다");
				}
			});//end of ajax
		} //end of getAns()
		
		//삭제 버튼을 눌렀을 때 공지사항 삭제
		$(document).on("click", "#del", function() {
			$.ajax({
				url : "deleteAn.do", 
				type : "post",
				dataType : "text", 
				data : "annum=" + $(this).attr("name"),	//서버에 전송할 데이터 : <input type='button' value='삭제' id='del' name='"+item.no+"'>
				success : function(data) {
					if (data == "ok") {
						alert("삭제 성공");
						getAns();
					} else {
						alert("삭제 실패");
					}
				},
				error : function(err) {//실패했을때
					alert(err + " : 공지사항 정보 삭제 실패");
				}
			});
		});//end of 공지사항 삭제
		
		//공지사항 등록
		$("#anWrite").click(function() {
			$.ajax({
				url : "writeAn.do",
				type : "post",
				dataType : "text", 				
				data : $("#anWriteForm").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("공지사항 작성 성공");
						$("textarea").val("");	
						getAns();							
					} else if(data == "again") {
						alert("공지사항 중요도를 선택하세요.");
					} else {
						alert("공지사항 작성 실패");
					}
				},
				error : function(data) {//200이 안 넘어 왔을 때
					alert(data + ' : 공지사항 작성 실행시 에러 발생');
				}
			}); //end of ajax
		});//end of 공지사항 작성 로직
		
		
		//공지사항 화면 초기화
		getAns();
	});//end of ready
</script>
<body>

	<h6>공지사항</h6>
	프로젝트 번호 : ${requestScope.pnum}
	유저 이메일 : ${sessionScope.userData.uemail}<br>
	<form action="writeAn.do" id="anWriteForm" method="post">
		<select id="animportance" name="animportance">
			<option value="-1">선택</option>
			<option value="3">상</option>
			<option value="2">중</option>
			<option value="1">하</option>
		</select><br>
		<input type="hidden" id="an_pnum" name="an_pnum" value="${requestScope.pnum}">
		<input type="hidden" id="an_uemail" name="an_uemail" value="${sessionScope.userData.uemail}">
		<textarea id="ancontent" name="ancontent" rows="5" cols="60" ></textarea>
		<input type="button" id="anWrite" value="등록">		
	</form>
	
	<form action="" id="anListForm">			
		<table id="listTable" cellspacing="0">
			<tr bgcolor="#FOFOF7">
				<th>번호</th><th>내용</th><th>날짜</th><th>등록자</th><th>중요도</th><th>삭제</th>
			</tr>
		</table>
	</form>
</body>
</html>