<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 사원검색</title>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="${ cPath }/resources/css/emplSearch.css">
</head>
<body>
	<div id="top">
		<span id="title">사원검색</span>
		<input id="searchButton" type="button" value="상세검색">
		<hr color="#F1F4FF">
	</div>
	<table id="list-table">
		<thead>
			<tr>
				<th style="width :200px;">사원번호</th>
				<th>성명</th>
				<th>부서명</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="3">
					<div id="pagingArea"></div>
				</td>
			</tr>
		</tfoot>
	</table>
		<div id="searchUI">
		<form>
			<table>
				<tbody>
					<tr>
						<th>
							성명
						</th>
						<td><input name="emplNm" type="text" placeholder="성명"></td>
					</tr>
					<tr>
						<th>
							입사일자
						</th>
						<td>
							<span class="dateForm">
								<input name="emplEcnyStart" type="date"> ~ <input name="emplEcnyEnd" type="date">
							</span>
							<input class="useButton" type="checkbox"> 사용
						</td>
					</tr>
					<tr>
						<th>
							부서
						</th>
						<td>
							<input type="hidden" class="code" name="deptCode">
							<button class="small-search" data-action="deptSearch" type="button">
								<img class="searchImg" src="${ cPath }/resources/images/Search.png">
							</button><input type="text" class="nm" name="deptNm" placeholder="부서" readonly>
						</td>
					</tr>
					<tr>
						<th>
							재직구분
						</th>
						<td>
							<input type="radio" name="emplTenureAtt" value>전체&ensp;
							<input type="radio" name="emplTenureAtt" value="TENURE" checked>재직자&ensp;
							<input type="radio" name="emplTenureAtt" value="RETIRE">퇴사자
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2"><input type="button" id="searchBtn" value="검색"> <input type="reset" value="다시 작성"></td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
	<div id="bottom">
		<hr color="#F1F4FF">
		<input type="button" onclick="window.close()" value="닫기">
	</div>
<input type="hidden" id="nm">
<input type="hidden" id="code">
<form id="searchForm">
	<input type="hidden" name="page">
	<input type="hidden" name="emplNm" value="${ pagingVO.detailSearch.emplNm }">
	<input type="hidden" name="deptCode" value="${ pagingVO.detailSearch.deptCode }">
	<input type="hidden" name="emplEcnyStart" value="${ pagingVO.detailSearch.emplEcnyStart }">
	<input type="hidden" name="emplEcnyEnd" value="${ pagingVO.detailSearch.emplEcnyEnd }">
</form>
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		let tbody = $("#list-table tbody");
		$(tbody).on("click", ".emplSelect", function(){
			code = $(this).parent().attr("code");
			nm = $(this).parent().attr("nm");
			dept = $(this).parent().children().last().text();
			opener.document.getElementById("nm").value = nm;
			opener.document.getElementById("code").value = code;
			opener.document.getElementById("dept").value = dept;
			window.close();
		});
		//검색창 slide
		let searchUI = $("#searchUI").hide();
		$("#searchButton").on("click", function(){
			if(searchUI.is(":visible")){
				searchUI.slideUp();
			} else {
				searchUI.slideDown();
			}
		});
		today = new Date();
		startDate = new Date(today.getFullYear(), today.getMonth(), 2);
		today = today.toISOString().slice(0, 10);
		startDate = startDate.toISOString().slice(0, 10);
		//검색창 입사일자 사용
		let dateForm = $(".dateForm").hide();
		$(".useButton").change(function(){
			if($(this).is(":checked")){
				$(this).parent().find(dateForm).show();
				$("input[name=emplEcnyStart]").val(startDate);
				$("input[name=emplEcnyEnd]").val(today);
			} else if(!$(this).is(":checked")) {
				$(this).parent().find(dateForm).hide();
				$("input[name=emplEcnyStart]").val("");
				$("input[name=emplEcnyEnd]").val("");
			}
		});
		$("input[type=reset]").on("click", function(){
			$("input[type=hidden]").val("");
			if($(dateForm).is(":visible")){
				dateForm.hide();
			}
		});
		//검색 버튼 클릭 시 검색창 닫음
		$("#searchBtn").on("click", function(){
			emplTenureAtt = $("input[name=emplTenureAtt]:checked").val();
			$("#searchForm input[name=tenureAtt]").val(emplTenureAtt);
			searchUI.slideUp();
		});
		//검색 버튼
		$(".small-search").on("click", function(){
			action = $(this).data("action");
			code = $(this).parents("td").find(".code");
			nm = $(this).parents("td").find(".nm");
			var nWidth = 500;
			var nHeight = 670;
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
		$(document).ajaxComplete(function(event, xhr, options){
			searchForm.find("[name='page']").val("");
		});
		let pagingArea = $("#pagingArea");
		searchForm = $("#searchForm").paging().ajaxForm({
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				pagingArea.empty();
				let emplList = pagingVO.dataList;
				let trTags = [];
				if(emplList.length > 0){
					$(emplList).each(function(idx, empl){
						let deptNm = "";
						if(empl.dept != null){
							deptNm = empl.dept.deptNm;
						}
						trTags.push(
							$("<tr>").append(
								$("<td class='emplSelect'>").html(empl.emplNo),
								$("<td class='emplSelect'>").html(empl.emplNm),
								$("<td class='emplSelect'>").html(deptNm)
							).attr("code", empl.emplNo).attr("nm", empl.emplNm)
						);
						idxs = idx;
					});
					while(idxs < 15){
						trTags.push(
							$("<tr>").append(
								$("<td>").attr("colspan", "3").css("border", "none")
							)		
						);
						idxs += 1;
					}
					pagingArea.html(pagingVO.pagingHTML);
				} else {
					trTags.push(
						$("<tr>").append(
							$("<td>").attr("colspan", "3").html("조건에 맞는 사원이 없습니다.").css("color", "black")
						)
					);
				}
				tbody.append(trTags);
			}
		}).submit();
		$('.checkAll').on('click',function(){
			ck = $(this).prop('checked');
			$(this).parents('table').find('.checkbox').prop('checked', ck);
		});
		$(tbody).on("change",".checkbox",function(){
			allbox = $("input:checkbox").length-1; 
			//전체선택 체크박스 제외 체크된박스 개수 구하기
			cnt = $("#cb input[type=checkbox]:checked").length;
			//체크박스가 다 체크될 경우 전체선택체크박스도 체크
			if(cnt == allbox){
				$(".checkAll").prop('checked',true);
			}else{
				$(".checkAll").prop('checked',false);
			}
		});
	});
</script>
</body>
</html>