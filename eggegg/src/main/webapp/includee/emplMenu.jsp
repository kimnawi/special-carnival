<%@page import="com.eg.vo.MenuVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
  <nav id="sidebarMenu">
	<ul>
		<li>
			<div id="firstSelected" class="changeContent" data-url="${cPath }/empl/emplList.do?command=content"><spring:message code="newEmpl"/></div>
		</li>
		<li>
			<div class="changeContent" data-url="/"><spring:message code="Appointment"/></div>
			<ul>
				<li class="changeContent" data-url="${cPath }/empl/gnfdList.do"><spring:message code="AppointmentList"/></li>
				<li class="changeContent" data-url="${cPath }/empl/gnfdInsert.do"><spring:message code="InsertAppointment"/></li>
				<li class="changeContent" data-url="${cPath }/empl/gnfdStatus.do"><spring:message code="AppointmentStatus"/></li>
			</ul>
		</li>
		<%-- <li>
			<div class="changeContent" data-url="/"><spring:message code="HRMStatus"/></div>
			<ul>
				<li class="changeContent" data-url="${cPath }/mypage.do"><spring:message code="CertApp"/></li>
				<li class="changeContent" data-url="${cPath }/mypage.do"><spring:message code="PrintingCert"/></li>
				<li class="changeContent" data-url="${cPath }/mypage.do"><spring:message code="PrintingStatus"/></li>
			</ul>
		</li> --%>
		<li>
			<div class="changeContent" data-url="/"><spring:message code="RegistBase"/></div>
			<ul>
				<li><a class="notChange" id="ResistProject" href="${cPath }/empl/projectList.do"><spring:message code="ResistProject"/></a></li>
				<li><a class="notChange" id="ResistDept" href="${cPath }/empl/deptList.do"><spring:message code="ResistDept"/></a></li>
			</ul>
		</li>
		<li>
			<div class="changeContent" data-url="/"><spring:message code="ORChartMange"/></div>
			<ul>
				<li class="changeContent" data-url="${cPath }/empl/deptFancy.do"><spring:message code="ORChartRegist"/></li>
				<li class="changeContent" data-url="${cPath }/empl/deptOrganStatus.do"><spring:message code="ORChartStatus"/></li>
			</ul>
		</li>
	</ul>
  </nav>
<c:if test="${ selectedMenu ne NULL }">
	<script>
	    const SELECTEDMENU = $("#${selectedMenu}");
	    const SELECTEDDIV = SELECTEDMENU.parents("ul").eq(0).siblings("div")
	    console.log(SELECTEDMENU,SELECTEDDIV)
	    SELECTEDMENU.css("color","#333e91").css("font-weight","bolder");
		if(SELECTEDMENU.parents("ul").eq(0).siblings("div")){
		  	SELECTEDMENU.parents("ul").eq(0).siblings("div").css({"background":"#3A4CA8", "color":"white"});
		}
	</script>
</c:if>