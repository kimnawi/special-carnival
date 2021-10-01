<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 사원검색</title>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="${ cPath }/resources/css/emplSearch.css">
</head>
<body>
	<div id="top">
		<span id="title">사원검색</span>
		<input id="searchButton" type="button" value="상세검색">
		<hr color="#F1F4FF">
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
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="4">
					<div id="pagingArea"></div>
				</td>
			</tr>
		</tfoot>
	</table>
		<div id="searchUI">
		<form>
			<table>
				<tbody>
					<tr>
						<th>
							성명
						</th>
						<td><input name="emplNm" type="text" placeholder="성명"></td>
					</tr>
					<tr>
						<th>
							입사일자
						</th>
						<td>
							<span class="dateForm">
								<input name="emplEcnyStart" type="date"> ~ <input name="emplEcnyEnd" type="date">
							</span>
							<input class="useButton" type="checkbox"> 사용
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
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2"><input type="button" id="searchBtn" value="검색"> <input type="reset" value="초기화"></td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
	<div id="bottom">
		<hr color="#F1F4FF">
		<input type="button" id="selectBtn" value="선택">
		<input type="button" class="close" value="닫기">
	</div>
<input type="hidden" id="nm">
<input type="hidden" id="code">
<form id="searchForm">
	<input type="hidden" name="page">
	<input type="hidden" name="emplNm" value="${ pagingVO.detailSearch.emplNm }">
	<input type="hidden" name="deptCode" value="${ pagingVO.detailSearch.deptCode }">
	<input type="hidden" name="emplEcnyStart" value="${ pagingVO.detailSearch.emplEcnyStart }">
	<input type="hidden" name="emplEcnyEnd" value="${ pagingVO.detailSearch.emplEcnyEnd }">
</form>
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		$(".close").on("click", function(){
			window.close();
		});
		let tbody = $("#list-table tbody");
		$(tbody).on("click", ".emplSelect", function(){
			code = $(this).parent().attr("code");
			nm = $(this).parent().attr("nm");
			deptNm = $(this).parent().attr("deptNm");
			pstNm = $(this).parent().attr("pstNm");
			ecny = $(this).parent().attr("ecny");
			entranceNm = $(this).parent().attr("entranceNm");
			console.log(entranceNm);
			if("${param.command}"=="ref"){
				opener.$("#refNm").val(nm); 
				opener.document.getElementById("refCode").value = code;
			}else if("${param.command}"=="rec"){
				opener.document.getElementById("recNm").value = nm;
				opener.document.getElementById("recCode").value = code;
			}else{
				opener.document.getElementById("code").value = code;
				opener.document.getElementById("nm").value = nm;
				if(opener.document.getElementById("deptNm")){
					opener.document.getElementById("deptNm").value = deptNm;
				}
				if(opener.document.getElementById("pstNm")){
					opener.document.getElementById("pstNm").value = pstNm;
				}
				if(opener.document.getElementById("ecny")){
					opener.document.getElementById("ecny").value = ecny;
				}
				if(opener.document.getElementById("entranceNm")){
					opener.document.getElementById("entranceNm").value = entranceNm;
				}
			}
			window.close();
		});
		//검색창 slide
		let searchUI = $("#searchUI").hide();
		$("#searchButton").on("click", function(){
			if(searchUI.is(":visible")){
				searchUI.slideUp();
			} else {
				searchUI.slideDown();
			}
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
			if("${param.command}"=="rec"){
				opener.document.getElementById("recCode").value = code;
				opener.document.getElementById("recNm").value = nm;
			}else if("${param.command}"=="ref"){
				opener.document.getElementById("refCode").value = code;
				opener.document.getElementById("refNm").value = nm;
			}else{
				opener.document.getElementById("code").value = code;
				opener.document.getElementById("nm").value = nm;
			}
			window.close();
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
		$("input[type=reset]").on("click", function(){
			$("input[type=hidden]").val("");
			if($(dateForm).is(":visible")){
				dateForm.hide();
			}
		});
		//검색 버튼 클릭 시 검색창 닫음
		$("#searchBtn").on("click", function(){
			searchUI.hide();
			searchUI.slideUp();
			emplTenureAtt = $("input[name=emplTenureAtt]:checked").val();
			$("#searchForm input[name=tenureAtt]").val(emplTenureAtt);
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
		$(document).ajaxComplete(function(event, xhr, options){
			$("#searchUI input[type=text]").each(function(){
				var classNm = $(this).attr("name");
				var searchVal = $(this).val();
				$("."+classNm+":contains('"+searchVal+"')", tbody).each(function(){
					var regex = new RegExp(searchVal, 'gi');
					$(this).html($(this).text().replace(regex, "<span style='font-weight: bold; color: green;'>"+searchVal+"</span>"));
					
				});
			});
			searchForm.get(0).reset();
			searchForm.find("[name='page']").val("");
		});
		let pagingArea = $("#pagingArea");
		let searchForm = $("#searchForm").paging().ajaxForm({
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				pagingArea.empty();
				let emplList = pagingVO.dataList;
				let trTags = [];
				if(emplList.length > 0){
					$(emplList).each(function(idx, empl){
						let deptNm = "";
						let pstNm = "";
						if(empl.dept != null){
							deptNm = empl.dept.deptNm;
						}
						if(empl.position != null){
							pstNm = empl.position.pstNm;
						}
						trTags.push(
							$("<tr>").append(
								$("<td>").append("<input class='checkbox' type='checkbox'>"),
								$("<td class='emplSelect'>").html(empl.emplNo),
								$("<td class='emplSelect emplNm'>").html(empl.emplNm),
								$("<td class='emplSelect deptNm'>").html(deptNm)
							).attr("code", empl.emplNo).attr("nm", empl.emplNm)
							.attr("deptCode", empl.deptCode).attr("deptNm", deptNm)
							.attr("pstCode", empl.pstCode).attr("pstNm", pstNm)
							.attr("ecny", empl.emplEcny).attr("entranceNm", empl.entrance.ctNm)
						);
						idxs = idx;
					});
					while(idxs < 15){
						trTags.push(
							$("<tr>").append(
								$("<td>").attr("colspan", "4").css("border", "none")
							)		
						);
						idxs += 1;
					}
					pagingArea.html(pagingVO.pagingHTML);
				} else {
					trTags.push(
						$("<tr>").append(
							$("<td>").attr("colspan", "4").html("조건에 맞는 사원이 없습니다.").css("color", "black")
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
	});
</script>
</body>
</html>