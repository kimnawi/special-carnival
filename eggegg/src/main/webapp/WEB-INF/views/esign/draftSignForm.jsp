<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authEmpl"/>
</security:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 기안서 결재</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<%-- <link rel="styleSheet" href="${cPath }/resources/css/main.css"> --%>
<link rel="styleSheet" href="${cPath }/resources/css/draftSignForm.css">
</head>
<body>
	<div id="top">
		<span id="title">기안서조회</span>
		<hr color="#F1F4FF">
	</div>
	<span id="draftTitle">${draft.draftTitle }</span>
	<div id="writerTableDiv">
		<table border="1" id="writerTable">
			<tr>
				<th>기안자</th><td>${draft.writer.emplNm } ${draft.writer.position.pstNm }</td>
			</tr>
			<tr>
				<th>소속</th><td>${draft.writer.dept.deptNm }</td>
			</tr>
			<tr>
				<th>기안일</th>
				<td>
				${fn:substring(draft.draftDate,0,19) }
				</td>
			</tr>
			<tr>
				<th>문서번호</th><td>${draft.draftNo }</td>
			</tr>
		</table>
	</div>
	<div id="signTableDiv">
		<table border="1" id="signTable">
			<tr>
				<th rowspan="3">결<br>재</th>
				<c:forEach items="${draft.authls }" var="auth">
					<th>${auth.authorNm } ${auth.pstNm }</th>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${draft.authls }" var="auth" varStatus="i">
					<c:if test="${authEmpl.emplNo eq auth.authorId }">
						<c:set var="currentAuth" value="${auth }"/>
					</c:if>
					<c:if test="${i.index eq 1}">
						<c:set var="firstAuth" value="${auth.authHist.ahAuthSe }"/>
					</c:if>
					<c:choose>					
					<c:when test="${auth.authHist.ahAuthSe eq '승인'}">
						<td data-authno="${auth.authorId }">
							<c:choose>
								<c:when test="${not empty auth.signImage }">
									<img class="confirmStampImg" alt="승인도장이미지" src="data:image/*;base64,${auth.base64Img }"/>
								</c:when>
								<c:otherwise>
									<img class="confirmStampImg" alt="승인도장이미지" src="${cPath }/resources/images/confirmStamp.png"/>
								</c:otherwise>
							</c:choose>
						</td>
					</c:when>
					<c:when test="${auth.authHist.ahAuthSe eq '반려'}">
						<td data-authno="${auth.authorId }">
							<img class="returnStampImg" alt="반려도장이미지" src="${cPath }/resources/images/returnStamp.png"/>
						</td>
					</c:when>
					<c:otherwise>
						<td></td>
					</c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${draft.authls }" var="auth">
					<td data-authno="${auth.authHist.ahAuthorId }">${fn:substring(auth.authHist.ahAuthTm,0,19) }</td>
				</c:forEach>
			</tr>
		</table>
	</div>
	<div id="draftWrapper">
		<table>
			<tbody>
				<tr>
					<td id="contentTd" colspan="3">
							${draft.draftContent }
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div id="attachDiv">
	</div>
	<c:if test="${draft.draftProgress eq '반려'}">
		<div id="returnCn">
		<span>반려 사유</span> 
		<br>
		<c:forEach items="${draft.authls }" var="auth">
			<c:if test="${auth.authHist.ahAuthSe eq '반려'}">
				<div class="authReturnDiv">
					<span class="authNmSpan">${auth.authorNm }(${auth.authorId }) :</span> <span>${auth.authHist.ahReturnCn }</span>
				</div>
			</c:if>
		</c:forEach>
		</div>
	</c:if>
	<div id="bottom">
		<hr color="#F1F4FF">
		<c:if test="${(draft.draftWriter eq authEmpl.emplNo ) and (draft.draftProgress eq '결재중') and (empty firstAuth) }">
			<button type="button" class="saveBtn" id="returnBtn">회수</button>
		</c:if>
		<c:if test="${(draft.draftProgress eq '결재중') and (draft.nextAuthorId eq authEmpl.emplNo)}">
					<button type="button" class="saveBtn" id="signBtn">결재</button>
					<c:if test="${currentAuth.authorAuthTyCode eq 'I200' }">
						<button type="button" class="saveBtn" id="signAllBtn">전결</button>
					</c:if>
					<button type="button" class="resetBtn" id="rejectBtn">반려</button>
				<c:if test="${empty currentAuth.signImage }">
					<br>
					<span style="color:red;">* 개인 결재 도장 등록을 해주세요.(미등록시 공용 승인 도장으로 표시됩니다.)</span>
				</c:if>
		</c:if>
		<input type="button" id="close" onclick="window.close()" value="닫기">
	<form id="signForm" method="post" hidden>
		<input type="text" name="draftNo" value="${draft.draftNo }">
		<input type="text" name="ahAuthSe" value="">
		<textarea name="ahReturnCn"></textarea>
		<input type="text" name="ahAuthTm" value="">
	</form>
	</div>
	<div id="background"></div>
<jsp:include page="/includee/cAlert.jsp"/>
<script>
	// 회수버튼 클릭
	$("#returnBtn").on("click",function(){
		$.ajax({
			url:"${cPath}/group/esign/draftSignReturn.do",
			method:"post",
			data: {draftNo:"${draft.draftNo}"},
			success : function(res){
				if(res.result == "OK"){
					cAlert("회수처리 되었습니다.","","close");
				}else{
					cAlert(res.result);
				}
			}
		})
	});
	
	$(CALERTBODY).on("keyup","#alertTextarea",function(){
		$("textarea[name='ahReturnCn']").val($(this).val().replace(/\r/ig,"<br>").replace(/\n/ig,""));
	});
	
	$("#alertResult").on("change",function(){
		console.log(FNNAME.val())
		// 반려시
		if(FNNAME.val()=="ahReturnCn"){
			$("#signForm").ajaxForm({
				success: function(res){
					if(res.result="OK"){
						opener.location.reload();
						window.close();
					}else{
						cAlert(res.result);
					}
				},
				dataType:'json',
			}).submit();
		} 
		if(FNNAME.val()=="close"){
			opener.location.reload();
			window.close();
		}
	});


	//결재버튼 클릭
	$("#signBtn").on("click",function(){
		var today = new Date();
			console.log(today.toISOString().slice(0, 19).replace("T"," "))
		today = today.toISOString().slice(0, 19).replace("T"," ");
		$("input[name='ahAuthSe']").val("승인");
		$("input[name='ahAuthTm']").val(today);
		$("#signForm").ajaxForm({
			dataType:'json',
			success: function(res){
				if(res.result="OK"){
					opener.location.reload();
					window.close();
				}else{
					cAlert(res.result);
				}
			}
		}).submit();
	});
	//반려버튼 클릭
	$("#rejectBtn").on("click",function(){
		var today = new Date();
			console.log(today.toISOString().slice(0, 19).replace("T"," "))
		today = today.toISOString().slice(0, 19).replace("T"," ");
		$("input[name='ahAuthSe']").val("반려");
		$("input[name='ahAuthTm']").val(today);
		
		cAlert("반려사유를 적어주세요","prompt","ahReturnCn");
		$("#cAlert").css("width","700px").css("height","400px").css("left","250px").css("top","300px")
		
		$("#alertPrompt",CALERTBODY).after($("<textarea id='alertTextarea'>")).remove();
		$("#alertTextarea").css("width","80%").css("margin-top","20px").css("min-height","100px").text("예방접종은 외출하여 받고 당일엔 집으로 돌아가 쉴 것.	\r\n 휴가 일수 차감이 없도록 반려 처리.")
		$("#cAlertContent").css("height","170px")
	});
	
</script>
</body>
</html>