<%@page import="com.eg.vo.MenuVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authEmpl"/>
</security:authorize>
  <nav id="sidebarMenu">
	<ul>
		<li>
			<div id="firstSelected" class="changeContent" data-url="${cPath }/group/esign/draftList.do?command=content&ownerId=${authEmpl.emplNo}"><spring:message code="MyDraft"/></div>
		</li>
		<li>
			<div class="changeContent" data-url="${cPath }/group/esign/draftFormList.do?command=INSERT"><spring:message code="WriteDraft"/></div>
		</li>
		<li>
			<div class="changeContent" data-url="${cPath }/group/esign/draftList.do?command=content"><spring:message code="TotalDraft"/></div>
		</li>
		<li>
			<div class="changeContent" data-url="${cPath }/group/esign/draftFormList.do?command=UPDATE"><spring:message code="WriteSample"/></div>
		</li>
	</ul>
  </nav>
  