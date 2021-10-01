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
		<span id="title">휴가현황</span>
		<hr color="#F1F4FF">
	</div>
	<div id="main-table">
		<p id="statusTitle">휴가현황</p>
		<table id="list-table">
			<thead>
				<tr>
					<th>휴가코드</th>
					<th>휴가일자</th>
					<th>사번</th>
					<th>사원명</th>
					<th>부서명</th>
					<th>직위/직급</th>
					<th>휴가구분</th>
					<th>휴가일수</th>
					<th>적요</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	<div id="bottom">
		<hr color="#F1F4FF">
		<input type="button" id="excel" value="Excel다운로드">
	</div>
	<form id="searchForm">
	</form>
	<div id="background"></div>
<input type="hidden" id="code">
<input type="hidden" id="nm">
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		//검색 초기화
		$(document).ajaxComplete(function(event, xhr, options){
			var vacstusCount = 0;
			$(".vacstusCount").each(function(){
				vacstusCount += parseInt($(this).html());
			});
			$(".sum").html(vacstusCount);
			searchForm.get(0).reset();
		});
		let tbody = $("#list-table tbody");
		let searchForm = $("#searchForm").paging().ajaxForm({
			url: "${ cPath }/vac/vacStatus.do",
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				let vacStusList = pagingVO.dataList;
				let trTags = [];
				if(vacStusList.length > 0){
					$(vacStusList).each(function(idx, vacStus){
						trTags.push(
							$("<tr>").append(
								$("<td>").html(vacStus.vacstusCode),
								$("<td>").html(vacStus.vacstusPeriod),
								$("<td>").html(vacStus.emplNo),
								$("<td>").html(vacStus.empl.emplNm),
								$("<td>").html(vacStus.empl.dept.deptNm),
								$("<td>").html(vacStus.empl.position.pstNm),
								$("<td>").html(vacStus.vacation.vcatnNm),
								$("<td class='vacstusCount'>").html(vacStus.vacstusCount),
								$("<td>").html(vacStus.vacstusSumry)
							)
						);
					});
					trTags.push(
						$("<tr>").append(
							$("<td>").html("합계").attr("colspan", "7"),
							$("<td class='sum'>").html("&ensp;"),
							$("<td>").html("&ensp;")
						).css("background", "#FCFCFE")
					)
				} else {
					trTags.push(
						$("<tr>").append(
							$("<td>").attr("colspan", "9").html("조건에 맞는 휴가신청내역이 없습니다.")
						)
					)
				}
				tbody.append(trTags);
			},
			error: function(xhr){
				alert(xhr.status);
			}
		}).submit();
	});
</script>
</body>
</html>