<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 직위/직급리스트</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/search.css">
<style>
	tbody tr td:first-child, tr th:first-child {
		width: 20px;
	}
	tbody tr td {
		text-align: center;
	}
</style>
</head>
<body>
	<div id="top">
		<span id="title">직위/직급리스트</span>
		<hr color="#F1F4FF">
	</div>
	<table>
		<thead>
			<tr>
				<td colspan="3">
					<div id="searchUI">
						<input name="pstNm" placeholder="직위/직급명">
						<input type="button" id="searchBtn" value="검색">
					</div>
				</td>
			</tr>
			<tr>
				<th><input type="checkbox" class="checkAll"></th>
				<th>직위/직급코드</th>
				<th>직위/직급명</th>
			</tr>
		</thead>
		<tbody>
		</tbody>		
	</table>
	<div id="bottom">
		<hr color="#F1F4FF">
		<input type="button" value="선택">
		<input type="button" onclick="window.close()" value="닫기">
	</div>
<form id="searchForm">
	<input type="hidden" name="pstNm" value="${ pagingVO.detailSearch.pstNm }">
</form>
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		let tbody = $("tbody");
		$(tbody).on("click", ".pstSelect", function(){
			code = $(this).parent().attr("code");
			nm = $(this).parent().attr("nm");
			opener.document.getElementById("nm").value = nm;
			opener.document.getElementById("code").value = code;
			window.close();
		});
		$(document).ajaxComplete(function(event, xhr, options){
			searchForm.find("[name='page']").val("");
		});
		let searchForm = $("#searchForm").paging().ajaxForm({
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				let pstList = pagingVO.dataList;
				let trTags = [];
				if(pstList.length > 0){
					$(pstList).each(function(idx, pst){
						trTags.push(
							$("<tr>").append(
								$("<td>").append("<input class='checkbox' type='checkbox'>"),
								$("<td class='pstSelect'>").html(pst.pstCode),
								$("<td class='pstSelect'>").html(pst.pstNm)
							).attr("code", pst.pstCode).attr("nm", pst.pstNm)
						);
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
				} else {
					trTags.push(
						$("<tr>").append(
							$("<td>").attr("colspan", "3").html("조건에 맞는 직위/직급이 없습니다.").css("color", "black")
						)
					);
				}
				tbody.append(trTags);
			}
		}).submit();
	});
</script>
</body>
</html>