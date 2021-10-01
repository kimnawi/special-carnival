<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styleSheet" href="${cPath }/resources/css/main.css">
<script type="text/javascript" src="${cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<style>
span {
	margin-left: 15px;
}

.withImg {
    width: 326px;
    margin-left: 0px;
    position: relative;
    padding-left: 0px;
    z-index: 0;
    left: -6px;
    top: 2.1px;
    height: 32.64px;
}

.withoutImg {
	width: 360px;
}

tr>td {
	width: 100px;
}

table {
	margin-bottom: 30px;
	width: 515px;
}

.searchImg {
	position: relative;
    width: 29px;
    right: 3px;
    margin: 0px;
    padding: 0px;
    z-index: 1;
    bottom: -2px;
}

.small-search {
    position: relative;
    display: inline;
    width: 38.2px;
    height: 38.2px;
    text-align: center;
    vertical-align: middle;
    z-index: 1;
    bottom: 1px;
}
#result{
	height: 30px;
	text-align: center;
}
html,body{
	width: 500px;
	height: 340px;
}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${cookie.languageCookie.value eq 'ko' }">
			<c:set var="emplNm" value="이름" />
			<c:set var="emplTel" value="전화번호" />
			<c:set var="deptNm" value="부서" />
			<c:set var="emplAuthority" value="직책" />
		</c:when>
		<c:otherwise>
			<c:set var="emplNm" value="이름" />
			<c:set var="emplTel" value="전화번호" />
			<c:set var="deptNm" value="부서" />
			<c:set var="emplAuthority" value="직책" />
		</c:otherwise>
	</c:choose>
	<span>사원번호찾기</span>
	<hr>
	<form action="${cPath }/empl/findEmplNo.do">
		<table>
			<tr>
				<td>${emplNm }</td>
				<td><input class="withoutImg" type="text" name="emplNm"	placeholder="${emplNm }" required></td>
			</tr>
			<tr>
				<td>${emplTel }</td>
				<td><input class="withoutImg" type="text" name="emplTel" placeholder="${emplTel }" required></td>
			</tr>
			<tr>
				<td>${deptNm }</td>
				<td>
					<button class="small-search" data-action="deptSearch" type="button">
						<img class="searchImg"
							src="${ cPath }/resources/images/Search.png">
					</button> 
					<input class="withImg" id="nm" name="dept.deptNm" type="text" placeholder="${deptNm }">
					<input type="hidden" id="code" type="text" placeholder="${deptNm }" required>
				</td>
			</tr>
			<tr>
				<td>${emplAuthority }</td>
				<td>
					<button class="small-search" data-action="roleSearch" type="button">
						<img class="searchImg"
							src="${ cPath }/resources/images/Search.png">
					</button> 
					<input class="withImg" id="description" name="roles.description" type="text" placeholder="${emplAuthority }" required>
				</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td colspan="3" id="result">
				</td>
			</tr>
		</table>
	<hr>
	<button type="submit" class="saveBtn">확인</button>
	</form>
	<script>
$(".small-search").on("click", function(){
	action = $(this).data("action");
	var nWidth = 1000;
	var nHeight = 800;
	var curX = window.screenLeft;
	var curY = window.screenTop;
	var curWidth = document.body.clientWidth;
	var curHeight = document.body.clientHeight;
	var nLeft = curX + (curWidth / 2) - (nWidth / 2);
	var nTop = curY + (curHeight / 2) - (nHeight / 2);
	window.name = action;
	popup = window.open(
			"${ cPath }/search/" + action + ".do",
			"searchTable",
			"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
});
$("form").ajaxForm({
	dataType: "json",
	success: function(empl){
		result="";
		if(empl.emplNo != 0){
			result= "사원번호 : " + empl.emplNo +"<button type='button' id='setData' class='resetBtn' style='margin-left:15px; width:150px;' data-nm='"+empl.emplNo+"'>자동 입력</button>"
		}else{
			result= "일치하는 사원번호가 없습니다."
		}
		$("#result").empty();
		$("#result").append(result);
	}
});

$("tbody").on("click","#setData",function(){
	nm = $(this).data("nm");
	opener.document.getElementById("empl_no").value = nm;
	window.close()
});
</script>
</body>
</html>
