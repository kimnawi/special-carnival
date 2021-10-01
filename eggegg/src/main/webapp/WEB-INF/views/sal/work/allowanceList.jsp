<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	color: blue;
}
.a:hover {
	text-decoration: underline;	
	cursor: pointer;
}
</style>
<body>
<span id="title">수당항목검색</span>
<hr color="#F1F4FF">
<table>
	<thead>
		<tr>
			<th>수당항목코드</th>
			<th>수당항목명</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${alList}" var="al">
			<tr>
				<td><span class="a code">${al.alCode}</span></td>
				<td>
				<span class="a name">${al.alNm}</span>		
				<span style="display: none;" class="pro">${al.alProvide }</span>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
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