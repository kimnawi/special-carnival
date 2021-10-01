<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정관리</title>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/list.css">
<link rel="stylesheet" href="${ cPath }/resources/js/fullcalendar/main.min.css">
<style>
/* body 스타일 */
html, body {
overflow: hidden;
font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
font-size: 14px;
height: 1300px;
}
/* 캘린더 위의 해더 스타일(날짜가 있는 부분) */
.fc-header-toolbar {
padding-top: 1em;
padding-left: 1em;
padding-right: 1em;
}
div{
	width: auto;
}
#calendar{
	margin-left: 20px;
	width: 95%;
}
.fc-toolbar button{
	background: #3A4CA8;
}
.fc-toolbar-title{
	display: inline-block;
	position: relative;
	top: 5px;
	width: 400px;
	text-align: center;
}
.fc-day-sat .fc-daygrid-day-number { color:blue; }     /* 토요일 */
.fc-day-sun .fc-daygrid-day-number { color:red; }    /* 일요일 */
.fc-next-button{
	background: transeparent;
}
.fc-h-event{
	background-color: var(--fc-event-bg-color,transparent);
	border: none;
}
.fc-h-event .fc-event-main{
	color: black;
}
.fc th{
	vertical-align: middle;
}
#list-body td{
	vertical-align: middle;
}
.fc .fc-toolbar.fc-header-toolbar{
	padding: 0;
	margin: 10px;
}
.fc-h-event .fc-event-title-container{
	border-radius: 5px;
	background: #3788d8;
	color: white;
}
#list-table {
    margin-top: 0;
}
#pagingArea{
	margin-top: 20px;
}
.lvTh{
	width: 448px;
}
#searchUI{
	position: relative;
	left: 10px;
	margin-bottom: 10px;
}
#searchUI td{
	vertical-align: middle;
	border: none;
	height: 47px;
}
#searchUI th{
	width: 150px;
	border: none;
}
.searchImg {
	position: relative;
    width: 25px;
    right: 3px;
    top: -1px;
    margin: 0px;
    padding: 0px;
    z-index: 1;
}
.small-search {
    position: relative;
    display: inline;
    top: -2px;
    left:1px;
    width: 33px;
    height: 33px;
    text-align: center;
    vertical-align: middle;
    z-index: 1;
    bottom: 3px;
    border: 1px solid black;
    border-radius: 2px;
}
.btnArea{
	text-align: right;
}
.btnArea input{
	margin: 0 5px;
}
#bottom{
	width:80%;
}
#insert{
	margin:5px;
}
.scheSelect{
	cursor: pointer;
	color: #4472C4;
   	height: 27px;  	
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;  
    word-break: break-all;
}
.scheSelect:hover{
	color: #4472C4;
	text-decoration: underline;
}
#bottom{
	width: 100%;
	visibility: hidden;
}
#insert{
 	margin-left: 10px; 
}
#excel{
	margin-left: -5px;
}
</style>
</head>
<body>
	<div id="top">
		<span id="title">일정관리</span>
		<hr color="#F1F4FF">
	</div>
	<div id='calendar-container'>
		<div id='calendar'></div>
	</div>
	  <div id='bottom'>
	    <hr id='hr' color='#F1F4FF'> 
	    <input type='button' id='insert' value='신규'>
		<input type='button' id='excel' value='Excel'>
	  </div>
<form id="changeMonthForm">
	<input type="hidden" name="atvlMonth">
</form>
<form id="searchForm">
	<input type="hidden" name="page">
	<input type="hidden" name="atvlMonth">
	<input type="hidden" name="atvlEmpl" value="${ pagingVO.detailSearch.atvlEmpl }">
	<input type="hidden" name="atvlStartDate" value="${ pagingVO.detailSearch.atvlStartDate }">
	<input type="hidden" name="atvlEndDate" value="${ pagingVO.detailSearch.atvlEndDate }">
</form>
<input type="hidden" id="nm">
<input type="hidden" id="code">
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script src="${ cPath }/resources/js/fullcalendar/main.min.js"></script>
<script src="${ cPath }/resources/js/fullcalendar/locale/ko.js"></script>
<script src="${ cPath }/resources/js/paging.js"></script>
<script>
	$(function(){		
		//검색 초기화
		$(document).ajaxComplete(function(event, xhr, options){
			searchForm.find("[name='page']").val("");
			searchForm.find("[name='atvlEmpl']").val("");
			searchForm.find("[name='atvlStartDate']").val("");
			searchForm.find("[name='atvlEndDate']").val("");
		});
		$(document).on("click", "#searchUI input[type=reset]", function(){
			$("input[name=atvlEmpl]").val("");
		});
		let changeMonthForm = $("#changeMonthForm").ajaxForm({
			url: "${ cPath }/schedule/scheList.do",
			dataType: "json",
			success: function(calScheList){
				$("#bottom").css('visibility', 'hidden');
				$(".fc-dayGridMonth-view").show();
				var events = [];
				for(i = 0; i < calScheList["dataList"].length; i++){
					sche = calScheList["dataList"][i];
					let eve ={
						title: sche.smTitle,
						start: sche.smStartTmCal,
						end: sche.smEndTmCal
					};
					events.push(eve);
				}
				atvlMonthValue = $("form input[name=atvlMonth]").val();
				today = new Date();
				if(atvlMonthValue == null || atvlMonthValue.length < 1) {
					convertDate(today);
					atvlMonthValue = $("form input[name=atvlMonth]").val();
				}
				initialDate = '20' + atvlMonthValue.substring(0, 2) + '-' + atvlMonthValue.substring(2, 4) + '-15';
				if(initialDate == null || initialDate.length < 1){
					initialDate = '20' + today.substring(0, 2) + '-' + today.substring(2, 4) + '-15';
				}
				renderCalendar(events, initialDate);
			}
		}).submit();
		calendar = null;
		function renderCalendar(events, initialDate){
			$(".fc-view-harness").empty();
			var calendarEl = $('#calendar')[0];
			calendar = new FullCalendar.Calendar(calendarEl, {
				height: '700px', // calendar 높이 설정
				expandRows: true, // 화면에 맞게 높이 재설정
				// 해더에 표시할 툴바
				customButtons: { 
			        scheList: { 
			            text: '리스트', 
			            click: function(event) { 
			            	$("#bottom").css('visibility', 'visible');
							$(".fc-dayGridMonth-view").hide();
							$(".fc-view-harness").empty();
							$(".fc-view-harness").append(
								$("<div id='searchUI'>").append(
									$("<form>").append(
										$("<table>").append(
											$("<tr>").append(
												$("<th>").html("일자"),
												$("<td>").append(
													$("<input name='atvlStartDate' type='date'>"),
													$("<span>").html("&ensp;~&ensp;"),
													$("<input name='atvlEndDate' type='date'>")
												),
												$("<th>").html("참석자"),
												$("<td>").append(
													$("<input type='hidden' class='code' name='atvlEmpl'>"),
													$("<button class='small-search' data-action='emplSearch' type='button'>").append(
														$("<img class='searchImg' src='${ cPath }/resources/images/Search.png'>")
													),
													$("<input type='text' class='nm' name='emplNm' placeholder='참석자' readonly>")
												),
												$("<td class='btnArea'>").append(
													$("<input type='button' id='searchBtn' value='검색'>"),
													$("<input type='reset' value='초기화'>")
												)
											)
										)
									)
								),
								$("<table id='list-table'>").append(
									$("<thead>").append(
										$("<tr>").append(
											$("<th><input type='checkbox' class='checkAll'>"),
											$("<th>").html("일자/요일"),
											$("<th>").html("시작시간"),
											$("<th>").html("종료시간"),
											$("<th>").html("참석자성명"),
											$("<th>").html("제목"),
											$("<th>").html("장소")
										)
									),
									$("<tbody id='list-body'>"),
									$("<tfoot>").append(
										$("<tr>").append(
											$("<td colspan='6' style='border:none;'>").append(
												$("<div id='pagingArea'>")
											)
										)
									)
								)
							);
							searchForm.submit();
			            } 
			        },
					todayBtn: {
						text: '오늘',
						click: function(){
							var date = new Date();
						    convertDate(date);
							$(".fc-event-title-container").removeClass("fc-event-title-container");
							changeMonthForm.submit();
							calendar.today();
						}
					}
				}, 
				headerToolbar: {
					left: 'dayGridMonth,scheList',
					center: 'prev,title,next',
					right: 'todayBtn'
				},
				initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
				initialDate: initialDate,	//초기 로드 날짜
				navLinks: true, // 날짜를  선택하면 Day캘린더나 Week캘린더로 링크
				editable: true, // 수정 가능?
				selectable: true, // 달력 일자 드래그 설정가능
				nowIndicator: true, // 현재 시간 마크
				dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
				locale: 'ko', // 한국어 설정
				events: events
			});
			calendar.render();
			$(".fc-next-button").removeClass("fc-button-primary");
			$(".fc-prev-button").removeClass("fc-button-primary");
			$(".fc-toolbar-title").css("font-size", "23px");
		}
		//검색 버튼
		$(document).on("click", ".small-search", function(){
			action = $(this).data("action");
			code = $(this).parents("td").find(".code");
			nm = $(this).parents("td").find(".nm");
			var nWidth = 900;
			var nHeight = 950;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name = action;
			popup = window.open(
					"${ cPath }/search/" + action + ".do",
					"searchTable",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				code.val($("#code").val());
				nm.val($("#nm").val());
			});
		});
		$(document).on("click", ".pageLink", function(event){
			event.preventDefault();
			let page = $(this).data("page");
			searchForm.find('[name=page]').val(page);
			searchForm.submit();
			return false;
		}).css("cursor", "pointer");
		$(document).on("click", "#searchBtn", function(){
			let inputs = $("#searchUI").find(":input[name]");
			$(inputs).each(function(idx, input){
				let name = this.name;
				let value = $(this).val();
				searchForm.find("[name='"+name+"']").val(value);
			})
			searchForm.submit();
		});
		const searchUIChangeTrigger = true;
		if(searchUIChangeTrigger){
			$("#searchUI").on("change", ":input", function(){
				$(this).siblings($("#searchBtn")).click();
			});
		}
		let searchForm = $("#searchForm").paging().ajaxForm({
			url: "${ cPath }/schedule/scheList.do",
			dataType: "json",
			success: function(pagingVO){
				$("#list-body").empty();
				$("#pagingArea").empty();
				let scheList = pagingVO.dataList;
				let trTags = [];
				if(scheList.length > 0){
					$(scheList).each(function(idx, sche){
						emplNm = "";
						if(sche.empl != null){
							emplNm = sche.empl.emplNm;
						}
						trTags.push(
							$("<tr>").append(
									$("<td>").append($("<input class='checkbox'>").attr("type", "checkbox")),
									$("<td>").append($("<a class='scheUpdate'>").html(sche.smStart)),
									$("<td>").html(sche.smStartTm),
									$("<td>").html(sche.smEnd),
									$("<td>").html(emplNm),
									$("<td>").append($("<a class='scheSelect'>").html(sche.smTitle)),
									$("<td>").html(sche.smLocation)
								).data("sche", sche)
							)       
						idxs = idx;
					});
					while(idxs < 14){
						trTags.push(
							$("<tr>").append(
								$("<td>").attr("colspan", "7").css("border", "none")
							)
						);
						idxs += 1;
					}
					$("#pagingArea").html(pagingVO.pagingHTML);
				} else {
					trTags.push(
						$("<tr>").html(
							$("<td>").attr("colspan", "7").html("조건에 맞는 일정이 없습니다.")
						)
					);
				}
				$("#list-body").append(trTags);
			}
		});
		//왼쪽, 오른쪽 버튼을 누를 경우
		$("#calendar").on("click", "button.fc-prev-button, button.fc-next-button", function(){
			var date = calendar.getDate();
		    convertDate(date);
			$(".fc-event-title-container").removeClass("fc-event-title-container");
			changeMonthForm.submit();
		});
		
		$("#calendar").on("click", "button.fc-dayGridMonth-button", function(){
			changeMonthForm.submit();
		});
		
		
		//일정등록폼
		$(document).on("click", "#insert", function(){
			var nWidth = 930;
			var nHeight = 990;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name ="scheInsert";
			popup = window.open(
					"${ cPath }/schedule/scheInsert.do",
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		});

		//체크박스 클릭
		$(document).on("click",".checkAll",function(){
			ck = $(this).prop('checked');
			$(this).parents('table').find('.checkbox').prop('checked', ck);
		});
		
		$(document).on("change",".checkbox",function(){
			allbox = $("input:checkbox").length-1; 
			//전체선택 체크박스 제외 체크된박스 개수 구하기
			cnt = $("input[type=checkbox]:checked").length;
			//체크박스가 다 체크될 경우 전체선택체크박스도 체크
			if(cnt == allbox){
				$(".checkAll").prop('checked',true);
			}else{
				$(".checkAll").prop('checked',false);
			}
		});
		
		//일정 상세보기
		$(document).on("click", ".scheSelect", function(){
// 			searchUI.hide();
			smNo = $(this).parents("tr").data("sche").smNo;
			var nWidth = 930;
			var nHeight = 990;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = Math.ceil(( window.screen.width - nWidth )/2);
			var nTop = Math.ceil(( window.screen.height - nHeight )/2);
			window.name ="scheSelect";
			popup = window.open(
					"${ cPath }/schedule/scheView.do?what=" + smNo,
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				scheSelect.css({"background":"transparent"});
			});
		});

	});
	function convertDate(date) {
	    var date = new Date(date);
	    $("form input[name=atvlMonth]").val(date.yymm());
	}
	// 받은 날짜값을 YYMM 형태로 출력하기위한 함수.
	Date.prototype.yymm = function() {
	    var yy = this.getFullYear().toString().slice(-2);
	    var mm = (this.getMonth() + 1).toString();
	    return yy + "" + (mm[1] ? mm : "0" + mm[0]);
	}
</script>
</body>
</html>