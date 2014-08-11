<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>${requestScope.title }</title>
</head>
<%
	String email = (String)request.getAttribute("email");
	String pw = (String)request.getAttribute("pw");
	String name = (String)request.getAttribute("name");
	String phone = (String)request.getAttribute("phone");
	
	HashMap userData = new HashMap();
	userData.put("uemail", email);
	userData.put("upw", pw);
	userData.put("uname", name);
	userData.put("uphone", phone);
	session.setAttribute("userData", userData);

%>
<script src="js/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(document).ready(	function() {
			
		var pleader = $("#pleader").val();
			
		// 프로젝트 생성하기 버튼을 클릭했을때 project table에 저장되는 로직
		$("#btn").click(function() {
			$.ajax({
				url : "newProject.do",
				type : "post",
				dataType : "text", 
				data : $("#newproform").serialize(),
				success : function(data) {
					if (data == "ok") {
						alert("프로젝트 생성 완료");
						$("input[type=text]").val("");	//text박스 모두 지우기
						$("input[type=password]").val("");
						$("#pleader").val(pleader);
						getData();							//모든레코드 검색하는 함수 호출
					} else {
						alert("가입 실패");
					}
				},
				error : function(data) {
					alert(data + ' : 가입로직 실행시 에러 발생');
				}
			}); //end of ajax
		});//end of 가입로직

		// 해당 유저의 email로 등록된 모든 프로젝트 검색 후 출력
		function getData() {
			$.ajax({
				url : "getProjectList.do",
				data : "uemail=" + $("#pleader").val(),
				type : "post",
				dataType : "json", 					//결과데이터타입
				success : function(data) {
					var table = "";
					//기존에 있는 테이블 첫행만 빼고 지우기
					//http://www.w3schools.com/jquery/tryit.asp?filename=tryjquery_sel_gt
					$("#projectlistTable tr:gt(0)").remove();
					
					$(data.list).each(function(index, project) {
						table += "<tr><td>" + project.pnum + "</td><td>" + project.pname + "</td><td>" +  project.pmento + "</td>";
						table += "<td>" + project.pstart + "</td><td>" + project.pend + "</td><td>" + project.pleader + "</td><td>";
						table += "<form action='enterProjectMain.do' id='enterProject' method='post'><input type='submit' value='입장하기'/>";
						table += "<input type='hidden' id='pnum' name='pnum' value='"+project.pnum+"'/>";
						table += "<input type='hidden' id='uemail' name='uemail' value='"+$("#curUser").val()+"'/></form>";
						
					});
					//테이블에 추가
					$("#projectlistTable tr:eq(0)").after(table);
				},
				error : function(err) {//실패했을때
					alert(err + " : 모든 프로젝트 정보 불러오기 실패");
				}
			}); //end of ajax
		}//end of getData()
		

		//레코드 가져오기는 함수 호출
		getData();

	});//end of ready()
</script>

<body>
	이메일 - ${requestScope.email}<br>
	비밀번호 - ${requestScope.pw}<br>
	이름 - ${requestScope.name}<br>
	전화번호 - ${requestScope.phone}<br>
	
	<br><hr><br>
	
	<h2>New Project</h2>
	<input type="hidden" id="curUser" name="curUser" value="${requestScope.email}">
	<form name="newProject.do" id="newproform" method="post">
		Project Name <input type="text"  name="pname" /><br>
		Project PassWord <input type="password" name="ppw" /><br>
		Project Mendo ID <input type="text" name="pmento" /><br>
		Project Start Date <input type="text" name="pstart" /><br>
		Project End Date <input type="text" name="pend" /><br>
		Project Leader <input type="text" name="pleader" id="pleader" value="${requestScope.email}"/><br>
		<input type="button" value="생성하기" id="btn">
	</form>
	
	<input type="button" value="테스트" onclick="">
	
	<h2>모든 프로젝트 정보 보기</h2>
		<table cellspacing="0">
			<tr>
				<td style="text-align: right">
					<input type="button" value="모든 학생 정보 보기">
				</td>
			</tr>
		</table>
		<table id="projectlistTable" cellspacing="0">
			<tr bgcolor="#FOFOF7">
				<th>프로젝트 번호</th><th>이름</th><th>담당자</th><th>시작일</th><th>종료일</th><th>팀장</th><th>입장</th>
			</tr>
			
		</table>
	
	<!-- <a href="WEB-INF/view/updateInfo.jsp">개인정보 변경 화면</a> -->
	<!-- <input type="button" value="수정하기"	Onclick="location.href='updateInfo.jsp'"> -->
	<form action="sendEmail.do" id="userEmail" method="post">
		<input type="submit" value="개인정보 변경하기"/>
	</form>
		
	
</body>
</html>
