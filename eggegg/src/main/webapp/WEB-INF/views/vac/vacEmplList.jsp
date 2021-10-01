<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>사원별휴가일수입력</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<link rel="stylesheet" href="${ cPath }/resources/css/vacEmplList.css">
</head>
<body>
	<div id="topWhite"></div>
	<div id="top">
		<span id="title">사원별휴가일수입력</span>
		<hr color="#F1F4FF">
	</div>
	<table id="vacInfo">
		<tr>
			<th>휴가</th>
			<td>${ param.vcatnCode }</td>
			<th>휴가명</th>
			<td>${ vacDetail.vcatnNm }</td>
			<th>사용기간</th>
			<td>${ vacDetail.vcatnStart } ~ ${ vacDetail.vcatnEnd }</td>
		</tr>
	</table>
	<form:form commandName="vacHistoryVOList" id="emplVacForm" method="post">
		<table id="emplVacList">
			<thead id="emplVacListThead">
				<tr id="calc">
					<td colspan="8">
						<input type="button" id="vacCalc" value="연차계산">
					</td>
				</tr>
				<tr>
					<th>
						<input type="checkbox" class="checkAll">
					</th>
					<th></th>
					<th>사번</th>
					<th>사원명</th>
					<th>부서명</th>
					<th>직급</th>
					<th>입사일자</th>
					<th>휴가일수</th>
					<th>휴가일수변경</th>
					<th>변경사유</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ empl }" var="emplVac" >
					<tr>
						<td>
							<input type="checkbox" class="checkbox">
							<input type="hidden" name="vcatnCode" value="${ param.vcatnCode }">
						</td>
						<td class="plus"> + </td>
						<td><input name="emplNo" class="selectEmpl code" type="text" placeholder="사번" value="${ emplVac.emplNo }" readonly></td>
						<td><input class="selectEmpl nm" type="text" placeholder="사원명" value="${ emplVac.emplNm }" readonly></td>
						<td><input type="text" class="deptNm" placeholder="부서명" value="${ emplVac.dept.deptNm }" disabled></td>
						<td><input type="text" class="pstNm" placeholder="직급" value="${ emplVac.position.pstNm }" disabled></td>
						<td><input type="text" class="ecny" placeholder="입사일자" value="${ emplVac.emplEcny }" disabled></td>
						<td>
							<c:if test="${ empty emplVac.vacHistory.vcatnAmount }">
								<input type="text" name="vcatnAmount" class="vcatnAuto" placeholder="휴가일수" value="${ emplVac.vacHistory.vcatnAmount }" readonly>
							</c:if>
							<c:if test="${ not empty emplVac.vacHistory.vcatnAmount }">
								<span>${ emplVac.vacHistory.vcatnAmount }</span>
							</c:if>
						</td>
						<td><input name="vcatnAmountWr" type="number" min="0" placeholder="휴가일수변경" value="${ emplVac.vacHistory.vcatnAmountWr }"></td>
						<td><input name="vcatnReason" placeholder="변경사유" value="${ emplVac.vacHistory.vcatnReason }"></td>
					</tr>
				</c:forEach>
				<tr>
					<td>
						<input type="checkbox" class="checkbox">
						<input type="hidden" name="vcatnCode" value="${ param.vcatnCode }">
					</td>
					<td class="plus"> + </td>
					<td><input name="emplNo" class="selectEmpl code" type="text" placeholder="사번" readonly></td>
					<td><input class="selectEmpl nm" type="text" placeholder="사원명" readonly></td>
					<td><input type="text" class="deptNm" placeholder="부서명" disabled></td>
					<td><input type="text" class="pstNm" placeholder="직급" disabled></td>
					<td><input type="text" class="ecny" placeholder="입사일자" disabled></td>
					<td><input type="text" name="vcatnAmount" placeholder="휴가일수" readonly></td>
					<td><input name="vcatnAmountWr" type="number" min="0" placeholder="휴가일수변경"></td>
					<td><input name="vcatnReason" placeholder="변경사유"></td>
				</tr>
			</tbody>
		</table>
	</form:form>
	<form id="excelForm" name="excelForm" method="post" enctype="multipart/form-data">
		<div id="bottom">
			<hr color="#F1F4FF">
			<input style="margin-left: 10px;" type="button" id="insertBtn" class="saveBtn" value="저장">
			<input type="button" id="deleteBtn" value="삭제">
			<input type="file" name="fileInput" id="fileInput" accept=".xls,.xlsx"  style="display:none;">
			<input type="button" id="excelUpload" value="Excel업로드">
			<input type="button" id="excelFormBtn" value="Excel양식다운로드">
			<input type="button" class="closePopup" value="닫기">
		</div>
	</form>
	<div id="bottom-background"></div>
<input type="hidden" id="code">
<input type="hidden" id="nm">
<input type="hidden" id="deptNm">
<input type="hidden" id="pstNm">
<input type="hidden" id="ecny">
<form:form commandName="vacHistoryList" id="deleteForm" action="${ cPath }/vac/vacDelete.do">
	<input type="hidden" name="vcatnCode">
	<input type="hidden" name="emplNo">
</form:form>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
<script>
	$(function(){
		<c:forEach begin="1" end="10" var="i">
			width = $("#emplVacList tbody tr td:nth-child(${i})").css("width");
			$("#emplVacListThead tr th:nth-child(${i})").css("width", width);
		</c:forEach>
		$(".closePopup").on("click", function(){
			window.close();
		});
		$("#excelFormBtn").on("click", function(){
			location.href = "${ cPath }/vac/vacExcelForm.do";
		});
		//체크박스 클릭
		$('.checkAll').on('click',function(){
			ck = $(this).prop('checked');
			$(this).parents('table').find('.checkbox').prop('checked', ck);
		});
		let tbody = $("#emplVacList tbody");
		$(tbody).on("change",".checkbox",function(){
			allbox = $("input:checkbox").length-1; 
			//전체선택 체크박스 제외 체크된박스 개수 구하기
			cnt = $("#emplVacList tbody input[type=checkbox]:checked").length;
			//체크박스가 다 체크될 경우 전체선택체크박스도 체크
			if(cnt == allbox){
				$(".checkAll").prop('checked',true);
			}else{
				$(".checkAll").prop('checked',false);
			}
		});
		$(tbody).on("click", ".plus", function(){
			html = '<tr>';
			html += '	<td>';
			html += '		<input type="checkbox" class="checkbox">';
			html += '		<input type="hidden" name="vcatnCode" value="${ param.vcatnCode }">';
			html += '	</td>';
			html += '	<td class="plus"> + </td>';
			html += '	<td><input name="emplNo" class="selectEmpl code" type="text" placeholder="사번" readonly></td>';
			html += '	<td><input class="selectEmpl nm" type="text" placeholder="사원명" readonly></td>';
			html += '	<td><input type="text" class="deptNm" placeholder="부서명" disabled></td>';
			html += '	<td><input type="text" class="pstNm" placeholder="직급" disabled></td>';
			html += '	<td><input type="text" class="ecny" placeholder="입사일자" disabled></td>';
			html += '	<td><input type="text" name="vcatnAmount" placeholder="휴가일수" readonly></td>';
			html += '	<td><input name="vcatnAmountWr" type="number" min="0" placeholder="휴가일수변경"></td>';
			html += '	<td><input name="vcatnReason" placeholder="변경사유"></td>';
			html += '</tr>';
			$(this).parent().after(html);
		});
		$(tbody).on("dblclick", ".selectEmpl", function(){
			thisis = $(this);
			code = $(this).parents("tr").find(".code");
			nm = $(this).parents("tr").find(".nm");
			deptNm = $(this).parents("tr").find(".deptNm");
			pstNm = $(this).parents("tr").find(".pstNm");
			ecny = $(this).parents("tr").find(".ecny");
			cnt = tbody.find("input[name=emplNo]").length;
			var nWidth = 900;
			var nHeight = 950;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name = "emplSearch";
			popup = window.open(
					"${ cPath }/search/emplSearch.do",
					"searchTable",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				success = 0;
				for(i = 0; i < cnt; i++){
					if(tbody.find("input[name=emplNo]").eq(i).val() == $("#code").val()){
						success = 1;
					}
				}
				if(success == 1){
					
					thisis.attr('data-original-title',"중복된 항목입니다.")
					thisis.tooltip();
				} else {
					code.val($("#code").val());
					nm.val($("#nm").val());
					deptNm.val($("#deptNm").val());
					pstNm.val($("#pstNm").val());
					ecny.val($("#ecny").val());
				}
			});
		});
		$(tbody).on("blur", "input[name=emplNo]", function(){
			$(this).removeAttr('data-original-title');
		});
		$("#insertBtn").click(function(){
			var frm = $("#emplVacForm")[0];
			var tr = $("tr", tbody);
			
			$.each(tr, function(index, item){
				$("input[name=vcatnCode]", item).attr("name", "vacHistory["+index+"].vcatnCode");
				$("input[name=emplNo]", item).attr("name", "vacHistory["+index+"].emplNo");
				$("input[name=vcatnAmount]", item).attr("name", "vacHistory["+index+"].vcatnAmount");
				$("input[name=vcatnAmountWr]", item).attr("name", "vacHistory["+index+"].vcatnAmountWr");
				$("input[name=vcatnReason]", item).attr("name", "vacHistory["+index+"].vcatnReason");
			});
			
			var data = $("#emplVacForm").serialize();
			
			$.ajax({
				url: "${ cPath }/vac/vacInsert.do",
				dataType: "text",
				method: "post",
				data: data,
				success: function(res){
					location.href = "${ cPath }/vac/vacInsert.do?vcatnCode=" + ${ param.vcatnCode };
				}
			});
		});
		//엑셀 업로드
		$("#excelUpload").on("click", function(){
			$("#fileInput").click();
		});
		$("#fileInput").on("change", function(){
			var excelForm = $("#excelForm")[0];
			var form = new FormData(excelForm);
			$.ajax({
				url: "${ cPath }/vac/uploadEmplExcel.do",
				dataType: "json",
				data: form,
				enctype: 'multipart/form-data',
				processData: false,
				contentType: false,
				type: "post",
				success: function(empl){
					emplVacTbody = $("#emplVacList tbody");
					emplVacTbody.empty();
					var html;
					for(var i = 0; i < empl.length; i++){
						emplNo = empl[i].emplNo;
						emplNm = empl[i].emplNm;
						deptNm = empl[i].deptNm;
						pstNm = empl[i].pstNm;
						emplEcny = empl[i].emplEcny;
						
						html += '<tr>';
						html += '	<td>';
						html += '		<input type="checkbox" class="checkbox">';
						html += '		<input type="hidden" name="vcatnCode" value="${ param.vcatnCode }">';
						html += '	</td>';
						html += '	<td class="plus"> + </td>';
						html += '	<td><input name="emplNo" class="selectEmpl code" type="text" placeholder="사번" value="' + emplNo + '" readonly></td>';
						html += '	<td><input class="selectEmpl nm" type="text" placeholder="사원명" value="' + emplNm + '" readonly></td>';
						html += '	<td><input type="text" class="deptNm" placeholder="부서명" value="' + deptNm + '" disabled></td>';
						html += '	<td><input type="text" class="pstNm" placeholder="직급" value="' + pstNm + '" disabled></td>';
						html += '	<td><input type="text" class="ecny" placeholder="입사일자" value="' + emplEcny + '" disabled></td>';
						html += '	<td><input type="text" name="vcatnAmount" placeholder="휴가일수" readonly></td>';
						html += '	<td><input name="vcatnAmountWr" type="number" min="0" placeholder="휴가일수변경"></td>';
						html += '	<td><input name="vcatnReason" placeholder="변경사유"></td>';
						html += '</tr>';
					}
					html += '<tr>';
					html += '	<td>';
					html += '		<input type="checkbox" class="checkbox">';
					html += '		<input type="hidden" name="vcatnCode" value="${ param.vcatnCode }">';
					html += '	</td>';
					html += '	<td class="plus"> + </td>';
					html += '	<td><input name="emplNo" class="selectEmpl code" type="text" placeholder="사번" readonly></td>';
					html += '	<td><input class="selectEmpl nm" type="text" placeholder="사원명" readonly></td>';
					html += '	<td><input type="text" class="deptNm" placeholder="부서명" disabled></td>';
					html += '	<td><input type="text" class="pstNm" placeholder="직급" disabled></td>';
					html += '	<td><input type="text" class="ecny" placeholder="입사일자" disabled></td>';
					html += '	<td><input type="text" name="vcatnAmount" placeholder="휴가일수" readonly></td>';
					html += '	<td><input name="vcatnAmountWr" type="number" min="0" placeholder="휴가일수변경"></td>';
					html += '	<td><input name="vcatnReason" placeholder="변경사유"></td>';
					html += '</tr>';
					emplVacTbody.html(html);
					<c:forEach begin="1" end="8" var="i">
						width = $("#emplVacList tbody tr td:nth-child(${i})").css("width");
						$("#emplVacListThead tr th:nth-child(${i})").css("width", width);
					</c:forEach>
				},
				error: function(xhr){
					alert(xhr.status);
				}
			});
		});
		//삭제 버튼
		$("#deleteBtn").on("click", function(){
			cAlert("삭제 후엔 복구가 불가능합니다.<br>삭제하시겠습니까?", "confirm");
		});
		$("#alertResult").on("change",function(){
			if($(this).val() != 'true'){
				return false;
			} else {
				vcatn = [];
				emplNo = [];
				vcatnCode = ${ param.vcatnCode };
				$(".checkbox:checked", tbody).each(function(){
					vcatn.push(vcatnCode);
					emplNo.push($(this).parents("tr").find("input[name='emplNo']").val());
				});
				$("#deleteForm input[name=vcatnCode]").val(vcatn);
				$("#deleteForm input[name=emplNo]").val(emplNo);
				
				$("#deleteForm").submit();
			}
		});
		$("#vacCalc").on("click", function(){
			vcatn = [];
			emplNo = [];
			vcatnCode = ${ param.vcatnCode };
			cnt = 0;
			$(".checkbox:checked", tbody).each(function(){
				vcatn.push(vcatnCode);
				emplNo.push($(this).parents("tr").find("input[name='emplNo']").val());
				cnt++;
			});
			if(cnt == 0){
				return;
			}
			$.ajax({
				url: "${ cPath }/vac/vacCalc.do",
				dataType: "json",
				data: {vcatn: vcatn, emplNo: emplNo},
				success: function(vacHistoryList){
					for(i = 0; i < vacHistoryList.length; i++){
						$("input[name=emplNo]", tbody).each(function(){
							if($(this).val() == vacHistoryList[i].emplNo){
								$(this).parents("tr").find("input[name=vcatnAmount]").val(vacHistoryList[i].vcatnDay);
							};
						})
					}
				},
				error: function(xhr){
					alert(xhr.status);
				}
			});
		});
	});
</script>
<jsp:include page="/includee/cAlert.jsp"/>
</body>
<style>
	#cAlert{
		left: 12%;
		top: 10%;
	}
</style>
</html>