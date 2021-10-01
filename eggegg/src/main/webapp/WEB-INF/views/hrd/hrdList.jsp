<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출/퇴근기록부</title>
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
#list-table {
    margin-top: 0;
}
#pagingArea{
	margin-top: 20px;
}
.lvTh, .atTh{
	width: 400px;
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
.fc-daygrid {
	height: 700px;
}
/* fc-dayGridMonth-view fc-view */
</style>
</head>
<body>
	<div id="top">
		<span id="title">출/퇴근기록부</span>
		<hr color="#F1F4FF">
	</div>
	<div id='calendar-container'>
		<div id='calendar'></div>
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
			url: "${ cPath }/vac/hrdList.do",
			dataType: "json",
			success: function(attendeLvffcList){
				$(".fc-dayGridMonth-view").show();
				var events = [];
				for(i = 0; i < attendeLvffcList.length; i++){
					atvl = attendeLvffcList[i];
					let eve ={
						title: atvl.emplWorkCnt + "(" + atvl.emplInCnt + ", " + atvl.emplOutCnt + ") | " + atvl.emplAbseCnt + " | " + atvl.emplCnt,
						start: atvl.atvlAttTm
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
			        hrdList: { 
			            text: '리스트', 
			            click: function(event) { 
			            	$(".info").remove();
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
												$("<th>").html("사원"),
												$("<td>").append(
													$("<input type='hidden' class='code' name='atvlEmpl'>"),
													$("<button class='small-search' data-action='emplSearch' type='button'>").append(
														$("<img class='searchImg' src='${ cPath }/resources/images/Search.png'>")
													),
													$("<input type='text' class='nm' name='emplNm' placeholder='사원' readonly>")
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
											$("<th>").html("일자"),
											$("<th>").html("사원명"),
											$("<th>").html("소속부서"),
											$("<th class='atTh'>").html("출근시간"),
											$("<th class='lvTh'>").html("퇴근시간"),
											$("<th>").html("내/외근")
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
					left: 'dayGridMonth,hrdList',
					center: 'prev,title,next',
					right: 'todayBtn'
				},
				initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
				initialDate: initialDate,	//초기 로드 날짜
				navLinks: false, // 날짜를  선택하면 Day캘린더나 Week캘린더로 링크
				editable: false, // 수정 가능?
				selectable: false, // 달력 일자 드래그 설정가능
				nowIndicator: true, // 현재 시간 마크
				dayMaxEvents: false, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
				locale: 'ko', // 한국어 설정
				events: events
			});
			$(".info").remove();
			calendar.render();
			$(".fc-next-button").removeClass("fc-button-primary");
			$(".fc-prev-button").removeClass("fc-button-primary");
			$(".fc-toolbar-title").css("font-size", "23px");
			$(".fc-daygrid-day-number").removeData("navlink");
			$(".fc-header-toolbar").after($("<p class='info' style='font-size: 15px; text-align:right;'>").html("근무자수(내근, 외근) | 결근자수 | 총 사원수"));
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
			url: "${ cPath }/vac/hrdEmplList.do",
			dataType: "json",
			success: function(pagingVO){
				$("#list-body").empty();
				$("#pagingArea").empty();
				let atvlList = pagingVO.dataList;
				let trTags = [];
				if(atvlList.length > 0){
					$(atvlList).each(function(idx, atvl){
						deptNm = "";
						if(atvl.dept != null){
							deptNm = atvl.dept.deptNm;
						}
						trTags.push(
							$("<tr>").append(
								$("<td>").html(atvl.dateCode),
								$("<td>").html(atvl.empl.emplNm),
								$("<td>").html(deptNm),
								$("<td>").html(atvl.atvlAttTm),
								$("<td>").html(atvl.atvlLvTm),
								$("<td>").html(atvl.atvlForm)
							)
						)
						idxs = idx;
					});
					while(idxs < 14){
						trTags.push(
							$("<tr>").append(
								$("<td>").attr("colspan", "6").css("border", "none")
							)
						);
						idxs += 1;
					}
					$("#pagingArea").html(pagingVO.pagingHTML);
				} else {
					trTags.push(
						$("<tr>").html(
							$("<td>").attr("colspan", "6").html("조건에 맞는 출/퇴근기록이 없습니다.")
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
			changeMonthForm.submit();
		});
		
		$("#calendar").on("click", "button.fc-dayGridMonth-button", function(){
			changeMonthForm.submit();
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