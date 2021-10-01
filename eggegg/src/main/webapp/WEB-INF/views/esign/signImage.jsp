<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authEmpl"/>
</security:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 도장/서명올리기</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<!-- css -->
<link rel="stylesheet" href="${cPath }/resources/css/signImage.css">
<!-- js -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<link rel="stylesheet" type="text/css" 
href="https://fengyuanchen.github.io/cropperjs/css/cropper.css">
<script src="https://fengyuanchen.github.io/cropper/js/cropper.js"></script>

<script type="text/javascript" src="${cPath }/resources/js/signImage.js"></script>
</head>
<body>
	<div id="top">
		<span id="title">도장/서명올리기</span>
	</div>
	<hr color="#F1F4FF">
	<div id="photo_box">
	<div>
		<div class="originalBtnDiv">
			<ul>
				<li>
					원본사진 
				</li>
				<li>
					<input type="file" accept="image/*" id="photoBtn" hidden> 
					<button id="imageBtn" type="button">사진 선택하기</button>
				</li>
			</ul>
		</div>
		<div id="originalDiv">
			<img id="originalImage" src="">
		</div>
	</div>
	<img id="arrowImg" src="${cPath }/resources/images/arrow.png">
	<div class="croppedPhotoDiv">
		<div class="originalBtnDiv">
			After
		</div>
		<div id="resultBox">
			<img id="result" src="">
		</div>
	</div>
	</div>
	<div class="upload_btn">
		<div class="upload">
			<hr color="#F1F4FF">
			<button type="button" class="saveBtn" id="complete">저장</button>
			<button type="button" class="resetBtn" id="resetPhoto">초기화</button>
			<input type="button" value="닫기" onclick="window.close()">
		</div>
	</div>
	<script>
		const emplNo = ${authEmpl.emplNo};
		const cPath = "${cPath}";
	</script>
	<jsp:include page="/includee/cAlert.jsp"/>
</body>
<style>
	#cAlert{
		left: 8%;
	}
</style>
</html>