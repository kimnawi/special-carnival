<%@page import="com.eg.vo.MenuVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
  <nav id="sidebarMenu">
	<ul>
		<li>
			<div class="changeContent"><spring:message code="WriteMail"/></div>
		</li>
		<li>
			<div id="firstSelected" class="changeContent" data-url="/"><spring:message code="BaseInbox"/></div>
			<ul>
				<li id="firstMenu" class="changeContent" data-url="${cPath }/group/mail/receiveMailList.do?command=content"><spring:message code="RecievedMail"/></li>
				<li class="changeContent" data-url="${cPath }/group/mail/sendedMailList.do"><spring:message code="SendedMail"/></li>
				<li class="changeContent" data-url="${cPath }/group/mail/tempMailList.do"><spring:message code="TempMail"/></li>
				<li class="changeContent"><spring:message code="ImportantMail"/></li>
			</ul>
		</li>
		<li>
			<div class="changeContent"><spring:message code="SpamMail"/></div>
		</li>
		<li>
			<div class="changeContent"><spring:message code="trashBox"/></div>
		</li>
	</ul>
  </nav>
  