<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Account</title>
</head>
<script src="js/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//모든 회계 목록을 불러오는 함수
		function getAcs() {
			$.ajax({
				url : "allAcs.do", 
				type : "post",
				dataType : "json", 					//결과데이터타입
				data : "pnum="+$("#ac_pnum").val(),
				success : function(data) {
					var table = "";
					$("#listTable tr:gt(0)").remove();
//	<th>번호</th><th>내역</th><th><font color="green"><b>+</b></font></th><th><font color="red"><b>-</b></font></th><th>삭제</th>
					var sumPlus = 0;
					var sumMinus = 0;
					$(data.list).each(function(index, item) {
						table += "<tr><td>" + (index + 1) + "</td><td>" + item.accontents + "</td><td>" +  item.acplus + "</td><td>" +  item.acminus + "</td>";
						table += "<td><input type='button' value='삭제' id='del' name='"+item.acnum+"'></td></tr>";
						sumPlus += item.acplus;
						sumMinus += item.acminus;
					});
					//테이블에 추가
					$("#listTable tr:eq(0)").after(table);
					//사용가능금액 계산
					$("#acTotal").val(sumPlus-sumMinus);
				},
				error : function(err) {//실패했을때
					alert(err + " : 해당 프로젝트에는 공지사항이 아직 작성되지 않았습니다");
				}
			});//end of ajax
		} //end of getAcs()
		
		//삭제 버튼을 눌렀을 때 회계목록 삭제
		$(document).on("click", "#del", function() {
			$.ajax({
				url : "deleteAc.do", 
				type : "post",
				dataType : "text", 
				data : "acnum=" + $(this).attr("name"),	
				success : function(data) {
					if (data == "ok") {
						alert("삭제 성공");
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
		/*
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
						getAcs();							
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
		 */
		//회계관리 화면 초기화
		getAcs();
	});//end of ready

</script>
<body>
	<h6>회계관리</h6>
	프로젝트 번호 : ${requestScope.pnum}
	유저 이메일 : ${sessionScope.userData.uemail}<br>
	<form action="" id="acListForm">			
		<table id="listTable" cellspacing="0">
			<tr bgcolor="#FOFOF7">
				<th>번호</th><th>내역</th><th><font color="green"><b>+</b></font></th><th><font color="red"><b>-</b></font></th><th>삭제</th>
			</tr>
		</table>
	</form>
	사용가능금액 : <input type="text" id="acTotal" readonly="readonly" />
<%-- 	insert into account (ac_pnum, acnum, acplus, acminus, accontents)
		values (#{ac_pnum}, seq_ac.nextval, #{acplus}, #{acminus}, #{accontents}) --%>
	<form action="writeAc.do" id="acWriteForm" method="post">
		<input type="hidden" id="ac_pnum" name="ac_pnum" value="${requestScope.pnum}">
		<textarea id="accontents" name="accontents" rows="1" cols="40" ></textarea>
		<input type="text" id="acplus" name="acplus" />
		<input type="text" id="acminus" name="acminus" />
<!-- 		<textarea id="acplus" name="acplus" rows="1" cols="20" ></textarea>
		<textarea id="acminus" name="acminus" rows="1" cols="20" ></textarea> -->
		<input type="button" id="acWrite" value="등록">
	</form>
</body>
</html>