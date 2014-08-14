<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="topBar.jsp" flush="false" />
	<jsp:include page="leftMenu.jsp" flush="false" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Account</title>
</head>

<script src="js/jquery-1.10.2.js"></script>
<script src="js/formValidation.js"></script>
<script>var jb = jQuery.noConflict();</script>
<script type="text/javascript">
	jb(document).ready(function(){
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
						table += "<tr><td>" + (index + 1) + "</td><td>" + item.accontents + "</td><td>" +  item.acplus + "</td><td>" +  item.acminus + "</td>";
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
		
		//삭제 버튼을 눌렀을 때 회계목록 삭제
		jb(document).on("click", "#del", function() {
			jb.ajax({
				url : "deleteAc.do", 
				type : "post",
				dataType : "text", 
				data : "acnum=" + jb(this).attr("name"),	
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
			}else{
//				jb("p").html("<font color='green'>정상실행</font>");
				jb.ajax({
					url : "writeAc.do",
					type : "post",
					dataType : "text", 				
					data : jb("#acWriteForm").serialize(),
					success : function(data) {
						if (data == "ok") {
							alert("회계 작성 성공");
							jb("textarea").val("내용을 입력하세요");
							jb("input[type=text]").val(0);
							getAcs();							
						} else {
							alert("회계 작성 실패");
						}
					},
					error : function(data) {//200이 안 넘어 왔을 때
						alert(data + ' : 회계 작성 실행시 에러 발생');
					}
				}); //end of ajax
			}
			
		});//end of 회계 작성 로직
		 
		//회계관리 화면 초기화
		getAcs();
		jb("#accontents").val("내용을 입력하세요");
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
	</form><br>
	사용가능금액 : <input type="text" id="acTotal" readonly="readonly" /><br>
<%-- 	insert into account (ac_pnum, acnum, acplus, acminus, accontents)
		values (#{ac_pnum}, seq_ac.nextval, #{acplus}, #{acminus}, #{accontents}) --%>
	<form action="writeAc.do" id="acWriteForm" method="post">
		<input type="hidden" id="ac_pnum" name="ac_pnum" value="${requestScope.pnum}">
		내용 <textarea id="accontents" name="accontents" rows="1" cols="40" ></textarea><br>
		수입 <input type="text" id="acplus" name="acplus" value="0"/>
		지출 <input type="text" id="acminus" name="acminus" value="0"/>
		<input type="button" id="acWrite" value="등록">
	</form>
	<p></p>
</body>
</html>
