<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원리스트</title>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/list.css">
</head>
<style>
	.emplUpdate{
		cursor: pointer;
		color: #4472C4;
	}
	.emplUpdate:hover{
		color: #4472C4;
		text-decoration: underline;
	}
	#excel{
		border-radius: 3px;
	}
	.searchImg {
		position: relative;
	    width: 25px;
	    right: 3px;
	    top: -1px;
	    margin: 0px;
	    padding: 0px;
	    z-index: 1;
	}
	.small-search {
	    position: relative;
	    display: inline;
	    left:1px;
	    width: 33px;
	    height: 33px;
	    text-align: center;
	    vertical-align: middle;
	    z-index: 1;
	    bottom: 3px;
	    border: 1px solid black;
	    border-radius: 2px;
	}
	#searchUI input[type=text]:not(.nm), #searchUI input[type=date]{
		width: 250px;
	}
	.nm{
		width: 218px;
	}
	#list-table{
		margin-bottom: 100px;
	}
	#list-table .emplCardPrint{
		color: #4472C4;
		cursor: pointer;
	}
	#list-table .emplCardPrint:active{
		font-weight: bold;
	}
	#background{
		position:fixed;
		bottom: 68px;
		height: 50px;
		width: 100%;
		background: white;
		z-index: 1;
	}
	#bottom{
		z-index: 2;
	}
</style>
<body>
	<div id="top">
		<span id="title">사원리스트</span>
		<input id="searchButton" type="button" value="상세검색">
	</div>
	<hr color="#F1F4FF">
	<div id="searchUI" class="searchDetail">
		<form>
			<table>
				<tbody>
					<tr>
						<th>
							성명
						</th>
						<td><input type="text" name="emplNm" placeholder="성명"></td>
					</tr>
					<tr>
						<th>
							입사일자
						</th>
						<td>
							<span class="dateForm">
								<input name="emplEcnyStart" type="date">&ensp;~&ensp;<input name="emplEcnyEnd" type="date">&ensp;
							</span>
							<input class="useButton" type="checkbox">&ensp;사용
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
							<input type="radio" name="emplTenureAtt" value="ALL">&ensp;전체&ensp;&ensp;
							<input type="radio" name="emplTenureAtt" value checked>&ensp;재직자&ensp;&ensp;
							<input type="radio" name="emplTenureAtt" value="RETIRE">&ensp;퇴사자
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2">
							<input type="button" id="searchBtn" value="검색">
							<input type="reset" value="초기화">
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
	<table id="list-table">
		<thead>
			<tr>
				<th><input type="checkbox" class="checkAll"></th>
				<th>사원번호</th>
				<th>성명</th>
				<th>부서명</th>
				<th>직위/직급명</th>
				<th>입사일자</th>
				<th>재직구분</th>
				<th>계좌번호</th>
				<th>Email</th>
				<th>사원증인쇄</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="10">
					<div id="pagingArea"></div>
				</td>
			</tr>
		</tfoot>
	</table>
	<form id="searchForm">
		<input type="hidden" name="page">
		<input type="hidden" name="emplNm" value="${ pagingVO.detailSearch.emplNm }">
		<input type="hidden" name="deptCode" value="${ pagingVO.detailSearch.deptCode }">
		<input type="hidden" name="emplEcnyStart" value="${ pagingVO.detailSearch.emplEcnyStart }">
		<input type="hidden" name="emplEcnyEnd" value="${ pagingVO.detailSearch.emplEcnyEnd }">
		<input type="hidden" name="tenureAtt" value="${ pagingVO.detailSearch.tenureAtt }">
	</form>
	<div id="bottom">
		<hr color="#F1F4FF">
		<button type="button" id="insert">신규</button>
		<button type="button" id="excel">Excel다운로드</button>
	</div>
	<div id="background"></div>
<input type="hidden" id="nm">
<input type="hidden" id="code">
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		$("#list-table").on("click", ".emplCardPrint", function(){
			emplNo = $(this).parents("tr").data("empl").emplNo;
			var nWidth = 1000;
			var nHeight = 800;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name ="emplCardPrint";
			popup = window.open(
					"${ cPath }/empl/emplCard.do?who="+emplNo,
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		});
		$("#excel").on("click", function(){
			location.href = "${cPath}/empl/emplExcel.do"
		});
		$("input[type=reset]").on("click", function(){
			$("input[type=hidden]").val("");
			if($(dateForm).is(":visible")){
				dateForm.hide();
			}
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
		//검색 완료 후
		$(document).ajaxComplete(function(event, xhr, options){
			//검색단어 표기
			$("#searchUI input[type=text]").each(function(){
				var classNm = $(this).attr("name");
				var searchVal = $(this).val();
				$("."+classNm+":contains('"+searchVal+"')", tbody).each(function(){
					var regex = new RegExp(searchVal, 'gi');
					$(this).html($(this).text().replace(regex, "<span style='font-weight: bold; color: green;'>"+searchVal+"</span>"));
					
				});
			});
			//검색 초기화
			searchForm.get(0).reset();
			searchForm.find("[name='page']").val("");
		});
		//리스트
		let tbody = $("#list-table tbody");
		let pagingArea = $("#pagingArea");
		let searchForm = $("#searchForm").paging().ajaxForm({
			url: "${ cPath }/empl/emplList.do",
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				pagingArea.empty();
				let emplList = pagingVO.dataList;
				let trTags = [];
				if(emplList.length > 0){
					$(emplList).each(function(idx, empl){
						let acnutno = "";
						let deptNm = "";
						let pstNm = "";
						let emplRetire = "";
						if(empl.salarybank != null){
							acnutno = empl.salarybank.slryAcnutno;
						}
						if(empl.dept != null){
							deptNm = empl.dept.deptNm;
						}
						if(empl.position != null){
							if(empl.position.pstNm != null){
								pstNm = empl.position.pstNm;
							}
						}
						if(empl.retire != null){
							trTags.push(
								$("<tr>").append(
									$("<td>").append($("<input class='checkbox'>").attr("type", "checkbox")),
									$("<td>").append($("<a class='emplUpdate'>").html(empl.emplNo)),
									$("<td>").append($("<a class='emplUpdate emplNm'>").html(empl.emplNm)),
									$("<td class='deptNm'>").html(deptNm),
									$("<td>").html(pstNm),
									$("<td>").html(empl.emplEcny),
									$("<td>").html("퇴사"),
									$("<td>").html(acnutno),
									$("<td>").html(empl.emplEmail),
									$("<td>").append($("<a class='emplCardPrint'>").html("인쇄"))
								).data("empl", empl).css("background", "#FFF7F7")
							)
						} else {
							trTags.push(
								$("<tr>").append(
									$("<td>").append($("<input class='checkbox'>").attr("type", "checkbox")),
									$("<td>").append($("<a class='emplUpdate'>").html(empl.emplNo)),
									$("<td>").append($("<a class='emplUpdate emplNm'>").html(empl.emplNm)),
									$("<td class='deptNm'>").html(deptNm),
									$("<td>").html(pstNm),
									$("<td>").html(empl.emplEcny),
									$("<td>").html("재직"),
									$("<td>").html(acnutno),
									$("<td>").html(empl.emplEmail),
									$("<td>").append($("<a class='emplCardPrint'>").html("인쇄"))
								).data("empl", empl)
							)
						}
						idxs = idx;
					});
					while(idxs != 15){
						trTags.push(
							$("<tr>").append(
								$("<td>").attr("colspan", "10").css("border", "none")
							)		
						);
						idxs += 1;
					}
					pagingArea.html(pagingVO.pagingHTML);
				} else {
					trTags.push(
						$("<tr>").html(
							$("<td>").attr("colspan", "10").html("조건에 맞는 사원이 없습니다.")	
						)
					);
				}
				tbody.append(trTags);
			}
		}).submit();
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
		//사원등록폼
		$("#insert").on("click", function(){
			var nWidth = 1010;
			var nHeight = 800;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name ="emplInsert";
			popup = window.open(
					"${ cPath }/empl/emplInsert.do",
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				setTimeout(() => {
					window.location.reload();
				}, 500);
			});
		});
		//검색 버튼 클릭 시 검색창 닫음
		$("#searchBtn").on("click", function(){
			emplTenureAtt = $("input[name=emplTenureAtt]:checked").val();
			$("#searchForm input[name=tenureAtt]").val(emplTenureAtt);
			searchUI.slideUp();
		});
		//사원정보 수정
		$(document).on("click", ".emplUpdate", function(){
			emplNo = $(this).parents("tr").data().empl.emplNo;
			emplSelect = $(this).parents("tr").find("td");
			emplSelect.css({"background":"#FEFAE5", "color":"#AAAAAA"});
			var nWidth = 1010;
			var nHeight = 1000;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name ="emplUpdate";
			popup = window.open(
					"${ cPath }/empl/emplUpdate.do?emplNo=" + emplNo,
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				emplSelect.css({"background":"transparent"});
				setTimeout(() => {
					window.location.reload();
				}, 500);
			});
		});
		//체크박스 클릭
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