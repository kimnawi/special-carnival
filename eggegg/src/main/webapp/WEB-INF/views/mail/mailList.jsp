<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일</title>
<link rel="stylesheet" href="${ cPath }/resources/css/list.css">
<link rel="stylesheet" href="${ cPath }/resources/css/gnfdList.css">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div id="top">
		<span id="title">메일</span>
		<hr color="#F1F4FF">
	</div>
	<div id="searchUI">
		<form>
			<table>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="inboxTitle">
					</td>
					<th>송신 일자</th>
					<td>
						<input type="date" name="sendStartDe">
						&ensp;~&ensp;
						<input type="date" name="sendEndDe">
					</td>
					<th>수신 일자</th>
					<td>
						<input type="date" name="RecieveStartDe">
						&ensp;~&ensp;
						<input type="date" name="RecieveEndDe">
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
				<th><input type="checkbox" class="checkAll"></th>
				<th>사원번호</th>
				<th>성명</th>
				<th class="deptNmCol">부서명</th>
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
		<input type="hidden" name="emplNo" value="${ pagingVO.detailSearch.emplNo }">
		<input type="hidden" name="gnfdStartDe" value="${ pagingVO.detailSearch.gnfdStartDe }">
		<input type="hidden" name="gnfdEndDe" value="${ pagingVO.deatilSearch.gnfdEndDe }">
		<input type="hidden" name="gnfdType" value="${ pagingVO.detailSearch.gnfdType }">
	</form>
<input type="hidden" id="draftTitle">
<input type="hidden" id="nm">
<input type="hidden" id="code">
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		//검색 초기화
		$(document).ajaxComplete(function(event, xhr, options){
			searchForm.get(0).reset();
		});
		$("#searchUI input[type=reset]").on("click", function(){
			$("#searchUI input[type=hidden]").val("");
		});
		let tbody = $("#list-table tbody");
		let pagingArea = $("#pagingArea");
		let searchForm = $("#searchForm").paging().ajaxForm({
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				pagingArea.empty();
				let gnfdList = pagingVO.dataList;
				let trTags = [];
				if(gnfdList.length > 0){
					$(gnfdList).each(function(idx, gnfd){
						draftProgress = "<a class='draftForm'>결재받기</a>";
						if(gnfd.draft != null){
							draftProgress = gnfd.draft.draftProgress;
						}
						trTags.push(
							$("<tr>").append(
									$("<td>").append("<input class='checkbox' type='checkbox'>"),
									$("<td class='emplSelect'>").html(empl.emplNo),
									$("<td class='emplSelect emplNm'>").html(empl.emplNm),
									$("<td class='emplSelect deptNm'>").html(deptNm)
							).data("gnfd", gnfd)
						)
						idxs = idx;
					});
					while(idxs < 15){
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
							$("<td>").attr("colspan", "6").html("조건에 맞는 인사발령이 없습니다.")
						)
					)
				}
				tbody.append(trTags);
			}
		}).submit();
		$("#list-table").on("click", ".selectGnfd", function(){
			gnfdStdrde = $(this).parents("tr").data().gnfd.gnfdStdrde;
			gnfdSelect = $(this).parents("tr").find("td");
			gnfdSelect.css({"background":"#FEFAE5", "color":"#AAAAAA"});
			var nWidth = 750;
			var nHeight = 700;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name ="gnfdUpdate";
			gnfd = $(this).parents("tr").data("gnfd").draft;
			popup = window.open(
					"${ cPath }/empl/gnfdUpdate.do?gnfdStdrde=" + gnfdStdrde,
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				gnfdSelect.css({"background":"transparent"});
			});
		})
		
		// 체크박스 전체 선택
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