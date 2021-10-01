<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG |직책리스트</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/search.css">
</head>
<body>
	<div id="top">
		<span id="title">직책리스트</span>
		<hr color="#F1F4FF">
	</div>
	<table>
		<thead>
			<tr>
				<td colspan="3">
					<div id="searchUI">
						<input name="description" placeholder="직책명">
						<input type="button" id="searchBtn" value="검색">
					</div>
				</td>
			</tr>
			<tr>
				<th>직책명</th>
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
	</div>
<form id="searchForm">
	<input type="hidden" name="page">
	<input type="hidden" name="description" value="${ pagingVO.detailSearch.description }">
</form>
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		let tbody = $("tbody");
		$(tbody).on("click", ".roleSelect", function(){
			nm = $(this).parent().attr("description");
			opener.document.getElementById("description").value = nm;
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
				let roleList = pagingVO.dataList;
				let trTags = [];
				if(roleList.length > 0){
					$(roleList).each(function(idx, role){
							trTags.push(
								$("<tr>").append(
									$("<td class='roleSelect'>").html(role.description)
								).attr("description", role.description)
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
					pagingArea.html(pagingVO.pagingHTML);
				} else {
					trTags.push(
						$("<tr>").append(
							$("<td>").attr("colspan", "3").html("조건에 맞는 부서가 없습니다.").css("color", "black")
						)
					);
				}
				console.log(trTags)
				tbody.append(trTags);
			}
		}).submit();
	});
</script>
</body>
</html>