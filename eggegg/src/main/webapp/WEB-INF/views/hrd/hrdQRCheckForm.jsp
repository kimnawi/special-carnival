<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 출/퇴근인증</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="${ cPath }/resources/js/jsQR.js"></script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
body{
	overflow: hidden;
}
* {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 18px;
}
main {
	width:100%;
	height:100%;
	text-align:center;
}
main > div {
	float:left;
	width:1%;
	height:98%;
}
main > div:first-child {
	width:49%;
}
main > div:last-child {
	background-color:#D3D3D3;
	width:49%;
}
div#output {
	background-color:#F1F4FF;
	height: 35px;
	vertical-align: middle;
	padding-left:10px;
	padding-right:10px;
	padding-top:10px;
	padding-bottom:10px;
}
div#frame {
	border:2px solid #005666;
	background-color:#FFFFFF;
	margin-top: 10px;
	margin-left:10px;
	margin-right:10px;
	padding: 5px;
}
div#outputLayer {
	text-align:left;
}
canvas {
	width:100%;
}
#bottom{
	width: 100%;
	position: fixed;
	bottom: 10px;
}
#scan-title{
	margin-left: 15px;
	font-size: 20px;
	font-weight: bold;
}
.fc-popover-body {
	overflow: scroll;
}
#title{
	margin: 10px;
	font-size: 20px;
	font-weight: bold;
}
</style>
</head>
<body>
	<div id="top">
		<span id="title">QR코드 출/퇴근 인증</span>
		<hr color="#F1F4FF">
	</div>
	<div id="QRCheck" class="mainDiv">
		<div id="test">
			<div id="output">
				<div id="outputMessage">
					QR코드를 카메라에 노출시켜 주세요
				</div>
	    		<div id="outputLayer" hidden>
	    			<span id="outputData"></span>
	    		</div>
			</div>
		</div>
		<div><hr color="#F1F4FF"></div>
		<div>
			<span id="scan-title">> 스캔</span>
			<div id="frame">
				<div id="loadingMessage">
					🎥 비디오 스트림에 액세스 할 수 없습니다<br/>웹캠이 활성화되어 있는지 확인하십시오
				</div>
				<canvas id="canvas"></canvas>
			</div>
		</div>
	</div>
	<div id="bottom">
		<hr color="#F1F4FF">
		<button type="button" onclick="window.close()">닫기</button>
	</div>
</body>
<jsp:include page="/includee/cAlert.jsp"/>
<style>
	#cAlert{
		position: absolute;
		top: 280px;
		left: 100px;
	}
</style>
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
		var video = document.createElement("video");		
		var canvasElement = document.getElementById("canvas");
		var canvas = canvasElement.getContext("2d");
		var loadingMessage = document.getElementById("loadingMessage");
		var outputContainer = document.getElementById("output");
		var outputMessage = document.getElementById("outputMessage");
		var outputData = document.getElementById("outputData");
		function drawLine(begin, end, color) {
			canvas.beginPath();
			canvas.moveTo(begin.x, begin.y);
			canvas.lineTo(end.x, end.y);
			canvas.lineWidth = 4;
			canvas.strokeStyle = color;
			canvas.stroke();
        }
	    // 카메라 사용시
		navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } }).then(function(stream) {
      		video.srcObject = stream;
      		video.setAttribute("playsinline", true);      // iOS 사용시 전체 화면을 사용하지 않음을 전달
         	video.play();
      		requestAnimationFrame(tick);
		});
		function tick() {
			loadingMessage.innerText = "⌛ 스캔 기능을 활성화 중입니다."
			if(video.readyState === video.HAVE_ENOUGH_DATA) {
				loadingMessage.hidden = true;
				canvasElement.hidden = false;
				outputContainer.hidden = false;
				// 읽어들이는 비디오 화면의 크기
				canvasElement.height = video.videoHeight;
				canvasElement.width = video.videoWidth;
				canvas.drawImage(video, 0, 0, canvasElement.width, canvasElement.height);
				var imageData = canvas.getImageData(0, 0, canvasElement.width, canvasElement.height);
				var code = jsQR(imageData.data, imageData.width, imageData.height, {
					inversionAttempts : "dontInvert"
				});
				// QR코드 인식에 성공한 경우
				if(code) {
					 // 인식한 QR코드의 영역을 감싸는 사용자에게 보여지는 테두리 생성
					drawLine(code.location.topLeftCorner, code.location.topRightCorner, "#FF0000");
					drawLine(code.location.topRightCorner, code.location.bottomRightCorner, "#FF0000");
					drawLine(code.location.bottomRightCorner, code.location.bottomLeftCorner, "#FF0000");
					drawLine(code.location.bottomLeftCorner, code.location.topLeftCorner, "#FF0000");
					outputMessage.hidden = true;
					outputData.parentElement.hidden = false;
					// QR코드 메시지 출력
					outputData.innerHTML = code.data;
					// return을 써서 함수를 빠져나가면 QR코드 프로그램이 종료된다.
					// return;
					outputData = $("#outputData").html();
					if(outputData != null || outputData.length > 0){
						emplNo = outputData.substring(0,7);
						$.ajax({
							url: "${ cPath }/vac/hrdQRCheck.do",
							data: {"atvlEmpl": emplNo},
							dataType: "text",
							type: "post",
							success: function(res){
								console.log(res);
								if(res == "AT"){
									cAlert("<strong>" + outputData.substring(8) + "</strong>님&ensp;<span style='color:blue; font-weight:bold;'>'출근'</span> 인증되었습니다.");
								} else if (res == "LV") {
									cAlert("<strong>" + outputData.substring(8) + "</strong>님&ensp;<span style='color:red; font-weight:bold;'>'퇴근'</span> 인증되었습니다.");
								}
								$("#alertYesBtn").on("click", function(){
									window.close();
								});
							}
						});
					}
					return false;
				}
				// QR코드 인식에 실패한 경우 
				else {
					outputMessage.hidden = false;
					outputData.parentElement.hidden = true;
				}
			}
     		requestAnimationFrame(tick);
		}
	});
</script>
</html>