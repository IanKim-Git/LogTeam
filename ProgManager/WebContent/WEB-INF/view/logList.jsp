<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="topBar.jsp" flush="false" />
	<jsp:include page="leftMenu.jsp" flush="false" />
	
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Log List</title>
</head>

<script src="js/jquery-1.10.2.js"></script>
<script>var jb = jQuery.noConflict();</script>

<script type="text/javascript">
	jb(document).ready(function(){
		//모든 로그를 불러오는 함수
		function getLogs() {
			jb.ajax({
				url : "allLogs.do", 
				type : "post",
				dataType : "json", 					//결과데이터타입
				data : "pnum="+jb("#l_pnum").val(),
				success : function(data) {
					var div = "";
					var input = "";
					var table = "";
					jb("#setLogs").children().remove();
					/*
					<div class="logContent">
						<table id="logTable">
							<tr>
								<td>작성자</td>
								<td>내용</td>
								<td>작성일</td>
								<td>공개여부</td>
								<td>승인여부</td>
							</tr>
						</table>
					</div>
					<div class='lcContent'>
						<form action="writeLc.do" id="writeLcForm" method="post">
							<input type="hidden" id="c_lnum" name="c_lnum" value="">
							<input type="hidden" id="c_uemail" name="c_uemail" value="">
							<input type="hidden" id="c_l_pnum" name="c_l_pnum" value="">
							<table>
								<tbody id="commentBody">
								</tbody>
								<tfoot id="writeComment">
									<tr>
										<td><textarea id="ctext" name="ctext" rows="2" cols="30"></textarea></td>
										<td><input type="button" id="writeLc" value="코멘트등록"></td>
									</tr>
								</tfoot>
							</table>
						</form>
					</div><!-- end of comment -->
					
					div += "<div class='lcContent'><form action='writeLc.do' id='writeLcForm' method='post'></form></div>";
					input = "<input type='hidden' id='c_lnum' name='c_lnum'><input type='hidden' id='c_uemail' name='c_uemail'><input type='hidden' id='c_l_pnum' name='c_l_pnum'>";
					jb("#writeLcForm").html(input);
					jb("#c_lnum").val(item.lnum);
					jb("#c_uemail").val() = jb("#l_uemail").val();
					jb("#c_l_pnum").val(item.l_pnum);
					table = "<table><tbody id='commentBody'></tbody><tfoot id='writeComment'><tr>"+
							"<td><textarea id='ctext' name='ctext' rows='2' cols='30'></textarea></td>"+
							"<td><input type='button' id='writeLc' value='코멘트등록'></td></tr></tfoot></table>";
					jb()
						
					
				
					*/
					 jb(data.list).each(function(index, item) {//{no:값, name:값,...}
						div += "<div class='logContent' id='"+ item.lnum +"'><table id='logTable'><tr><td>"+ item.l_uemail +"</td><td>"+ item.ltext +"</td>";
						
						div += "<td>"+ item.ldata + "</td>";
						if(item.lpublic == 0){
							div += "<td>비공개</td>";
						}else if(item.lpublic == 1){
							div += "<td>공개</td>";
						}
						div += "<td>"+ item.ladmission +"</td></tr></table></div>";
						div += "<div class='lcContent'><form action='writeLc.do' id='writeLcForm' method='post'></form></div>";
						//div += "<td><input type='button' value='코멘트 등록' id='addLc' name='"+ item.lnum +"'></td></tr></table></div>";
						/*
						<form id='lcWriteForm' method='post' action=''>
							<input type='hidden' id='c_lnum' name='c_lnum' value=''>
							<input type='hidden' id='c_l_pnum' name='c_l_pnum' value=''>
							<input type='button' value='코멘트 등록' id='addLc'>
						</form>
						*/
//						getLcs(item.lnum, item.l_pnum);
					});
					jb("#setLogs").html(div); 
				},
				error : function(err) {//실패했을때
					alert(err + " : 해당 프로젝트에는 로그가 아직 작성되지 않았습니다");
				}
			});//end of ajax
		} //end of getLogs()
		
		//코멘트 목록 초기화(일단 코멘트만 나오게)
		function getLcs(c_lnum, c_l_pnum){
			jb.ajax({
				url : "allLcs.do", 
				type : "post",
				dataType : "json", 		
				data : "lnum="+c_lnum+"&pnum="+c_l_pnum,
				success : function(data) {
					var comments = "";
					/*
					<tbody id="commentBody">
						<tr>
							<td>-→</td>
							<td>작성자</td>
							<td>내용</td>
							<td>작성일</td>
							<td>코멘트삭제</td>
						</tr>
						<tr>
							<td>-→</td>
							<td>작성자</td>
							<td>내용</td>
							<td>작성일</td>
							<td>코멘트삭제</td>
						</tr>
					</tbody>
					*/
					 jb(data.list).each(function(index, item) {//{no:값, name:값,...}
						
					});
					return comments;
				},
				error : function(err) {//실패했을때
					alert(err + " : 해당 프로젝트에는 코멘트가 아직 작성되지 않았습니다");
				}
			});//end of ajax
		}//end of getLcs()
		
		/* 
		//코멘트 등록 버튼을 눌렀을 때 코멘트 등록
		jb(document).on("click", "#del", function() {
			jb.ajax({
				url : "deleteLog.do", 
				type : "post",
				dataType : "text", 
				data : "lnum=" + jb(this).attr("name"),	//서버에 전송할 데이터 : <input type='button' value='삭제' id='del' name='"+item.no+"'>
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
		 */
		//로그 등록
		jb("#write").click(function() {
			if(jb("#ltext").val() == ""){
				alert("내용을 입력하세요.");
			}else{
				jb.ajax({
					url : "write.do",
					type : "post",
					dataType : "text", 				
					data : jb("#writeForm").serialize(),
					success : function(data) {
						if (data == "ok") {
							alert("로그 작성 성공");
							jb("textarea").val("");	
							getLogs();							
						} else if(data == "again") {
							alert("로그 공개여부를 선택하세요.");
						} else {
							alert("로그 작성 실패");
						}
					},
					error : function(data) {//200이 안 넘어 왔을 때
						alert(data + ' : 로그 작성 실행시 에러 발생');
					}
				}); //end of ajax
			}
		});//end of 로그 작성 로직
		
		
		//로그화면 초기화
		getLogs();
	});//end of ready
</script>
<body>
	<h6>로그게시판</h6>
	프로젝트 번호 : ${requestScope.pnum}
	유저 이메일 : ${sessionScope.userData.uemail}<br>
	
	<!-- 로그 화면 -->
	<div id="logsView" align="left">
		<fieldset>
			<!-- 로그 등록창 -->
			<div id="writeLog">
				<form action="write.do" id="writeForm" method="post">
					<input type="hidden" id="l_pnum" name="l_pnum" value="${requestScope.pnum}">
					<input type="hidden" id="l_uemail" name="l_uemail" value="${sessionScope.userData.uemail}">
					<table>
						<!-- 내용 -->
						<tr>
							<th rowspan="5">
								<textarea id="ltext" name="ltext" rows="5" cols="60" ></textarea>
							</th>
						</tr>
						<!-- 공개여부 -->
						<tr>
							<td>
							<select id="lpublic" name="lpublic">
								<option value="-1">선택</option>
								<option value="0">비공개</option>
								<option value="1">공개</option>
							</select>
							</td>
						</tr>
						<tr><td></td></tr>
						<tr><td></td></tr>
						<!-- 등록버튼 -->
						<tr>
							<td>
								<input type="button" id="write" value="로그등록">
							</td>
						</tr>
					</table>				
				</form>
			</div><!-- end of writeLog -->
			
			
			<!-- 로그 목록 -->
			<div id="logsList">
				<!-- jQuery 함수 사용을 위해서 선언 -->
				<div id="setLogs">
					
					<!-- 로그마다 코멘트 창이 달려야 한다. -->
					<!-- 코멘트 등록 버튼을 누르면 코멘트 목록이 비동기로 바뀌어야 한다. -->
					<!-- 코멘트는 작성자만 삭제할 수 있다. -->
					<!-- <table id="listTable" cellspacing="0">
						<tr bgcolor="#FOFOF7" >
							<th>로그번호</th><th>작성자</th><th>작성일</th><th>내용</th><th>공개여부</th><th>승인여부</th><th>코멘트등록</th>
						</tr>
					</table> -->
					<div class="logContent">
						<table id="logTable">
							<tr>
								<td>작성자</td>
								<td>내용</td>
								<td>작성일</td>
								<td>공개여부</td>
								<td>승인여부</td>
							</tr>
						</table>
					</div>
					<!-- jb("")
						 jb(".logContent").after(".lcContent");
						 jb("#c_lnum").val(c_lnum);
						 jb("#c_uemail").val(c_uemail);
						 jb("#c_l_pnum").val(c_l_pnum);
						 jb("#commentBody").html();
					
					 -->
					<div class='lcContent'>
						<form action="writeLc.do" id="writeLcForm" method="post">
							<input type="hidden" id="c_lnum" name="c_lnum" value="">
							<input type="hidden" id="c_uemail" name="c_uemail" value="">
							<input type="hidden" id="c_l_pnum" name="c_l_pnum" value="">
							<table>
								<tbody id="commentBody">
									<tr>
										<td>-→</td>
										<td>작성자</td>
										<td>내용</td>
										<td>작성일</td>
										<td>코멘트삭제</td>
									</tr>
									<tr>
										<td>-→</td>
										<td>작성자</td>
										<td>내용</td>
										<td>작성일</td>
										<td>코멘트삭제</td>
									</tr>
								</tbody>
								<tfoot id="writeComment">
									<tr>
										<td><textarea id="ctext" name="ctext" rows="2" cols="30"></textarea></td>
										<td><input type="button" id="writeLc" value="코멘트등록"></td>
									</tr>
								</tfoot>
							</table>
						</form>
					</div><!-- end of comment -->
					
				</div><!-- end if setLogs -->
				
			</div><!-- end of logsList -->	
			
			
			
		</fieldset>	
	</div><!-- end of logsView -->	
</body>
</html>
