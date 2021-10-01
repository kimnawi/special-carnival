<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사카드인쇄</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
	*{
		font-family:'Noto Sans KR', sans-serif;
		font-size: 18px;
	}
	#title{
		margin: 10px;
		font-size: 20px;
		font-weight: bold;
	}
	#bottom{
		width: 97%;
		position: fixed;
		bottom: 10px;
		z-index: 1;
	}
	.print {
	    display: inline-block;
	    text-decoration: none;
	    color: white;
	    padding: 1px 12px;
	    background: #3A4CA8;
	    border-radius: 3px;
	}
</style>
</head>
<body>
	<div id="top">
		<span id="title">사원증인쇄</span>
		<hr color="#F1F4FF">
	</div>
	<div style="float:left;margin:10px;font-family:'Noto Sans KR', sans-serif;border-radius: 5px;border: 1px solid #4472C4;">
		<table style="border-collapse:collapse;width:212px;height:333px;text-align: center;">
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th style="padding: 0;">
					<img alt="eggegg" src="${ cPath }/resources/images/eggegg_logo.png" style="height: 60px;">
				</th>
			</tr>
			<tr>
				<td style="padding:0;vertical-align: top;">
					<c:if test="${ empty empl.file }">
						<img alt="프로필사진" src="${ cPath }/resources/images/profile.png" style="max-height: 100px;margin:0;">
					</c:if>
					<c:if test="${ not empty empl.file }">
						<img alt="프로필사진" src="${ cPath }/group/esign/getSignImage.do?link=${ empl.file.commonPath }" style="max-height: 100px;margin:0;">
					</c:if>
				</td>
			</tr>
			<tr>
				<td style="font-size:14px;">${ empl.dept.deptNm }</td>
			</tr>
			<tr>
				<td style="font-weight: bold;font-size: 15px;height: 30px;vertical-align: top;">${ empl.position.pstNm }&ensp;&ensp;<span style="font-weight: bold;font-size: 18px;">${ empl.emplNm }</span></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
	</div>
	<div style="float:left;margin:10px;font-family:'Noto Sans KR', sans-serif;border-radius: 5px;border: 1px solid #4472C4;">
		<table style="border-collapse:collapse;width:212px;height:333px;">
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th colspan="2" style="text-align: center;">
					<img alt="eggegg" src="${ cPath }/resources/images/qrCode.jpg" style="width: 120px;">
					<p style="font-size: 10px;text-align: left;padding: 0 10px;">
						1. 본 증은 당사 출입시 항상 휴대하여야 합니다.<br>
						2. 본 증을 습득하신 분은 하단 전화번호로 연락 또는 가까운 우체통에 넣어주시기 바랍니다.
					</p>
				</th>
			</tr>
			<tr>
				<th style="text-align: right;width:50px;padding-left:4px;font-size: 11px;">전화번호</th>
				<td style="font-size: 11px;">| ${ empl.emplMobile }</td>
			</tr>
			<tr>
				<th style="text-align: right;padding-left:2px;font-size: 11px;">이메일</th>
				<td style="font-size: 11px;">| ${ empl.emplEmail }</td>
			</tr>
			<tr>
				<th style="text-align: right;vertical-align:top;padding-top:4px;padding-left:2px;font-size: 11px;">주소</th>
				<td style="font-size: 11px;">| ${ empl.emplDetAdres }</td>
			</tr>
			<tr>
				<td style="font-size: 12px;">&nbsp;</td>
			</tr>
		</table>
	</div>
	<div id="bottom">
		<hr color="#F1F4FF">
		<input type="button" class="print" value="인쇄">
		<input type="button" class="close" onclick="window.close()" value="닫기">
	</div>
</body>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script>
	$(".print").on("click", function(){
		print();
	});
</script>
</html>