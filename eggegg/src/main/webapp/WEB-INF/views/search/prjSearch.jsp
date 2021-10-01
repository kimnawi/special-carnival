<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 프로젝트리스트</title>
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
		<span id="title">프로젝트리스트</span>
		<hr color="#F1F4FF">
	</div>
	<table>
		<thead>
			<tr>
				<td colspan="3">
					<div id="searchUI">
						<button name="prjUse" id="searchBtn" type="button" class="use">사용중단포함</button>
						&nbsp;&nbsp;
						<input name="prjNm" placeholder="프로젝트명">
						<input type="button" id="searchBtn" value="검색">
					</div>
				</td>
			</tr>
			<tr>
				<th><input type="checkbox" class="checkAll"></th>
				<th>프로젝트코드</th>
				<th>프로젝트명</th>
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
		<input id="selectBtn" type="button" value="선택">
	</div>
<form id="searchForm">
	<input type="hidden" name="page">
	<input type="hidden" name="prjNm" value="${ pagingVO.detailSearch.prjNm }">
	<input type="hidden" name="prjUse" value="${ pagingVO.detailSearch.prjUse }">
</form>
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		let tbody = $("tbody");
		$(tbody).on("click", ".prjSelect", function(){
			code = $(this).parent().attr("code");
			nm = $(this).parent().attr("nm");
			opener.document.getElementById("nm").value = nm;
			opener.document.getElementById("code").value = code;
			window.close();
		});
		$("#selectBtn").on("click", function(){
			code = [];
			nm = [];
			$(document).find(".checkbox").each(function(i){
				if($(this).is(":checked")){
					code.push($(this).parents("tr").attr("code"));
					nm.push($(this).parents("tr").attr("nm"));
				}
			});
			opener.document.getElementById("code").value = code;
			opener.document.getElementById("nm").value = nm;
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
				let prjList = pagingVO.dataList;
				let trTags = [];
				if(prjList.length > 0){
					$(prjList).each(function(idx, prj){
						if(prj.prjUse == 'Yes'){
							trTags.push(
								$("<tr>").append(
									$("<td>").append("<input class='checkbox' type='checkbox'>"),
									$("<td class='prjSelect'>").html(prj.prjCode),
									$("<td class='prjSelect'>").html(prj.prjNm)
								).attr("code", prj.prjCode).attr("nm", prj.prjNm)
							);
						} else {
							trTags.push(
								$("<tr>").append(
									$("<td>").append("<input class='checkbox' type='checkbox'>"),
									$("<td class='prjSelect'>").html(prj.prjCode),
									$("<td class='prjSelect'>").html(prj.prjNm)
								).attr("code", prj.prjCode).attr("nm", prj.prjNm).css("background", "#FFF7F7")
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
							$("<td>").attr("colspan", "3").html("조건에 맞는 프로젝트가 없습니다.").css("color", "black")
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
		$("button[name=prjUse]").on("click", function(){
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