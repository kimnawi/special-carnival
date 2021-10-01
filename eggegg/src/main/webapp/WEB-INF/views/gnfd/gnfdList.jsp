<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사발령리스트</title>
<link rel="stylesheet" href="${ cPath }/resources/css/list.css">
<link rel="stylesheet" href="${ cPath }/resources/css/gnfdList.css">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div id="top">
		<span id="title">인사발령조회</span>
		<hr color="#F1F4FF">
	</div>
	<div id="searchUI">
		<form>
			<table>
				<tr>
					<th>사원</th>
					<td>
						<input type="hidden" class="code" name="emplNo">
						<button class="small-search" data-action="emplSearch" type="button">
							<img class="searchImg" src="${ cPath }/resources/images/Search.png">
						</button><input type="text" class="nm" name="emplNm" placeholder="사원" readonly>
					</td>
					<th>발령일자</th>
					<td>
						<input type="date" name="gnfdStartDe">
						&ensp;~&ensp;
						<input type="date" name="gnfdEndDe">
					</td>
					<th>발령구분</th>
					<td>
						<select name="gnfdType">
							<option value>== 발령구분 ==</option>
							<c:forEach items="${ gnfdTypeList }" var="gnfdType">
								<option value="${ gnfdType.ctTable }">${ gnfdType.ctNm }</option>
							</c:forEach>
						</select>
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
				<th class="gnfdStdrde">발령코드</th>
				<th class="emplNm">사원명</th>
				<th class="gnfdDe">발령일자</th>
				<th class="ctNm">발령구분</th>
				<th class="sumry">적요</th>
				<th class="draftProgress">결재구분</th>
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
		$("#list-table").on("click", ".draftForm", function(){
			gnfdStdrde = $(this).parents("tr").data("gnfd").gnfdStdrde;
			emplNm = $(this).parents("tr").data("gnfd").empl.emplNm;
			draftTitle = "인사발령기안서_" + emplNm;
			$("#draftTitle").val(draftTitle);
			$.ajax({
				url: "${ cPath }/empl/gnfdDraft.do?what=" + gnfdStdrde,
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
			window.name ="gnfdInsert";
			popup = window.open(
					"${ cPath }/group/esign/draftForm.do?command=INSERT&formNo=14&chit=com.eg.gnfd.service.GnfdService&code=" + gnfdStdrde,
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				searchForm.submit();
			});
		});
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
			url: "${ cPath }/empl/gnfdList.do",
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				pagingArea.empty();
				let gnfdList = pagingVO.dataList;
				let trTags = [];
				if(gnfdList.length > 0){
					$(gnfdList).each(function(idx, gnfd){
						color = "black";
						draftProgress = "<a class='draftForm'>결재받기</a>";
						if(gnfd.draft != null){
							draftProgress = gnfd.draft.draftProgress;
							if(draftProgress == '결재완료'){
								color = "green";
							}
						}
						trTags.push(
							$("<tr>").append(
								$("<td class='selectGnfd'>").append($("<a>").html(gnfd.gnfdStdrde)),
								$("<td>").html(gnfd.empl.emplNm),
								$("<td>").html(gnfd.gnfdDe),
								$("<td>").html(gnfd.gnfd.ctNm),
								$("<td style='text-align:left;'>").html(gnfd.gnfdSumry),
								$("<td>").html(draftProgress).css('color', color)
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
	});
</script>
</body>
</html>