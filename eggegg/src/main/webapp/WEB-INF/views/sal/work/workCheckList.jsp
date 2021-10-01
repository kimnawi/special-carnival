<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${cPath}/resources/js/paging.js"></script>
<script src="${cPath}/resources/js/jquery.form.min.js"></script>
</head>
<style>
.cen{
	text-align : center;
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
#searchUI{
	padding: 5px 10px;
	background: #FCFCFE;
	margin-bottom: 10px;
}
.th1{
	border: 1px solid #EAEAEA;
   	padding: 5px 10px;
   	height: 40px;
   	width: 48px;
   	text-align: center;
}
tr{
	height:40px;
}
th{
	text-align: center;
	background: #FCFCFE;
}
table{
	border-collapse: collapse;
	width: 100%;
}
td, th{
	border: 1px solid #EAEAEA;
	padding: 5px 10px;
	height: 40px;
}
.th2{
	width : 250px;
}
.th3{
	width : 250px;
}
.th5{
	width : 250px;
}
#bottom{
	width: 98%;
	position: fixed;
	bottom: 75px;
}
tfoot td{
	text-align: center;
	border:none;
}
#searchBtn{
	display : none;
}
#maindiv{
	margin: 10px;
}
.hour{
	text-align: right;
}
.stdate{
	text-align: center;
}
.ch{
	border: 1px solid #EAEAEA;
	padding : 5px;
	height : 40px;
	width : 48px;
	text-align: center;
}
#cb .a{
	color: #4472C4;
}
#cb .a:hover {
	text-decoration: underline;	
	cursor: pointer;
}
#searchTitle{
	display: inline-block;
	width: 180px;
	text-align: center;
}
</style>
<body>
	<div id="top">
		&ensp;&ensp;&ensp;<span id="title">근무조회</span>
		<hr color="#F1F4FF">
	</div>
	<div id="maindiv">
		<div id="searchUI">
			<strong id="searchTitle">전표일자 검색</strong>
			<input type="date" name="startDate" id="std">
			&ensp;~&ensp;
			<input type="date" name="lastDate" id="lad">
			<input type="button" value="검색" id="searchBtn">
		</div>
		<table id="workList">
			<thead>
				<tr>
				<th class="th1"><input type="checkbox" class="checkAll"></th>
				<th class="th2">전표일자</th>
				<th class="th3">사원</th>
				<th class="th4">수당항목</th>
				<th class="th5">근무기록</th>
				</tr>
			</thead>
			<tbody id="cb">
			
			</tbody>
			<tfoot>
				<tr>
					<td colspan="5">
						<div id="pagingArea"></div>
					</td>
				</tr>
			</tfoot>
	</table>
	</div>
	<div id="bottom">
		<hr color="#F1F4FF">
		<input type="button" value="선택삭제" id="remove" style="margin-left: 10px;">
		<input type="button" value="excel">
	</div>
	<form id="searchForm">
		<input type="hidden" name="page">
		<input type="hidden" name="startDate" id="std2" value="${pagingVO.detailSearch.startDate}">
		<input type="hidden" name="lastDate" id="lad2" value="${pagingVO.detailSearch.lastDate}">
	</form>
</body>
<script>
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
$(function(){
today = new Date();
preYear = today.getFullYear();
preMonth = today.getMonth();
if(preMonth <10){
	preMonth = "0"+preMonth;
}
if(preMonth == 0){
	preYear = parseInt(preYear)-1;
	preMonth = "12";
}

prev = preYear+"-"+preMonth+"-01";
today = today.toISOString().slice(0, 10);
$("input[name=lastDate]").val(today);
$("input[name=startDate]").val(prev);

$("input[name=startDate]").on("change",function(){
		last = $("input[name=lastDate]").val();
		start = $("input[name=startDate]").val();
		if(start > last){
			$("input[name=lastDate]").val(start);
		}
	})
$("input[name=lastDate]").on("change",function(){
	last = $("input[name=lastDate]").val();
	start = $("input[name=startDate]").val();
	if(start > last){
		$("input[name=startDate]").val(last);
	}
})


let tbody = $("#cb");
let pagingArea = $("#pagingArea");

function makeTrTag(work){
	if(work.emplCount != 0){
		empl = work.emplNm + " 외 "+ work.emplCount+"명";
	}else{
		empl = work.emplNm
	}
	work.workHour = comma(work.workHour);
	return $("<tr>").append(
		$("<td class='ch'>").html("<input type='checkbox' class='checkbox'>"),
		$("<td class='stdate'>").html("<span class='a'>"+work.workStdate+"</span>"),		
		$("<td>").html(empl),		
		$("<td>").html(work.alNm),
		$("<td class='hour'>").html(work.workHour)
	);
}
function makeTag(){
	return $("<tr>").append(
		$("<td>").html(),
		$("<td>").html(),
		$("<td>").html(),		
		$("<td>").html(),
		$("<td>").html()
	);
}



let searchForm = $("#searchForm").paging({
	pagingArea : "#pagingArea",
	pageLink : ".pageLink",
	searchUI : "#searchUI",
	btnSelector : "#searchBtn",
	pageKey : "page",
	pageParam : "page",
	searchUIChangeTrigger:true
}).ajaxForm({
	dataType:"json",
	url : "${cPath}/sal/workList.do",
	success:function(pagingVO){
		console.log(pagingVO);
		tbody.empty();
		pagingArea.empty();
		let workList = pagingVO.dataList;
		let trTags = [];
		idxs = 0;
		if(workList && workList.length > 0){
			$(workList).each(function(idx, work){
				trTags.push( makeTrTag(work) );
				idxs = idx;
			});
			while(idxs!=15){
				trTags.push(makeTag());
				idxs +=1;
			}
			pagingArea.html(pagingVO.pagingHTML);
		}else{
			trTags.push(
				$("<tr>").html(
					$("<td class='cen'>").attr("colspan", "5").html("조건에 맞는 결과가 없음.")	
				)
			);
			while(idxs!=15){
				trTags.push(makeTag());
				idxs +=1;
			}
		}
		tbody.append(trTags);
	} // success end
}).submit();


$("#cb").on("click",".a",function(){
	stdate = $(this).text();
	var nWidth = 1300;
	var nHeight = 900;
	var curX = window.screenLeft;
	var curY = window.screenTop;
	var curWidth = document.body.clientWidth;
	var curHeight = document.body.clientHeight;
	var nLeft = curX + (curWidth / 2) - (nWidth / 2);
	var nTop = curY + (curHeight / 2) - (nHeight / 2);
	window.name = "adgroup";
	popup = window.open(
			"${cPath}/sal/workForm2.do?stdate="+stdate,
			"adgroupForm",
			"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
	popup.addEventListener('beforeunload',function(){
		setTimeout(() => {
			window.location.reload();
			}, 200);
	})	
	
	
})
$('input[type="text"]').keydown(function() {
    if (event.keyCode === 13) {
        event.preventDefault();
    }
});	
	
$("#remove").on("click",function(){
	cnt = $(".checkbox:checked");
	date = "";
	for(i = 0; i<cnt.length; i++){
		tr = cnt.eq(i).parent().parent();
		stdate = tr.find(".a").text();
		if(i != 0){
			date +=",";
		}
		date += stdate;
	}
	if(cnt.length == 0){
		cAlert("리스트에 선택된 자료가 없습니다.<br>체크박스에 체크한 후 다시 시도 바랍니다.");
	}else{
		location.href="${cPath}/sal/workDelete.do?stdate="+date;
	}
})	
	
	
})
</script>
</html>