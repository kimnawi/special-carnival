<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 급여정보입력</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
	*{
		font-family: 'Noto Sans KR', sans-serif;
	}
	table, button, input, textarea{
		font-size: 18px;
	}
#title{
	font-size: 20px;
	margin: 10px;
	margin-bottom: 20px;
	font-weight: bold;
}
hr{
	margin: 5px 0px;
}
select{
	width :281px;
	font-size: 17px;
	height: 28px;
}
th, td{
	padding: 5px;
}
th{
	width: 120px;
	text-align: inherit;
	font-weight: normal;
}
table{
	border-collapse: collapse;
	width: 680px;
}
tbody{
	background: #FCFCFE; 
}
a{
	color: #3A4CA8;
	cursor: pointer;
}
a:hover {
	text-decoration: underline;
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
label.error, .adres label.error{
	color: #C00000;
}
input[name=piBonusamount]{
	text-align: right;
}
</style>
<!-- <link rel="stylesheet" href="/eggegg/resources/css/emplForm.css"> -->
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script src="${ cPath }/resources/js/jquery.validate.min.js"></script>
</head>
<body>
	<div id="top">
		&ensp;&ensp;&ensp;<span id="title">급여정보입력</span>
	</div>
		<hr color="#F1F4FF">
	<br>
	<form:form commandName="payInfo" id="form" method="post">
		<table>
			<tr>
				<th>귀속연월</th>
				<td>
				<input type="month" name="piStdate" value="${salary.piStdate}">
				<form:errors path="piStdate" element="label" id="piStdate-error" cssClass="error" for="piStdate"/>
				</td>
			</tr>
			<tr>
				<th id="row" >급여구분</th>
				<td>
					<select name="piType">
						<option value="급여">급여</option>
						<option value="상여">상여</option> 
					</select>
					<form:errors path="piType" element="label" id="piType-error" cssClass="error" for="piType"/>
				</td>
			</tr>	
			<tr id="hidden">
				<td>
				<span>지급액</span><input type="text" name="piBonusamount" onkeyup="inputNumberFormat(this)">
				<form:errors path="piBonusamount" element="label" id="piBonusamount-error" cssClass="error" for="piBonusamount"/>
				</td>
			</tr>
			<tr>
				<th>대상기간</th>
				<td>
				<input type="date" name="piTargetdo">
				<form:errors path="piTargetdo" element="label" id="piTargetdo-error" cssClass="error" for="piTargetdo"/>
				~
				<input type="date" name="piTargetdt">
				<form:errors path="piTargetdt" element="label" id="piTargetdt-error" cssClass="error" for="piTargetdt"/>
				</td>
			</tr>
			
			<tr>
				<th>지급일</th>
				<td>
					<input type="date" name="piPayday">
					<form:errors path="piPayday" element="label" id="piPayday-error" cssClass="error" for="piPayday"/>
				</td>
			</tr>
			<tr>
				<th>급여대장명칭</th>
				<td>
					<input type ="text" name="piNm">
					<form:errors path="piNm" element="label" id="piNm-error" cssClass="error" for="piNm"/>
				</td>
			</tr>
			<tr>
				<th>대상사원</th>
				<td>
					<input type="radio" name="empl" id="all" value="전체" checked>전체
					<input type="radio" name="empl" id="chk" value="선택">선택
					<a data-action="" id="insertEmployee">설정</a>
				</td>
			</tr>
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

$("#insertEmployee").hide();
$("#hidden").hide();
$(function(){
	today = new Date();
	preYear = today.getFullYear();
	preMonth = today.getMonth()+1;
	if(preMonth <10){	
		preMonth = "0"+preMonth;
	}
	month = preYear+"-"+preMonth;
	start = month +"-"+"01";
	endDate = new Date(preYear,preMonth,0);
	end = month +"-"+ endDate.getDate();
	console.log(end);
	$("input[name=piStdate]").val(month);
	$("input[name=piTargetdo]").val(start);
	$("input[name=piTargetdt]").val(end);
	
	$("#chk").on("click",function(){
		$("#insertEmployee").show();
	})
	$("#all").on("click",function(){
		$("#insertEmployee").hide();
	})
	
	$("select[name=piType]").on("change",function(){
		val = $("select[name=piType] option:selected").val();
		if(val == "급여"){
			$("#hidden").hide();
			$("#row").attr("rowspan","1");
		}else{
			$("#row").attr("rowspan","2");
			$("#hidden").show();
		}
	})
	$(".close").on("click", function(){
	window.close();
	});	
		
	$(".saveBtn").on("click",function(){
		val = $("input[name=piBonusamount]").val();
		$("input[name=piBonusamount]").val(uncomma(val));
		$("#form").submit();
	})
	
	//대상사원 설정 폼
	$("#insertEmployee").on("click", function(){
		action = $(this).data("action");
		abEmpl = $("#emplNo").val();
		var nWidth = 500;
		var nHeight = 400;
		var curX = window.screenLeft; 
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);
		window.name = action;
		popup = window.open(
				"/eggegg/empl/" + action + ".do?abEmpl=" + abEmpl,
				"taxFree",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
	});
	
	//정규식
	$.validator.addMethod("regx", function(value, element, regexpr){
		return regexpr.test(value);
	});
	$("#form").validate({
		onkeyup: function(element){
			$(element).valid();
		},
		rules: {
			piStdate : {
				required : true				
			},
			piType : {
				required : true
			},
			piTargetdo : {
				required : true
			},
			piTargetdt : {
				required :true
			},
			piPayday : {
				required : true
			},
			piNm : {
				required : true				
			}
		},
		messages: {
			piStdate : {
				required : "귀속연월을 입력하세요."			
			},
			piType : {
				required : "급여구분을 선택하세요."
			},
			piTargetdo :{
				required : "기간을 선택하세요."
			},
			piTargetdt :{
				required : "기간을 선택하세요."
			},
			piPayday : {
				required : "지급일을 선택하세요."
			},
			piNm : {
				required : "명칭을 입력하세요."				
			}
		},
		submitHandler: function(form){
			form.submit();
		}
	});
	
	
	
	
	
})
</script>
</html>