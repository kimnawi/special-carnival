<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 자격/면허입력</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="${ cPath }/resources/css/search.css">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<style>
	tr th:first-child, tr th:nth-child(2), tr td:first-child, tr td:nth-child(2) {
		width: 20px;
	}
	td{
		text-align: center;
		padding: 5px;
	}
	tbody tr:hover{
		text-decoration: none;
	}
	.plus{
		color: #4472C4;
		font-weight: bold;
		cursor: pointer;
		text-decoration: none;
	}
	.plus:hover{
		text-decoration: none;
		color: black;
	}
	#bottom-background{
		position:fixed;
		bottom: 0;
		width: 100%;
		height: 53px;
		background: white;
	}
	.required{
		color: red;
	}
</style>
</head>
<body>
	<div id="top">
		<span id="title">자격/면허입력</span>
		<hr color="#F1F4FF">
	</div>
	<form:form id="emplQualForm">
		<table>
			<thead>
				<tr>
					<th><input type="checkbox" class="checkAll"></th>
					<th>
					</th>
					<th>자격증명 <span class="required">*</span></th>
					<th>점수/레벨</th>
					<th>취득일자 <span class="required">*</span></th>
					<th>만료일자</th>
				</tr>
			</thead>
			<tbody id="tableBody">
				<c:if test="${ fn:length(qualList) ne 0 }">
					<c:forEach items="${ qualList }" var="qual">
						<tr>
							<td>
								<input type="checkbox" class="checkbox">
								<input type="hidden" name="qcEmpl" value="${ param.qcEmpl }">
							</td>
							<td class="plus"> + </td>
							<td><input placeholder="자격증명" name="qcNm" value="${ qual.qcNm }" readonly></td>
							<td><input placeholder="점수/레벨" name="qcScore" value="${ qual.qcScore }"></td>
							<td><input type="date" name="qcDate" value="${ qual.qcDate }"></td>
							<td><input type="date" name="qcExpire" value="${ qual.qcExpire }"></td>
						</tr>
					</c:forEach>
					<tr>
						<td>
							<input type="checkbox" class="checkbox">
							<input type="hidden" name="qcEmpl" value="${ param.qcEmpl }">
						</td>
						<td class="plus"> + </td>
						<td><input placeholder="자격증명" name="qcNm"></td>
						<td><input placeholder="점수/레벨" name="qcScore"></td>
						<td><input type="date" name="qcDate"></td>
						<td><input type="date" name="qcExpire"></td>
					</tr>
					<c:if test="${ fn:length(qualList) eq 1 }">
						<tr>
							<td>
								<input type="checkbox" class="checkbox">
								<input type="hidden" name="qcEmpl" value="${ param.qcEmpl }">
							</td>
							<td class="plus"> + </td>
							<td><input placeholder="자격증명" name="qcNm"></td>
							<td><input placeholder="점수/레벨" name="qcScore"></td>
							<td><input type="date" name="qcDate"></td>
							<td><input type="date" name="qcExpire"></td>
						</tr>
					</c:if>
				</c:if>
				<c:if test="${ fn:length(qualList) eq 0 }">
					<c:forEach begin="0" end="2" varStatus="status">
						<tr>
							<td>
								<input type="checkbox" class="checkbox">
								<input type="hidden" name="qcEmpl" value="${ param.qcEmpl }">
							</td>
							<td class="plus"> + </td>
							<td><input placeholder="자격증명" class="qcNm${ status.index }" name="qcNm"></td>
							<td><input placeholder="점수/레벨" class="qcScore${ status.index }" name="qcScore"></td>
							<td><input type="date" class="qcDate${ status.index }" name="qcDate"></td>
							<td><input type="date" name="qcExpire"></td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		<div id="bottom">
			<hr color="#F1F4FF">
			<input type="button" class="saveBtn" id="inputQual" value="입력">
			<input type="button" id="deleteQual" value="삭제">
			<input type="button" class="close" value="닫기">
		</div>
		<div id="bottom-background"></div>
	</form:form>
<Script>
	$(function(){
		$("#title").on("click", function(){
			$(".qcNm0").val("정보처리기사");
			$(".qcDate0").val("2017-07-15");
			$(".qcNm1").val("자동차운전면허증");
			$(".qcScore1").val("1종 보통");
			$(".qcDate1").val("2013-08-23");
		});
		let tbody = $("tbody");
		//닫기버튼
		$(".close").on("click", function(){
			window.close();
		});
		//체크박스 모두 선택
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
		$("#deleteQual").on("click", function(){
			$('tbody .checkbox:checked').parents("tr").remove();
		});
		$(tbody).on("click", ".plus", function(){
			html = '<tr>';
			html += '	<td>';
			html += '		<input type="checkbox" class="checkbox">';
			html += '		<input type="hidden" name="qcEmpl" value="${ param.qcEmpl }">';
			html += '	</td>';
			html += '	<td class="plus"> + </td>';
			html += '	<td><input placeholder="자격증명" name="qcNm"></td>';
			html += '	<td><input placeholder="점수/레벨" name="qcScore"></td>';
			html += '	<td><input type="date" name="qcDate"></td>';
			html += '	<td><input type="date" name="qcExpire"></td>';
			html += '</tr>';
			$(this).parent().after(html);
		});
		
		$("#inputQual").click(function(){
			var frm = $("#emplQualForm")[0];
			var tr = $("tr", $("#tableBody"));			
			
			idx = 0;
			$.each(tr, function(index, item){
				$("input[name=qcEmpl]", item).attr("name", "qual["+index+"].qcEmpl");
				$("input[name=qcNm]", item).attr("name", "qual["+index+"].qcNm");
				$("input[name=qcScore]", item).attr("name", "qual["+index+"].qcScore");
				$("input[name=qcDate]", item).attr("name", "qual["+index+"].qcDate");
				$("input[name=qcExpire]", item).attr("name", "qual["+index+"].qcExpire");

				qcEmpl = $('input[name="qual['+index+'].qcEmpl"]').val();
				qcNm = $('input[name="qual['+index+'].qcNm"]').val();
				qcScore = $('input[name="qual['+index+'].qcScore"]').val();
				qcDate = $('input[name="qual['+index+'].qcDate"]').val();
				qcExpire = $('input[name="qual['+index+'].qcExpire"]').val();
				
				$(opener.document).find("input[name='qualVOList.qual["+index+"].qcEmpl']").val(qcEmpl);
				$(opener.document).find("input[name='qualVOList.qual["+index+"].qcNm']").val(qcNm);
				$(opener.document).find("input[name='qualVOList.qual["+index+"].qcScore']").val(qcScore);
				$(opener.document).find("input[name='qualVOList.qual["+index+"].qcDate']").val(qcDate);
				$(opener.document).find("input[name='qualVOList.qual["+index+"].qcExpire']").val(qcExpire);
				
				idx++;
			});
			
			$(opener.document).find("#idx").val(idx);
			
			window.close();
		});
	});
</Script>
</body>
</html>