<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authEmpl"/>
</security:authorize>
  <nav id="sidebarMenu">
	<ul>
		<li>
			<div id="firstSelected" class="changeContent" data-url="${cPath }/schedule/scheList.do?command=content">일정관리</div>
		</li>
		<li>
			<div><a href="${cPath }/group/schedule/drive/driveList.do?who=${authEmpl.emplNo}">EG Drive</a></div>
		</li>
		<li>
			<div class="changeContent" data-url="/">출/퇴근</div>
			<ul>
				<li class="changeContent" data-url="${cPath }/mypage.do">출/퇴근기록부</li>
				<li class="changeContent" data-url="${cPath }/mypage.do">출/퇴근현황</li>
				<li class="changeContent" data-url="${cPath }/mypage.do">지각현황</li>
				<li class="changeContent" data-url="${cPath }/mypage.do">출퇴근/근태/일정현황</li>
			</ul>
		</li>
	</ul>
  </nav>
  