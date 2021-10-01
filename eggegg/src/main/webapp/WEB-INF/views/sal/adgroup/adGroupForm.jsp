<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 수당/공제그룹</title>
</head>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 18px;
}
body{
	padding-top: 5px;
	overflow: hidden;
}
hr{
	margin: 5px 0px;
}
#bottom-background{
	position:fixed;
	bottom: 0;
	width: 100%;
	height: 53px;
	background: white;
}
#bottom{
	width: 100%;
	position: fixed;
	bottom: 10px;
	z-index: 1;
}
.saveBtn {
    display: inline-block;
    text-decoration: none;
    color: white;
    padding: 1px 12px;
    background: #3A4CA8;
    border-radius: 3px;
}
#form{
	margin-bottom: 50px;
}
tbody tr:hover{
	text-decoration: none;
}
.plus1, .plus2{
	color: #4472C4;
	font-weight: bold;
	cursor: pointer;
	text-decoration: none;
}
.plus1:hover, .plus2:hover{
	text-decoration: none;
	color: black;
}
.money{
	text-align: right;	
}
button[type=button]{
	border-radius: 20px;
	padding: 2px 10px;
	border: 1px solid #929292;
	color: #929292;
}
button[type=button]:hover{
	background: #EAEAEA;
}
table{
	border-collapse: collapse;
	width: 100%;
	margin: 10px;
}
thead th{
	background: #FCFCFE;
}
th, td{
	padding: 5px;
	border: 1px solid #EAEAEA;
	text-align: center;
}
.th1{
	width :48px;
}
.th3{
	width : 200px;
}
.th4{
	width : 100px;
}
.th4{
	width : 150px;
}
.plus1,.plus2{
	width : 48px;
	text-align: center;
}
.info td, th{
	border: none;
	background: #FCFCFE;
}
.hr{
	margin : 0px;
}
#form2{
	overflow-y: scroll;
	overflow-x: hidden;
	height : 640px;
	padding-right: 30px;
}
#form2 th{
	border: 1px solid #EAEAEA;
}
#title{
	margin: 20px;
	font-size: 20px;
	font-weight: bold;
}
.saveBtn{
	margin-left: 10px;
}
</style>
<body>
	<div id="top">
			<span id="title">수당/공제그룹</span>
			<hr color="#F1F4FF">
		</div>
	<div>
<form:form commandName="adGroup" method="post" id="form">
<table class="info">
<tr>
	<th>	
	수당/공제그룹코드
	</th>
	<td>
		<input type="text" name="adgCode" value="${group.adgCode}" readonly>
	</td>
	<th>
	수당/공제그룹명
	</th>
	<td>
		<input type="text" required name="adgNm" value="${group.adgNm}" placeholder="수당/공제그룹명">
	</td>
</tr>
</table>
<div id="form2">
<form:errors path="adgNm" element="label" id="adgNm-error" cssClass="error" for="adgNm" />
<br>
<span>&ensp;&ensp;> 수당</span>
<table>
	<thead>
		<tr>
			<th class="th1"><input type="checkbox" class="checkAll1"></th>
			<th class="plus1"></th>
			<th class="th2">항목코드</th>
			<th class="th3">항목명</th>
			<th class="th4">단위</th>
			<th class="th5">내역</th>
		</tr>
	</thead>
	<tbody id="cb1">
		<c:if test="${group.alGroup ne null}">
			<c:forEach items="${group.alGroup}" var="al">
				<tr>
					<td><input type="checkbox" class="checkbox1 ch"></td>
					<td class="plus1"> + </td>
					<td><input type="text" name="alCode" value="${al.alCode}" class="al co" readonly></td>
					<td><span class="alNm nm">${al.alNm}</span></td>
					<c:if test="${al.alProvide eq '고정'}">
						<td><span class='unit un'>금액</span></td>
					</c:if>
					<c:if test="${al.alProvide eq '변동(시간)'}">
						<td><span class='unit un'>시급</span></td>
					</c:if>
					<c:if test="${al.alProvide eq '변동(일)'}">
						<td><span class='unit un'>일급</span></td>
					</c:if>
					<td><input class="money mo" type="text" value=<fmt:formatNumber value="${al.algAmount}"/> onkeyup="inputNumberFormat(this)" name="algAmount"></td> 
				</tr>
			</c:forEach>
		</c:if>
		<c:forEach var="i" begin="1" end="3">
			<tr>
				<td><input type="checkbox" class="checkbox1 ch"></td>
				<td class="plus1"> + </td>
				<td><input type="text" name="alCode" class="al co" readonly></td>
				<td><span class="alNm nm"></span></td>
				<td><span class="unit un"></span></td>
				<td><input class="money mo" type="text" name="algAmount" onkeyup="inputNumberFormat(this)" value="0"></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<span>&ensp;&ensp;> 공제</span>
<table>
	<thead>
		<tr>
			<th class="th1"><input type="checkbox" class="checkAll2"></th>
			<th class="plus2"></th>
			<th class="th2">항목코드</th>
			<th class="th3">항목명</th>
			<th class="th4">단위</th>
			<th class="th5">내역</th>
		</tr>
	</thead>
	<tbody id="cb2">
		<c:if test="${group.deGroup ne null}">
			<c:forEach items="${group.deGroup}" var="de">
				<tr>
					<td><input type="checkbox" class="checkbox2 ch"></td>
					<td class="plus2"> + </td>
					<td><input type="text" name="deCode" value="${de.deCode}" class="de co" readonly></td>
					<td><span class="deNm nm">${de.deNm}</span></td>
					<td><span class="unit un">금액</span></td>
					<td><input class="money mo" type="text" value=<fmt:formatNumber value="${de.adgAmount}"/> name="adgAmount" onkeyup="inputNumberFormat(this)"></td> 
				</tr>
			</c:forEach>
		</c:if>
		<c:forEach var="i" begin="1" end="3">
			<tr>
				<td><input type="checkbox" class="checkbox2 ch"></td>
				<td class="plus2"> + </td>
				<td><input type="text" name="deCode" class="de co" readonly></td>
				<td><span class="deNm nm"></span></td>
				<td><span class="unit un"></span></td>
				<td><input class="money mo" type="text" value="0" name="adgAmount" onkeyup="inputNumberFormat(this)" ></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>
</form:form>
</div>
<div id="bottom">
	<hr color="#F1F4FF" style="margin-bottom:10px; margin-top:0px;">
	<input type="button" class="saveBtn" value="저장">
	<input type="button" value="선택삭제" id="remove">
	<input type="reset" value="초기화">
	<input type="button" class="closes" value="닫기">
</div>
<div id="bottom-background"></div>
<input type="hidden" id="alco">
<input type="hidden" id="alnm">
<input type="hidden" id="alpro">
</body>
<script>
$("input[class=closes]").on("click",function(){
	window.close();
	
})
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
	<c:if test="${ message ne NULL}">
		alert("${message}");
	</c:if>
	<c:if test="${ success eq 'SUCCESS' }">
		window.close();
	</c:if>
	
	$("#remove").on("click",function(){
		cnt = $(".ch:checked");
		
		for(i = 0; i<cnt.length;i++){
			par = cnt.eq(i).parent().parent();
			par.find("input[type=checkbox]").prop("checked",false);
			par.find(".co").val("");
			par.find(".nm").text("");
			par.find(".un").text("");
			par.find(".mo").val("0");
		}
		
		
		
	})
	
		//체크박스전체선택
	$('.checkAll1').on('click',function(){
		ck = $(this).prop('checked');
		$(this).parents('table').find('.checkbox1').prop('checked', ck);
	})
	
		//체크박스전체선택
	$('.checkAll2').on('click',function(){
		ck = $(this).prop('checked');
		$(this).parents('table').find('.checkbox2').prop('checked', ck);
	})
	
	$("input[type=reset]").on("click",function(){
		window.location.reload();
	})
	let tbody = $("tbody");
	$(tbody).on("click",".plus1",function(){
		cnt = $("td[class=plus1]").length;
		if(cnt != 15){
		html = '<tr>';
		html += "<td><input type='checkbox' class='checkbox1 ch'></td>";
		html += "<td class='plus1'> + </td>";
		html += "<td><input type='text' name='alCode' class='al co' readonly> </td>";
		html += "<td><span class='alNm nm'></span> </td>";
		html += "<td><span class='unit un'></td>";
		html += "<td><input class='money mo' type='text' value='0' name='algAmount'onkeyup='inputNumberFormat(this)'> </td>";
		html += "</tr>";
		$(this).parent().after(html);
		}else{
			alert("더이상 생성할 수 없습니다.");
		}
	});
	$(tbody).on("click",".plus2",function(){
		cnt = $("td[class=plus2]").length;
		if(cnt != 15){
		html = '<tr>';
		html += "<td><input type='checkbox' class='checkbox2 ch'></td>";
		html += "<td class='plus2'> + </td>";
		html += "<td><input type='text' name='deCode' class='de co' readonly> </td>";
		html += "<td><span class='deNm nm'></span> </td>";
		html += "<td><span class='unit un'></td>";
		html += "<td><input class='money mo' type='text' value='0' name='adgAmount'onkeyup='inputNumberFormat(this)' > </td>";
		html += "</tr>";
		$(this).parent().after(html);
		}else{
			alert("더이상 생성할 수 없습니다.");
		}
	});
	
	//체크박스 전체 개수구하기
	$('#cb1').on("change",".checkbox1",function(){
		allbox = $("input[class=checkbox1]").length; 
		//전체선택 체크박스 제외 체크된박스 개수 구하기
		cnt = $("#cb1 input[type=checkbox]:checked").length;
		//체크박스가 다 체크될 경우 전체선택체크박스도 체크
		if(cnt == allbox){
			$(".checkAll1").prop('checked',true);
		}else{
			$(".checkAll1").prop('checked',false);
		}
	})
	
		//체크박스 전체 개수구하기
	$('#cb2').on("change",".checkbox2",function(){
		allbox = $("input[class=checkbox2]").length; 
		//전체선택 체크박스 제외 체크된박스 개수 구하기
		cnt = $("#cb2 input[type=checkbox]:checked").length;
		//체크박스가 다 체크될 경우 전체선택체크박스도 체크
		if(cnt == allbox){
			$(".checkAll2").prop('checked',true);
		}else{
			$(".checkAll2").prop('checked',false);
		}
	})
	$("#cb1").on("click",".al",function(){
		names = $(this).parent().parent().find(".alNm");
		units = $(this).parent().parent().find(".unit");
		codes = $(this).parent().parent().find(".al");
		thisis = $(this);
		var nWidth = 900;
		var nHeight =950;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);
		che = $(this).parents("#cb1").find('input[name=alCode]');
		cnt = che.length;
		for(i = 0; i<cnt; i++){
			console.log(che.eq(i).val());
		}
		window.name ="group";
		popup = window.open(
				"${cPath}/sal/allowanceList.do",
				"allowance",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		popup.addEventListener('beforeunload',function(){
			var success = 0;
			for(i = 0; i<cnt; i++){
			if(che.eq(i).val() == $("#alco").val()){
				success = 1;
			}
		}
			if(success == 0){
			names.text($("#alnm").val());
			codes.val($("#alco").val());
			prod = $("#alpro").val();
			if(prod == "고정"){ 
				provide = "금액";
			}else if(prod == "변동(시간)"){
				provide = "시급";
			}else if(prod == "변동(일)"){
				provide = "일급";
			}
			units.text(provide);
			}else{
				thisis.attr('data-original-title',"중복된 항목입니다.").tooltip();
			}
				
		})
		
	})
	$("#cb1").on("blur",".al",function(){
		thisis.removeAttr('data-original-title');
	})
	
	
	$("#cb2").on("click",".de",function(){
		names = $(this).parent().parent().find(".deNm");
		units = $(this).parent().parent().find(".unit");
		codes = $(this).parent().parent().find(".de");
		thisis = $(this);
		var nWidth = 950;
		var nHeight =900;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);
		che = $(this).parents("#cb2").find('input[name=deCode]');
		cnt = che.length;
		window.name ="group";
		popup = window.open(
				"${cPath}/sal/popDeductionList.do",
				"deduction",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		popup.addEventListener('beforeunload',function(){
			var success = 0;
			for(i = 0; i<cnt; i++){
			if(che.eq(i).val() == $("#alco").val()){
				success = 1;
			}
		}
			if(success == 0){
			names.text($("#alnm").val());
			codes.val($("#alco").val());
			units.text("금액");
			}else{
				thisis.attr('data-original-title',"중복된 항목입니다.").tooltip();
			}
				
		})
		
	})
	$("#cb2").on("blur",".de",function(){
		thisis.removeAttr('data-original-title');
	})
	
	$("input[class=saveBtn]").on("click",function(){
		target = $("#form");
		cnts = $("table").find(".money");
		for(i = 0; i<cnts.length; i++){
			cnts.eq(i).removeAttr('onkeyup');
			tmp =cnts.eq(i).val();
			console.log(tmp);
			tmps = tmp.replaceAll(',',"");
			console.log(tmps);
			cnts.eq(i).val(tmps);
		}
		target.submit();
	})
})
</script>
</html>