<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="topBar.jsp" flush="false" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Project Information</title>

<link href="css/projectMenu.css" rel="stylesheet" />
<script src="js/login.js"></script>
<script src="js/jquery-1.10.2.js"></script>

<script>var jb = jQuery.noConflict();</script>
<script type="text/javascript">
	$(document).ready(function(){
		var nflag = false;
		var pflag = false;
		var sflag = false;
		var eflag = false;
		
		var str = '';
		
		$.ajax({
			url : "getProjectLeader.do",
			type : "post",
			dataType : "text", 
			data : $("#proDel").serialize(),
			success : function(data) {
				$('#pstart').val($('#pst').val());
				$('#pend').val($('#ped').val());
				
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
				}
			},
			error : function(data) {
				alert(data + ' : ��ư ��Ȱ���� ���� �߻�');
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
			alert("������Ʈ �̸��� ����� �Է��Ͻʽÿ�");
			return false;
		}
		 
		if(!pflag){
			alert("�н����带 �ٽ� �Է��Ͻʽÿ�");
			$("#ppw").val("");
			$("#ppwAgain").val("");
			//location.reload();
			return false;
		}
		
		if(!sflag || !eflag){
			alert("������Ʈ ���� ��¥�� ������ ��¥�� ����� �Է��Ͻʽÿ�");
			return false;
		}
		
		$.ajax({
			url : "proUpdate.do",
			type : "post",
			dataType : "text", 
			data : $("#proupdateform").serialize(),
			success : function(data) {
				if (data == "ok") {
					alert("������Ʈ ���� ���� ����!");
					$("#proname").html($("#pname").val());
					str = $("#pstart").val() + " ~ " +$("#pend").val();
					$("#term").html(str);
					
					$("#pname").val("");
					$("#ppw").val("");
					$("#ppwAgain").val("");
					$("#pstart").val("");
					$("#pend").val("");	
				} else {
					alert("������Ʈ ���� ���� ����");
				}
			},
			error : function(data) {
				alert(data + ' : ������Ʈ ���� ���� ���� ����� ���� �߻�');
			}
		}); //end of ajax 
	});//end of change button
	
	$("#deletPro").click(function(){
		alert("������Ʈ�� �����մϴ�");
	});//end of deletPro button
});//end of ready
</script>
</head>

<body>
	<br><br>
	<img src="./images/projectinfo.png" align="left" style="margin: 3% 0 0 0%; "><br>
	<%-- <h6>������Ʈ ȭ��</h6>
	������Ʈ ��ȣ : ${requestScope.pnum}
	���� �̸��� : ${sessionScope.userData.uemail}<br> --%>
	<div id="projectInformation" align="center">
	
	<div class='contents' style="margin-top: 5px">
	<br><hr>
	<form action="" id="info" method="post">
    	<b> 
    	<font color="#5A5A5A" style="font-style: initial;" size="5">������Ʈ �̸� : <b id="proname">${requestScope.pinfo.pname}</b></font><br><br>
    	<font color="#5A5A5A" style="font-style: initial;" size="5">������Ʈ �� ��ȣ : &nbsp;&nbsp;${requestScope.pinfo.pnum}</font><br><br>
    	<font color="#5A5A5A" style="font-style: initial;" size="5">�Ⱓ : <b id="term">${requestScope.pinfo.pstart} ~ ${requestScope.pinfo.pend}</b></font><br><br>
    	<font color="#5A5A5A" style="font-style: initial;" size="5">������Ʈ ���� ��Ȳ:</font>&nbsp;&nbsp;
    </form>
   		<div><b id="percentage"></b>%
    	<progress value="${requestScope.prodate}" max="100"/>
    	</div>
	</div>
    	
    	<br>
		<font color="#5A5A5A" style="font-style: oblique;" size="5">���� ���� : &nbsp;</font></b>
		<br>
	<div id="userList">
		<table border="0" cellpadding="5" cellspacing="3" width="40%" bordercolordark="white" bordercolorlight="black">
			<tr>
		        <td bgcolor="#9B2626">
		            <p align="center"><font color="white"><b><span style="font-size:9pt;">Photo</span></b></font></p>
		        </td>
		        <td bgcolor="#9B2626" >
		            <p align="center"><font color="white"><b><span style="font-size:9pt;">Nickname</span></b></font></p>
		        </td>
		        <td bgcolor="#9B2626">
		            <p align="center"><font color="white"><b><span style="font-size:9pt;">Mobile</span></b></font></p>
		        </td>
		        <td bgcolor="#9B2626">
		            <p align="center"><font color="white"><b><span style="font-size:9pt;">E-mail</span></b></font></p>
		        </td>
		    </tr>
		    
		<c:forEach items="${requestScope.puser}" var = "data">
			 <tr>
				        <td bgcolor="">
				            <%-- <p align="center"><font style="font-style: oblique;" size="3pt">${data.uPhoto}</font></p> --%>
				            <p align="center"><img id="barUserPhoto" src="${data.uPhoto}" width="50" height="50" border="3" style="margin: -5px 5px 5px 5px;">
				        	</p>
				        </td>		    
				        <td bgcolor="">		        
				            <p align="center"><font style="font-style: oblique;" size="3pt">${data.uname}</font></p>
				        </td>
				        <td bgcolor="">
				            <p align="center"><font style="font-style: oblique;" size="3pt">${data.uphone}</font></p>
				        </td>
				        <td bgcolor="">
				            <p align="center"><font style="font-style: oblique;" size="3pt">${data.uemail}</font></p>
				        </td>
				    </tr>
		</c:forEach>
		</table>
	</div>
	</div>
	
	<div id="projectInfoChange" style="border-left:2px solid; padding:5px;">

		 <br><hr>
		 <div align="left">
			 <font color="#9B2626" size="10" style="font-style: oblique;">������Ʈ ���� ����</font>
			 <font color="#9B2626" size="3" style="font-style: oblique;">
			 <form action="proUpdate.do" id="proupdateform" method="post">
				Project Name <input type="text"  name="pname" id="pname" /><br>
				Project PassWord <input type="password" name="ppw" id="ppw"/><br>
				Reenter PassWord <input type="password" name="ppwAgain" id="ppwAgain"/><br>
				Project Start Date <input type="text" name="pstart" id="pstart"/><br>
				Project End Date <input type="text" name="pend" id="pend"/><br>
				<input type="hidden" name="pnum" id="pnum" value="${requestScope.pinfo.pnum}">
				<input type="button" id="change" value="Ȯ��" />
				</form>
			</font>
			<form action="deleteProject.do" id="proDel" method="post">
				<input type="hidden" name="pnum" id="pnum" value="${requestScope.pinfo.pnum}">
				<input type="hidden" name="pleader" id="pleader" value="${requestScope.pleader}">
				<input type="hidden" name="puser" id="puser" value="${sessionScope.userData.uemail}">
				<input type="hidden" name="prodate" id="prodate" value="${requestScope.prodate}">
				<input type="hidden" name="pst" id="pst" value="${requestScope.pinfo.pstart}">
				<input type="hidden" name="ped" id="ped" value="${requestScope.pinfo.pend}">
				<input type="submit" id="deletePro" value="������Ʈ ����"/>
			</form>
		 </div>
	</div>
</body>
<br><br><br>
<jsp:include page="bottomMenu.jsp" flush="true"/>
</html>

