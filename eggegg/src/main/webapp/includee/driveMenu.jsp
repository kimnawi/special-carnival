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
			<div><a href="${cPath }/schedule/scheList.do">일정관리</a></div>
		</li>
		<li>
			<div id="firstSelected"><a href="${cPath }/group/schedule/drive/driveList.do?who=${authEmpl.emplNo}&command='content'">EG Drive</a></div>
		</li>
		<li>
			<div data-url="/">출/퇴근</div>
			<ul>
				<li data-url="${cPath }/mypage.do">출/퇴근기록부</li>
				<li data-url="${cPath }/mypage.do">출/퇴근현황</li>
				<li data-url="${cPath }/mypage.do">지각현황</li>
				<li data-url="${cPath }/mypage.do">출퇴근/근태/일정현황</li>
			</ul>
		</li>
	</ul>
  </nav>
<script>
	$("#firstSelected>a").css("color","white");
</script>
  