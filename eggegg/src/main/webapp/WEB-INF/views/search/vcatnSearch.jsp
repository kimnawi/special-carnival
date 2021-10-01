<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 휴가코드검색</title>
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
		<span id="title">휴가코드검색</span>
		<hr color="#F1F4FF">
	</div>
	<table>
		<thead>
			<tr>
				<td colspan="3">
					<div id="searchUI">
						<button name="vcatnUse" id="searchBtn" type="button" class="use">사용중단포함</button>
						&nbsp;&nbsp;
						<input name="vcatnNm" placeholder="부서명">
						<input type="button" id="searchBtn" value="검색">
					</div>
				</td>
			</tr>
			<tr>
				<th>휴가코드</th>
				<th>휴가명</th>
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
		<input type="button" value="선택">
		<input type="button" onclick="window.close()" value="닫기">
	</div>
<form id="searchForm">
	<input type="hidden" name="page">
	<input type="hidden" name="vcatnNm" value="${ pagingVO.detailSearch.vcatnNm }">
	<input type="hidden" name="vcatnUse" value="${ pagingVO.detailSearch.vcatnUse }">
</form>
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		let tbody = $("tbody");
		$(tbody).on("click", ".vcatnSelect", function(){
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
				let vcatnList = pagingVO.dataList;
				let trTags = [];
				if(vcatnList.length > 0){
					$(vcatnList).each(function(idx, vcatn){
						if(vcatn.vcatnUse == 'Yes'){
							trTags.push(
								$("<tr>").append(
									$("<td class='vcatnSelect'>").html(vcatn.vcatnCode),
									$("<td class='vcatnSelect'>").html(vcatn.vcatnNm)
								).attr("code", vcatn.vcatnCode).attr("nm", vcatn.vcatnNm)
							);
						} else {
							trTags.push(
								$("<tr>").append(
									$("<td class='vcatnSelect'>").html(vcatn.vcatnCode),
									$("<td class='vcatnSelect'>").html(vcatn.vcatnNm)
								).attr("code", vcatn.vcatnCode).attr("nm", vcatn.vcatnNm).css("background", "#FFF7F7")
							);
						}
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
							$("<td>").attr("colspan", "2").html("조건에 맞는 휴가코드가 없습니다.").css("color", "black")
						)
					);
				}
				tbody.append(trTags);
			}
		}).submit();
		$("button[name=vcatnUse]").on("click", function(){
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