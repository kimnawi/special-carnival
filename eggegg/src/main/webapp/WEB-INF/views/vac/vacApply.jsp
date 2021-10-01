<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가신청</title>
<link rel="stylesheet" href="${ cPath }/resources/css/vacApply.css">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div id="top">
		<span id="title">휴가신청</span>
		<hr color="#F1F4FF">
	</div>
	<table id="emplInfo">
		<tr>
			<th>사번</th>
			<td>${ empl.emplNo }</td>
			<th>사원명</th>
			<td>${ empl.emplNm }</td>
			<th>부서</th>
			<td>${ empl.dept.deptNm }</td>
			<th>총 휴가일수</th>
			<td>${ empl.vacHistory.vcatnAmount } 일</td>
			<th>잔여 휴가일수</th>
			<td>${ empl.vacHistory.vcatnLeft } 일</td>
		</tr>
	</table>
	<div id="searchUI">
		<form>
			<table>
				<tr>
					<th>휴가코드</th>
					<td>
						<input type="hidden" class="code" name="vcatnCode">
						<button class="small-search" data-action="vcatnSearch" type="button">
							<img class="searchImg" src="${ cPath }/resources/images/Search.png">
						</button><input type="text" class="nm" name="vcatnNm" placeholder="휴가코드" readonly>
					</td>
					<th>작성일자</th>
					<td>
						<input type="date" name="vacstusStart">
						&ensp;~&ensp;
						<input type="date" name="vacstusEnd">
					</td>
					<th>휴가사유</th>
					<td>
						<input type="text" name="vacstusSumry" placeholder="적요">
					</td>
					<td class='btnArea'>
						<input type="button" id="searchBtn" value="검색"><input type="reset" value="초기화">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<table id="list-table">
		<thead>
			<tr>
				<th>휴가명</th>
				<th>휴가기간</th>
				<th id="resn">휴가사유</th>
				<th>반차여부</th>
				<th>진행상태</th>
			</tr>
		</thead>
		<tbody></tbody>
		<tfoot>
			<tr>
				<td colspan="5">
					<div id="pagingArea"></div>
				</td>
			</tr>
		</tfoot>
	</table>
	<div id="bottom">
		<hr color="#F1F4FF">
		<button type="button" id="insert">신청</button>
	</div>
	<form class="draftInfo">
		<input type="hidden" id="draftTitle">
	</form>
	<form id="searchForm">
		<input type="hidden" name="page">
		<input type="hidden" name="vcatnCode" value="${ pagingVO.detailSearch.vcatnCode }">
		<input type="hidden" name="vacstusStart" value="${ pagingVO.detailSearch.vacstusStart }">
		<input type="hidden" name="vacstusEnd" value="${ pagingVO.detailSearch.vacstusEnd }">
		<input type="hidden" name="vacstusSumry" value="${ pagingVO.detailSearch.vacstusSumry }">
	</form>
	<input type="hidden" id="nm">
	<input type="hidden" id="code">
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
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
		$("#list-table").on("click", ".draftForm", function(){
			vacstusCode = $(this).parents("tr").data("vacApply").vacstusCode;
			draftTitle = "휴가신청서_${ empl.emplNm }";
			$("#draftTitle").val(draftTitle);
			$.ajax({
				url: '${ cPath }/vac/vacApplyDraft.do?what=' + vacstusCode,
				dataType: "html"
			}).done(function(res){
				localStorage.setItem("draftContent", res);
			});
			var nWidth = 1100;
			var nHeight = 1000;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name ="vacApplyInsert";
			popup = window.open(
					"${ cPath }/group/esign/draftForm.do?command=INSERT&formNo=6&chit=com.eg.vacation.service.VacService&code=" + vacstusCode,
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				searchForm.submit();
			});
		});
		$("#searchUI input[type=reset]").on("click", function(){
			$("#searchUI input[type=hidden]").val("");
		});
		$(document).ajaxComplete(function(event, xhr, options){
			searchForm.find("[name='page']").val("");
		});
		let tbody = $("#list-table tbody");
		let pagingArea = $("#pagingArea");
		let searchForm = $("#searchForm").paging().ajaxForm({
			dataType: "json",
			url: "${ cPath }/vac/vacApply.do",
			success: function(pagingVO){
				tbody.empty();
				pagingArea.empty();
				let vacApplyList = pagingVO.dataList;
				let trTags = [];
				if(vacApplyList.length > 0){
					$(vacApplyList).each(function(idx, vacApply){
						halfAt = "-";
						if(vacApply.vacstusHalfAt == 'Yes'){
							halfAt = "Y";
						}
						if(vacApply.draft == null){
							trTags.push(
								$("<tr>").append(
									$("<td>").html(vacApply.vacation.vcatnNm),
									$("<td>").html(vacApply.vacstusPeriod),
									$("<td class='selectDetail'>").html(vacApply.vacstusSumry),
									$("<td>").html(halfAt),
									$("<td>").html("<a class='draftForm'>결재받기</a>")
								).data("vacApply", vacApply)
							)
							idxs = idx;
						} else {
							color="black";
							if(vacApply.draft.draftProgress == '결재완료'){
								color = "green";
							}
							trTags.push(
								$("<tr>").append(
									$("<td>").html(vacApply.vacation.vcatnNm),
									$("<td>").html(vacApply.vacstusPeriod),
									$("<td class='selectDetail'>").html(vacApply.vacstusSumry),
									$("<td>").html(halfAt),
									$("<td>").html(vacApply.draft.draftProgress).css("color", color)
								).data("vacApply", vacApply)
							)
							idxs = idx;
						}
					});
					while(idxs < 15){
						trTags.push(
							$("<tr>").append(
								$("<td>").attr("colspan", "5").css("border", "none")
							)
						);
						idxs++;
					}
					pagingArea.html(pagingVO.pagingHTML);
				} else {
					trTags.push(
						$("<tr>").html(
							$("<td>").attr("colspan", "5").html("휴가신청내역이 없습니다.")
						)
					)
				}
				tbody.append(trTags);
			}
		}).submit();
		
		$("#insert").on("click", function(){
			var nWidth = 700;
			var nHeight = 500;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name ="vacApplyInsert";
			popup = window.open(
					"${ cPath }/vac/vacApplyInsert.do",
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				searchForm.submit();
			});
		});
		
		$(document).on("click", ".selectDetail", function(){
			vacstusCode = $(this).parent().data("vacApply").vacstusCode;
			selectDetail = $(this).parents("tr").find("td");
			selectDetail.css("background", "#FEFAE5");
			selectDetail.not(".selectDetail").css("color", "#AAAAAA");
			var nWidth = 700;
			var nHeight = 500;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			draft = $(this).parent().data("vacApply").draft;
			window.name ="vacApplyUpdate";
			if(draft == null){
				popup = window.open(
						"${ cPath }/vac/vacApplyUpdate.do?vacstusCode=" + vacstusCode + "&command=VIEW",
						"draftDetail",
						"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			} else {
				if(draft.draftProgress == '임시저장'){
					popup = window.open(
							"${ cPath }/vac/vacApplyUpdate.do?vacstusCode=" + vacstusCode + "&command=VIEW",
							"draftDetail",
							"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
				} else {
					popup = window.open(
							"${ cPath }/vac/vacApplyUpdate.do?vacstusCode="+vacstusCode+"&view=VIEW",
							"draftDetail",
							"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
				}
			}
			popup.addEventListener('beforeunload', function(){
				selectDetail.css({"background":"transparent"});
			});
		});
	});
</script>
</body>
</html>