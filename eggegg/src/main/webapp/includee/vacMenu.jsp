<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authMember"/>
	<security:authentication property="authorities" var="authMemRoles"/>
</security:authorize>
  <nav id="sidebarMenu">
	<ul>
		<security:authorize url="/vac/emplVacList.do">
		<li>
			<c:choose>
				<c:when test="${authMemRoles eq '[ROLE_VAC]' }">
					<div id="firstSelected" class="changeContent" data-url="/">기본사항조회</div>
					<ul>
						<li id="firstMenu" class="changeContent" data-url="${cPath }/vac/emplVacList.do?command=content">사원별휴가일수조회</li>
					</ul>
				</c:when>
				<c:otherwise>
					<div class="changeContent" data-url="/">기본사항조회</div>
					<ul>
						<li class="changeContent" data-url="${cPath }/vac/emplVacList.do?command=content">사원별휴가일수조회</li>
					</ul>
				</c:otherwise>
			</c:choose>
		</li>
		</security:authorize>
		<li>
			<c:choose>
				<c:when test="${authMemRoles eq '[ROLE_VAC]' }">
					<div class="changeContent" data-url="/">휴가</div>
				</c:when>
				<c:otherwise>
					<div id="firstSelected" class="changeContent" data-url="/">휴가</div>
				</c:otherwise>
			</c:choose>
			<ul>
			<c:choose>
				<c:when test="${authMemRoles eq '[ROLE_VAC]' }">
					<li class="changeContent" data-url="${cPath }/vac/vacApply.do?command=content">휴가신청</li>
				</c:when>
				<c:otherwise>
					<li id="firstMenu" class="changeContent" data-url="${cPath }/vac/vacApply.do?command=content">휴가신청</li>
				</c:otherwise>
			</c:choose>
		<security:authorize url="/vac/emplVacList.do">
				<li class="changeContent" data-url="${cPath }/vac/vacStusList.do">휴가조회</li>
				<li class="changeContent" data-url="${cPath }/vac/vacStatus.do">휴가현황</li>
		</security:authorize>
			</ul>
		</li>
		<security:authorize url="/vac/emplVacList.do">
		<li>
			<div class="changeContent" data-url="/">출퇴근</div>
			<ul>
				<li class="changeContent" data-url="${cPath }/vac/hrdList.do">출/퇴근기록부</li>
				<li class="changeContent" data-url="${cPath }/vac/hrdStatus.do">출/퇴근현황</li>
<%-- 				<li class="changeContent" data-url="${cPath }/mypage.do">지각현황</li> --%>
			</ul>
		</li>
		<%-- <li>
			<div class="changeContent" data-url="/">출력물</div>
			<ul>
				<li class="changeContent" data-url="${cPath }/mypage.do">휴가잔여일수현황</li>
				<li class="changeContent" data-url="${cPath }/mypage.do">휴가사용실적현황</li>
				<li class="changeContent" data-url="${cPath }/mypage.do">근태집계표</li>
			</ul>
		</li> --%>
		</security:authorize>
	</ul>
  </nav>
