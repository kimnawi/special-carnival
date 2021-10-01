<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/list.css">
<link rel="stylesheet" href="${ cPath }/resources/css/status.css">
</head>
<body>
	<div id="top">
		<span id="title">출/퇴근현황</span>
		<input id="searchButton" type="button" value="상세검색">
		<hr color="#F1F4FF">
	</div>
	<div id="searchUI" class="searchDetail">
		<form>
			<table>
				<tbody>
					<tr>
						<th>
							기간
						</th>
						<td>
							<input name="atvlStartDate" type="date">&ensp;~&ensp;<input name="atvlEndDate" type="date">&ensp;
						</td>
					</tr>
					<tr>
						<th>
							사원
						</th>
						<td>
							<input type="hidden" class="code" name="atvlEmpl">
							<button class="small-search" data-action="emplSearch" type="button">
								<img class="searchImg" src="${ cPath }/resources/images/Search.png">
							</button><input type="text" class="nm" name="emplNm" placeholder="사원" readonly>
						</td>
					</tr>
					<tr>
						<th>내/외근구분</th>
						<td>
							<input type="radio" name="inOut" value checked>&ensp;전체&ensp;&ensp;
							<input type="radio" name="inOut" value="IN">&ensp;내근&ensp;&ensp;
							<input type="radio" name="inOut" value="OUT">&ensp;외근
						</td>
					</tr>
					<tr>
						<th>업무일/휴일구분</th>
						<td>
							<input type="radio" name="workAt" value checked>&ensp;전체&ensp;&ensp;
							<input type="radio" name="workAt" value="WORK">&ensp;업무일&ensp;&ensp;
							<input type="radio" name="workAt" value="REST">&ensp;휴일
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2">
							<input type="button" id="searchBtn" value="검색">
							<input type="reset" value="초기화">
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
	<div id="main-table">
		<p id="statusTitle">출/퇴근현황</p>
		<table id="list-table">
			<thead>
				<tr>
					<th>일자</th>
					<th>사원명</th>
					<th>출근시간</th>
					<th>퇴근시간</th>
					<th>근무시간(시간)</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	<form id="searchForm">
		<input type="hidden" name="atvlStartDate" value="${ pagingVO.detailSearch.atvlStartDate }">
		<input type="hidden" name="atvlEndDate" value="${ pagingVO.detailSearch.atvlEndDate }">
		<input type="hidden" name="atvlEmpl" value="${ pagingVO.detailSearch.atvlEmpl }">
		<input type="hidden" name="atvlForm" value="${ pagingVO.detailSearch.atvlForm }">
		<input type="hidden" name="atvlWorkAt" value="${ pagingVO.detailSearch.atvlWorkAt }">
	</form>
	<div id="bottom">
		<hr color="#F1F4FF">
		<input type="button" id="excel" value="Excel다운로드">
	</div>
	<div id="background"></div>
<input type="hidden" id="code">
<input type="hidden" id="nm">
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		//검색 버튼 클릭 시 검색창 닫음
		$("#searchBtn").on("click", function(){
			inOut = $("input[name=inOut]:checked").val();
			workAt = $("input[name=workAt]:checked").val();
			$("#searchForm input[name=atvlForm]").val(inOut);
			$("#searchForm input[name=atvlWorkAt]").val(workAt);
			searchUI.slideUp();
		});
		//검색 버튼
		$(".small-search").on("click", function(){
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
		//검색 초기화
		$(document).ajaxComplete(function(event, xhr, options){
			/* //검색단어 표시
			$("#searchUI input[type=text]").each(function(){
				var classNm = $(this).attr("name");
				var searchVal = $(this).val();
				$("."+classNm+":contains('"+searchVal+"')", tbody).each(function(){
					var regex = new RegExp(searchVal, 'gi');
					$(this).html($(this).text().replace(regex, "<span style='font-weight: bold; color: green;'>"+searchVal+"</span>"));
					
				});
			});
			$("#searchUI select").each(function(){
				var classNm = $(this).attr("name");
				var searchVal = $(this).find("option:selected").html();
				$("."+classNm+":contains('"+searchVal+"')", tbody).each(function(){
					var regex = new RegExp(searchVal, 'gi');
					$(this).html($(this).text().replace(regex, "<span style='font-weight: bold; color: green;'>"+searchVal+"</span>"));
					
				});
			}); */
			var atvlWorkTm = 0;
			$(".atvlWorkTm").each(function(){
				atvlWorkTm += parseInt($(this).html());
			});
			$(".sum").html(atvlWorkTm);
			searchForm.get(0).reset();
		});
		let tbody = $("#list-table tbody");
		let searchForm = $("#searchForm").paging().ajaxForm({
			url: "${ cPath }/vac/hrdStatus.do",
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				let atvlList = pagingVO.dataList;
				let trTags = [];
				if(atvlList.length > 0){
					$(atvlList).each(function(idx, atvl){
						background = "none";
						if(atvl.dateDay == '토'){
							background = "#F7FBFF";
						} else if (atvl.dateDay == '일'){
							background = "#FFF7F7";
						}
						trTags.push(
							$("<tr>").append(
								$("<td>").html(atvl.dateCode),
								$("<td>").html(atvl.empl.emplNm),
								$("<td>").html(atvl.atvlAttTm),
								$("<td>").html(atvl.atvlLvTm),
								$("<td class='atvlWorkTm'>").html(atvl.atvlWorkTm)
							).css("background", background)
						);
					});
					trTags.push(
						$("<tr>").append(
							$("<td>").html("합계").attr("colspan", "4"),
							$("<td class='sum'>")
						).css("background", "#FCFCFE")
					)
				} else {
					trTags.push(
						$("<tr>").append(
							$("<td>").attr("colspan", "5").html("조건에 맞는 출/퇴근내역이 없습니다.")
						)
					)
				}
				tbody.append(trTags);
			}
		}).submit();
		//검색창 slide
		let searchUI = $(".searchDetail").hide();
		$("#searchButton").on("click", function(){
			if(searchUI.is(":visible")){
				searchUI.slideUp();
			} else {
				searchUI.slideDown();
			}
		});
		
		today = new Date();
		today = today.toISOString().slice(0, 10);
		$("#searchUI input[name=atvlStartDate]").val(today);
		$("#searchUI input[name=atvlEndDate]").val(today);
		
		$("#searchUI input[type=reset]").on("click", function(e){
			e.preventDefault();
			$("#searchUI input[type=text]").val("");
			$("#searchUI input[type=hidden]").val("");
			$('#searchUI input[type=radio]').removeAttr('checked');
			$('#searchUI input[type=radio]').filter("[value='']").prop("checked", true);
			today = new Date();
			today = today.toISOString().slice(0, 10);
			$("#searchUI input[name=atvlStartDate]").val(today);
			$("#searchUI input[name=atvlEndDate]").val(today);
			
		});
	});
</script>
</body>
</html>