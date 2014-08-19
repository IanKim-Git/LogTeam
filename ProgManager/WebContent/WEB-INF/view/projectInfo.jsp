<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="topBar.jsp" flush="false" /><%-- 
	<jsp:include page="leftMenu.jsp" flush="false" /> --%>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Project Information</title>

<link href="css/kendo.common.min.css" rel="stylesheet" />
<link href="css/kendo.default.min.css" rel="stylesheet" />
<link href="css/kendo.dataviz.min.css" rel="stylesheet" />
<link href="css/kendo.dataviz.default.min.css" rel="stylesheet" />
<script src="js/jquery.min.js"></script>
<script src="js/angular.min.js"></script>
<script src="js/kendo.all.min.js"></script>
<script src="js/login.js"></script>
<script src="js/jquery-1.10.2.js"></script>

<script>var jb = jQuery.noConflict();</script>
<script type="text/javascript">
	$(document).ready(function(){
		var pflag = false;
		var str = '';
		
		$.ajax({
			url : "getProjectLeader.do",
			type : "post",
			dataType : "text", 
			data : $("#proDel").serialize(),
			success : function(data) {
				if (data == "ok" && $('#puser').val()!=$('#pleader').val()){
					$('#change').attr('disabled',true);
					$('#deletePro').attr('disabled',true);
				}
			},
			error : function(data) {
				alert(data + ' : 버튼 비활성시 에러 발생');
			}
		}); //end of ajax
		
		
		$("#ppwAgain").keyup(function(){
			if($("#ppw").val() != $("#ppwAgain").val()){
				pflag = false;
			}else{
				pflag = true;
			} 
		});//end of reentered password validaion
		
	
	 $("#change").click(function(){
		if(!pflag){
			alert("패스워드를 다시 입력하십시오");
			$("#ppw").val("");
			$("#ppwAgain").val("");
			//location.reload();
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
					$("#pstart").val("");
					$("#pend").val("");	
				} else {
					alert("프로젝트 정보 변경 실패");
				}
			},
			error : function(data) {
				alert(data + ' : 프로젝트 정보 변경 로직 실행시 에러 발생');
			}
		}); //end of ajax 
	});//end of change button
	
	$("#deletPro").click(function(){
		alert("프로젝트를 삭제합니다");
	});//end of deletPro button
});//end of ready
</script>
</head>

<body>
	<%-- <h6>프로젝트 화면</h6>
	프로젝트 번호 : ${requestScope.pnum}
	유저 이메일 : ${sessionScope.userData.uemail}<br> --%>
	
	<div class='contents' align="left" style="margin-top: 40px">
	<form action="" id="info" method="post">
    	<b> <font color="4682B4" style="font-style: oblique;" size="5">프로젝트 이름 : <b id="proname">${requestScope.pinfo.pname}</b></font><br><br>
    	<font color="4682B4" style="font-style: oblique;" size="5">프로젝트 방 번호 : &nbsp;&nbsp;${requestScope.pinfo.pnum}</font><br><br>
    	<font color="4682B4" style="font-style: oblique;" size="5">기간 : <b id="term">${requestScope.pinfo.pstart} ~ ${requestScope.pinfo.pend}</b></font><br><br>
    	<font color="4682B4" style="font-style: oblique;" size="5">프로젝트 일정 상황:</font>&nbsp;&nbsp;
    </form>
   		<div>${requestScope.prodate}%
    	<progress value="${requestScope.prodate}" max="100"/>
    	</div>
    	<br>
		<font color="4682B4" style="font-style: oblique;" size="5">팀원 정보 : &nbsp;</font></b>
		<br>
		<!-- <div class="wrap">
			<div class="bar">
				<div class="percent">
					<span style="width: 100%;"></span>
				</div>
				<div class="circle">
					<span>0%</span>
				</div>
			</div>
			<div class="text">
				<input type="text" class="input" value="0" />
			</div>	
		</div> -->

<table align="left" border="0" cellpadding="2" cellspacing="1" width="25%" bordercolordark="white" bordercolorlight="black">
	<tr>
        <td bgcolor="#336699">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">Photo</span></b></font></p>
        </td>
        <td bgcolor="#336699">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">Nickname</span></b></font></p>
        </td>
        <td bgcolor="#336699">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">Mobile</span></b></font></p>
        </td>
        <td bgcolor="#336699">
            <p align="center"><font color="white"><b><span style="font-size:9pt;">E-mail</span></b></font></p>
        </td>
    </tr>
    
<c:forEach items="${requestScope.puser}" var = "data">
	 <tr>
		        <td bgcolor="">
		            <p align="center"><span style="font-size:3pt;">
		            </span></p>
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

		 <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><hr>
		 <div id="example" class="k-content">
            <div id="gauge-container">
                <div id="gauge"></div>

            </div>

            <script>
                function createGauge() {
                    $("#gauge").kendoRadialGauge({

                        pointer: {
                            value: $("#prodate").val()
                        },

                        scale: {
                            minorUnit: 5,
                            startAngle: -30,
                            endAngle: 210,
                            max: 100
                        }
                    });
                }

                $(document).ready(function() {
                    createGauge();

                    function updateValue() {
                        $("#gauge").data("kendoRadialGauge").value($("#gauge-value").val());
                    }

                    if (kendo.ui.Slider) {
                        $("#gauge-value").kendoSlider({
                            min: 0,
                            max: 100,
                            showButtons: false,
                            change: updateValue
                        });
                    } else {
                        $("#gauge-value").change(updateValue);
                    }


                    $(document).bind("kendo:skinChange", function(e) {
                        createGauge();
                    });
                });
            </script>

            <style scoped>
                #gauge-container {
                    background: transparent url("css/textures/gauge-container-partial.png") no-repeat 50% 50%;
                    width: 386px;
                    height: 386px;
                    text-align: center;
                    margin: 0 auto 30px auto;
                }

                #gauge {
                    width: 350px;
                    height: 300px;
                    margin: 0 auto;
                }

                #gauge-container .k-slider {
                    margin-top: -11px;
                    width: 140px;
                }

            </style>
        </div>

		 <div>
			 <font color="black" size="10" style="font-style: oblique;">프로젝트 정보 변경</font>
			 <form action="proUpdate.do" id="proupdateform" method="post">
				Project Name <input type="text"  name="pname" id="pname" /><br>
				Project PassWord <input type="password" name="ppw" id="ppw"/><br>
				Reenter PassWord <input type="password" name="ppwAgain" id="ppwAgain"/><br>
				Project Start Date <input type="text" name="pstart" id="pstart"/><br>
				Project End Date <input type="text" name="pend" id="pend"/><br>
				<input type="hidden" name="pnum" id="pnum" value="${requestScope.pinfo.pnum}">
				<input type="button" id="change" value="확인" />
			</form>
		</div>
		<div align="left" >
			<form action="deleteProject.do" id="proDel" method="post">
				<input type="hidden" name="pnum" id="pnum" value="${requestScope.pinfo.pnum}">
				<input type="hidden" name="pleader" id="pleader" value="${requestScope.pleader}">
				<input type="hidden" name="puser" id="puser" value="${sessionScope.userData.uemail}">
				<input type="hidden" name="prodate" id="prodate" value="${requestScope.prodate}">
				<input type="submit" id="deletePro" value="프로젝트 삭제"/>
			</form>
		</div>
		
    </div>
   	
</body>
</html>
