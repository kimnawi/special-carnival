<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 18px;
}
.hr{
	margin : 0px;
}
.a{
	color: blue;
}
.a:hover {
	text-decoration: underline;	
	cursor: pointer;
}
#title{
	margin-left: 20px;
	font-size: 20px;
	font-weight: bold;
}
table{
	width : 100%;
}
td, th, table{
	border : 1px solid #EAEAEA;
	border-collapse: collapse;
}
</style>
<body>
<span id="title">프로젝트검색</span>
<hr color="#F1F4FF">
<table>
	<thead>
		<tr>
			<th>프로젝트코드</th>
			<th>프로젝트명</th>
			<th>기간</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${projectList}" var="project">
			<tr>
				<td><span class="a code">${project.prjCode}</span></td>
				<td><span class="a name">${project.prjNm}</span></td>
				<td><span class="a period">${project.prjPeriod}</span></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<script>
$(function(){
	let tbody = $("tbody");
	tbody.on("click",".a",function(){
		code = $(this).parent().parent().find(".code").text();
		name = $(this).parent().parent().find(".name").text();
		opener.document.getElementById("alco").value = code;
		opener.document.getElementById("alnm").value = name;
		window.close();
	})
})
</script>
</body>
</html>