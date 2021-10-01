<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script src="${pageContext.request.contextPath }/resources/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<footer>
	<div id="footerInfoDiv">
	${companyVO.comNm } | <spring:message code="REP"/> : ${companyVO.comRep }
<br>
	<spring:message code="CRN"/> : ${companyVO.comNo }
<br>
	<i class="fas fa-phone-alt"></i>. ${companyVO.comTel }
	 &nbsp; <i class="far fa-envelope"></i>. ${companyVO.comEmail }
	  
<br>
	${companyVO.comAddress }
	</div>
	<div id="emptyDiv"></div>
	<div>
	</div>
	<div id="linkDiv">
    	<img src="${cPath }/resources/images/ko.png" class="controlBtn" data-gopage="?language=ko">
		<img src="${cPath }/resources/images/en.png" class="controlBtn" data-gopage="?language=en">
	</div>
</footer>