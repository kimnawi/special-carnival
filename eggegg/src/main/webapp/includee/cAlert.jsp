<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="styleSheet" href="${cPath }/resources/css/cAlert.css">
<div id="preventClickDiv">
	<div id="cAlert">
		<div id="cAlertHead">
			<span id="alertTitle">&nbsp;&nbsp;알림</span>
			<button type="button" id="closeAlertBtn" onclick='closeAlert()'>&times;</button>
		</div>
			<hr>
		<div id="cAlertBody">
			<p id="cAlertContent">내용이 들어갈 위치</p>
		</div>
			<br>
			<hr class="alertHr">
		<div id="cAlertFooter">
			<button type="button" id="alertYesBtn">확인</button>
		</div>
		<input type="hidden" id="alertResult">
		<input type="hidden" id="fnName">
	</div>
</div>
<script src="${cPath }/resources/js/cAlert.js"></script>