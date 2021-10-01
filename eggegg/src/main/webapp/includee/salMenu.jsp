<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
  <nav id="sidebarMenu">
	<ul>
		<li>
			<div class="changeContent" data-url="${cPath}/empl/salEmplList.do?command=content"><spring:message code="RegistBase"/></div>
			<ul>
				<li><a id="ResistPay" href="${cPath}/empl/salEmplList.do"><spring:message  code="ResistPay"/></a></li>
				<li><a id="ResistAllow" href="${cPath}/sal/extrapayList.do"><spring:message  code="ResistAllow"/></a></li>
				<li><a id="ResistDeduc" href="${cPath}/sal/deductionList.do"><spring:message code="ResistDeduc"/></a></li>
				<li><a id="ResistAD" href="${cPath}/sal/adGroupList.do"><spring:message   code="ResistAD"/></a></li>
<%-- 				<li><a id="ResistComAcount" href="${cPath}/empl/salEmplList.do"><spring:message  code="ResistComAcount"/></a></li> --%>
			</ul>
		</li>
		<li>
			<div class="changeContent"><spring:message code="WorkStat"/></div>
			<ul>
				<li><a id="ResistWork" href="${cPath }/sal/workForm.do"><spring:message code="ResistWork"/></a></li>
				<li><a id="WorkCheck" href="${cPath }/sal/workList.do"><spring:message code="WorkCheck"/></a></li>
			</ul>
		</li>
		<li>
			<div class="changeContent" data-url="/"><spring:message code="SalWork"/></div>
			<ul>
				<li><a id="SalCalc" href="${cPath }/sal/salWorkList.do"><spring:message code="SalCalc"/></a></li>
<%-- 				<li><a id="SalList" href="${cPath }/empl/salEmplList.do"><spring:message code="SalList"/></a></li> --%>
<%-- 				<li><a id="SalStat" href="${cPath }/empl/salEmplList.do"><spring:message code="SalStat"/></a></li> --%>
<%-- 				<li><a id="WorkConfirm" href="${cPath }/empl/salEmplList.do"><spring:message code="WorkConfirm"/></a></li> --%>
<%-- 				<li><a id="SalTransfer" href="${cPath }/empl/salEmplList.do"><spring:message code="SalTransfer"/></a></li> --%>
			</ul>
		</li>	
	</ul>
  </nav>
  <script>
    const SELECTEDMENU = $("#${selectedMenu}");
    const SELECTEDDIV = SELECTEDMENU.parents("ul").eq(0).siblings("div")
    console.log(SELECTEDMENU,SELECTEDDIV)
    SELECTEDMENU.css("color","#333e91").css("font-weight","bolder");
	if(SELECTEDMENU.parents("ul").eq(0).siblings("div")){
	  	SELECTEDMENU.parents("ul").eq(0).siblings("div").css("background","#3A4CA8").css("color","white");
	}
</script>