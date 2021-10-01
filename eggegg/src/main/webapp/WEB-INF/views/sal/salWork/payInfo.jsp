<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 급여대장</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Noto Sans KR', sans-serif;
}
table, button, input, textarea{
	font-size: 17px;
}
#title{
	margin: 10px;
	font-size: 20px;
	font-weight: bold;
}
hr{
	margin: 5px 0px;
}
td, th{
	border : 1px solid #999999;
	padding: 5px;
	height : 25px;
}
table{
	border-collapse: collapse;
	margin-top: 10px;
	margin-bottom: 50px;
}
.right{
	text-align: right;
}
.cen{
	text-align: center;
}
th{
	background: #FCFCFE;
}
#main{
	height: 802px;
	overflow-y: auto;
	overflow-x: hidden;
}
#bottom{
	width: 98%;
	position: fixed;
	bottom: 10px;
}
.sumTr{
	background: #FCFCFE;
}
</style>
<body>
	<div id="top">
		<span id="title">급여대장</span>
		<hr color="#F1F4FF">
	</div>
	<div id="main">
		<table>
			<tr>
				<th rowspan="3">성명</th>
				<th rowspan="3">부서명</th>
				<c:forEach items="${alList}" var="al" begin="0" end="4">
					<th>${al.alNm}</th>
				</c:forEach>
				<th rowspan="4">지급총액</th>
				<c:forEach items="${deList}" var="de" begin="0" end="4">
					<th>${de.deNm}</th>
				</c:forEach>
				<th rowspan="4">공제총액</th>
				<th rowspan="4">실지급액</th>
			</tr>
			<tr>
				<c:forEach items="${alList}" var="al" begin="5" end="9">
					<th>${al.alNm}</th>
				</c:forEach>
				<c:forEach items="${deList}" var="de" begin="5" end="9">
					<th>${de.deNm}</th>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${alList}" var="al" begin="10" end="14">
					<th>${al.alNm}</th>
				</c:forEach>
				<c:forEach items="${deList}" var="de" begin="10" end="14">
					<th>${de.deNm}</th>
				</c:forEach>
			</tr>
			<tr>
				<th>사원번호</th>
				<th>직위/직급명</th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
			</tr>
			<c:forEach items="${empl}" var="empl">
			<c:set value="${empl.alHistory}" var="alhistory"/>
			<c:set value="${empl.deHistory}" var="dehistory"/>
			<tr>
				<td rowspan="3">${empl.emplNm}</td>
				<td rowspan="3">${empl.dept.deptNm}</td>
				<c:forEach items="${alhistory}" var="al" begin="0" end="4">
					<c:choose>
						<c:when test="${al.alhAmount eq 0}">
							<td class="right"></td>
						</c:when>
						<c:otherwise>
							<td class="right"><fmt:formatNumber value="${al.alhAmount}" /> </td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<td rowspan="4" class="right"><fmt:formatNumber value="${empl.piHistory.pihAl}"/></td>
				<c:forEach items="${dehistory}" var="de" begin="0" end="4">
					<c:choose>
					<c:when test="${de.dehAmount eq 0}">
					<td class="right"></td>
					</c:when>
					<c:otherwise>
					<td class="right"><fmt:formatNumber value="${de.dehAmount}"/></td>
					</c:otherwise>
					</c:choose>
				</c:forEach>
				<td rowspan="4" class="right"><fmt:formatNumber value="${empl.piHistory.pihDe}"/></td>
				<td rowspan="4" class="right"><fmt:formatNumber value="${empl.piHistory.pihPay}"/></td>
			</tr>
			<tr>
				<c:forEach items="${alhistory}" var="al" begin="5" end="9">
					<c:choose>
						<c:when test="${al.alhAmount eq 0}">
							<td class="right"></td>
						</c:when>
						<c:otherwise>
							<td class="right"><fmt:formatNumber value="${al.alhAmount}" /> </td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<c:forEach items="${dehistory}" var="de" begin="5" end="9">
					<c:choose>
					<c:when test="${de.dehAmount eq 0}">
					<td class="right"></td>
					</c:when>
					<c:otherwise>
					<td class="right"><fmt:formatNumber value="${de.dehAmount}"/></td>
					</c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${alhistory}" var="al" begin="10" end="14">
					<c:choose>
						<c:when test="${al.alhAmount eq 0}">
							<td class="right"></td>
						</c:when>
						<c:otherwise>
							<td class="right"><fmt:formatNumber value="${al.alhAmount}" /> </td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<c:forEach items="${dehistory}" var="de" begin="10" end="14">
					<c:choose>
					<c:when test="${de.dehAmount eq 0}">
					<td class="right"></td>
					</c:when>
					<c:otherwise>
					<td class="right"><fmt:formatNumber value="${de.dehAmount}"/></td>
					</c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
			<tr>
				<td>${empl.emplNo}</td>
				<td>${empl.position.pstNm}</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			</c:forEach>
			<tr class="sumTr">
				<td rowspan="3" colspan="2" class="cen">합계</td>
				<c:forEach items="${sumAl}" var="al" begin="0" end="4">
					<c:choose>
						<c:when test="${al.alhAmount eq 0}">
							<td class="right"></td>
						</c:when>
						<c:otherwise>
							<td class="right"><fmt:formatNumber value="${al.alhAmount}" /> </td>
						</c:otherwise>
					</c:choose>						
				</c:forEach>
				<td rowspan="4" class="right"><fmt:formatNumber value="${sumA}"/>  </td>
				
				<c:forEach items="${sumDe}" var="de" begin="0" end="4">
					<c:choose>
						<c:when test="${de.dehAmount eq 0}">
							<td class="right"></td>
						</c:when>
						<c:otherwise>
							<td class="right"><fmt:formatNumber value="${de.dehAmount}" /> </td>
						</c:otherwise>
					</c:choose>						
				</c:forEach>
				<td rowspan="4" class="right"><fmt:formatNumber value="${sumD}"/>  </td>
				<td rowspan="4" class="right"><fmt:formatNumber value="${sumT}"/>  </td>
			</tr>
			<tr class="sumTr">
				<c:forEach items="${sumAl}" var="al" begin="5" end="9"> 
					<c:choose>
						<c:when test="${al.alhAmount eq 0}">
							<td class="right"></td>
						</c:when>
						<c:otherwise>
							<td class="right"><fmt:formatNumber value="${al.alhAmount}" /> </td>
						</c:otherwise>
					</c:choose>					
				</c:forEach>
				
				<c:forEach items="${sumDe}" var="de" begin="5" end="9">
					<c:choose>
						<c:when test="${de.dehAmount eq 0}">
							<td class="right"></td>
						</c:when>
						<c:otherwise>
							<td class="right"><fmt:formatNumber value="${de.dehAmount}" /> </td>
						</c:otherwise>
					</c:choose>						
				</c:forEach>
			</tr>
			
			<tr class="sumTr">
				<c:forEach items="${sumAl}" var="al" begin="10" end="14"> 
					<c:choose>
						<c:when test="${al.alhAmount eq 0}">
							<td class="right"></td>
						</c:when>
						<c:otherwise>
							<td class="right"><fmt:formatNumber value="${al.alhAmount}" /> </td>
						</c:otherwise>
					</c:choose>						
				</c:forEach>
							
				<c:forEach items="${sumDe}" var="de" begin="10" end="14">
					<c:choose>
						<c:when test="${de.dehAmount eq 0}">
							<td class="right"></td>
						</c:when>
						<c:otherwise>
							<td class="right"><fmt:formatNumber value="${de.dehAmount}" /> </td>
						</c:otherwise>
					</c:choose>						
				</c:forEach>
			</tr>
		</table>
	</div>
<div id="bottom">
	<hr color="#F1F4FF">
	<input type="button" onclick="window.close()" value="닫기">
</div>
</body>
</html>