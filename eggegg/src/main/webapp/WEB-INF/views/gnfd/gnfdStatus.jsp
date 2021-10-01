<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<span id="title">인사발령현황</span>
		<input id="searchButton" type="button" value="상세검색">
		<hr color="#F1F4FF">
	</div>
	<div id="searchUI" class="searchDetail">
		<form>
			<table>
				<tbody>
					<tr>
						<th>
							발령일자
						</th>
						<td>
							<span class="dateForm">
								<input name="gnfdStartDe" type="date">&ensp;~&ensp;<input name="gnfdEndDe" type="date">&ensp;
							</span>
							<input class="useButton" type="checkbox">&ensp;사용
						</td>
					</tr>
					<tr>
						<th>
							사원
						</th>
						<td>
							<input type="hidden" class="code" name="emplNo">
							<button class="small-search" data-action="emplSearch" type="button">
								<img class="searchImg" src="${ cPath }/resources/images/Search.png">
							</button><input type="text" class="nm" name="emplNm" placeholder="사원" readonly>
						</td>
					</tr>
					<tr>
						<th>발령구분</th>
						<td>
							<select name="gnfdType">
								<option value>== 발령구분 ==</option>
								<c:forEach items="${ gnfdTypeList }" var="gnfdType">
									<option value="${ gnfdType.ctTable }">${ gnfdType.ctNm }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>적요</th>
						<td>
							<input name="gnfdSumry" type="text" placeholder="적요">
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
		<p id="statusTitle">인사발령현황</p>
		<table id="list-table">
			<thead>
				<tr>
					<th>발령코드</th>
					<th>발령일자</th>
					<th>사번</th>
					<th>사원명</th>
					<th>발령구분명</th>
					<th>이전 직위/직급</th>
					<th>발령 직위/직급</th>
					<th>이전 부서</th>
					<th>발령 부서</th>
					<th>적요</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	<form id="searchForm">
		<input type="hidden" name="gnfdStartDe" value="${ pagingVO.detailSearch.gnfdStartDe }">
		<input type="hidden" name="gnfdEndDe" value="${ pagingVO.detailSearch.gnfdEndDe }">
		<input type="hidden" name="emplNo" value="${ pagingVO.detailSearch.emplNo }">
		<input type="hidden" name="gnfdType" value="${ pagingVO.detailSearch.gnfdType }">
		<input type="hidden" name="gnfdSumry" value="${ pagingVO.detailSearch.gnfdSumry }">
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
		$("#excel").on("click", function(){
			location.href = "${cPath}/empl/gnfdExcel.do"
		});
		//검색 초기화
		$(document).ajaxComplete(function(event, xhr, options){
			//검색단어 표시
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
			});
			searchForm.get(0).reset();
		});
		$("#searchUI input[type=reset]").on("click", function(){
			$("#searchUI input[type=hidden]").val("");
		});
		let tbody = $("#list-table tbody");
		let searchForm = $("#searchForm").paging().ajaxForm({
			url: "${ cPath }/empl/gnfdStatus.do",
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				let gnfdList = pagingVO.dataList;
				let trTags = [];
				if(gnfdList.length > 0){
					$(gnfdList).each(function(idx, gnfd){
						trTags.push(
							$("<tr>").append(
								$("<td>").html(gnfd.gnfdStdrde),
								$("<td>").html(gnfd.gnfdDe),
								$("<td>").html(gnfd.emplNo),
								$("<td class='emplNm'>").html(gnfd.empl.emplNm),
								$("<td class='gnfdType'>").html(gnfd.gnfd.ctNm),
								$("<td>").html(gnfd.gnfdBposition),
								$("<td>").html(gnfd.position.pstNm),
								$("<td>").html(gnfd.deptBnm),
								$("<td>").html(gnfd.dept.deptNm),
								$("<td class='gnfdSumry'>").html(gnfd.gnfdSumry)
							)
						);
						idxs = idx+1;
					});
					trTags.push(
						$("<tr>").append(
							$("<td>").html("사원 수").attr("colspan", "9"),
							$("<td>").html(idxs)
						).css("background", "#FCFCFE")
					)
				} else {
					trTags.push(
						$("<tr>").append(
							$("<td>").attr("colspan", "10").html("조건에 맞는 인사발령내역이 없습니다.")
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
		startDate = new Date(today.getFullYear(), today.getMonth()-1, 2);
		today = today.toISOString().slice(0, 10);
		startDate = startDate.toISOString().slice(0, 10);
		//검색창 입사일자 사용
		let dateForm = $(".dateForm").hide();
		$(".useButton").change(function(){
			if($(this).is(":checked")){
				$(this).parent().find(dateForm).show();
				$(this).parent().find("input:first-child").val(startDate);
				$(this).parent().find("input:last-child").val(today);
			} else if(!$(this).is(":checked")) {
				$(this).parent().find(dateForm).hide();
				$(this).find("input").val("");
			}
		});
	});
</script>
</body>
</html>