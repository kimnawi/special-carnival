<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isFullyAuthenticated()">
   <security:authentication property="principal.adaptee" var="authMember"/>
   <security:authentication property="authorities" var="authMemRoles"/>
</security:authorize>
<%-- ${authMember.emplNm }님 --%>
<%--  / 권한 : ${authMemRoles } --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 새 쪽지</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="${ cPath }/resources/css/emplForm.css">
<style>
body{
	overflow: hidden;
}
#bottom{
   bottom: 10px;
}
#send{
   cursor: pointer;
}
#close{
   width : 65px;   
   cursor: pointer;   
}
table{
   width : 100%;
}
#content{
   vertical-align: top;
}
#receiver{
   position : relative;
   width : 280px;
   left : -5px;
}
.small-search{
   cursor: pointer;
}
</style>
</head>
<body>
   <span id="title">새 쪽지</span>
   <hr color="#F1F4FF">
   <form:form commandName="msg" id="msgForm" method="post" enctype="multipart/form-data">
   <table>
      <tbody>
         <tr>
            <th>받는 사람</th>
            <td colspan="3">
               <button class="small-search" data-action="emplSearch" type="button">
                  <img class="searchImg" src="${ cPath }/resources/images/Search.png">
               </button>
               <c:choose>
                  <c:when test="${ param.senderNm eq null}">
                     <input type="hidden" class="code" name="msgReceiver" value="${ msg.msgReceiver }">
                     <input id="receiver" type="text" name="msgReceiverNm" class="nm" placeholder="받는 사람" readonly>
                  </c:when>
                  <c:otherwise>
                     <input type="hidden" class="code" name="msgReceiver" value="${ param.senderCode }">
                     <input id="receiver" type="text" name="msgReceiverNm" class="nm" value="${ param.senderNm }" readonly>
                  </c:otherwise>
               </c:choose>
               <input type="hidden" name="msgSender" value="${ authMember.emplNo }">
            </td>
         </tr>
         <tr>
            <td colspan="2"></td>
         </tr>
         <tr>
            <td colspan="2">
            <textarea name="msgContent" cols="52" rows="11" style="resize: none;" placeholder="내용을 입력하세요."></textarea>
            </td>
         </tr>
      </tbody>
   </table>
   <div id="bottom">
   <hr color="#DDE4FF">
      <input type="submit" id="send" class="saveBtn" value="보내기">
      <input type="button" id="close" value="닫기">
   </div>
   </form:form>
<input type="hidden" id="code">
<input type="hidden" id="nm">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
$(function(){
   
   $("#msgForm").ajaxForm({
      url: "${ cPath }/msg/msgInsert.do",
      dataType: "text",
      method: "post",
      success: function(res){
    	 cAlert("쪽지가 전송되었습니다.")
		 $("#alertYesBtn").on("click", function(){
			 opener.location.reload();
			 self.close();
		 });
      },
      error: function(xhr){
    	 cAlert("받는 사람과 내용을<br>입력해주세요.")
//       alert(xhr.status);
      }
   });
   
   $(".small-search").on("click", function(){
      action = $(this).data("action");
      code = $(this).parents("td").find(".code");
      nm = $(this).parents("td").find(".nm");
      var nWidth = 800;
      var nHeight = 1000;
      var curX = window.screenLeft;
      var curY = window.screenTop;
      var curWidth = document.body.clientWidth;
      var curHeight = document.body.clientHeight;
      var nLeft = curX + (curWidth / 2) - (nWidth / 2);
      var nTop = curY + (curHeight / 2) - (nHeight / 2);
      window.name = action;
      popup = window.open(
            "${ cPath }/search/" + action + ".do",
            "taxFree",
            "status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
      popup.addEventListener('beforeunload', function(){
         code.val($("#code").val());
         nm.val($("#nm").val());
      });
   });
   
   $("#close").on("click", function(){
      window.close();
      opener.location.reload();
   });
});
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