<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | ERP&GROUPWARE</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<link rel="styleSheet" href="${cPath }/resources/css/login.css">
<script type="text/javascript" src="${cPath }/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<jsp:include page="/includee/cAlert.jsp"/>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authMember"/>
	<security:authentication property="authorities" var="authMemRoles"/>
</security:authorize>
<c:if test="${not empty authMember }">
<script>
	alert("이미 로그인 되어있습니다.");
	location.href="${cPath}/mainPage.do";
</script>
</c:if>
	<c:choose>
		<c:when test="${cookie.languageCookie.value eq 'ko' }">
			<c:set var="emplNo" value="사원번호를 입력하세요"/>
			<c:set var="emplPass" value="비밀번호를 입력하세요"/>
			<c:set var="findNumber" value="사원번호 찾기"/>
			<c:set var="initPass" value="비밀번호 초기화"/>
			<c:set var="login" value="로그인"/>
			<c:set var="choose" value="선택"/>
			<c:set var="hrm" value="인사담당자"/>
			<c:set var="vac" value="휴가담당자"/>
			<c:set var="sal" value="급여담당자"/>
			<c:set var="commons" value="일반사용자"/>
			<c:set var="last" value="최종결재자"/>
		</c:when>
		<c:otherwise>
			<c:set var="emplNo" value="Employee Number"/>
			<c:set var="emplPass" value="Your Password"/>
			<c:set var="findNumber" value="Find Employee Number"/>
			<c:set var="initPass" value="Password reset"/>
			<c:set var="login" value="Login"/>
			<c:set var="choose" value="Choose"/>
			<c:set var="hrm" value="HRM"/>
			<c:set var="vac" value="VAC"/>
			<c:set var="sal" value="SAL"/>
			<c:set var="commons" value="COMMONS"/>
			<c:set var="last" value="LAST"/>
		</c:otherwise>
	</c:choose>
<img src="${cPath }/resources/images/ko.png" class="controlBtn" data-gopage="${cPath }/login?language=ko">
<img src="${cPath }/resources/images/en.png" class="controlBtn" data-gopage="${cPath }/login?language=en">
<form name="loginForm" action="${cPath }/login/loginCheck.do" method="post">
	<ul>
		<li>
			<img src="${cPath }/resources/images/eggegg_logo_with.png">
		</li>
		<li>
			 <select id="selectUser">
			 	<option>${choose}</option>
			 	<option value="HRM">${hrm }</option>
			 	<option value="VAC">${vac }</option>
			 	<option value="SAL">${sal }</option>
			 	<option value="COMMONS">${commons }</option>
			 	<option value="LAST">${last }</option>
			 </select>
		 </li>
		<li>
			 <input required type="text" id="empl_no" name="empl_no" placeholder="${emplNo }" autocomplete="off"/>
		</li>
		<li>
			<input required type="password" id="empl_pw" name="empl_pw" placeholder="${emplPass }" autocomplete="off"
			/> 
<!-- 			pattern="^(?=.*[a-z]+)(?=.*[A-Z]+)(?=.*[0-9]+)(?=.*[!@#\\$%\\^\\&\\*]+).{4,8}$" data-msg-pattern="형식확인" /> -->
		</li>
		<li>
			<div id="hoverDiv">
			<a id="findNumber">${findNumber}</a><span> /</span><a id="initPass">${initPass }</a>
			</div>
		</li>
		<li>
			<input type="submit" value="${login }" />
		</li>
		<li>
			<span>
			<c:choose>
				<c:when test="${(not empty failCnt) and (cookie.languageCookie.value eq 'ko')}">
					<script>
					cAlert("비밀번호 오류 횟수 : ${failCnt } <br>/ 오류 3회 초과시 비밀번호 초기화 버튼을 눌러주세요")
					</script>
				</c:when>
				<c:when test="${(not empty failCnt) and ((cookie.languageCookie.value eq 'en') or (empty cookie.languageCookie))}">
					<script>
					cAlert("PW Fail CNT : ${failCnt } <br>/ If Fail Count Over 3, Please press the password reset button.")
					</script>
				</c:when>
			</c:choose>
				<c:remove var="failCnt" scope="session"/>
			<c:if test="${not empty errorMessage}">
				<script>
					cAlert("${errorMessage }")
				</script>
			</c:if>
			</span>
			<c:remove var="errorMessage" scope="session"/>
		</li>
	</ul>
</form>
${EXCEPTION }
<script type="text/javascript">
localStorage.setItem("selectedHead","");
$("#selectUser").on("change",function(){
	var id = "";
	var pw = "aA12!@";
	switch($(this).val()){
	case "HRM":
		id = "2021013";
		break;
	case "VAC":
		id = "2021013";
		break;
	case "SAL":
		id = "2021004";
		break;
	case "COMMONS":
		id = "2021003";
		break;
	case "LAST":
		id = "2021001";
		break;
	}
	$("#empl_no").val(id);
	$("#empl_pw").val(pw);
});

$(".controlBtn").on("click", function(){
	let gopage = $(this).data("gopage");
	if(gopage){
		location.href = gopage;
	}
}).css("cursor","pointer");	
$("#findNumber").on("click",function(){
	popup = window.open(
			"findNumber.jsp",
			"findNumber",
			"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height= 330px, width= 540px, left=350px, top=250px");
});
$("#initPass").on("click",function(){
	confirm("관리자가 확인 후 초기화를 합니다.\n관리자에게 요청을 보내시겠습니까?");
})
</script>
</body>
</html>





