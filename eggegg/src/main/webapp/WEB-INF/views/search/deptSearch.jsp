<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 부서리스트</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/search.css">
<style>
	tbody tr td:first-child, tr th:first-child {
		width: 20px;
	}
	tbody tr td:nth-child(2){
		text-align: center;
	}
</style>
</head>
<body>
	<div id="top">
		<span id="title">부서리스트</span>
		<hr color="#F1F4FF">
	</div>
	<table>
		<thead>
			<tr>
				<td colspan="3">
					<div id="searchUI">
						<button name="deptUse" id="searchBtn" type="button" class="use">사용중단포함</button>
						&nbsp;&nbsp;
						<input name="deptNm" placeholder="부서명">
						<input type="button" id="searchBtn" value="검색">
					</div>
				</td>
			</tr>
			<tr>
				<th><input type="checkbox" class="checkAll"></th>
				<th>부서코드</th>
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
	<div id="bottom">
		<hr color="#F1F4FF">
		<input type="button" value="선택">
		<input type="button" onclick="window.close()" value="닫기">
	</div>
<form id="searchForm">
	<input type="hidden" name="page">
	<input type="hidden" name="deptNm" value="${ pagingVO.detailSearch.deptNm }">
	<input type="hidden" name="deptUse" value="${ pagingVO.detailSearch.deptUse }">
</form>
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		let tbody = $("tbody");
		$(tbody).on("click", ".deptSelect", function(){
			code = $(this).parent().attr("code");
			nm = $(this).parent().attr("nm");
			opener.document.getElementById("nm").value = nm;
			opener.document.getElementById("code").value = code;
			window.close();
		});
		$(document).ajaxComplete(function(event, xhr, options){
			searchForm.find("[name='page']").val("");
		});
		let pagingArea = $("#pagingArea");
		let searchForm = $("#searchForm").paging().ajaxForm({
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				pagingArea.empty();
				let deptList = pagingVO.dataList;
				let trTags = [];
				if(deptList.length > 0){
					$(deptList).each(function(idx, dept){
						if(dept.deptUse == 'Yes'){
							trTags.push(
								$("<tr>").append(
									$("<td>").append("<input class='checkbox' type='checkbox'>"),
									$("<td class='deptSelect'>").html(dept.deptCode),
									$("<td class='deptSelect'>").html(dept.deptNm)
								).attr("code", dept.deptCode).attr("nm", dept.deptNm)
							);
						} else {
							trTags.push(
								$("<tr>").append(
									$("<td>").append("<input class='checkbox' type='checkbox'>"),
									$("<td class='deptSelect'>").html(dept.deptCode),
									$("<td class='deptSelect'>").html(dept.deptNm)
								).attr("code", dept.deptCode).attr("nm", dept.deptNm).css("background", "#FFF7F7")
							);
						}
						idxs = idx;
					});
					while(idxs != 15){
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
							$("<td>").attr("colspan", "3").html("조건에 맞는 부서가 없습니다.").css("color", "black")
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
		$("button[name=deptUse]").on("click", function(){
			if($(this).val() == '1'){
				$(this).css("background", "#EAEAEA").css("color", "black").html('사용중단포함');
				$(this).val(null);
			} else {
				$(this).css("background", "#3A4CA8").css("color", "white").html('사용중단미포함');
				$(this).val('1');
			}
		});
	});
</script>
</body>
</html>