<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="topBar.jsp" flush="false" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="description" content="Css Progress Bar">

<title>Project Information</title>

<link href="css/projectMenu.css" rel="stylesheet" />
<script src="js/login.js"></script>
<script src="js/jquery-1.10.2.js"></script>

<script>var jb = jQuery.noConflict();</script>
<script type="text/javascript">
	$(document).ready(function(){
		var nflag = false;
		var pflag = false;
		var sflag = true;
		var eflag = true;
		
		var str = '';
		
		var imsi = $('#pst').val();
		var imsi2 = $('#ped').val();
		
		var cpstart = imsi.substring(0,4) +"-"+ imsi.substring(5,7) +"-"+ imsi.substring(8,10);
		var cpend = imsi2.substring(0,4) +"-"+ imsi2.substring(5,7) +"-"+ imsi2.substring(8,10);
		
		$.ajax({
			url : "getProjectLeader.do",
			type : "post",
			dataType : "text", 
			data : $("#proDel").serialize(),
			success : function(data) {
				$('#pstart').val(cpstart);
				$('#pend').val(cpend);
				$("#term").html(cpstart + " ~ " + cpend);
				
				if($('#prodate').val() <= 100 && $('#prodate').val() >= 0){
					$('#percentage').html($('#prodate').val());
				}else if($('#prodate').val() < 0){
					$('#percentage').html("0");
				}
				else if($('#prodate').val() > 100){
					$('#percentage').html("100");
				}
				
				if (data == "ok" && $('#puser').val()!=$('#pleader').val()){
					$('#change').attr('disabled',true);
					$('#deletePro').attr('disabled',true);
					$("#caution").html("*PM만이 프로젝트 정보를 변경할 수 있습니다.");
				}
			},
			error : function(data) {
				alert(data + ' : 버튼 비활성시 에러 발생');
			}
		}); //end of ajax
		
		$("#pname").keyup(function(){
			if($("#pname").val() == ""){
				nflag = false;
			}else{
				nflag = true;
			} 
		});
		
		$("#ppwAgain").keyup(function(){
			if($("#ppw").val() != $("#ppwAgain").val()){
				pflag = false;
			}else{
				pflag = true;
			} 
		});
		
		$("#pstart").keyup(function(){
			if($("#pstart").val() == ""){
				sflag = false;
			}else{
				sflag = true;
			} 
		});
		
		$("#pend").keyup(function(){
			if($("#pend").val() == ""){
				eflag = false;
			}else{
				eflag = true;
			} 
		});
	
	 $("#change").click(function(){
		 if(!nflag){
			alert("프로젝트 이름을 제대로 입력하십시오");
			return false;
		}
		 
		if(!pflag){
			alert("패스워드를 다시 입력하십시오");
			$("#ppw").val("");
			$("#ppwAgain").val("");
			//location.reload();
			return false;
		}
		
		if(!sflag || !eflag){
			alert("프로젝트 시작 날짜와 끝나는 날짜를 제대로 입력하십시오");
			return false;
		}
		
		$.ajax({
			url : "proUpdate.do",
			type : "post",
			dataType : "text", 
			data : $("#proupdateform").serialize(),
			success : function(data) {
				if (data == "ok") {
					alert("프로젝트 정보 변경 성공!");
					$("#proname").html($("#pname").val());
					str = $("#pstart").val() + " ~ " +$("#pend").val();
					$("#term").html(str);
					
					$("#pname").val("");
					$("#ppw").val("");
					$("#ppwAgain").val("");
					$("#pstart").val(cpstart);
					$("#pend").val(cpend);	
				} else {
					alert("프로젝트 정보 변경 실패");
				}
			},
			error : function(data) {
				alert(data + ' : 프로젝트 정보 변경 로직 실행시 에러 발생');
			}
		}); //end of ajax 
	});//end of change button
	
	$("#deletePro").click(function(){
		alert("프로젝트를 삭제합니다");
	});//end of deletPro button
});//end of ready
</script>

<style>

/* SINGLE PROGRESS BAR */

.progressBar{
	width:216px;
	height:41px;;
	background:url(bg_bar.gif) no-repeat 0 0;
	position:relative;
}
.progressBar b{
	position:absolute;
	display:block;
	width:200px;
	height:25px;
	background:url(bar.gif) no-repeat 0 0;
	top:8px;
	left:8px;
	overflow:hidden;
	text-indent:-8000px;
}
.progressBar e{
	position:absolute;
	display:block;
	width:200px;
	height:25px;
	background:url(bg_cover.gif) repeat-x 0 0;
	top:0;
}

</style>

</head>

<body>
	<br><br>
	<%-- <h6>프로젝트 화면</h6>
	프로젝트 번호 : ${requestScope.pnum}
	유저 이메일 : ${sessionScope.userData.uemail}<br> --%>
	<div id="projectInformation" align="center">
	<img src="./images/projectinfo.png" align="left" style="margin: 3% 0 0 2%;float: left;"><br>
	<div class='contents' style="margin-top: 9px" >
	<br><br><br>
	
	<form action="" id="info" method="post">
    	<b> 
    	<br><font color="#5A5A5A" style="font-style: initial;" size="5">프로젝트 이름 : &nbsp;&nbsp;<b id="proname">${requestScope.pinfo.pname}</b></font><br>
    	<br><font color="#5A5A5A" style="font-style: initial;" size="5">프로젝트 방 번호 : &nbsp;&nbsp;${requestScope.pinfo.pnum}</font><br>
    	<br><font color="#5A5A5A" style="font-style: initial;" size="5">기간 : <b id="term"></b></font><br>
    	<br><font color="#5A5A5A" style="font-style: initial;" size="5">프로젝트 경과율:</font>&nbsp;&nbsp;
    
    	<c:if test="${requestScope.prodate <= 0}">
	   		<div class="progressBar">
				<b><e style="left:0px"></e></b>
			</div>
		</c:if>
		<c:if test="${requestScope.prodate >= 100}">
	   		<div class="progressBar">
				<b><e style="left:200px"></e></b>
			</div>
		</c:if>
		<c:if test="${requestScope.prodate > 0 && requestScope.prodate < 100}">
	   		<div class="progressBar">
				<b><e style="left:${requestScope.prodate*2}px"></e></b>
			</div>
		</c:if>
		<font color="#5A5A5A" style="font-style: initial;" size="5"><b id="percentage"></b>%</font>
    </form>	
	</div>
    	<br>
		<font color="#5A5A5A" style="font-style: initial;" size="5">팀원 정보 : &nbsp;</font>
		<br><br>
	<div id="userList">
		<table border="0" cellpadding="0" cellspacing="1" width="80%" bordercolordark="white" bordercolorlight="black">
			<tr>
		        <td bgcolor="#9b2626">
		            <p align="center"><font color="white"><b><span style="font-size:12pt;">Photo</span></b></font></p>
		        </td>
		        <td bgcolor="#9b2626" >
		            <p align="center"><font color="white"><b><span style="font-size:12pt;">Nickname</span></b></font></p>
		        </td>
		        <td bgcolor="#9b2626">
		            <p align="center"><font color="white"><b><span style="font-size:12pt;">Mobile</span></b></font></p>
		        </td>
		        <td bgcolor="#9b2626">
		            <p align="center"><font color="white"><b><span style="font-size:12pt;">E-mail</span></b></font></p>
		        </td>
		    </tr>
		    
		<c:forEach items="${requestScope.puser}" var = "data">
			 <tr>
				        <td bgcolor="#F5E9E9">
				            <p align="center"><img id="barUserPhoto" src="${data.uPhoto}" width="50" height="50" border="0" style="margin: -19px -20px -20px -20px;">
				        	</p>
				        </td>		    
				        <td bgcolor="#F5E9E9">		        
				            <p align="center"><font style="font-style: oblique;" size="3pt">${data.uname}</font></p>
				        </td>
				        <td bgcolor="#F5E9E9">
				            <p align="center"><font style="font-style: oblique;" size="3pt">${data.uphone}</font></p>
				        </td>
				        <td bgcolor="#F5E9E9">
				            <p align="center"><font style="font-style: oblique;" size="3pt">${data.uemail}</font></p>
				        </td>
				    </tr>
		</c:forEach>
		</table>
	</div>
	</div>
	
	<div id="projectInfoChange" style="border-left:2px solid; padding:9px;">

		 <br><br><br><br><br>
		 <div align="left" >
			 <font color="#9B2626" size="6" style="font-style: oblique;">Info Change.</font><br><br>
			 <font color="#5A5A5A" size="3" style="font-style: oblique;">
			 <form action="proUpdate.do" id="proupdateform" method="post">
			 	<table border="0" width="70%" height="7%" cellspacing="5">
					<tr>
 						<td>Project Name :</td>
 						<td><input type="text"  name="pname" id="pname"/></td>
					</tr>
					<tr>
 						<td>Project PassWord :</td>
 						<td><input type="password" name="ppw" id="ppw"/><br></td>
					</tr>
					<tr>
 						<td>Reenter PassWord :</td>
 						<td><input type="password" name="ppwAgain" id="ppwAgain"/></td>
					</tr>
					<tr>
 						<td>Start Date :</td>
 						<td><input type="text" name="pstart" id="pstart"/></td>
					</tr>
					<tr>
 						<td>End Date :</td>
 						<td><input type="text" name="pend" id="pend"/></td>
					</tr>
				</table>
				<input type="hidden" name="pnum" id="pnum" value="${requestScope.pinfo.pnum}">
				<input type="button" id="change" value="확인"/>
			</form>				
			</font>
			<form action="deleteProject.do" id="proDel" method="post">
				<input type="hidden" name="pnum" id="pnum" value="${requestScope.pinfo.pnum}">
				<input type="hidden" name="pleader" id="pleader" value="${requestScope.pleader}">
				<input type="hidden" name="puser" id="puser" value="${sessionScope.userData.uemail}">
				<input type="hidden" name="prodate" id="prodate" value="${requestScope.prodate}">
				<input type="hidden" name="pst" id="pst" value="${requestScope.pinfo.pstart}">
				<input type="hidden" name="ped" id="ped" value="${requestScope.pinfo.pend}">
				<input type="submit" id="deletePro" value="프로젝트 삭제"/>
				<br><font color="#FF0000" style="font-style: initial;" size="4pt"><b id="caution"></b></font>
			</form>
		 </div>
	</div>	
</body>
<br>
<jsp:include page="bottomMenu.jsp" flush="true"/>
</html>

