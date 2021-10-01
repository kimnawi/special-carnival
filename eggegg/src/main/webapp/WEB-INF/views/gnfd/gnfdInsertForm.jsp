<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사발령입력</title>
<link rel="stylesheet" href="${ cPath }/resources/css/list.css">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
</head>
<style>
#list-table input[type=text]{
	width: 100%;
}
#list-table td{
	text-align: center;
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
#list-table tr th:first-child, #list-table tr th:nth-child(2) {
	width: 46px;
}
.required{
	color: red;
}
</style>
<body>
	<div id="top">
		<span id="title">인사발령입력</span>
		<hr color="#F1F4FF">
	</div>
	<form id="gnfdForm">
		<table id="list-table">
			<thead>
				<tr>
					<th>
						<input type="checkbox" class="checkAll">
					</th>
					<th></th>
					<th>발령일자 <span class="required">*</span></th>
					<th>사원 <span class="required">*</span></th>
					<th>발령구분 <span class="required">*</span></th>
					<th>입사구분 </th>
					<th>이전 직위/직급</th>
					<th>발령 직위/직급 <span class="required">*</span></th>
					<th>이전 부서</th>
					<th>발령 부서 <span class="required">*</span></th>
					<th>적요</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach begin="0" end="2">
					<tr>
						<td>
							<input type="checkbox" class="checkbox">
						</td>
						<td class="plus"> + </td>
						<td>
							<input name="gnfdDe" type="date">
						</td>
						<td>
							<input type="hidden" class="code" name="emplNo" readonly>
							<input type="text" class="nm selectEmpl" readonly>
						</td>
						<td>
							<select name="gnfdType">
								<option value>== 발령구분 ==</option>
								<c:forEach items="${ gnfdTypeList }" var="gnfdType">
									<option value="${ gnfdType.ctTable }">${ gnfdType.ctNm }</option>
								</c:forEach>
							</select>
						</td>
						<td>
							<input type="text" class="entranceNm selectEmpl" readonly>
						</td>
						<td>
							<input type="text" class="pstNm selectEmpl" readonly>
						</td>
						<td class="notSearch">
							<input type="hidden" name="gnfdAposition" class="code" readonly>
							<input type="text" class="search1 nm" data-action="pstSearch" readonly>
						</td>
						<td>
							<input type="text" class="deptNm selectEmpl" readonly>
						</td>
						<td class="notSearch">
							<input type="hidden" name="deptAnm" class="code" readonly>
							<input type="text" class="search1 nm" data-action="deptSearch" readonly>
						</td>
						<td>
							<input type="text" name="gnfdSumry">
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="bottom">
			<hr color="#F1F4FF">
			<button type="button" id="insert">신청</button>
			<input type="button" id="delete" value="삭제">
			<input type="reset" id="reset" value="초기화">
		</div>
	</form>
<input type="hidden" id="code">
<input type="hidden" id="nm">
<input type="hidden" id="deptNm">
<input type="hidden" id="pstNm">
<input type="hidden" id="entranceNm">
<script>
	$(function(){
		let tbody = $("#list-table tbody");
		//인사발령 입력
		$("#insert").on("click", function(){
			var frm = $("#gnfdForm")[0];
			var tr = $("tr", tbody);
			$.each(tr, function(i, v){
				$("input[name=emplNo]",v).attr("name", "gnfd[" + i + "].emplNo");
				$("input[name=gnfdDe]",v).attr("name", "gnfd[" + i + "].gnfdDe");
				$("input[name=gnfdSumry]",v).attr("name", "gnfd[" + i + "].gnfdSumry");
				$("select[name=gnfdType]",v).attr("name", "gnfd[" + i + "].gnfdType");
				$("input[name=deptAnm]",v).attr("name", "gnfd[" + i + "].deptAnm");
				$("input[name=gnfdAposition]",v).attr("name", "gnfd[" + i + "].gnfdAposition");
			});
			var data = $("#gnfdForm").serialize();
			$.ajax({
				url: "${ cPath }/empl/gnfdInsert.do",
				dataType: "text",
				method: "post",
				data: data,
				success: function(res){
					$("#reset").click();
					cAlert("인사발령입력이 완료되었습니다.");
				},
				error: function(xhr){
					cAlert("필수 항목이 누락되었거나<br>이미 인사발령을 신청한 사원이 포함되어 있습니다.");
				}
			});
		});
		$("#delete").on("click", function(){
			$(".checkbox:checked", tbody).parents("tr").remove();
		});
		//+버튼 누를 시
		$(tbody).on("click", ".plus", function(){
			html = '<tr>';
			html += '	<td><input type="checkbox" class="checkbox"></td>';
			html += '	<td class="plus"> + </td>';
			html += '	<td><input name="gnfdDe" type="date"></td>';
			html += '	<td><input type="hidden" class="code" name="emplNo" readonly><input type="text" class="nm selectEmpl" readonly></td>';
			html += '	<td>';
			html += '		<select name="gnfdType">';
			html += '			<option value>== 발령구분 ==</option>';
			html += '			<c:forEach items="${ gnfdTypeList }" var="gnfdType">';
			html += '				<option value="${ gnfdType.ctTable }">${ gnfdType.ctNm }</option>';
			html += '			</c:forEach>';
			html += '		</select>';
			html += '	</td>';
			html += '	<td><input type="text" class="entranceNm selectEmpl" readonly></td>';
			html += '	<td><input type="text" class="pstNm selectEmpl" readonly></td>';
			html += '	<td class="notSearch"><input type="hidden" name="gnfdAposition" class="code" readonly><input type="text" class="search1 nm" data-action="pstSearch" readonly></td>';
			html += '	<td><input type="text" class="deptNm selectEmpl" readonly></td>';
			html += '	<td class="notSearch"><input type="hidden" name="deptAnm" class="code" readonly><input type="text" class="search1 nm" data-action="deptSearch" readonly></td>';
			html += '	<td><input type="text" name="gnfdSumry"></td>';
			html += '</tr>';
			$(this).parent().after(html);
		});
		//검색
		$(tbody).on("dblclick", ".selectEmpl", function(){
			var thistr = $(this).parents("tr");
			code = $(this).parents("tr").find(".code");
			nm = $(this).parents("tr").find(".nm");
			deptNm = $(this).parents("tr").find(".deptNm");
			pstNm = $(this).parents("tr").find(".pstNm");
			entrance = $(this).parents("tr").find(".entranceNm");
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
				code.val($("#code").val());
				nm.val($("#nm").val());
				deptNm.val($("#deptNm").val());
				pstNm.val($("#pstNm").val());
				entrance.val($("#entranceNm").val());
				$(".notSearch", thistr).find("input").val("");
			});
		});
		//검색
		$(tbody).on("dblclick", ".search1", function(){
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
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				code.val($("#code").val());
				nm.val($("#nm").val());
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
			cnt = $("#gnfdList tbody input[type=checkbox]:checked").length;
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