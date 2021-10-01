<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<title>EGGEGG | 공제항목검색</title>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/search.css">
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
.a{
	color: #4472C4;
}
.a:hover {
	text-decoration: underline;	
	cursor: pointer;
}
</style>
<body>
<span id="title">공제항목검색</span>
<hr color="#F1F4FF">
<table>
	<thead>
		<tr>
			<th>공제항목코드</th>
			<th>공제항목명</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${deList}" var="de">
			<tr>
				<td><span class="a code">${de.deCode}</span></td>
				<td>
				<span class="a name">${de.deNm}</span>		
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
	<div id="bottom">
		<hr color="#F1F4FF">
		<input type="button" onclick="window.close()" value="닫기">
	</div>
<script>
$(function(){
	let tbody = $("tbody");
	$(tbody).on("click",".a",function(){
		code = $(this).parent().parent().find(".code").text();
		name = $(this).parent().parent().find(".name").text();
		pro = $(this).parent().parent().find(".pro").text();
		opener.document.getElementById("alco").value = code;
		opener.document.getElementById("alnm").value = name;
		opener.document.getElementById("alpro").value = pro;
		window.close();
	})
})
</script>
</body>
</html>