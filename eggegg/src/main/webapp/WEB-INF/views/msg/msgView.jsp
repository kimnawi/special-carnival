<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authMember" />
	<security:authentication property="authorities" var="authMemRoles" />
</security:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:set var="msgSender" value="${ msg.msgSender }" />
<c:set var="msgReceiver" value="${ msg.msgReceiver }" />
<c:choose>
	<c:when test="${ msgSender ne msgReceiver }">
		<title>EGGEGG | 보낸 쪽지</title>
	</c:when>
	<c:otherwise>
		<title>EGGEGG | 받은 쪽지</title>
	</c:otherwise>
</c:choose>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/emplForm.css">
<style>
body{
	overflow: hidden;
}
input, button {
	cursor: pointer;
}
#content {
	height: 290px;
	vertical-align: top;
	margin : 10px;
}
#tb {
	width : 100%
}
#tb th, td{
	border : 1px solid #EAEAEA;
}
td {
	overflow: auto;
	height: 290px;
	background: white;
	font-size: 18px;
	padding: 0px;
	vertical-align: top;
}
.bar{
	opacity: 0.2;
}
</style>
</head>
<body>
<c:if test="${not empty message }">
<script>
	alert("${message}")
</script>
<c:remove var="message" scope="session"/>
</c:if>
	<c:choose>
		<c:when test="${ msgSender ne msgReceiver and authMember.emplNo ne msgReceiver}">
			<span id="title">보낸 쪽지</span>
		</c:when>
		<c:otherwise>
			<span id="title">받은 쪽지</span>
		</c:otherwise>
	</c:choose>
<hr color="#F1F4FF">
	<table id="tb" style="table-layout:fixed;">
		<tbody>
			<tr>
		<c:choose>
			<c:when test="${ msgSender ne msgReceiver and authMember.emplNo ne msgReceiver}">
				<th>&nbsp;${ msg.pmpl.emplNm } &nbsp; <span class="bar">|</span> &nbsp; ${ msg.msgSdate }</th>
			</c:when>
			<c:otherwise>
				<th>&nbsp;${ msg.empl.emplNm } &nbsp; <span class="bar">|</span> &nbsp; ${ msg.msgSdate }</th>
			</c:otherwise>
		</c:choose>
			</tr>
			<tr>
				<td style="word-break:break-all;"> 
				<div style="overflow:auto;">
					<div id="content">${ msg.msgContent }</div>
				</div>
				</td>
			</tr>
		</tbody>
	</table>
	<div id="bottom">
		<hr color="#F1F4FF">
		<c:choose>
			<c:when test="${ msgSender ne msgReceiver and authMember.emplNo ne msgReceiver}">
				<button type="button" class="closeSendMsg">닫기</button>
			</c:when>
			<c:otherwise>
				<button type="button" id="reply">답장</button>
				<button type="button" id="save">보관</button>
				<button type="button" id="delete">삭제</button>
				<button type="button" class="close">닫기</button>
			</c:otherwise>
		</c:choose>
	</div>
<script>
$(function(){		
	
// 		//접근 권한 
// 		window.onload = function() {
// 			msgSender = ${ msg.msgSender };
// 			msgReceiver = ${ msg.msgReceiver };
// 			authMember = ${ authMember.emplNo };
// 			if( msgSender != authMember && msgReceiver != authMember ){
// 				history.back();
// 			}	
// 		};

		//쪽지 답장
		$("#reply").on("click", function() {
			msgSenderCode = '${ msg.msgSender }';
			msgSenderNm = '${ msg.empl.emplNm }';
			var nWidth = 480;
			var nHeight = 465;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = Math.ceil(( window.screen.width - nWidth )/2);
			var nTop = Math.ceil(( window.screen.height - nHeight )/2);
			window.name ="msgInsert";
			popup = window.open(
					"${ cPath }/msg/msgInsert.do?senderCode=" + msgSenderCode + "&senderNm=" + msgSenderNm,
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				cAlert("쪽지가 전송되었습니다.")
				 $("#alertYesBtn").on("click", function(){
					 window.open('about:blank','_self').self.close();
				 });
		    });
			popup.addEventListener('beforeunload', function(){
				 window.close();
			     opener.location.reload();
		    });
		});
	
		//쪽지 보관
		$("#save").on("click", function() {
			msgNo = [];
			what = ${ param.what };
			msgNo.push(what);
			$.ajax({
				url: "${cPath}/msg/msgSaveUpdate.do", 
				type: "post",
				data: {"what" : msgNo},
				dataType: "text",
				success:function(res){
				cAlert("보관되었습니다.");
					$("#alertYesBtn").on("click", function(){
						window.close();
					    opener.location.reload();
					 });
				}
			});
		});
		
		//쪽지 삭제
		$("#delete").on("click", function(){
	         cAlert("삭제 후엔 복구가 불가능합니다.<br>삭제하시겠습니까?", "confirm");
	      });		
	      $("#alertResult").on("change",function(){
	    	  if($(this).val() != 'true'){
	              return false;
	           } 
	        msgNo = [];
		    what = ${ param.what };
			msgNo.push(what);
			$.ajax({
				url: "${cPath}/msg/msgDelete.do", 
				type: "post",
				data: {"what" : msgNo},
				dataType: "text",
				success:function(res){
				cAlert("삭제되었습니다.");
					$("#alertYesBtn").on("click", function(){
						window.close();
					    opener.location.reload();
					 });
			   	 }
			});	
	    });
		
		// 상세보기창 닫기
		$(".close").on("click", function(){
			opener.location.reload();
			window.close();
		});
		
		// 보낸쪽지함 상세보기창 닫기
		$(".closeSendMsg").on("click", function(){
			window.close();
		});
		
		width = $("#tb").css("width");
		$("#tr").css("width", width);
})
</script>
<jsp:include page="/includee/cAlert.jsp"/>
</body>
<style>
	#cAlert{
		width: 300px;
		top: 6%; 
 		left: 6%;
	}
</style>
</html>