<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${ cPath }/resources/css/list.css">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
</head>
<style>
	#list-table a{
		color: #4472C4;
		cursor: pointer;
	}
	#list-table a:hover{
		text-decoration: underline;
	}
	.att{
		background: #EAEAEA;
		border-color : #929292;
		border-width : 1px;
		color: black;
		border-radius: 20px;
		padding: 3px 10px;
		cursor: pointer;
		width: 90px;
	}
	.att:active{
		background: #3A4CA8;
		border-color : #3A4CA8;
		color : white;
	}
	#searchUI{
		margin-top: 10px;
		margin-left: 10px;
	}
	#list-table .vacstusCode{
		width: 160px;
	}
	#list-table .vacstusPeriod{
		width: 300px;
	}
	#list-table .emplNm{
		width: 110px;
	}
	#list-table .vcatnNm{
		width: 180px;
	}
	#list-table .vacstusCount{
		width: 130px;
	}
	#searchUI button[name=draftAll]{
		background: #3A4CA8;
		border-color: #3A4CA8;
		color: white;
	}
	.draftProgress{
		width: 120px;
	}
</style>
<body>
	<div id="top">
		<span id="title">휴가조회</span>
		<hr color="#F1F4FF">
	</div>
	<div id="searchUI">
		<button type="button" name="draftAll" class="att">전체</button>
		<button type="button" name="draftIng" class="att" value="결재중">결재중</button>
		<button type="button" name="draftIng" class="att" value="결재완료">결재완료</button>
	</div>
	<table id="list-table">
		<thead>
			<tr>
				<th class="vacstusCode">휴가번호</th>
				<th class="vacstusPeriod">휴가일자</th>
				<th class="emplNm">사원명</th>
				<th class="vcatnNm">휴가명</th>
				<th class="vacstusCount">휴가일수</th>
				<th>적요</th>
				<th>결재구분</th>
			</tr>
		</thead>
		<tbody></tbody>
		<tfoot>
			<tr>
				<td colspan="6">
					<div id="pagingArea"></div>
				</td>
			</tr>
		</tfoot>
	</table>
	<form id="searchForm">
		<input type="hidden" name="page">
		<input type="hidden" name="draft.draftProgress" value="${ pagingVO.detailSearch.draft.draftProgress }">
	</form>
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		//검색 초기화
		$(document).ajaxComplete(function(event, xhr, options){
			searchForm.get(0).reset();
		});
		let tbody = $("#list-table tbody");
		let pagingArea = $("#pagingArea");
		let searchForm = $("#searchForm").paging().ajaxForm({
			url: "${ cPath }/vac/vacStusList.do",
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				pagingArea.empty();
				let vacStusList = pagingVO.dataList;
				let trTags = [];
				if(vacStusList.length > 0){
					$(vacStusList).each(function(idx, vacStus){
						color="black";
						if(vacStus.draft.draftProgress == '결재완료'){
							color = "green";
						}
						trTags.push(
							$("<tr>").append(
								$("<td class='vacstusCode'>").html(vacStus.vacstusCode),
								$("<td class='vacstusPeriod'>").html(vacStus.vacstusPeriod),
								$("<td class='emplNm'>").html(vacStus.empl.emplNm),
								$("<td class='vcatnNm'>").html(vacStus.vacation.vcatnNm),
								$("<td class='vacstusCount'>").html(vacStus.vacstusCount),
								$("<td class='sumry' style='text-align:left;'>").html(vacStus.vacstusSumry),
								$("<td class='draftProgress'>").html(vacStus.draft.draftProgress).css("color", color)
							)
						)
						idxs = idx;
					});
					while(idxs < 14){
						trTags.push(
							$("<tr>").append(
								$("<td>").attr("colspan", "6").css("border", "none")
							)
						);
						idxs += 1;
					}
					pagingArea.html(pagingVO.pagingHTML);
				} else {
					trTags.push(
						$("<tr>").append(
							$("<td>").attr("colspan", "6").html("데이터가 없습니다.")
						)
					)
				}
				tbody.append(trTags);
			}
		}).submit();
		$("#searchUI .att").on("click", function(){
			$(this).css({'background':'#3A4CA8', 'border-color':'#3A4CA8', 'color':'white'});
			$("#searchUI .att").not($(this)).css({'background':'#EAEAEA', 'border-color':'#929292', 'color':'black'});
			draftProgress = $(this).val();
			$("input[name='draft.draftProgress']").val(draftProgress);
			searchForm.submit();
		});
	});
</script>
</body>
</html>