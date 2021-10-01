<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 근무기록확정</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Noto Sans KR', sans-serif;
}
table, button, input, textarea{
	font-size: 18px;
}
#title{
	margin: 10px;
	font-size: 20px;
	font-weight: bold;
}
#list-table{
	width: 100%;
}
hr{
	margin: 5px 0px;
}
th{
	background: #FCFCFE;
}
th, td{
	padding: 5px;
}
/* .th1{
	width : 90px;
}
.th2{
	width : 80px;
}
.th3{
	width : 110px;
} */
.allowance{
	width :150px;
}
.input{
	width : 94%;
	text-align: right;
}
.cen{
	text-align: center;
}
td, th{
	border : 1px solid #EAEAEA;
	padding: 5px 10px;
}
table{
	border-collapse: collapse;
}
#form{
	margin-top: 5px;
	height : 760px;
	overflow-y : auto;
	min-width : 900px;
	overflow-x: auto;
}
.saveBtn {
    display: inline-block;
    text-decoration: none;
    color: white;
    padding: 1px 10px;
    background: #3A4CA8;
    border-radius: 3px;
}
#bottom{
	width: 98%;
	position: fixed;
	bottom: 10px;
}
</style>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script src="${ cPath }/resources/js/jquery.validate.min.js"></script>
</head>
<body>
	<div id="top">
		<span id="title">근무기록확정</span>
		<hr color="#F1F4FF">
	</div>
	<input type="button" value="근무기록" id="history">
	<form:form commandName="workConfirm" id="form" method="post">
		<input type="hidden" value="${stdate}" id="date" name="pihStdate">
		<table id="list-table">
			<tr>
				<th class="th1">사원번호</th>
				<th class="th2">사원명</th>
				<th class="th3">부서명</th>
				<c:forEach items="${alList}" var="al">
					<th class="allowance">${al.alNm}</th>
				</c:forEach>
			</tr>
			<c:forEach items="${empl}" var="empl">
				<tr id="${empl.emplNo}">
					<td class="cen">${empl.emplNo}<input type="hidden" name="pihEmpl" value="${empl.emplNo}"></td>
					<td class="cen">${empl.emplNm}</td>
					<td class="cen">${empl.dept.deptNm}</td>
					<c:forEach items="${alList}" var="al">
						<td class="${al.alCode}">
						<input type="hidden" name="whAlcode" value="${al.alCode}">
						<input type="text" name="whHour" class="input" onkeyup="inputNumberFormat(this)">
						</td>
					</c:forEach>
				</tr>
			</c:forEach>
		
		</table>
	
	</form:form>
<div id="bottom">
	<hr color="#F1F4FF">
	<input type="submit" class="saveBtn" value="저장">
	<input type="button" class="close" value="닫기">
</div> 	
	
</body>
<script>
<c:if test="${ success eq 'SUCCESS' }">
window.close();
</c:if>
//콤마찍는거
function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    if(str.length>1){
	    str = str.replace(/(^0+)/, "");
    }else{
	    str = str.replace(/(^0+)/, "0");
    }
    return str.replace(/[^\d]+/g, '');
}
$(function(){
	date = $("#date").val();
	date = date.replace(" ","");
	$.ajax({
		url : "${cPath}/sal/workHistory.do",
		dataType : "json",
		data : {"stDate" : date},
		success : function(resp) {
			$.each(resp,function(i,v){
				trTag = $("tbody").find("#"+v.pihEmpl);
				trTag.find("."+v.whAlcode).find(".input").val(v.whHour);
			})
		}
	});	
	
	$(".close").on("click", function(){
		window.close();
	});	
	
	$(".saveBtn").on("click",function(){
		input = $(".input");
		$.each(input,function(i,v){
			if(v.value == ""){
				v.value = "0";
			}
			
		})
		cAlert("저장 시 전체계산을 진행해야지 적용됩니다.","confirm");
		
		
	})
	$("#alertResult").on("change",function(){
			if($(this).val() != 'true'){
				return false;
			}
			$("#form").submit();
			setTimeout(() => {
				window.close();
			}, 500);
			
	});
	$("#history").on("click",function(){
		date = $("#date").val();
		$.ajax({
			url : "${cPath}/sal/workMapping.do",
			dataType : "json",
			data : {"stDate" : date},
			success : function(resp) {
				console.log(resp);
				$.each(resp,function(i,work){
					no = work.emplNo;
					code = work.alCode;
					check = $("#form").find("#"+no);
					check.find("."+code).find(".input").val(work.workHour);
				})
			}
		});		
		
		
		
	})
	
})

</script>
<jsp:include page="/includee/cAlert.jsp"/>
<style>
#cAlert{
	left: 9%;
	overflow: hidden;
}
body{
	overflow: hidden;
}
</style>
</html>