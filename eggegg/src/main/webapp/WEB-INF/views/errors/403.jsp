<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${cPath }/resources/css/error.css">
</head>
<body>
<div id="errorImg">
<img alt="403error" src="${cPath }/resources/errorImages/403error.png">
</div>
<h3><spring:message code="sorry"/>&nbsp;<spring:message code="forbidden"/></h3><br>
<span class="notFound1"><spring:message code="forbiddenPage"/></span><br>
<span class="notFound1"><spring:message code="callCS"/></span><br><br>
<span class="notFound2"><spring:message code="thank"/></span><br><br>
<span class="notFound2"><spring:message code="CS"/></span><br>
Tel. ${companyVO.comTel} / e-Mail. ${companyVO.comEmail }
<br><br>
<div class="button" data-goPage="mainPage"><spring:message code="mainPage"/></div>
<div class="button" onclick="javascript:history.go(-1)"><spring:message code="prev"/></div>
</body>
</html>