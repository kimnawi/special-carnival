<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 일정구분검색</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/search.css">
<style>
	tbody tr td{
		text-align: center;
	}	
</style>
</head>
<body>
	<div id="top">
		<span id="title">일정구분검색</span>
		<hr color="F1F4FF">
	</div>
	<table>
		<thead>
			<tr>
				<td colspan="3">
					<div id="searchUI">
						<input name="ctNm" placeholder="일정구분명">
						<input type="button" id="searchBtn" value="검색">
					</div>
				</td>
			</tr>
			<tr>
				<th>일정구분코드</th>
				<th>일정구분명</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2"> 
					<div id="pagingArea"></div>
				</td>
			</tr>
		</tfoot>
	</table>
	<div id="bottom">
		<hr color="#F1F4FF">
		<input type="button" onclick="window.close()" value="닫기">
	</div>
<form id="searchForm">
	<input type="hidden" name="page">
	<input type="hidden" name="ctNm" value="${ pagingVO.detailSearch.ctNm }">
</form>
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		$(document).ajaxComplete(function(event, xhr, options){
			searchForm.find("[name='page']").val("");				
		});
		
		let tbody = $("tbody");
		$(tbody).on("click", ".scheSelect", function(){
			code = $(this).parent().attr("code");
			nm = $(this).parent().attr("nm");
			opener.document.getElementById("code").value = code;
			opener.document.getElementById("nm").value = nm;
			window.close();
		});
		
		let pagingArea = $("#pagingArea");
		let searchForm = $("#searchForm").paging().ajaxForm({
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				pagingArea.empty();
				let scheList = pagingVO.dataList;
				console.log(scheList)
				let trTags = [];
				if(scheList.length > 0){
					$(scheList).each(function(idx, sche){
						trTags.push(
							$("<tr>").append(
								$("<td class='scheSelect'>").html(sche.ctTable),	
								$("<td class='scheSelect'>").html(sche.ctNm)		
							).attr("code", sche.ctTable).attr("nm", sche.ctNm)
						);
						idxs = idx;
					});
					while(idxs != 15){
						trTags.push(
							$("<tr>").append(
								$("<td>").attr("colspan", "2").css("border", "none")
							)		
						);
						idxs += 1;
					}
					pagingArea.html(pagingVO.pagingHTML);
				} else {
					trTags.push(
						$("<tr>").append(
							$("<td>").attr("colspan", "2").html("조건에 맞는 일정구분이 없습니다.").css("color", "black")
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