<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script type="text/javascript" src="${cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${cPath }/resources/js/jquery.form.min.js"></script>
<title>EGGEGG | 공제리스트</title>
</head>
<style>
input[name=deNm]{
	height : 26px;
	width : 100%;
}
.th2{
	width : 300px;
}
.th3{
	width : 300px;
}
#bottom{
	position: fixed;
	bottom: 75px;
	width: 100%;
}
table{
	width : 70%;
	margin-left: 10px;
}
td, th{
	border: 1px solid #EAEAEA;
	padding: 5px 10px;
	height: 40px;
}
main {
	width: 83%;
	padding: 30px 0 0;
}
th{
	text-align : center;
background : #FCFCFE;
}
.seq{
   text-align: right;
}
table,th,td{
   border : 1px solid #EAEAEA;
   border-collapse: collapse;
}
.No input[type=text]:disabled{
   background : #FEE5E5;
}
input[type="text"]:disabled{
   width : 300px;
   background :white;
   border : none;
   color: black;
}
.dropup {
  position: relative;
  display: inline-block;
}

.dropup-content {
  display: none;
  position: absolute;
  background-color: white;
  min-width: 160.8px;
  border : 1px solid rgb(118, 118, 118);
  bottom: 35px;
  z-index: 1;
  font-size: 12px;
}

.dropup-content a {
  color: black;
  padding: 3px 5px;
  text-decoration: none;
  display: block;
}

.dropup-content a:hover {background-color: #F1F1F8}

.dropup:hover .dropup-content {
  display: block;
}

.dropbtn {
	color: black;
	border: 1px solid rgb(118, 118, 118);
	padding: 3px 10px;
	border-radius: 3px;
}
.hang{
   width: 600px;
}
.cen{
   text-align: center;
}
.No{
   background : #FEE5E5;
}
a{
   cursor: pointer;
}
input:-webkit-autofill {
   -webkit-box-shadow: 0 0 0 1000px white inset;
}
hr{
	margin: 5px 0px;
}
#title{
	font-size: 20px;
	margin: 10px;
	margin-bottom: 20px;
	font-weight: bold;
}
.th1{
	widht : 400px;
	height: 40px;
	padding : 5px 10px;
	text-align: center;
}
.emplListTd{
	border: 1px solid #EAEAEA;
   	padding: 5px 10px;
   	height: 40px;
   	width: 48px;
}
input[name=deCode]{
	text-align: center;
}
.saveBtn{
	background: #3A4CA8;
	color: white;
	border-radius: 3px;
	padding: 1px 10px;
	margin: 2px 0px 2px 10px;
}
.sort{
	font-size: 0.5em;
	vertical-align: 0.3em;
}
#useNo, #useYes{
	padding: 2px 10px;
}
#background{
	position:fixed;
	bottom: 70px;
	height: 50px;
	width: 100%;
	background: white;
	z-index: 1;
}
</style>
<body>
<div id ="top">
	&ensp;&ensp;&ensp;<span id="title">공제리스트</span>
</div>
	<hr color="#F1F4FF">
<br>
<form:form method="post" action="${cPath}/sal/deductionUpdate.do?use=${use}" commandName="deduction" id="form">
   <table>
      <tr>
         <th class="th1 emplListTd"><input type="checkbox" class="checkAll"></th>
         <th class="th2">공제항목코드</th>
         <th class="hang">공제항목명</th>
         <th class="th3">표시순서</th>
      </tr>
      <tbody id="cb">
         <c:forEach items="${deList}" var="de" >
            <c:choose>
               <c:when test="${use eq 'no'}">
                  <tr class="${de.deUse}">
                     <td class="cen emplListTd">
                        <input class="checkbox" type="checkbox" value="${de.deCode}">
                     </td>
                     <td ><input disabled name="deCode" type="text" value=${de.deCode}></td>
                     <td class="input"><input disabled name="deNm" type="text" value=${de.deNm}></td>
                     <td class="seq">${de.deSeq}</td>
                  </tr>         
               </c:when>
               <c:otherwise>
                  <c:if test="${de.deUse eq 'Yes'}">
                  <tr class="${de.deUse}">
                     <td class="cen">
                        <input class="checkbox" type="checkbox" value="${de.deCode}">
                     </td>
                     <td ><input disabled name="deCode" type="text" value=${de.deCode}></td>
                     <td class="input"><input disabled name="deNm" type="text" value=${de.deNm}></td>
                     <td class="seq">${de.deSeq}</td>
                  </tr>   
                  </c:if>
               </c:otherwise>
            </c:choose>
         </c:forEach>
      </tbody>
   </table>
</form:form>
<div id="bottom">
	<hr color="#F1F4FF">
<input type="button" value="저장" id="save" class="saveBtn">
<div class="dropup" style="display : inline-block;">
  <button class="dropbtn">사용중단/재사용 <span class="sort">▲</span></button>
  <div class="dropup-content">
    <a id="stop">사용중단</a>
    <a id="delete">삭제</a>
    <a id="continue">재사용</a>
  </div>
</div>
<c:choose>
   <c:when test="${use eq 'yes' }">
      <input type="button" value="사용중단포함" id="useNo" >
   </c:when>
   <c:when test="${use eq 'no' }">
      <input type="button" value="사용중단미포함" id="useYes">
   </c:when>
</c:choose>
</div>
</body>
<script>
   $(function(){
      //삭제 버튼 기능
      $("#delete").on("click",function(){
         cnt = $("#cb input[type=checkbox]:checked").length;
         val = $("#cb input[type=checkbox]:checked");
         value="";
         for(i = 0; i<val.length;i++){
            if(i!=0){
               value+=",";
            }
            value += val.eq(i).val();
         }
         if(cnt == 0 ){
            cAlert("리스트에 선택된 자료가 없습니다.<br>체크박스에 체크한 후 다시 시도 바랍니다.");
         }else{
            location.href="${cPath}/sal/deductionDelete.do?deCode="+value+"&use=${use}";
         }   
      })
      //사용중단 버튼 기능
      $("#stop").on("click",function(){
         cnt = $("#cb input[type=checkbox]:checked").length;
         val = $("#cb input[type=checkbox]:checked");
         value="";
         for(i = 0; i<val.length;i++){
            if(i!=0){
               value+=",";
            }
            value += val.eq(i).val();
         }
         if(cnt == 0 ){
            cAlert("리스트에 선택된 자료가 없습니다.<br>체크박스에 체크한 후 다시 시도 바랍니다.");
         }else{
            location.href="${cPath}/sal/deductionStop.do?deCode="+value+"&use=${use}";
         }   
      })
      
      //재사용 버튼 기능
      $("#continue").on("click",function(){
         cnt = $("#cb input[type=checkbox]:checked").length;
         val = $("#cb input[type=checkbox]:checked");
         value="";
         for(i = 0; i<val.length;i++){
            if(i!=0){
               value+=",";
            }
            value += val.eq(i).val();
         }
         if(cnt == 0 ){
            cAlert("리스트에 선택된 자료가 없습니다.<br>체크박스에 체크한 후 다시 시도 바랍니다.");
         }else{
            location.href="${cPath}/sal/deductionContinue.do?deCode="+value+"&use=${use}";
         }   
      })
      
      //체크박스전체선택
      $('.checkAll').on('click',function(){
         ck = $(this).prop('checked');
      
         $(this).parents('table').find('.checkbox').prop('checked', ck);
      })
      //체크박스 전체 개수구하기
      allbox = $("input[type=checkbox]").length-1; 
      $('.checkbox').on("change",function(){
         //전체선택 체크박스 제외 체크된박스 개수 구하기
         cnt = $("#cb input[type=checkbox]:checked").length;
         //체크박스가 다 체크될 경우 전체선택체크박스도 체크
         if(cnt == allbox){
            $(".checkAll").prop('checked',true);
         }else{
            $(".checkAll").prop('checked',false);
         }
      })
      
      
      //사용중단포함
      $("#useNo").on("click",function(){
         location.href="?use=no";
      })
      //사용중단미포함
      $("#useYes").on("click",function(){
         location.href="?use=yes";
      })
      
      //input버튼을 누를경우 text가 활성화되게 만드는 것
      $("tbody").on("click",".input",function(){
         input = $(this).find("input[type=text]");
         input.removeAttr('disabled');
         input.focus();
//          console.log($(this).find("input").val());
      })
      
      //input버튼을 벗어나면 비활성화
      $("tbody").on("focusout",".input",function(){
         input.attr('disabled','disabled');
      })
      
      //저장버튼 클릭시 이벤트
      $("#save").on("click",function(){
         target = $("#form");
         var disabled = target.find(':disabled').removeAttr('disabled');
         target.submit();
         disabled.attr('disabled','disabled');
      })
      
   })
</script>
</html>