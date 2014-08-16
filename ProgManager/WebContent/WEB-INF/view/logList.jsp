<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		var vLnum;
		var vCtext;
		//모든 로그를 불러오는 함수
		function getLogs() {
			jb.ajax({
				url : "allLogs.do", 
				type : "post",
				dataType : "json", 					//결과데이터타입
				data : "pnum="+jb("#l_pnum").val(),
				success : function(data) {
					var div = "";
					jb("#setLogs").children().remove();
//					alert(data.clist.length);
					jb(data.list).each(function(index, item) {//{no:값, name:값,...}
						//로그 div
					 	div += "<div class='logContent' id='"+ item.lnum +"'><table id='logTable'><tr><td>＃  </td><td>"+ item.l_uemail +"</td><td>"+ item.ltext +"</td></tr>";
						div += "<tr>";
						if(item.lpublic == 0){
							div += "<td>비공개</td>";
						}else if(item.lpublic == 1){
							div += "<td>공개</td>";
						}
						div += "<td>"+ item.ladmission +"</td><td>"+ item.ldata + "</td></tr></table></div>";
						//div += "<td><input type='button' value='코멘트 등록' id='addLc' name='"+ item.lnum +"'></td></tr></table></div>";
						
						//해당 로그의 코멘트 목록 div
						div += "<div class='lcContent'>";
						div += "<table><tbody id='commentBody'>";
						jb(data.clist).each(function(index, citem) {//{no:값, name:값,...}
							if(citem.c_lnum == item.lnum){
								div += "<tr><td>→</td>";
								div += "<td>"+citem.c_uemail+"</td>";
								div += "<td>"+citem.ctext+"</td>";
								div += "<td>"+ citem.cdate +"</td>";
								if(citem.c_uemail == jb("#l_uemail").val()){
									div += "<td><input type='button' value='삭제' id='del' name='"+citem.cnum+"'></td></tr>";
								}
							}	
						});	
						div += "</tbody></table></div>";
						
						//코멘트 작성창 div
						div += "<div class='lcWrite'><form action='writeLc.do' class='writeLcForm' id='writeLcForm"+ item.lnum +"' method='post'>";
						div += "<input type='hidden' class='c_lnum' id='c_lnum"+ item.lnum +"' name='c_lnum' value='"+ item.lnum +"'>";
						div += "<input type='hidden' class='uemail' id='c_uemail"+ item.lnum +"' name='c_uemail'>";
						div += "<input type='hidden' id='c_l_pnum"+ item.lnum +"' name='c_l_pnum' value="+jb("#l_pnum").val()+">";
						div += "<table><tfoot id='writeComment"+ item.lnum +"'><tr><td><textarea id='ctext"+ item.lnum +"' name='ctext' rows='2' cols='30'></textarea></td>";
						div += "<td><input type='button' id='writeLc' value='코멘트등록'></td></tr></tfoot></table>";
						
						div += "</form></div>";
					});
					jb("#setLogs").html(div);
					jb(".uemail").val(jb("#l_uemail").val());
				},
				error : function(err) {//실패했을때
					alert(err + " : 해당 프로젝트에는 로그가 아직 작성되지 않았습니다");
				}
			});//end of ajax
		} //end of getLogs()
		
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
		
		//코멘트 삭제 버튼을 눌렀을 때 코멘트 삭제
		jb(document).on("click", "#del", function() {
//			alert(jb(this).attr("name") + "삭제 성공");
			jb.ajax({
				url : "deleteLc.do", 
				type : "post",
				dataType : "text", 
				data : "cnum=" + jb(this).attr("name"),
				success : function(data) {
					if (data == "ok") {
						alert("삭제 성공");
						getLogs();
					} else {
						alert("삭제 실패");
					}
				},
				error : function(err) {//실패했을때
					alert(err + " : 코멘트 정보 삭제 실패");
				}
			}); 
		});//end of 코멘트 삭제
				 
		//코멘트 등록 버튼을 눌렀을 때 코멘트 등록
		jb(document).on("click", "#writeLc", function() {
			vLnum = "#"+jb(this).parent().parent().parent().parent().parent().attr("id"); //코멘트 등록하는 form의 id 추출
			vCtext = "#"+jb(this).parent().parent().parent().attr("id"); // 코멘트 입력창이 있는 table의 id 추출
//			alert(jb(vLnum).serialize() + " 등록 성공");
//			alert(vCtext);
//			alert(jb(vCtext + " textarea").attr("id"));
			if(jb(vCtext + " textarea").val() == ""){
				alert("내용을 입력하세요");
			}else{
				jb.ajax({
					url : "writeLc.do", 
					type : "post",
					dataType : "text", 
					data : jb(vLnum).serialize(),	
					success : function(data) {
						if (data == "ok") {
							alert("등록 성공");
							getLogs();
						} else {
							alert("등록 실패");
						}
					},
					error : function(err) {//실패했을때
						alert(err + " : 코멘트 정보 등록 실패");
					}
				}); 
			}
		 });//end of 코멘트 등록
		 		
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
					
					<%-- 로그마다 코멘트 창이 달려야 한다.
					코멘트 등록 버튼을 누르면 코멘트 목록이 비동기로 바뀌어야 한다.
					코멘트는 작성자만 삭제할 수 있다. --%>
					<c:forEach items="${requestScope.logsList}" var="logs">
						<!-- 로그내용 -->
						<div class="logContent">
							<table id="logTable">
								<tr>
									<td>＃  </td>
									<td>${logs.l_uemail}</td>
									<td>${logs.ltext}</td>
								</tr>
								<tr>
									<c:if test="${logs.lpublic == 0}"><td>비공개</td></c:if>
									<c:if test="${logs.lpublic == 1}"><td>공개</td></c:if>
									<td>${logs.ladmission}</td>
									<td>${logs.ldata}</td>
								</tr>
							</table>
						</div><!-- end of logContent -->
						
						<!-- 코멘트 목록 -->
						<c:forEach items="${requestScope.commentsList}" var="comment">
							<c:if test="${comment.c_lnum == logs.lnum }">
								<div class="lcContent">
									<table>
											<tbody id="commentBody">
												<tr>
													<td>-→</td>
													<td>${comment.c_uemail }</td>
													<td>${comment.ctext}</td>
													<td>${comment.cdate}</td>
													<c:if test="${comment.c_uemail == sessionScope.userData.uemail}">
														<td><input type="button" value="삭제" id="del" name="${comment.cnum}"></td>
													</c:if>
												</tr>
											</tbody>
										</table>					
								</div><!-- end of lcContent -->
							</c:if>
						</c:forEach>
						
						<!-- 코멘트 입력창 -->
						<div class="lcWrite">
							<form action="writeLc.do" class="writeLcForm" id="writeLcForm${logs.lnum}" method="post">
								<input type="hidden" id="c_lnum${logs.lnum}" name="c_lnum" value="${logs.lnum}">
								<input type="hidden" id="c_uemail${logs.lnum}" name="c_uemail" value="${sessionScope.userData.uemail}">
								<input type="hidden" id="c_l_pnum${logs.lnum}" name="c_l_pnum" value="${logs.l_pnum}">
								
								<table>
									<tfoot id="writeComment${logs.lnum}">
										<tr>
											<td><textarea id="ctext${logs.lnum}" name="ctext" rows="2" cols="30"></textarea></td>
											<td><input type="button" id="writeLc" value="코멘트등록"></td>
										</tr>
									</tfoot>
								</table>
							</form>
						</div><!-- end of lcWrite -->
					
					</c:forEach><!-- end of log loop -->
					
				</div><!-- end of setLogs -->
				
			</div><!-- end of logsList -->		
		</fieldset>	
	</div><!-- end of logsView -->	
</body>
</html>
