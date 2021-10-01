<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${cPath}/resources/js/jquery-3.6.0.min.js"></script>
<title>EGGEGG | 근무입력</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 18px;
}
 td, th{
 	border: 1px solid #EAEAEA; 
 	padding: 5px 10px; 
 	text-align: center; 
 }	 
 table{
  border-collapse: collapse;
 }
#title{
	font-size: 20px; 
	margin: 10px; 
	margin-bottom: 20px; 
	font-weight: bold; 
 } 
hr{ 
 	margin: 7px 0px; 
}
#mainScroll{
	margin-top: 10px;
 	height: 743px; 
 	overflow-y : auto; 
 }
#date{
	background: #FCFCFE;
	padding: 5px;
}
 #day{ 
	display: inline-block;
	width: 150px;
	text-align: center;
 } 
input[name=workStdate]{ 
 	text-align: center; 
}
.ch{ 
	border: 1px solid #EAEAEA; 
	padding : 5px 10px; 
	width : 30px; 
	text-align: center; 
	margin-left : 0px;
 } 
#bottom{
	width: 98%;
	position: fixed;
	bottom: 10px;
}
.plus{
	width : 30px; 
	color: #4472C4;
	font-weight: bold;
	cursor: pointer;
	text-decoration: none;
	text-align: center;
}
.hidden{
	display: none;	
}
input[name=workHour]{
text-align: right;
}
th{ 
	border: 1px solid #EAEAEA; 
	padding: 5px 10px; 
	text-align: center; 
	background: #FCFCFE; 
}
.td1{
	width :210px;
}
.td2{
	width :150px;
}
.alNm{
	width :150px;
}
.unit{
	width :100px;
	text-align: center;
}
.td4{
	width :100px;
	text-align: center;
}
.td5{
	width : 150px;
}
#sumth{
	text-align: right;
}
#right{
	float:right;
}
#emplNm{
	width : 150px;
}
#searchUI table{
	position: absolute;
	top: 45px;
	border-bottom: 1px solid #EAEAEA;
	width: 97%;
	background: #FCFCFE;
	margin: 0;
}
#searchUI tbody td, #searchUI tbody th{
	border: none;
	color: black;
	text-align: inherit;
	font-weight: normal;
}
#searchUI tfoot td{
	background: white;
	text-align: inherit;
}
#searchButton{
	background: #3A4CA8;
	color: white;
	font-size: 16px;
	border-radius: 3px;
	padding: 2px 10px;
	margin: 2px 10px;
	float: right;
}
#searchBtn{
	background: #3A4CA8;
	color: white;
	border-radius: 3px;
	padding: 1px 10px;
	margin: 2px 0px 2px 10px;
}
.saveBtn {
	    display: inline-block;
	    text-decoration: none;
	    color: white;
	    padding: 1px 12px;
	    background: #3A4CA8;
	    border-radius: 3px;
	}
</style>
</head>
<body>
	<div id="top">
		<span id="title">근무입력</span>
		<span id="right">
			<span id="sNm"></span>
			<span id="sstart"></span>
			<span id="send"></span>
			<input type="button" value="상세검색" id="searchButton">
		</span>
		<hr color="#F1F4FF">
	</div>
<div id="maindiv">
	<form:form id="form" method="post" action="${cPath}/sal/workUpdate.do" commandName="work">
	<div id="date">
		<strong id="day">작성일자</strong><input type="date" readonly name="workStdate" value="${stdate}">
	</div>
	<div id="mainScroll">
		<div id="searchUI" class="searchDetail">
			<table>
				<tbody>
					<tr>
						<th>
							성명
						</th>
						<td><input name="emplNm" type="text" id="emplNm" placeholder="성명"></td>
					</tr>
					<tr>
						<th>
							근무일자
						</th>
						<td>
							<span class="dateForm">
								<input name="start" id="start"type="date"> ~ <input id="end"name="end" type="date">
							</span>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2"><input type="button" id="searchBtn" value="검색"><input type="reset" value="초기화"></td>
					</tr>
				</tfoot>
			</table>
		</div>
		<table id="work">
			<thead>
				<tr>
					<th class="ch"><input type="checkbox" class="checkAll"></th>
					<th class="plus"></th>
					<th class="th1">근무일자</th>
					<th class="th2">사원</th>
					<th class="th3">수당항목</th>
					<th class="th4">단위</th>
					<th class="th5">근무기록</th>
					<th class="th6">프로젝트</th>
				</tr>
			</thead>
			<tbody id="cb">
				<c:forEach items="${work}" var="work">
					<tr>
						<td class="ch"><input type="checkbox" class="checkbox"></td>
						<td class="plus"> + </td>
						<td><input class="td1" type="date" name="workDate" value="${work.workDate}"></td>
						<td><input type="hidden" name="emplNo" class="emplNo" value="${work.emplNo}"><input class="td2" type="text" name="emplNm" value="${work.emplNm}" readonly></td>
						<td><input type="hidden" name="alCode" class="alCode" value="${work.alCode}"><input class="alNm" type="text" name="alNm" value="${work.alNm}" readonly></td>
						<td class="td4"><span class="unit">${work.alProvide}</span></td>
						<td><input class="td5" type="text" name="workHour" onkeyup="inputNumberFormat(this)" value="${work.workHour}"></td>
						<td><input type="hidden" name="prjCode" class="prjCode" value="${work.prjCode}"><input class="td6" type="text" name="prjNm" class="prjNm" value="${work.prjNm}" readonly></td>
					</tr>
				</c:forEach>
					<tr>
						<td class="ch"><input type="checkbox" class="checkbox"></td>
						<td class="plus"> + </td>
						<td><input class="td1" type="date" name="workDate" ></td>
						<td><input type="hidden" name="emplNo" class="emplNo" ><input class="td2" type="text" name="emplNm" readonly></td>
						<td><input type="hidden" name="alCode" class="alCode" ><input class="alNm" type="text" name="alNm" readonly></td>
						<td class="td4"><span class="unit"></span></td>
						<td><input class="td5" type="text" name="workHour" onkeyup="inputNumberFormat(this)"></td>
						<td><input type="hidden" name="prjCode" class="prjCode"><input class="td6" type="text" name="prjNm" class="prjNm" readonly></td>
					</tr>
			</tbody>
					<tr>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th id="sumth"><span id="sum"><fmt:formatNumber value="${sum}"/></span></th>
						<th></th>
					</tr>
		</table>
	</div>
		<div id="hidden">
		
		</div>
	
	<input type="submit" id="realsub" style="display:none;">
	</form:form>
</div>
<div id="bottom">
	<hr color="#F1F4FF">
	<input type="button" value="저장" class="saveBtn">
	<input type="button" value="초기화" id="reset">
	<input type="button" value="선택삭제" id="remove">
	<input type="button" value="닫기" onclick="window.close()">
</div>
<input type="hidden" id="alco">
<input type="hidden" id="alnm">
<input type="hidden" id="alpro">
<input type="hidden" id="nm">
<input type="hidden" id="code">
<input type="hidden" id="dept">
<script>
$("#start").on("change",function(){
	last = $("#end").val();
	start = $("#start").val();
	if(start > last){
		$("#end").val(start);
	}
})
$("#end").on("change",function(){
last = $("#end").val();
start = $("#start").val();
if(start > last){
	$("#start").val(last);
}
})

//검색창 slide
let searchUI = $("#searchUI").hide();
$("#searchButton").on("click", function(){
	if(searchUI.is(":visible")){
		$("#searchUI").slideUp();
	} else {
		$("#searchUI").slideDown();
	}
});
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
	<c:if test="${ success eq 'SUCCESS' }">
	window.close();
	</c:if>
	function makeTr(works){
		if(works.prjNm== null){
			prjCode = "";
			prjNm = "";
		}
		return $("<tr>").append(
			$("<td class='ch'>").html("<input type='checkbox' class='checkbox'>"),
			$("<td class='plus'>").html(" + "),
			$("<td>").html("<input class='td1' type='date' name='workDate' value='"+works.workDate+"'>"),
			$("<td>").html("<input type='hidden' name='emplNo' class='emplNo' value='"+works.emplNo+"'><input class='td2' type='text' name='emplNm' value='"+works.emplNm+"' readonly>"),
			$('<td>').html("<input type='hidden' name='alCode' class='alCode' value='"+works.alCode+"'><input class='alNm' type='text' name='alNm' value='"+works.alNm+"' readonly>"),
			$("<td class='td4'>").html("<span class='unit'>"+works.alProvide+"</span>"),
			$("<td>").html("<input class='td5' type='text' name='workHour' onkeyup='inputNumberFormat(this)' value='"+works.workHour+"'>"),
			$("<td>").html("<input type='hidden' name='prjCode' class='prjCode' value='"+prjCode+"'><input class='td6' type='text' name='prjNm' class='prjNm' value='"+prjNm+"' readonly>")
		)
	}
	function makeEmpty(){
		return $("<tr>").append(
			$("<td class='ch'>").html("<input type='checkbox' class='checkbox'>"),
			$("<td class='plus'>").html(" + "),
			$("<td>").html("<input class='td1' type='date' name='workDate'>"),
			$("<td>").html("<input type='hidden' name='emplNo' class='emplNo'><input class='td2' type='text' name='emplNm' readonly>"),
			$('<td>').html("<input type='hidden' name='alCode' class='alCode' ><input class='alNm' type='text' name='alNm' readonly>"),
			$("<td class='td4'>").html("<span class='unit'></span>"),
			$("<td>").html("<input class='td5' type='text' name='workHour' onkeyup='inputNumberFormat(this)'>"),
			$("<td>").html("<input type='hidden' name='prjCode' class='prjCode'><input class='td6' type='text' name='prjNm' class='prjNm' readonly>")
		)
	}
	
	tbody = $("#cb");
	$("#searchBtn").on("click",function(){
		$("#searchUI").hide();
		$("#searchUI").slideUp();
		stdate = $("input[name=workStdate]").val();
		searchEmpl = $("#emplNm").val();
		start = $("#start").val();
		end = $("#end").val();
		$("#sNm").text(searchEmpl);
		$("#sstart").text(start);
		$("#send").text(end);
		$.ajax({
			url : "${cPath}/sal/searchWorkList.do",
			data : {"stdate" : stdate, "searchEmpl" : searchEmpl, "start" : start , "end" : end},
			dataType : "json",
			success : function(resp) {
				console.log(resp);
				tbody.empty();
				let trTags = [];
				sum = 0;
				$.each(resp,function(i,v){
					trTags.push(makeTr(v));
					sum += parseInt(v.workHour);
				});
				trTags.push(makeEmpty());
				tbody.append(trTags);
				$("#sum").text(sum);
			}
		})
		
		
		
	})
	
	
	$("#cb").on("change",".td5",function(){
		hour = $(".td5");
		sum = 0;
		for(i = 0;i<hour.length;i++){
			if(hour.eq(i).val() > 0){
				sum += parseInt(hour.eq(i).val());
			}
		}
		$("#sum").text(sum);
	})
	
	$("#remove").on("click",function(){
		cnt = $(".checkbox:checked");
		
		for(i = 0; i<cnt.length;i++){
			par = cnt.eq(i).parent().parent();
			par.find("input[type=checkbox]").prop("checked",false);
			no = par.find("input[name=emplNo]").val();
			date = par.find("input[name=workDate]").val();
			code = par.find("input[name=alCode]").val();
			$("#hidden").append("<input type='hidden' name='emplDel' value="+no+">");
			$("#hidden").append("<input type='hidden' name='dateDel' value="+date+">");
			$("#hidden").append("<input type='hidden' name='codeDel' value="+code+">");
			par.find("input").val("");
			par.find("input").removeAttr("value");
			par.find(".unit").text("");
// 			parent.find(".alNm").removeAttr("required");
// 			parent.find("input[name=workHour]").removeAttr("required");
		}
		hour = $(".td5");
		sum = 0;
		for(i = 0;i<hour.length;i++){
			if(hour.eq(i).val() > 0){
				sum += parseInt(hour.eq(i).val());
			}
		}
		$("#sum").text(sum);
	})
	
	$(".saveBtn").on("click",function(){
			$("tbody>tr:first").find("input[name=workDate]").attr("required","required");
			$("tbody>tr:first").find(".alNm").attr("required","required");
			$("tbody>tr:first").find("input[name=workHour]").attr("required","required");
			read = $(".alNm");
			read.removeAttr("readonly");
			$("#form").submit();
			$("#realsub").click();
			read.attr("readonly");
	})
	
	
	
	//사원검색
	$("#cb").on("click",".td2",function(){
		emplNm = $(this).parent().find(".td2");
		emplNo = $(this).parent().find(".emplNo");
		var nWidth = 800;
		var nHeight = 1000;
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
	$("#cb").on("click",".plus",function(){
		html = "<tr>";
		html += '<td class="ch"><input type="checkbox" class="checkbox"></td>';
		html += '<td class="plus"> + </td>';
		html += '<td><input class="td1" type="date" name="workDate" ></td>';
		html += '<td><input type="hidden" name="emplNo" class="emplNo" ><input readonly class="td2" type="text" name="emplNm"></td>';
		html += '<td><input type="hidden" name="alCode" class="alCode" ><input class="alNm" type="text" name="alNm" readonly></td>';
		html += '<td class="td4"><span class="unit"></span></td>';
		html += '<td><input class="td5" type="text" name="workHour" onkeyup="inputNumberFormat(this)"></td>';
		html += '<td><input type="hidden" name="prjCode" class="prjCode"><input class="td6" type="text" name="prjNm" class="prjNm" readonly></td>';
		html += '</tr>';
		$(this).parent().after(html);
	})
	$('input[type="text"]').keydown(function() {
		if($(this).attr("id") == "emplNm"){
			if(event.keyCode === 13){
				$("#search").click();
			}
		}
	    if (event.keyCode === 13) {
	        event.preventDefault();
	    }
	});
	
})

</script>
</body>
</html>