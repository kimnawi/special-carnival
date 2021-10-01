<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authMember"/>
	<security:authentication property="authorities" var="authMemRoles"/>
</security:authorize>
<head>
<title>폴더선택</title>
<link rel="stylesheet" href="${cPath }/resources/js/fancytree/skin-win8/ui.fancytree.min.css">
<link rel="stylesheet" href="${cPath }/resources/css/driveList.css">
<link rel="stylesheet" href="${cPath }/resources/css/uploadForm.css">
<script type="text/javascript" src="${cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="${cPath }/resources/js/fancytree/jquery.fancytree-all-deps.min.js"></script>
<script type="text/javascript"	src="https://cdnjs.cloudflare.com/ajax/libs/jquery.fancytree/2.36.1/jquery.fancytree-all.min.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<jsp:include page="/includee/cAlert.jsp"/>
<style>
#cAlert {
    position: absolute;
    z-index: 8;
    top: 120px;
    left: 20px;
    width: 200px;
    height: 180px;
    background: white;
    overflow: hidden;
}
#cAlertFooter{
	bottom: 2px;
}
</style>
</head>
<div id="driveWrap">
	<div id="title">
		폴더 선택
	</div>
	<div class="hrDiv" id="titleHr">
		<hr>
	</div>
	<div id="tree1" class="tree"></div>
	<div id="tree2" class="tree"></div>
	<div class="hrDiv" id="bottomHr">
		<hr>
	</div>
	<div id="btnDiv">
		<button class="saveBtn" type="button" id="uploadBtn">폴더 선택</button>
	</div>
</div>
<input id="path" type="hidden" name="paths">
<script>
	var emplNo = ${authMember.emplNo};
</script>
<script type="text/javascript" src="${cPath }/resources/js/uploadForm.js"></script>
