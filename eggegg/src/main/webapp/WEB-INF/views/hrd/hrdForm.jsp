<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출근정보입력</title>
<link rel="stylesheet" href="${ cPath }/resources/css/list.css">
<style>
.required{
	color: red;
}
th{
	background: #FCFCFE;
}
input[name=atvlEmpl]{
	border: none;
}
input::placeholder{
	color: #D9D9D9;
}
</style>
</head>
<body>
	<table>
		<thead></thead>
		<tbody>
			<tr>
				<th>사번 <span class="required">*</span></th>
				<td>
					<input name="atvlEmpl" value="${ param.emplNo }" readonly>
				</td>
			</tr>
			<tr>
				<th>사원명</th>
				<td></td>
			</tr>
			<tr>
				<th>출근일시 <span class="required">*</span></th>
				<td>
					<input name="atvlAttTm">
				</td>
			</tr>
			<tr>
				<th>내/외근 <span class="required">*</span></th>
				<td>
					<input type="radio" name="inOut" value="IN" checked> 내근&ensp;
					<input type="radio" name="inOut" value="OUT"> 외근&ensp;
					<input type="radio" name="inOut"> 기타
				</td>
			</tr>
			<tr>
				<th>장소</th>
				<td>
					<input type="text" name="atvlPlace" placeholder="사무실">
				</td>
			</tr>
		</tbody>
	</table>
<script>
	
</script>
</body>
</html>