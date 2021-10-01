<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${cPath}/resources/js/jquery-3.6.0.min.js"></script>
<title>Insert title here</title>
<style>
form{
	width: 98%;
}
td, th{
	border: 1px solid #EAEAEA;
	padding: 5px 10px;
	height: 36px;
	text-align: center;
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
main {
 	width: 84%; 
	padding: 30px 0 0;
}
#maindiv{
	margin-left: 10px;
	height: 770px;
	overflow-y : auto;
}
#date{
	width : 100%;
	background: #FCFCFE;
	padding: 5px 10px;
}
#day{
	text-align: center;
	width : 150px;
	display: inline-block;
}
input[name=workStdate]{
	width : 218px;
	text-align: center;
	margin-right : 200px;
}
input[name=workDate]{
	width :100%;
	text-align: center;
}
.ch{
	border: 1px solid #EAEAEA;
	padding : 5px; 10px;
	height : 40px;
	width : 40px;
	text-align: center;
}
th{
	border: 1px solid #EAEAEA;
	padding: 5px 10px;
	height: 40px;
	text-align: center;
	background: #FCFCFE;
}
#work{
	width :100%;
}
.plus{
	width : 40px;
}
#bottom{
	width: 98%;
	position: fixed;
	bottom: 75px;
}
.th1{
	width: 240px;
}
.plus{
	color: #4472C4;
	font-weight: bold;
	cursor: pointer;
	text-decoration: none;
	text-align: center;
}
#right{
	float:right;
	margin-right : 10px;
}
#work input{
	width :100%;
	border: 1px solid #EAEAEA;
	border-radius: 5px;
}
.th3{
	width :350px;
}
.th4{
	width :180px;
}
.th5{
	width : 180px;
}
.th6{
	width : 300px;
}
.hidden{
	display: none;	
}
input[name=workHour]{
text-align: right;
}
.emplNm{
 border: none;
 background: #FCFCFE;
 cursor: default;
 text-align: center;
}
.emplNm:focus{
	outline: none;
	
}
.saveBtn{
	margin-left: 10px;
	padding: 1px 10px;
	height: 33px;
}
</style>
</head>
<body>
	<div id="top">
		&ensp;&ensp;&ensp;<span id="title">근무입력</span>
	</div>
		<hr color="#F1F4FF">
	<br>
<div id="maindiv">
	<form:form id="form" method="post" action="${cPath}/sal/workInsert.do" commandName="work">
	<div id="date">
		<strong id="day">작성일자</strong><input type="date" name="workStdate">
		<div id="right">
			<input type="hidden" id="emplNo" name="emplNo">
			<input readonly type="text" class="emplNm" id="emplNm" ><input type="button" value="사원검색" id="emplSearch">
		</div>
	</div>
	<br>
	<table id="work">
		<thead>
			<tr>
				<th class="ch"><input type="checkbox" class="checkAll"></th>
				<th></th>
				<th class="th1">근무일자</th>
				<th class="th3">수당항목</th>
				<th class="th4">단위</th>
				<th class="th5">근무기록</th>
				<th class="th6">프로젝트</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" begin="1" end="3">
				<tr>
					<td class="ch"><input type="checkbox" class="checkbox"></td>
					<td class="plus"> + </td>
					<td><input type="hidden" name="emplNo" class="emplNo"><input type="date" name="workDate"></td>
					<td><input type="hidden" name="alCode" class="alCode"><input class="alNm" type="text" name="alNm"></td>
					<td><span class="unit"></span></td>
					<td><input type="text" name="workHour" onkeyup="inputNumberFormat(this)"></td>
					<td><input type="hidden" name="prjCode" class="prjCode"><input type="text" name="prjNm" class="prjNm"></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<input type="submit" id="realsub" style="display:none;">
	</form:form>
</div>
<div id="bottom">
	<hr color="#F1F4FF">
	<input type="button" value="저장" class="saveBtn">
	<input type="button" value="초기화" id="reset">
	<input type="button" value="선택삭제" id="remove">
</div>
<input type="hidden" id="alco">
<input type="hidden" id="alnm">
<input type="hidden" id="alpro">
<input type="hidden" id="nm">
<input type="hidden" id="code">
<input type="hidden" id="dept">
<script>
//readolnly change이벤트 감지 
(function ($) {
    var originalVal = $.fn.val;
    $.fn.val = function (value) {
        var res = originalVal.apply(this, arguments);
 
        if (this.is('input:text') && arguments.length >= 1) {
            // this is input type=text setter
            this.trigger("input");
        }
 
        return res;
    };
})(jQuery);

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
    str = str.replace(/(^0+)/, "");
    return str.replace(/[^\d]+/g, '');
}
today = new Date();
today = today.toISOString().slice(0, 10);
$("input[name=workStdate]").val(today);
	$("#emplNm").oninput = function(){
		console.log(123);
	}
//빈 태그
function makeEmpty(){
	return $("<tr>").append(
			$("<td class='ch'>").html("<input type='checkbox' class='checkbox'>"),
			$("<td class='plus'>").html(" + "),
			$("<td>").html("<input type='date' name='workDate'>"),
			$("<td>").html("<input type='hidden' name='alCode' class='alCode'><input type='text' class='alNm' name='alNm' readonly>"),
			$("<td>").html("<span class='unit'></span>"),
			$("<td>").html("<input type='text' name='workHour' onkeyup='inputNumberFormat(this)'>"),
			$("<td>").html("<input type='hidden' name='prjCode' class='prjCode'><input type='text' name='prjNm' class='prjNm'> ")
	)
}	

function makeTr(work){
	year = work.dateCode.substring(0,4);
	month = work.dateCode.substring(4,6);
	day = work.dateCode.substring(6,8);
	date = year+"-"+month+"-"+day;
	emplNo = work.emplNo;
	if(work.holiday == "Y" || work.day =="토" || work.day=="일"){
		alCode = "03";
		alNm = "주말근무수당";
		work = work.work;
	}else{
		if(work.pto == "Y"){
			return;
		}
		alCode = "02";
		alNm = "야근수당";
		work = work.work-9;
		if(work == 0){
			return;
		}
	}
	
	return $("<tr>").append(
			$("<td class='ch'>").html("<input type='checkbox' class='checkbox'>"),
			$("<td class='plus'>").html(" + "),
			$("<td>").html("<input type='date' name='workDate' value='"+date+"'>"),
			$("<td>").html("<input type='hidden' name='alCode' class='alCode' value='"+alCode+"'><input type='text' readonly class='alNm' name='alNm' value='"+alNm+"'>"),
			$("<td>").html("<span class='unit'>변동(시간)</span>"),
			$("<td>").html("<input type='text' name='workHour' onkeyup='inputNumberFormat(this)' value='"+work+"'>"),
			$("<td>").html("<input type='hidden' name='prjCode' class='prjCode'><input type='text' name='prjNm' class='prjNm' readonly> ")
	)
	
}	
	
$(function(){
	$("#work").on("change","input[name=workDate]",function(){
		parent = $(this).parent().parent();
		parent.find(".alNm").attr("required","required");
		parent.find("input[name=workHour]").attr("required","required");
		
	})
	$("#remove").on("click",function(){
		cnt = $(".checkbox:checked");
		
		for(i = 0; i<cnt.length;i++){
			par = cnt.eq(i).parent().parent();
			par.find("input[type=checkbox]").prop("checked",false);
			par.find("input").val("");
			par.find("input").removeAttr("value");
			par.find(".unit").text("");
			parent.find(".alNm").removeAttr("required");
			parent.find("input[name=workHour]").removeAttr("required");
		}
		if(cnt.length == 0){
			cAlert("리스트에 선택된 자료가 없습니다. <br>체크박스에 체크한 후 다시 시도 바랍니다.");
		}
		
	})
	
	$(".saveBtn").on("click",function(){
		if($("#emplNo").val().length >0){
			$("tbody>tr:first").find("input[name=workDate]").attr("required","required");
			$("tbody>tr:first").find(".alNm").attr("required","required");
			$("tbody>tr:first").find("input[name=workHour]").attr("required","required");
			read = $(".alNm");
			read.removeAttr("readonly");
			$("#realsub").click();
			read.attr("readonly");
		}else{
			cAlert("사원 검색 후 다시 시도바랍니다.");
		}
	})
	
	tbody = $("tbody");
    var $input = $("#emplNo"); // readonly inputBox  
    $("#emplNm").on('input', function() {
        console.log($(this).val());
        date =$("input[name=workStdate]").val();
        No = $("#emplNo").val();
		$.ajax({
			url : "${cPath}/sal/workEmplList.do",
			dataType : "json",
			data : {"date" : date , "No" : No},
			success : function(resp) {
				tbody.empty();
				console.log(resp);
    
				let trTags = [];
				$.each(resp.autoList,function(i,work){
					trTags.push(makeTr(work));
				});
				trTags.push(makeEmpty());
				tbody.append(trTags);
			}
		});
        
    });
	
	
	//사원검색
	$("#emplSearch").on("click",function(){
		emplNm = $(this).parent().find(".emplNm");
		emplNo = $(this).parent().find("#emplNo");
		var nWidth = 900;
		var nHeight = 950;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);
		window.name = "work";
		popup = window.open(
				"${ cPath }/sal/emplSearch.do",
				"emplSearch",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		popup.addEventListener('beforeunload', function(){		
			emplNo.val($("#code").val());
			emplNm.val($("#nm").val());
		})
	})
	
	//form초기화
	$("#reset").on("click",function(){
		window.location.reload();
	})
	
	//프로젝트 입력 팝업
	$("#work").on("click",".prjNm",function(){
		prjNm = $(this).parent().parent().find(".prjNm");
		prjCode = $(this).parent().parent().find(".prjCode");
		var nWidth = 500;
		var nHeight =500;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);		
		window.name ="work";
		popup = window.open(
				"${cPath}/sal/popProjectList.do",
				"project",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		popup.addEventListener('beforeunload',function(){
			prjNm.val($("#alnm").val());
			prjCode.val($("#alco").val());
		})		
		
		
	})
	//수당항목 입력 팝업
	$("#work").on("click",".alNm",function(){
		names = $(this).parent().parent().find(".alNm");
		units = $(this).parent().parent().find(".unit");
		codes = $(this).parent().parent().find(".alCode");
		var nWidth = 500;
		var nHeight =500;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);		
		window.name ="work";
		popup = window.open(
				"${cPath}/sal/popAllowanceList.do",
				"allowance",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		popup.addEventListener('beforeunload',function(){
			names.val($("#alnm").val());
			codes.val($("#alco").val());
			units.text($("#alpro").val());
		})
	})
	
	
	//플러스 기능
	$("#work").on("click",".plus",function(){
		html = "<tr>";
		html += '<td class="ch"><input type="checkbox" class="checkbox"></td>';
		html += '<td class="plus"> + </td>';
		html += '<td><input type="date" name="workDate"></td>';
		html += '<td><input type="hidden" name="alCode" class="alCode"><input class="alNm" type="text" name="alNm"></td>';
		html += '<td><span class="unit"></span></td>';
		html += '<td><input type="text" name="workHour" onkeyup="inputNumberFormat(this)"></td>';
		html += '<td><input type="hidden" name="prjCode" class="prjCode"><input type="text" name="prjNm" class="prjNm"></td>';
		html += '</tr>';
		$(this).parent().after(html);
	})
	$('input[type="text"]').keydown(function() {
	    if (event.keyCode === 13) {
	        event.preventDefault();
	    }
	});
	
})

</script>
</body>
</html>