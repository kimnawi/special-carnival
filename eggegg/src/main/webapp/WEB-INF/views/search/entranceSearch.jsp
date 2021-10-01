<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 입사구분리스트</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/search.css">
</head>
<body>
	<div id="top">
		<span id="title">입사구분리스트</span>
		<hr color="#F1F4FF">
	</div>
	<table>
		<thead>
			<tr>
				<th>입사구분코드</th>
				<th>입사구분명</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ entranceList }" var="entrance">
				<tr code="${ entrance.ctTable }" nm="${ entrance.ctNm }">
					<td class="entranceSelect">
						${ entrance.ctTable }
					</td>
					<td class="entranceSelect">
						${ entrance.ctNm }
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
		$(tbody).on("click", ".entranceSelect", function(){
			code = $(this).parent().attr("code");
			nm = $(this).parent().attr("nm");
			opener.document.getElementById("nm").value = nm;
			opener.document.getElementById("code").value = code;
			window.close();
		});
	});
</script>
</body>
</html>