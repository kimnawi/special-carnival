<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isFullyAuthenticated()">
   <security:authentication property="principal.adaptee" var="authEmpl"/>
</security:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 기안서 작성</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script src="${cPath }/resources/ckeditor/ckeditor.js"></script>
<link rel="styleSheet" href="${cPath }/resources/css/main.css">
<link rel="styleSheet" href="${cPath }/resources/css/draftForm.css">
</head>
<body>
	<div id="top">
	   <span id="title">기안서작성</span>
	   <hr color="#F1F4FF">
	</div>
   <form id="draftForm" method="post" enctype="multipart/form-data">
   <div id="draftWrapper">
      <table>
         <tbody>
         <tr>
         <td><input type="hidden" name="draftNo" value="${draft.draftNo }"></td>
         </tr>
               <c:choose>
                  <c:when test="${(param.command eq 'VIEW') and (draft.draftProgress != '임시저장')}">
                     <tr>
                        <th>기안일시 </th>
                        <td class="required"><span>*</span></td>
                        <td colspan="3">
                              <span>${draft.draftDate }</span>                  
                        </td>
                     </tr>
                  </c:when>
               </c:choose>
            <tr>
               <th>제목</th>
               <td class="required"><span>*</span></td>
               <td colspan="3">
               <c:choose>
                  <c:when test="${(param.command eq 'VIEW') and (draft.draftProgress != '임시저장')}">
                     <span>${draft.draftTitle }</span>                  
                  </c:when>
                  <c:otherwise>
                     <input id="draftTitle" name="draftTitle" placeholder="제목" value="${draft.draftTitle}">
                  </c:otherwise>
               </c:choose>
               </td>
            </tr>
            <c:choose>
               <c:when test="${(param.command eq 'VIEW') and (draft.draftProgress != '임시저장')}">
                  <tr id="lineTr">
                     <th rowspan="4">결재라인</th>
                     <td  class="required" rowspan="4"></td>
                  </tr>
               </c:when>
               <c:otherwise>
                  <tr id="lineTr">
                     <th rowspan="5">결재라인</th>
                     <td class="required" rowspan="5"><span>*</span></td>
                  </tr>
                  <tr>
                     <td class="lineTd">결재라인</td>
                     <td>
                        <button data-action="authlSearch.do" class="small-search" type="button" data-page="lineSearch">
                           <img class="searchImg" src="${ cPath }/resources/images/Search.png">
                        </button>
                        <input type="text" class="nm" id="lineNm" placeholder="결재라인 명" readonly>
                     </td>
                  </tr>
               </c:otherwise>
            </c:choose>
            <tr>
               <td class="lineTd">결재자</td>
               <td id="authNos">
                  <c:forEach items="${draft.authls }" var="auth" varStatus="status">
                     <span class="authl">${auth.authorNm }<button type='button' class='del'>-</button>
                     <input type=hidden name="authNos" value='${auth.authorId }'>
                     <input type=hidden name="authorAuthTyCode" value='${auth.authorAuthTyCode }'>
                     </span>
                  </c:forEach>
               </td>
            </tr>
            <tr>
               <td class="lineTd">참조자</td>
               <td id="refCode">
                  <c:forEach items="${draft.references }" var="ref" varStatus="status">
                     <span class="authl">${ref.authorNm }<button type='button' class='del'>-</button>
                     <input type=hidden name="refCode" value='${ref.authorId }'>
                     </span>
                  </c:forEach>
               </td>
            </tr>
            <tr>
               <td class="lineTd">수신자</td>
               <td id="recCode">
                  <c:forEach items="${draft.receivers }" var="rec" varStatus="status">
                     <span class="authl">${rec.authorNm }<button type='button' class='del'>-</button>
                     <input type=hidden name="recCode" value='${rec.authorId}'>
                     </span>
                  </c:forEach>
               </td>
            </tr>
            <tr>
               <th> 구분</th>
               <td class="required">*</td>
               <td colspan="4">
                  <c:choose>
	              	<c:when test="${param.chit eq 'com.eg.gnfd.service.GnfdService'}">
	              		<c:set var="draftType" value="F100"/>
	              		<c:set var="draftTypeNm" value="일반기안서"/>
	              	</c:when> 		
	              	<c:when test="${param.chit eq 'com.eg.vacation.service.VacService'}">
	              		<c:set var="draftType" value="F300"/>
	              		<c:set var="draftTypeNm" value="휴가신청서"/>
	              	</c:when> 		
	              	<c:otherwise>
	              		<c:set var="draftType" value="${draft.draftType }"/>
	              		<c:set var="draftTypeNm" value="${draft.draftTypeNm }"/>
	              	</c:otherwise>
	              </c:choose>
                  <c:choose>
                     <c:when test="${(param.command eq 'VIEW') and (draft.draftProgress != '임시저장')}">
                        <span>${draft.draftTypeNm }</span>
                     </c:when>
                     <c:otherwise>
                        <input class="ctInput" id="ctCode" name="draftType" type="text" placeholder="구분코드" value="${draftType }">
                        <button id="ctBtn" class="small-search" data-action="commonTableSearch.do?typePrefix=F" type="button">
                              <img class="searchImg" src="${ cPath }/resources/images/Search.png">
                        </button>
                        <input class="ctInput" id="ctNm" type="text" placeholder="구분" value="${draftTypeNm }">
                     </c:otherwise>
                  </c:choose>
               </td>
            </tr>
            <tr>
               <th>결재문서</th>
               <td colspan="5"><span id="chit">전표</span></td>
            </tr>
            <tr>
               <th>첨부</th>
               <td colspan="5">
               <c:choose>
                  <c:when test="${(param.command eq 'VIEW') and (draft.draftProgress != '임시저장')}">
                     <span data-attachpath>변경 예정(첨부파일 목록)</span>
                  </c:when>
                  <c:otherwise>
                     <input type="file" accept="image/*" value="이미지" >
                  </c:otherwise>
               </c:choose>
               </td>
            </tr>
            <tr>
               <td id="contentTd" colspan="5">
                  <c:choose>
                     <c:when test="${(param.command eq 'INSERT') and empty param.chit}">
                        <textarea id="draftContent" class="form-control">
                           ${draftFormVO.dfContent }
                        </textarea>
                     </c:when>
                     <c:when test="${(param.command eq 'INSERT') and (not empty param.chit)}">
                           <div id="contentHeader"><span>내용</span></div>
                           <div id="content">${draft.draftContent }</div>
                     </c:when>
                     <c:when test="${(param.command eq 'VIEW') and (draft.draftProgress != '임시저장')}">
                           <div id="contentHeader"><span>내용</span></div>
                           <div id="content">${draft.draftContent }</div>
                     </c:when>
                     <c:otherwise>
                        <textarea id="draftContent" class="form-control">
                           ${draft.draftContent }
                        </textarea>
                     </c:otherwise>
                  </c:choose>
               </td>
            </tr>
         </tbody>
      </table>
   </div>
   	<div id="bottom">
		<hr color="#F1F4FF">
		<c:if test="${(draft.draftProgress eq '임시저장') or (param.command eq 'INSERT')}">
			 <button type="button" class="saveBtn" id="uploadDraftBtn">결재</button>
			 <button type="button" class="resetBtn" id="tempSaveBtn">임시저장</button>
			 <button type="button" class="resetBtn" id="delDraft">삭제</button>
		</c:if>
		<button type="button" class="resetBtn" id="uploadSignBtn">My도장/서명</button>
		<button type="button" class="resetBtn" id="closeBtn" onclick="window.close()">닫기</button>
		<input type="hidden" name="draftProgress" value="임시저장">
		<input type="hidden" name="draftWriter" value="${draft.draftWriter }">
		<input type="hidden" name="chit" value="${param.chit }">
		<input type="hidden" name="code" value="${param.code }">
	</div>
   </form>
<br>
<div id="chitForm">
   <div data-popup="sal">급여대장</div>
   <div data-popup="vac">휴가신청</div>
   <div data-popup="hrd">인사이동</div>
</div>
<form id="signForm" method="post" hidden>
	<input type="text" name="draftNo" value="${draft.draftNo }">
	<input type="text" name="ahAuthSe" value="">
	<input type="text" name="ahReturnCn" value="">
	<input type="text" name="ahAuthTm" value="">
</form>
<jsp:include page="/includee/cAlert.jsp"></jsp:include>
<style>
	#cAlert{
		left: 9%;
		top: 9%;
	}
</style>
<script>
$(function(){

// 머지하는 펑션
async function mergeDraft(){
   if($("#authNos .authl").length<1){
      cAlert("결재자를 선택해 주세요")
      return false;
   }
   if($("#recCode .authl").length<1){
      cAlert("수신자를 선택해 주세요")	
      return false;
   }
   if($("input[name='draftWriter']").val() == ""){
      $("input[name='draftWriter']").val("${authEmpl.emplNo}")
   }
   var content = "";
   <c:choose>
	   <c:when test="${(param.command eq 'INSERT') and (not empty param.chit)}">
	 	  content = $("#content").html();
	   </c:when>
	   <c:otherwise>
	 	  content = CKEDITOR.instances.draftContent.getData();
	   	  var dfContent = $("#draftContent");
		   $(dfContent).empty();
		   $(dfContent).text(content);
	   </c:otherwise>
   </c:choose>
   
   
   
   function updateAjax(){
	   	$("#draftForm").ajaxForm({
		      url:"${cPath}/group/esign/draftUpdate.do",
		      data:{draftContent:content},
		      async: true,
		      success: function(res){
		         if(res.result == 'OK'){
		        	$("input[name='draftNo']").val(res.draftNo).change();
			        cAlert("저장이 완료 되었습니다. 창을 닫을까요?","confirm")
		         }else{
		            cAlert(res.result)
		         }
		      }
	  	 }).submit();
	   	return draftNo;
   }
   draftNo = await updateAjax();
   
   return draftNo;
}; // merge Function end

$("#alertResult").on("change", function() {
    if($("#alertResult").val()=="true"){
    	opener.location.reload();
    	window.close();
    }
});


	<c:choose>
	  <c:when test="${ not empty param.chit }">
	     $("#content").html(localStorage.getItem("draftContent"))
	     draftTitle = opener.document.getElementById("draftTitle").value;
	     $("#draftTitle").val(draftTitle);
	  </c:when>
	  <c:otherwise>
		// ckEditor 로딩
      	CKEDITOR.replace("draftContent", {width: '100%', height: '300',});
	  </c:otherwise>
	</c:choose>
	 
		
      // 이름 옆의 - 버튼 누르면 해당 이름 삭제
      $("tbody").on("click",".del",function(){
         $(this).parent().remove();
      });
      // 임시저장 버튼 누르면 merge
      $("#tempSaveBtn").on("click",function(){
    	  mergeDraft()
      });
      // 결재 버튼 누르면 진행 상태 결재중으로 바꾸고 merge
      $("#uploadDraftBtn").on("click",function(){
	     var today = new Date();
	   	 today = today.toISOString().slice(0, 19).replace("T"," ");
         $("input[name='draftProgress']").val("결재중");
         mergeDraft()
   		$("input[name='ahAuthSe']").val("승인");
   		$("input[name='ahAuthTm']").val(today);
      });
      
      var once = true;
      $("input[name='draftNo']").on("change",function(){
	    	if(once && $("input[name='ahAuthSe']").val() != ""){
		    	$("#signForm").ajaxForm({
			  		url:"${cPath}/group/esign/authHistCreate.do",
			  		dataType:'json',
			  		success: function(res){
							console.log(res)
			  		}
		  		}).submit();
		    	once = false;
// 		    	window.close();
	    	}
 	  });
      
      //my 도장/서명 버튼 누르면 팝업띄워주기
      $("#uploadSignBtn").on("click",function(){
         window.open(
         "${cPath}/group/esign/signImage.do",
         "signImage",
         "status=no, resizable=no, menubar=no, toolbar=no, location=no, scrollbars=no ,height= 700px, width=900px, left=500px, top=150px");
      });
      
      
      $("#chitForm>div").on("click",function(){
      // INSERT에서 팝업으로 해당 화면 띄우기
         console.log($(this).data("popup"))
      });

      // 결재상태가 있고 결재상태가 임시저장이 아니면  지워야 할 내용들
      if(("${draft.draftProgress}" != "") && ("${draft.draftProgress}" != '임시저장')){
         $(".del").remove();
         $(".required").remove();
         $("table").css("border","1px solid black").css("border-spacing","0 10px")
         $("table th").css("padding","0 15px").css("border-right","2px solid #777777")
         $("table td").css("padding","0 15px").css("border-right","2px solid #777777")
         $("table td:last-child").css("border-right","")
         $("table td:last-child>span").css("background","white").css("border-radius","5px").css("display","inline-block").css("padding","0 10px")
      }
      
      // VIEW에서 전표 클릭시
      const CHITFORM = $("#chitForm")
      $("#chit").on("click",function(e){
         e.stopPropagation();
         if("${param.command}" == "VIEW"){
            alert("결재 올린 전표를 띄워줄 것.")
         }
         else{
            if(CHITFORM.is(":visible")){
               CHITFORM.slideUp();
            } else {
               CHITFORM.slideDown();
            }
         }
      });
      
      $(document).on("click",function(e){
         if(this != $("#chit")[0] && CHITFORM.is(":visible")){CHITFORM.slideUp();}
      });
      
      
      //검색
      $(".small-search").on("click", function(){
         action = $(this).data("action");
         code = $(this).parents("td").find(".code");
         nm = $(this).parents("td").find(".nm");
         var nWidth = 900;
         var nHeight = 950;
         var curX = window.screenLeft;
         var curY = window.screenTop;
         var curWidth = document.body.clientWidth;
         var curHeight = document.body.clientHeight;
         var nLeft = curX + (curWidth / 2) - (nWidth / 2);
         var nTop = curY + (curHeight / 2) - (nHeight / 2);
         if($(this).data("page") == "lineSearch"){
            nWidth = 1480;
            nHeight = 890;
            nLeft = 1960;
             nTop = 30;
         }
         
         window.name = action;
         popup = window.open(
               "${ cPath }/search/" + action,
               "draftSearchPopup",
               "status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left=" + nLeft + "px, top="+ nTop+"px");
      });// 검색 end
      
   });//$function end
</script>

</body>
</html>