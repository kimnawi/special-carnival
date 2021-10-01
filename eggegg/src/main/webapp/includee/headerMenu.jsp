<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
<style>
.wrap {
	position: absolute;
	top: 45px;
	right: 60px;
	text-align: center;
 	width: 150px;
}
#QRCheck {
	-webkit-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-moz-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-ms-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-o-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	display: block;
	max-width: 180px;
	text-decoration: none;
	border-radius: 4px;
	padding: 10px 25px;
	font-size: 20px;
	font-weight: bold;
	background: white;
}
a#QRCheck {
	color: #3A4CA8;
	box-shadow: #9FA9D8 0 0px 0px 2px inset;
}
a#QRCheck:hover {
	color: white;
	box-shadow: #9FA9D8 0 0px 0px 40px inset;
}
#push{
	cursor: pointer;
}
.dropdown{
	display: inline;
}
.toast { 
   position: absolute;
   top: 15px;
   left: 35%;
   max-width: 700px;
   width: 400px;
   color: white;
   background-color: rgba(0,0,0,0.5);
   z-index: 100;
   text-align: center;
}

#count{
    font-weight: bold;
    text-align: center;
    font-size: 10px;
    width: 20px;
    height: 20px;
    background: red;
    color: white;
    border-radius: 50%;
    display: inline-block;
    padding-top: 2px;
}
</style>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authEmpl"/>
	<security:authentication property="authorities" var="authMemRoles"/>
</security:authorize>
<c:if test="${not empty errorMessage }">
	<script>
	$(function(){
		cAlert("${errorMessage }");
	})
	</script>	
</c:if>
<nav>
  <ul id=navWrap>
  	<li id=headerLogo>
	  <a href="${cPath }"><img id="logo" src="${cPath }/resources/images/eggegg_logo.png"></a>
  	</li>
  	<li id=headerLink>
  		<div>
	  		<ul id="commonLink">
		    	<li>
			      <a href="#" id="drivePopup"><spring:message code="drive"/></a>
		    	</li>
		    	<li>
			      <span id="count"></span>
			      <div class="dropdown">
			      <span id="push" data-toggle="dropdown"><spring:message code="notify"/></span>
			      <ul class="dropdown-menu" aria-labelledby="dLabel" id="down" >
			      </ul>
			      </div>
		    	</li>
		    	<li>
			      <a id ="message"><spring:message code="message"/></a>
		    	</li>
		    	<li>
			      <a href="${cPath }/fileBrowser.do"><spring:message code="myPage"/></a>
		    	</li>
			    <li>
			      <a href="${cPath }/login/logout.do"><spring:message code="logout"/></a>
			    </li>
		    </ul>
		    <ul id="authorityLink">
			    <security:authorize url="/sal/extrapayList.do">
			    <li >
			      <a id="PAY" href="${cPath}/empl/salEmplList.do"><spring:message code="PAY"/></a>
			    </li>
			    </security:authorize>
			    <security:authorize url="/empl/emplInsert.do">
			    <li >
			      <a id="HRM" href="${cPath }/empl/emplList.do"><spring:message code="HRM"/></a>
			    </li>
			    </security:authorize>
			    <c:choose>
			    	<c:when test="${authMemRoles eq '[ROLE_VAC]' }">
					    <li >
					      <a id="VAC" href="${cPath }/vac/emplVacList.do"><spring:message code="VAC"/></a>
					    </li>
			    	</c:when>
			    	<c:otherwise>
					    <li >
					      <a id="VAC2" href="${cPath }/vac/vacApply.do"><spring:message code="VAC2"/></a>
					    </li>
			    	</c:otherwise>
			    </c:choose>
			    <li >
			      <a id="SCHE" href="${cPath }/schedule/scheList.do"><spring:message code="schedule"/></a>
			    </li>
			    <li >
			      <a id="ESIGN" href="${cPath }/group/esign/draftList.do?ownerId=${authEmpl.emplNo }"><spring:message code="esign"/></a>
			    </li>
			    <%-- <li>
			      <a href="${cPath }/board/boardList.do"><spring:message code="board"/></a>
			    </li> --%>
		    </ul>
		    <div class="wrap">
		      <div id = "pushMsg">
  			</div>
			    <a href="#" id="QRCheck">출/퇴근하기</a>
			</div>
	    </div>
    </li>
  </ul>

  <div id="boundary">
  </div>
  <div class="toast" data-autohide="false" >
   <div class="toast-body"></div>
</div>
</nav>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script>
$(function(){
	var selectedHead = localStorage.getItem("selectedHead");
	$(document.getElementById(selectedHead)).css("background","radial-gradient(#d3dcff, white)").css("border-radius","50%");
		
	$("a","#authorityLink").on("click",function(e){
		e.stopPropagation()
		localStorage.setItem("selectedHead",$(this).attr('id'));
	});
	if($("#count").text() ==""){
		$("#count").hide();
	}
	if(parseInt($("#count").text()) > 0){
		$("#count").show();
	}
})
//웰컴 토스트 메시지
$('.toast').css("display", "none");

let client = null;
let headers = {}
let pushMsg = $('#pushMsg');
let memId = ${authEmpl.emplNo};
let SUB_ID=null; 
function init(){
<!-- // stomp-endpoint로 양방향 통신 연결 수립  -->
	var sockJS=new SockJS("${pageContext.request.contextPath}/stomp/push");
		
		client=Stomp.over(sockJS); 
		client.connect(headers, function(connectFrame){
			
			client.subscribe("/app/pushMsg/" + memId, function(messageFrame){
					SUB_ID=messageFrame.body;
					headers.sub_id=SUB_ID; 
				
					client.subscribe("/topic/pushMsg/"+memId, function(messageFrame){
						let body = messageFrame.body;

						lcnt = localStorage.getItem(memId);
						if(lcnt == null){
							lcnt = "";
						}
						cnt = 0;
						if(lcnt != ""){
							cnt = parseInt(lcnt) +1;
						}else{
							cnt = 1;
						}
						localStorage.setItem(memId,cnt);
						$("#count").text(cnt);
						$("#count").show();
						$("#down").prepend("<li><span class='dropdown-item'>"+body+"</span></li>")
				   function showMsg() { 
				    $('.toast').css("display", "block");
				    $('.toast').toast('show');  
				   }  
				   function hideMsg(){
				       $('.toast').fadeOut(1000);   
				       $('.toast').css("display", "none");
				   }      
				   setTimeout(showMsg, 500);
				   setTimeout(hideMsg, 6000);	
				   $(".toast-body").html(body);	
					}, {id:SUB_ID});
			
			});
			
		}, function(error){
			console.log(error);
			alert(error.headers.message);
		});
	}
	$("#push").on("click",function(){
		localStorage.setItem(memId,"");
		$("#count").hide();
		$("#count").text("");
		
	})
	function disconnect(event){
		if(! client || ! client.connected) throw "stomp 연결 수립 전";
			client.disconnect();
			let msgTag=document.createElement("p");
			msgTag.innerHTML="연결종료";
			messageArea.appendChild(msgTag);
			
			$(roomBtn).each(function(){
				$(this).attr("disabled", false);
			})
		}
	
	
	
		init();


	var list = $("#authorityLink");
	var listCnt = list.find("li").length;
	list.css("width",listCnt*200)
	
	var nWidth = 1100;
	var nHeight = 1000;
	const curX = window.screenLeft;
	const curY = window.screenTop;
	const curWidth = document.body.clientWidth;
	const curHeight = document.body.clientHeight;
	const nLeft = curX + (curWidth / 2) - (nWidth / 2);
	const nTop = curY + (curHeight / 2) - (nHeight / 2);
	$("#message").on("click", function(){
		window.name ="message";
		popup = window.open(
				"${ cPath }/msg/msgList.do",
				"taxFree",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
	}).css('cursor', 'pointer');
	
	$("#drivePopup").on("click", function(){
		nHeight = 740;
		nWidth = 1600;
		popup = window.open(
				"${cPath}/group/schedule/drive/driveList.do?who=${authEmpl.emplNo}&command=popup",
				"drivePopup",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height="+nHeight+"px, width=" + nWidth  + "px, left="+(curX + (curWidth / 4) - (nHeight / 2))+"px, top=50px");
	}).css('cursor', 'pointer');
	$("#QRCheck").on("click", function(){
		var nWidth = 700;
		var nHeight = 800;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);
		window.name = "QRCheck";
		popup = window.open(
				"${ cPath }/vac/hrdQRCheck.do",
				"searchTable",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
	});
	ct = localStorage.getItem(memId);
	$("#count").text(ct);
</script>