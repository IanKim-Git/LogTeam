<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <jsp:include page="topBar.jsp" flush="false" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Announcement</title>
<link href="kendo_file/examples-offline.css" rel="stylesheet">
    <link href="kendo_file/kendo.common.min.css" rel="stylesheet">
    <link href="kendo_file/kendo.rtl.min.css" rel="stylesheet">
    <link href="kendo_file/kendo.default.min.css" rel="stylesheet">
    <link href="kendo_file/kendo.dataviz.min.css" rel="stylesheet">
    <link href="kendo_file/kendo.dataviz.default.min.css" rel="stylesheet">
    <script src="kendo_file/jquery.min.js"></script>

    <script src="kendo_file/angular.min.js"></script>
    <script src="kendo_file/kendo.all.min.js"></script>
</head>
<!-- <script src="js/jquery-1.10.2.js"></script> -->
<script>var jb = jQuery.noConflict();</script>

<body>

   <%-- <h6>��������</h6>
   ������Ʈ ��ȣ : ${requestScope.pnum}
   ���� �̸��� : ${sessionScope.userData.uemail}<br> --%>
   <br><br><br><br>
   <div style="width: 81%;padding: 4% 0 0 10%;">
   <div>
      <form action="writeAn.do" id="anWriteForm" method="post">
         <select id="animportance" name="animportance">
            <option value="-1">����</option>
            <option value="3">��</option>
            <option value="2">��</option>
            <option value="1">��</option>
         </select><br>
         <input type="hidden" id="an_pnum" name="an_pnum" value="${requestScope.pnum}">
         <input type="hidden" id="an_uemail" name="an_uemail" value="${sessionScope.userData.uemail}">
         <textarea id="ancontent" name="ancontent" rows="5" cols="150%" ></textarea>
         <input type="button" id="anWrite" value="���">      
      </form>
   </div>
   <br><hr><br>
    <div id="example">
      <div id="grid"></div>
      </div>
         <script>
            jb(document).ready(function(){
              //��� ���������� �ҷ����� �Լ�
              function getAns() {
                 jb.ajax({
                    url : "allAns.do", 
                    type : "post",
                    dataType : "json",                //���������Ÿ��
                    data : "pnum="+jb("#an_pnum").val(),
                    success : function(data) {
                       var table = "";
                       jb("#listTable tr:gt(0)").remove();
//                       <th>��ȣ</th><th>����</th><th>��¥</th><th>�����</th><th>�߿䵵</th><th>����</th>
                       var count = data.list.length;

                       //data.list�� �� ������ : [{no:��, name:��,...}, {no:��, name:��,...}, {no:��, name:��,...}, ...]
                       jb(data.list).each(function(index, item) {//{no:��, name:��,...}
                          table += "<tr><td>" + (count--) + "</td><td>" + item.ancontent + "</td><td>" +  item.andate + "</td><td>" +  item.an_uemail + "</td>";
                          if(item.animportance == 3){
                             table += "<td>��</td>";
                          }else if(item.animportance == 2){
                             table += "<td>��</td>";
                          }else if(item.animportance == 1){
                             table += "<td>��</td>";
                          }
                          if($("#an_uemail").val() == item.an_uemail){
                             table += "<td><input type='button' value='����' id='del' name='"+item.annum+"'></td></tr>";
                          }
                       });
                       //���̺� �߰�
                       jb("#listTable tr:eq(0)").after(table);
                       //alert(lists.length);
                       /* count = lists.length;
                       jb(lists).each(function(index, item){
                          item.annum = count;
                          count -= 1;
                       }); */
                       /*
                       var dataSource = new kendo.data.DataSource({
                          data: lists
                       });
                       
                       jb("#grid").kendoGrid({
                          dataSource : dataSource,
                          toolbar: ["create"],
                          columns: [
                                          { field:"annum", title: "��ȣ", width: "50px" },
                                          { field: "ancontent", title:"����"},
                                          { field: "andate", title:"�ۼ���", width: "100px" },
                                          { field: "an_uemail", title: "�����", width: "80px" },
                                          { field: "animportance", title: "�߿䵵", width: "80px", values: [{text: "��", value: 3}, {text: "��", value: 2}, {text: "��", value: 1}] },
                                          { command: [{
                                             name: "delete",
                                             click: function(e){
                                                // e.target is the DOM element representing the button
                                                  var tr = $(e.target).closest("tr"); // get the current table row (tr)
                                                  // get the data bound to the current table row
                                                  var data = this.dataItem(tr);
                                                  jb.ajax({
                                                  url : "deleteAn.do", 
                                                  type : "post",
                                                  dataType : "text", 
                                                  data : "annum=" + data.annum,   //������ ������ ������ : <input type='button' value='����' id='del' name='"+item.no+"'>
                                                  success : function(data) {
                                                     if (data == "ok") {
                                                        alert("���� ����");
                                                     //   getAns();
                                                     } else {
                                                        alert("���� ����");
                                                     }
                                                  },
                                                  error : function(err) {//����������
                                                     alert(err + " : �������� ���� ���� ����");
                                                  }
                                               });
                                             }
                                          }], title: "����", width: "100px" }],
                        editable: "popup"
                       }); */
                    },
                    error : function(err) {//����������
                       alert(err + " : �ش� ������Ʈ���� ���������� ���� �ۼ����� �ʾҽ��ϴ�");
                    }
                 });//end of ajax
              } //end of getAns()
              
              //���� ��ư�� ������ �� �������� ����
              jb(document).on("click", "#del", function() {
                 jb.ajax({
                    url : "deleteAn.do", 
                    type : "post",
                    dataType : "text", 
                    data : "annum=" + jb(this).attr("name"),   //������ ������ ������ : <input type='button' value='����' id='del' name='"+item.no+"'>
                    success : function(data) {
                       if (data == "ok") {
                          alert("���� ����");
                          getAns();
                       } else {
                          alert("���� ����");
                       }
                    },
                    error : function(err) {//����������
                       alert(err + " : �������� ���� ���� ����");
                    }
                 });
              });//end of �������� ���� 
              
              //�������� ���
              jb("#anWrite").click(function() {
                 if(jb("#ancontent").val() == ""){
                    alert("������ �Է��ϼ���.");
                 }else{
                    jb.ajax({
                       url : "writeAn.do",
                       type : "post",
                       dataType : "text",             
                       data : jb("#anWriteForm").serialize(),
                       success : function(data) {
                          if (data == "ok") {
                             alert("�������� �ۼ� ����");
                             jb("textarea").val("");   
                             getAns();
                             getKendoAns();
                          } else if(data == "again") {
                             alert("�������� �߿䵵�� �����ϼ���.");
                          } else {
                             alert("�������� �ۼ� ����");
                          }
                       },
                       error : function(data) {//200�� �� �Ѿ� ���� ��
                          alert(data + ' : �������� �ۼ� ����� ���� �߻�');
                       }
                    }); //end of ajax
                 }
              });//end of �������� �ۼ� ����
              
              //�������� ȭ�� �ʱ�ȭ
              getAns();
              
              
              /* var dataSource = new kendo.data.DataSource({
                 transport: {
                    read: {
                       url : "allAns.do", 
  
                        dataType : "jsonp",                //���������Ÿ��
                        data : {
                            q: function() {
                                    return jb("#an_pnum").val();
                                }
                        }
                     }
                } 
                 
                }); */
                //kendoUI
                function getKendoAns(){
                   jb.ajax({
                    url : "allAns.do", 
                    type : "post",
                    dataType : "json",                //���������Ÿ��
                    data : "pnum="+jb("#an_pnum").val(),
                    success : function(data) {
                       var count = data.list.length;
                       var lists = data.list;
                       var annumArray = [];
                       
                       jb(lists).each(function(index, item){
                          annumArray[index] = item.annum;
                          item.annum = count;
                          count -= 1;
                       });
                       
                       for(var i=0; i<count; i++){
                          console.log(annumArray[i]);
                       }
                       
                       var dataSource = new kendo.data.DataSource({
                          data: lists,
                          pageSize: 5
                       });
                       
                       jb("#grid").kendoGrid({
                          dataSource : dataSource,
                          pageable: true,
                          columns: [
                                          { field:"annum", title: "��ȣ", width: "50px" },
                                          { field: "ancontent", title:"����"},
                                          { field: "andate", title:"�ۼ���", width: "100px" },
                                          { field: "an_uemail", title: "�����", width: "80px" },
                                          { field: "animportance", title: "�߿䵵", width: "80px", values: [{text: "��", value: 3}, {text: "��", value: 2}, {text: "��", value: 1}] },
                                          { command: [{
                                             name: "delete",
                                             click: function(e){
                                                // e.target is the DOM element representing the button
                                                  var tr = $(e.target).closest("tr"); // get the current table row (tr)
                                                  // get the data bound to the current table row
                                                  var data = this.dataItem(tr);
                                                  if(data.an_uemail != jb("#an_uemail").val()){
                                                     alert("����ڸ� ���� �����մϴ�.");
                                                  }else{
                                                     jb.ajax({
                                                      url : "deleteAn.do", 
                                                      type : "post",
                                                      dataType : "text", 
                                                      data : "annum=" + annumArray[data.annum],   //������ ������ ������ : <input type='button' value='����' id='del' name='"+item.no+"'>
                                                      success : function(data) {
                                                         if (data == "ok") {
                                                            alert("���� ����");
                                                         //   getAns();
                                                         } else {
                                                            alert("���� ����");
                                                         }
                                                      },
                                                      error : function(err) {//����������
                                                         alert(err + " : �������� ���� ���� ����");
                                                      }
                                                   });
                                                  }
                                                  
                                             }
                                          }], title: "����", width: "100px" }]
                          });
                       },
                       error : function(err) {//����������
                          alert(err + " : �ش� ������Ʈ���� ���������� ���� �ۼ����� �ʾҽ��ϴ�");
                       }
                    });//end of kendo ajax
                }
                getKendoAns();
              
              
              });//end of ready
            </script>
        </div>
     
<!--    <div>  
      <form action="" id="anListForm">         
         <table id="listTable" cellspacing="0">
            <tr bgcolor="#FOFOF7">
               <th>��ȣ</th><th>����</th><th>��¥</th><th>�����</th><th>�߿䵵</th><th>����</th>
            </tr>
         </table>
      </form>
   </div>
 -->   <br><br><br><br>
</body>
<jsp:include page="bottomMenu.jsp" flush="true"/>
</html>