<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정조회</title>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/emplForm.css">
<style type="text/css">
#tb {
 	width : 100% 
}
#tb th, td{
	border : 1px solid #EAEAEA;
	padding: 10px;
}
td{
	background: white;
}
.contentTb{
	height: 400px;
}
</style>
</head>
<body>
	<span id="title">일정조회</span>
	<hr color="#F1F4FF">
	<table id="tb">
		<tr>
			<th>제목</th>
			<td colspan="3"></td>
		</tr>
		<tr>
			<th>일정구분</th>
			<td></td>
			<th>캘린더</th>
			<td></td>
		</tr>
		<tr>
			<th>장소</th>
			<td></td>
			<th>라벨</th>
			<td></td>
		</tr>
		<tr>
			<th>날짜/시간</th>
			<td colspan="3"></td>
		</tr>
		<tr>
			<th>참석자</th>
			<td colspan="3"></td>
		</tr>
		<tr>
			<th>공유자</th>
			<td colspan="3"></td>
		</tr>
		<tr>
			<th>첨부</th>
			<td colspan="3"></td>
		</tr>
		<tr class="contentTb">
			<td class="contentTb" colspan="4">
			
			</td>
		</tr>
	</table>
	<div id="bottom">
		<hr color="#F1F4FF">
		<button type="button" id="update">수정</button>
		<button type="button" id="copy">복사</button>
		<button type="button" id="delete">삭제</button>
		<button type="button" class="close" onclick="window.close()">닫기</button>
	</div>
</body>
</html>