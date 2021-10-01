<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authMember"/>
	<security:authentication property="authorities" var="authMemRoles"/>
</security:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 휴가신청</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
	*{
		font-family: 'Noto Sans KR', sans-serif;
		font-size: 18px;
	}
	body{
		overflow: hidden;
	}
	table{
		border-collapse: collapse;
		width: 100%;
		background: #FCFCFE;
	}
	#title{
		margin: 10px;
		font-size: 20px;
		font-weight: bold;
	}
	#bottom{
		width: 97%;
		position: fixed;
		bottom: 10px;
		z-index: 1;
	}
	th, td{
		padding: 10px 10px;
	}
	input::placeholder{
		color: #D9D9D9;
	}
	textarea::placeholder{
		color: #D9D9D9;
	}
	.saveBtn {
	    display: inline-block;
	    text-decoration: none;
	    color: white;
	    padding: 1px 12px;
	    background: #3A4CA8;
	    border-radius: 3px;
	}
	.required{
		color: red;
	}
	#vacstusDe-error{
		display: block;
		color: #C00000;
	}
</style>
</head>
<body>
	<div id="top">
		<span id="title">휴가신청</span>
		<hr color="#F1F4FF">
	</div>
	<form:form commandName="vacApply" id="vacApplyForm" method="post">
		<table class="list-table">
			<tr>
				<th>휴가일자  <span class="required">*</span></th>
				<td id="vacPeriod">
					<input id="vacstusStart" name="vacStart" type="date" value="${ vacStus.vacstusStart }" required><span id="vacDay">
					&ensp;&ensp;~&ensp;&ensp;
					<input id="vacstusEnd" name="vacEnd" value="${ vacStus.vacstusEnd }" type="date" required></span>
					<input type="hidden" name="vacstusDe" value="${ vacStus.vacstusDe }" required>
					<input type="hidden" id="vacstusCount">
					<label id="vacstusDe-error"></label>
				</td>
			</tr>
			<tr>
				<th>휴가종류  <span class="required">*</span></th>
				<td>
					<c:if test="${ command eq 'UPDATE' }">
						<c:if test="${ vacStus.vacstusHalfAt eq 'Yes' }">
							<input name="vacAt" type="radio" value="No"> <span>연차&nbsp;</span>
							<input name="vacAt" type="radio" value="Yes" checked> <span>반차</span>
						</c:if>
						<c:if test="${ vacStus.vacstusHalfAt eq 'No' }">
							<input name="vacAt" type="radio" value="No" checked> <span>연차&nbsp;</span>
							<input name="vacAt" type="radio" value="Yes"> <span>반차</span>
						</c:if>
					</c:if>
					<c:if test="${ command eq 'INSERT' }">
						<input name="vacAt" type="radio" value="No" checked> <span>연차&nbsp;</span>
						<input name="vacAt" type="radio" value="Yes"> <span>반차</span>
					</c:if>
					<input type="hidden" id="vacstusHalfAt" name="vacstusHalfAt" value="No">
				</td>
			</tr>
			<tr>
				<th>사유  <span class="required">*</span></th>
				<td>
					<textarea placeholder="적요" rows="3" cols="60" name="vacstusSumry" id="vacstusSumry" style="resize:none;" required>${ vacStus.vacstusSumry }</textarea>
					<input type="hidden" id="emplNo" name="emplNo" value="${ empl.emplNo }">
					<input type="hidden" id="emplNm" value="${ empl.emplNm }">
					<input type="hidden" id="draftTitle" value="휴가신청서_${ empl.emplNm }">
					<input type="hidden" id="deptNm" value="${ empl.dept.deptNm }">
					<input type="hidden" id="pstNm" value="${ empl.position.pstNm }">
					<input type="hidden" name="draftNo" value="${ param.draftNo }">
					<input type="hidden" name="vacstusCode" value="${ vacStus.vacstusCode }">
				</td>
			</tr>
		</table>
		<div id="bottom">
			<hr color="#F1F4FF">
			<c:if test="${ param.view ne 'VIEW' }">
				<input type="submit" id="apply" class="saveBtn" value="신청">
			</c:if>
			<c:if test="${ param.command eq 'VIEW' }">
				<input type="button" class="deleteBtn" value="삭제">
			</c:if>
			<input type="button" class="close" value="닫기">
		</div>
	</form:form>
<script src="${ cPath }/resources/js/moment.js"></script>
<script>
	$(function(){
		var setCookie = function(name, value, exp) {
			var date = new Date();
			date.setTime(date.getTime() + exp*24*60*60*1000);
			document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/;Secure';
		};
		
		var getCookie = function(name) {
			var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
			return value? value[2] : null;
		};
		<c:if test="${ success eq 'SUCCESS' }">
			window.close();
		</c:if>
		<c:if test="${ param.view eq 'VIEW' }">
			$(".list-table input").attr('readonly', true).css({"border":"none", "background": "#FCFCFE"});
			$(".list-table textarea").attr('readonly', true).css({"border":"none", "background": "#FCFCFE"});
			$("[name=vacAt]:not(:checked)").hide();
			$("[name=vacAt]:not(:checked)").next("span").hide();
		</c:if>
		$(".close").on("click", function(){
			window.close();
		});
		$("input[name=vacAt]").on("change", function(){
			vacAt = $("input[name=vacAt]:checked").val();
			$("input[name=vacstusHalfAt]").val(vacAt);
		});
		$("input[type=date]").on("change", function(){
			start = $("input[name=vacStart]").val();
			last = $("input[name=vacEnd]").val();
			if(start != "" && last != ""){
				startDate = new Date(start);
				lastDate = new Date(last);
				result = [];
				curDate = startDate;
				while(curDate <= lastDate){
					result.push(curDate);
					nextDate = new Date(curDate.getDate() + 1);
					curDate.setDate(nextDate);
				}
				$.ajax({
					url : "${cPath}/vac/holiday.do",
					dataType : "json",
					data : {"start" : start , "last" : last},
					success : function(resp) {
						input = [];
						vacstusCnt = 0;
						for(i = 0; i < resp.length; i++){
							if(resp[i].dateName == 'N'){
								input.push(
									resp[i].locdate
								)
								vacstusCnt++;
							}
						}
						$("input[name=vacstusDe]").val(input);
						$("#vacstusCount").val(vacstusCnt);
						if(vacstusCnt == 0){
							$("#vacstusDe-error").html("휴일은 휴가신청을 할 수 없습니다.");
						} else {
							$("#vacstusDe-error").empty();
						}
					}
				});
			}
		});
		$(".deleteBtn").on("click", function(){
			cAlert("삭제 후엔 복구가 불가능합니다.<br>삭제하시겠습니까?", "confirm");
		});
		$("#alertResult").on("change",function(){
			if($(this).val() != 'true'){
				return false;
			}
			vacstusCode = $("input[name=vacstusCode]").val()
			$.ajax({
				url: "${ cPath }/vac/vacApplyDelete.do",
				data: {"vacstusCode": vacstusCode},
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
	});
</script>
<jsp:include page="/includee/cAlert.jsp"/>
</body>
<style>
	#cAlert{
		left: 4%;
	}
</style>
</html>