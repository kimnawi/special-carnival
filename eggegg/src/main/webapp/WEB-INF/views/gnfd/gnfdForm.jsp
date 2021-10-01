<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 인사발령상세보기</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="${ cPath }/resources/css/gnfdForm.css">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div id="top">
		<span id="title">인사발령정보</span>
		<hr color="#F1F4FF">
	</div>
	<form:form commandName="gnfd" id="gnfdForm" method="post">
		<table class="form-table">
			<tbody>
				<tr>
					<th>발령코드</th>
					<td>
						${ gnfd.gnfdStdrde }
						<input type="hidden" name="gnfdStdrde" value="${ gnfd.gnfdStdrde }">
					</td>
					<th>결재구분</th>
					<td>${ gnfd.draft.draftProgress }</td>
				</tr>
				<tr>
					<th>사번</th>
					<td>
						${ gnfd.emplNo }
					</td>
					<th>사원명</th>
					<td>
						${ gnfd.empl.emplNm }
					</td>
				</tr>
				<tr>
					<th>발령일자 <span class="required">*</span></th>
					<td>
						<c:if test="${ gnfd.draft != null }">
							${ gnfd.gnfdDe }
						</c:if>
						<c:if test="${ gnfd.draft == null }">
							<input name="gnfdDe" type="date" value="${ gnfd.gnfdDe }">
						</c:if>
					</td>
					<th>발령구분 <span class="required">*</span></th>
					<td>
						<c:if test="${ gnfd.draft != null }">
							${ gnfd.gnfd.ctNm }
						</c:if>
						<c:if test="${ gnfd.draft == null }">
							<select name="gnfdType">
								<option value>== 발령구분 ==</option>
								<c:forEach items="${ gnfdTypeList }" var="gnfdType">
									<option value="${ gnfdType.ctTable }">${ gnfdType.ctNm }</option>
								</c:forEach>
							</select>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>입사구분</th>
					<td colspan="3">${ gnfd.empl.entrance.ctNm }</td>
				</tr>
				<tr>
					<th>이전부서</th>
					<td>${ gnfd.deptBnm }</td>
					<th>발령부서 <span class="required">*</span></th>
					<td>
						<c:if test="${ gnfd.draft != null }">
							${ gnfd.dept.deptNm }
						</c:if>
						<c:if test="${ gnfd.draft eq null }">
							<input type="hidden" class="code" name="deptAnm" value="${ gnfd.deptAnm }"><button data-action="deptSearch" class="small-search" type="button">
								<img class="searchImg" src="${ cPath }/resources/images/Search.png">
							</button><input type="text" class="nm" value="${ gnfd.dept.deptNm }" placeholder="부서명" readonly>
							<form:errors path="deptAnm" element="label" id="deptAnm-error" cssClass="error" for="deptAnm"/>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>이전직급</th>
					<td>${ gnfd.gnfdBposition }</td>
					<th>발령직급 <span class="required">*</span></th>
					<td>
						<c:if test="${ gnfd.draft != null }">
							${ gnfd.position.pstNm }
						</c:if>
						<c:if test="${ gnfd.draft == null }">
							<input type="hidden" name="gnfdAposition" class="code" value="${ gnfd.gnfdAposition }"><button data-action="pstSearch" class="small-search" type="button">
								<img class="searchImg" src="${ cPath }/resources/images/Search.png">
							</button><input type="text" class="nm" placeholder="직위/직급명" value="${ gnfd.position.pstNm }" readonly>
							<form:errors path="gnfdAposition" element="label" id="gnfdAposition-error" cssClass="error" for="gnfdAposition"/>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>적요</th>
					<td colspan="3">
						<c:if test="${ gnfd.draft != null }">
							${ gnfd.gnfdSumry }
						</c:if>
						<c:if test="${ gnfd.draft == null }">
							<input id="sumry" type="text" name="gnfdSumry" value="${ gnfd.gnfdSumry }">
						</c:if>
					</td>
				</tr>
			</tbody>
		</table>
		<div id="bottom">
			<hr color="#F1F4FF">
			<c:if test="${ gnfd.draft == null }">
				<input type="submit" id="apply" class="saveBtn" value="신청">
				<input type="button" class="deleteBtn" value="삭제">
			</c:if>
			<input type="button" class="close" onclick="window.close()" value="닫기">
		</div>
	</form:form>
<input type="hidden" id="code">
<input type="hidden" id="nm">
<script>
	$(function(){
		gnfdType = "${ gnfd.gnfdType }";
		$("select[name=gnfdType]").val(gnfdType);
		<c:if test="${ success eq 'SUCCESS' }">
			window.close();
		</c:if>
		gnfdStdrde = "${ gnfd.gnfdStdrde }";
		$(".deleteBtn").on("click", function(){
			cAlert("삭제 후엔 복구가 불가능합니다.<br>삭제하시겠습니까?", "confirm");
		});
		$("#alertResult").on("change",function(){
			if($(this).val() != 'true'){
				return false;
			}
			$.ajax({
				url: "${ cPath }/empl/gnfdDelete.do?",
				data: {"what": gnfdStdrde},
				dataType: "text",
				method: "post",
				success: function(res){
					cAlert("삭제가 완료되었습니다.");
					window.close();
				},
				error: function(xhr){
					alert(xhr.status);
				}
			}); 
		});
		//검색
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
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				code.val($("#code").val());
				nm.val($("#nm").val());
			});
		});
	});
</script>
<jsp:include page="/includee/cAlert.jsp"/>
</body>
<style>
	#cAlert{
		left: 5%;
	}
</style>
</html>