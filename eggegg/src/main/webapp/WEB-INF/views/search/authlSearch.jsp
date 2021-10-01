<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html>
<head>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authMember"/>
</security:authorize>
<meta charset="UTF-8">
<title>EGGEGG | 결재라인리스트</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="${ cPath }/resources/js/common.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/js/fancytree/skin-win8/ui.fancytree.min.css">
<script type="text/javascript" src="${ cPath }/resources/js/fancytree/jquery.fancytree-all-deps.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript"	src="https://cdnjs.cloudflare.com/ajax/libs/jquery.fancytree/2.36.1/jquery.fancytree-all.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/emplSearch.css">
<link rel="stylesheet" href="${ cPath }/resources/css/draftForm.css">
<style>
@charset "UTF-8";

@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap')
	;

* {
	font-family: 'Noto Sans KR', sans-serif;
}
html,body{
	width: 1450px;
    height: 920px;
}
input {
	font-size: 18px;
}

table {
	border-collapse: collapse;
	width: 100%;
}

thead th {
	background: #FCFCFE;
}

td, th {
	font-size: 18px;
	border: 1px solid #EAEAEA;
	padding: 8px;
	height: 35px;
}

tfoot td {
	border: none;
	text-align: center;
}

#pagingArea {
	margin-top: 30px;
}

#title {
	font-size: 20px;
	font-weight: bold;
}

#list-table td:nth-child(1) {
	text-align: center;
	width: 50px;
}

#list-table tbody tr {
	cursor: pointer;
	color: #4472C4;
}

#list-table tbody tr:hover {
	color: #4472C4;
	text-decoration: underline;
}

#bottom {
	width: 97%;
	position: absolute;
	bottom: 10px;
}

button[name=emplUse] {
	width: 120px;
	background: #EAEAEA;
}

.searchImg {
	position: relative;
	width: 25px;
	right: 5px;
	bottom: 5px;
}

.small-search {
	padding-top: 0px;
	width: 35px;
	height: 35px;
	text-align: center;
	vertical-align: middle;
}

#simpleSearch {
	position: absolute;
	right: 15px;
	top: 5px;
}

#searchButton {
	background: #4472C4;
	color: white;
	font-size: 16px;
	border-radius: 3px;
	padding: 2px 10px;
	margin: 2px 10px;
}

#list-table {
	width: 1450px;
	height: 200px;
	overflow: auto;
}

#list-table>table>thead>tr>th, #lineDetail>table>thead>tr>th {
	position: sticky;
	top: 0px;
}

#list-table td:nth-child(2) {
	text-align: center;
}

#list-table td:nth-child(3) {
	padding-left: 20px;
}

#emplList {
	height: 520px;
	width: 330px;
	border: 1px solid #EAEAEA;
	padding: 5px;
	overflow: auto;
}

#searchUI2{
	display: flex;
	justify-content: space-around;
}

input[name='emplNm']{
    height: 31px;
    margin-bottom: 6px;
}

input[value='전체열기']{
	margin-left: 4px;
}

#emplList .resetBtn, #emplList .saveBtn{
	width: 70px;
	font-size : 14px;
}
#emplTree *{
	outline: none;
	border : none;
	font-size: 18px;
}

#listDiv {
	display: flex;
	padding: 5px;
	border: 1px solid #EAEAEA;
	justify-content: space-around;
}

#lineWrapper {
	display: flex;
	flex-direction: column;
	height: 532px;
}

#lineDetail {
	display: inline-block;
	width: 1040px;
	border: 1px solid #EAEAEA;
	height: 150px;
	flex: 2;
	overflow: auto;
	text-align: center;
}

.pxNot50 {
	width: 450px;
}

.px50 {
	width: 50px;
}

#lineDetail2 {
	display: block;
	background-color: #EAEAEA;
	padding: 6px 0;
}

#borderDiv {
	flex: 0.1;
}

#searchUI table {
	position: relative;
	top: 0;
	width: 100%;
	background: none;
}

#searchUI tbody td, #searchUI tbody th {
	border: 1px solid #EAEAEA;
	color: #4472C4;
}

input[type="text"]:disabled {
	background: white;
	color: black;
	border : 1px solid rgb(187, 187, 187);
}

.plusBtn, .minusBtn, .plusLineBtn, .minusLineBtn {
	background: none;
	border: none;
	font-size: 20px;
	font-weight: bold;
	color: #4472C4;
}

.saveBtn {
	cursor: pointer;
	display: inline-block;
	color: white;
	width: 80px;
	height: 36px;
	background: #3A4CA8;
	border-radius: 3px;
	text-align: center;
	font-weight: bolder;
    font-size: 16px;
}


.resetBtn {
	display: inline-block;
	color: black;
	width: 80px;
	height: 36px;
	background: #EAEAEA;
	border-radius: 3px;
	text-align: center;
	font-weight: bolder;
	border: 1.5px solid black;
    font-size: 16px;
}

#closeBtn {
	width: 82px;
}

#ctBtn {
    bottom: 2.7px;
    left: -5px;
}

.searchImg {
	bottom: -1px;
}

.ctInput {
	width: 910px;
	left: -10px;
	position: relative;
}
.hidden{
	display: none;
}
#lineBoxNm{
	border: none;
	width: 100%;
	height: 100%;
	text-align: center;
}
#lineBoxNm:focus{
	outline: none;
}
#searchBtn {
    display: inline-block;
    color: white;
    width: 60px;
    height: 36px;
    background: #3A4CA8;
    border-radius: 3px;
    text-align: center;
    font-weight: bolder;
    position: absolute;
    font-size: 16px;
    right : 0px;
}
#searchInput{
    position: absolute;
    font-size: 18px;
    height: 33px;
    border: 1px solid #919191;
    border-radius: 5px;
    right: 70px;
}
#info{
	color: red;
	font-size: 14px;
	text-align: right;
	height: 1px;
	padding: 0;
}
#emplTree .fancytree-icon{
	display: none;
}
#repDiv{
	border: 1px solid #EAEAEA;
	width: 170px;
    position: absolute;
    left: 155px;
    top: 350px;
    border-radius: 5px;
    background: white;
    display: none;
}
#repDiv td{
    border: none;
    font-size: 14px;
    width: auto;
    height: 10px;
}
.ui-state-hover{
	background: #4472C4;
	color: white;
}
</style>
</head>
<body>
<div id="searchUI">
	<div id="top">
		<span id="title">결재라인리스트</span>
		<div id="simpleSearch">
		<input  id="searchInput" type="text" placeholder="명칭으로 검색" value="${detailSearch.lcbAuthlNm}" name="lcbAuthlNm">
		<input id="searchBtn" type="button" value="검색">
		</div>
		<hr color="#F1F4FF">
	</div>
	<div id="list-table">
		<table>
			<thead>
				<tr>
					<th class="px50"></th>
					<th class="px50"><input type="checkbox" class="checkAll"></th>
					<th class="hidden">라인번호</th>
					<th class="pxNot50">결재라인명</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>+</td><td><input type="checkbox"></td><td>1</td><td>라인명</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<br>
<hr color="#F1F4FF">
<div id="listDiv">
	<div id="emplList">
 		<input class="resetBtn" id="expandBtn" type="button" value="전체열기">
 		<input class="resetBtn" id="collapseBtn" type="button" value="전체접기">
		<div id="emplTree"></div>
		<div id="repDiv">
			<table>
				<tbody>
					
				</tbody>
			</table>			
		</div>
	</div>
	<div id=lineWrapper>
		<div id="lineDetail">
			<table>
				<thead>
					<tr>
						<th class="px50"></th><th class="pxNot50">결재자명</th><th class="pxNot50">직책</th><th data-code="I100" class="pxNot50">결재 방법</th><th class="pxNot50">순번</th>
					</tr>
				</thead>
				<tbody>
					<tr data-emplno="${authMember.emplNo }" class="author">
						<td></td><td>${authMember.emplNm }</td><td>${authMember.position.pstNm }</td><td data-code="I100">일반결재</td><td>1</td>
					</tr>
					<tr class="author">
						<td><button type='button' class='plusBtn' style='cursor:pointer;'>+</button></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td id="info" colspan=5>* 마지막 순번이 최종 결재자 입니다.</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div id=borderDiv></div>
		<div id="lineDetail2">
			<table>
				<tr>
					<th>참조자</th>
					<td colspan="2">
						<input class="ctInput" id="refCode" name="draftType" type="hidden" placeholder="참조자 명" value="${draft.draftType }" disabled>
						<button id="ctBtn" class="small-search" data-action="emplSearch" data-command="ref" type="button">
								<img class="searchImg" src="${ cPath }/resources/images/Search.png">
						</button>
						<input class="ctInput" id="refNm" name="draftType" type="text" placeholder="참조자 명" value="${draft.draftTypeNm }" disabled>
					</td>
				</tr>
				<tr>
					<th>수신자</th>
					<td colspan="2">
						<input class="ctInput" id="recCode" name="draftType" type="hidden" placeholder="수신자코드" value="${draft.draftType }" disabled>
						<button id="ctBtn" class="small-search" data-action="emplSearch" data-command="rec" type="button">
								<img class="searchImg" src="${ cPath }/resources/images/Search.png">
						</button>
						<input class="ctInput" id="recNm" name="draftType" type="text" placeholder="수신자 명" value="${draft.draftTypeNm }" disabled>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
		
<div id="bottom">
	<hr color="#F1F4FF">
	<button type="button" class="saveBtn" id="adapt">적용</button>
	<button type="button" class="resetBtn" onclick="window.location.reload()">재작성</button>
	<button type="button" class="resetBtn" id="del">삭제</button>
	<button type="button" class="resetBtn" id="closeBtn" onclick="window.close()">닫기</button>
</div>
<form id="searchForm">
	<input type="hidden" name="lcbEmpl" value="${authMember.emplNo }">
	<input type="hidden" name="lcbAuthlNm" value="${detailSearch.lcbAuthlNm }">
</form>
<form id="searchForm2">
	<input type="hidden" name="emplNm" value="${detailSearch.emplNm }">
</form>
<form id="updateLineForm">
	<input type="hidden" name="authNos">    
	<input type="hidden" name="authNms"> 
	<input type="hidden" name="authPstNms"> 
	<input type="hidden" name="authorAuthTy">   
	<input type="hidden" name="authTyCodes">   
	<input type="hidden" name="authOrder">  
	<input type="hidden" name="lcbLineNo">     
	<input type="hidden" name="lineNm">
</form>
<form id="deleteForm" action="${cPath }/group/esign/lineBoxDelete.do" method="post">
	<input type="hidden" id="delNms">
	<input type="hidden" name="delCodes" id="delCodes">
</form>
<jsp:include page="/includee/cAlert.jsp"/>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script src="${ cPath }/resources/js/paging.js"></script>
<script>
	$(function(){
		var newLine = false;
		var switchLine = false;
		var lineClick = false;
		var tbody = $("#list-table tbody");
		var authLineTbody =  $("#lineDetail tbody")
		var lcbLineNo = "";
		var lineNm = "";
		const UPDATEFORM = $("#updateLineForm");
		const DELETEFORM = $("#deleteForm")
		var selectedNo = "";
		var selectedNm = "";
		var selectedPstNm = "";
		var selectedType = "";
		var selectedTypeCode = "";
		
		$(".author").droppable({accept:".author",classes: {"ui-droppable-active": "ui-state-active", "ui-droppable-hover": "ui-state-hover"}});
		// 삭제 버튼 누를 때
		$("#del").on("click",function(){
			if($("#delNms").val().length < 1){
				alert("삭제할 라인을 선택해 주세요")
				return false;
			}
			cAlert($("#delNms").val() +'\r\n' + delNm.length + '개의 라인을 삭제하시겠습니까?',"confirm","deleteLineAll")
		});
		
		var repDiv = $("#repDiv tbody");
		// 대표이사 정보 가져오기(repDiv에 담아둠)
		$.ajax({
			url: "${ cPath }/empl/emplFancy.do",
			data: "deptParent=001",
			success : function(res){
				repDiv.empty();
				trTags = [];
				if(res.length > 0){
					$(res).each(function(idx, line){
						trTags.push(
							$("<tr>").append(
								$("<td>").css("display","none"),
								$("<td>").html(line.title),
								$("<td>").html(line.adaptee.position.pstNm),
								$("<td>").css("display","none"),
								$("<td>").css("display","none")
							).attr("data-emplNo",line.adaptee.emplNo).attr("class","author").attr("draggable",true)
							.draggable({
								  containment: false, 
								  scroll: false,
								  cursor: "move",
							      cursorAt: { top: -12, left: -20 },
							      helper: function( event ) {
							        return $( "<div class='ui-widget-header'>"+line.title+"</div>" );
							      }
							})
						);
					});
				} 
				repDiv.append(trTags);
			}
		});
		
		// 적용버튼 누를 때
		$("#adapt").on("click",function(){
			var authNos = [];
			var authNms = [];
			var authPstNms = [];
			var authTyCodes = [];
			var authorAuthTy = [];
			var authOrder = [];
			var	recNm = $("#recNm").val().split(",");
			
			var authList = $("#lineDetail tbody").find("tr")
			$.each(authList,function(i,v){
				if(authList.length-1==i) return false;
				no = $(v).data("emplno");
				nm = $(v).find("td").eq(1).text();
				tyCode = $(v).find("td").eq(3).data("code");
				if(no!="undefined" && nm!=""){
					authNos.push(no)
					authNms.push(nm)
					authTyCodes.push(tyCode)
				}else{
					clickMinusBtn(v)
				}
				if(newLine){
					pst = $(v).find("td").eq(2).text();
					ty = $(v).find("td").eq(3).text();
					tyCode = $(v).find("td").eq(3).data("code");
					order = $(v).find("td").eq(4).text();
					authPstNms.push(pst)  
					authorAuthTy.push(ty)  
					authTyCodes.push(tyCode)
					authOrder.push(order)
				}
			})
			
			if(authNos[0] == undefined){
					cAlert("결재자를 선택해주세요");
					return false;
			}
			if(!newLine&&(recNm==""||recNm==undefined)){
					cAlert("수신자를 선택해주세요");
					return false;
			}

			$(UPDATEFORM).find("input[name='authNos']").val(authNos);  
			$(UPDATEFORM).find("input[name='authNms']").val(authNms);  
			$(UPDATEFORM).find("input[name='authPstNms']").val(authPstNms);  
			$(UPDATEFORM).find("input[name='authTyCodes']").val(authTyCodes);   
			$(UPDATEFORM).find("input[name='authorAuthTy']").val(authorAuthTy);   
			$(UPDATEFORM).find("input[name='authOrder']").val(authOrder);
			$(UPDATEFORM).find("input[name='lcbLineNo']").val(lcbLineNo);
			$(UPDATEFORM).find("input[name='lineNm']").val(lineNm);
			
			// 정보수정이 있을 시
			if(newLine){
				cAlert(lineNm + "의 변경된 내용을 저장하시겠습니까?","confirm","updateLine");
			}else{
				$(FNNAME).val("updateLine");
				$("#alertResult").change();
			} // 정보수정이 있을 시 end
				
		});
		
		
		$("#alertResult").on("change",function(){
			
			// 결재라인 일괄 삭제
			if(($(FNNAME).val()=="deleteLineAll")&&($(this).val()=='true')){
				DELETEFORM.ajaxForm({
					success:function(res){window.location.reload();}
				}).submit();
			}
			
			
			// 결재라인 삭제
			if(($(FNNAME).val()=="deleteLine")&&($(this).val()=='true')){
				DELETEFORM.ajaxForm({
					success:function(res){
						window.location.reload();
					}
				}).submit();
			}
			
			// 결재라인 생성 혹은 수정
			if($(FNNAME).val()=="updateLine"){
				authNos = $(UPDATEFORM).find("input[name='authNos']").val().split(",");  
				authNms = $(UPDATEFORM).find("input[name='authNms']").val().split(",");  
				authPstNms = $(UPDATEFORM).find("input[name='authPstNms']").val().split(",");  
				authTyCodes = $(UPDATEFORM).find("input[name='authTyCodes']").val().split(",");   
				authorAuthTy = $(UPDATEFORM).find("input[name='authorAuthTy']").val().split(",");   
				authOrder = $(UPDATEFORM).find("input[name='authOrder']").val().split(",");
				lineNm = $(UPDATEFORM).find("input[name='lineNm']").val();
				var	refNo = $("#refCode").val().split(",");
				var	refNm = $("#refNm").val().split(",");
				var	recNo = $("#recCode").val().split(",");
				var	recNm = $("#recNm").val().split(",");
	
				// 부모창에 결재자 목록 넣어주기
				$(opener.document.querySelectorAll(".authl")).each(function(){
					$(this).remove();
				})
				$(opener.document.getElementById("lineNm")).val(lineNm).blur();
				var pAuthNos = $(opener.document.getElementById("authNos"));
				
				html = "";
				$.each(authNos,function(i,v){
					if(v == "") return true;
					html += "<span class='authl'>"+authNms[i]+"<button class='del' type='button'>-<input type='hidden' name='authNos' value='" + v + "'><input type='hidden' name='authorAuthTyCode' value='" + authTyCodes[i] + "'></button>"
					+"</span>";
				});
				pAuthNos.append(html);
			
			// 부모창에 참조자 목록 넣어주기
				html = "";
				var pRefCodes = $(opener.document.getElementById("refCode"));  
				$.each(refNo,function(i,v){
					if(v == "") return true;
					html += "<span class='authl'>"+refNm[i]+"<button class='del' type='button'>-<input type='hidden' name='refCode' value='" + v + "'></button></span>"
				});
				pRefCodes.append(html);
	
			// 부모창에 수신자 목록 넣어주기
				html = "";
				var pRecCodes = $(opener.document.getElementById("recCode"));
				$.each(recNo,function(i,v){
					if(v == "") return true;
					html += "<span class='authl'>"+recNm[i]+"<button class='del' type='button'>-<input type='hidden' name='recCode' value='" + v + "'></button></span>"
				});
				pRecCodes.append(html);
				
				// 수정하겠다고 눌렀을 시
				if($(this).val()=='true'){
					$("#updateLineForm").ajaxForm({
	 					url:"${cPath}/esign/updateLine.do",
	 					method:"post",
	 					success: function(res){
	 						window.location.reload();
	 					},
	 					error: function(xhr){
	 						console.log(xhr.status);
	 						alert("저장이 실패하였습니다. 개발자에게 문의해주세요.")
	 					}
	 				}).submit();
				}else{
					window.close();
				}// 수정 끝
				
			}//updateLine_fn end
				
		}); // alertResult click event end
		
		
		// 새로운 라인 등록 시
		$(tbody).on("focusout","#lineBoxNm",function(){
			newLine = (!isEmpty($(this).val()));
			if(newLine){
				lcbLineNo = null;
				lineNm = $(this).val();
			}
		});
		
		
		//라인 명 클릭시
		$(tbody).on("click", ".emplSelect", function(){
			lcbLineNo = $(this).parent().attr("code");
			$(UPDATEFORM).find("input[name='lcbLineNo']").val(lcbLineNo);
			lineNm = $(this).text();
			newLine = false;
			lineClick = true;
			$.ajax({
				data : "lcbLineNo="+$(this).parent().attr("code"),
				dataType : "json",
				success : function(res) {
					authLineTbody.empty();
					let lineList = res.auths;
					let trTags = [];
					if(lineList.length > 0){
						$(lineList).each(function(idx, line){
						var buttonTd = "";
							trTags.push(
								$("<tr>").append(
									$("<td>").append("<button type='button' class='minusBtn' style='cursor:pointer;'>-</button>"),
									$("<td>").html(line.authorNm),
									$("<td>").html(line.pstNm),
									$("<td>").html(line.authorAuthTy).attr("data-code",line.authorAuthTyCode),
									$("<td>").html(line.authorOrder)
								).attr("data-emplNo",line.authorId).attr("class","author ui-draggable ui-draggable-handle ui-droppable")
							);
						});
							trTags.push(
								$("<tr>").append(
									$("<td>").append("<button type='button' class='plusBtn' style='cursor:pointer;'>+</button>"),
									$("<td>"),$("<td>"),$("<td>"),$("<td>")
								).attr("class","author").droppable({
									accept: ".author"
									,classes: {"ui-droppable-active": "ui-state-active", "ui-droppable-hover": "ui-state-hover"}
								})
							);
					} else {
						trTags.push(
							$("<tr>").append(
								$("<td>").attr("colspan", "4").html("등록한 결재라인이 없습니다.").css("color", "black").css("text-decoration","none")
							)
						);
					}
					authLineTbody.append(trTags);
					authLineTbody.find("tr:first-child").find("td:first-child").empty();
				}
			});
		});

		// 결재자 추가
		authLineTbody.on("click",".plusBtn",function(){
			clickPlusBtn(this);
		});
		
		function clickPlusBtn(td){
			$(td).html("<button type='button' class='minusBtn'>-</button>");

			$(authLineTbody).find("tr").each(function(i,v){
				$(this).find("td:last-child").empty().text(i+1);
			})
			
			authLineTbody.append(
					$("<tr>").append(
						$("<td>").append("<button type='button' class='plusBtn' style='cursor:pointer;'>+</button>"),
						$("<td>"),
						$("<td>"),
						$("<td>"),		
						$("<td>")		
					).attr("class","author").droppable({
						accept: ".author",
						classes: {"ui-droppable-active": "ui-state-active", "ui-droppable-hover": "ui-state-hover"}
					})
			)
		}
		
		// 결재자 삭제
		authLineTbody.on("click",".minusBtn",function(){
			clickMinusBtn(this)
		});
		function clickMinusBtn(td){
			trList = $(td).parents("tbody").find("tr");
			selected = $(td).parents("tr").attr("data-selected","true");
			selected.remove();
			var order = 1;
			$.each(trList,function(i,v){
				if($(v).data("selected")) {
					return true;
				}else if(i==trList.length-1){
					return true;
				}else{
					$(v).children().last().html(order)
					order++;
					}
			});
		}
		
		// 즐겨찾기 라인 삭제
		tbody.on("click",".minusLineBtn",function(){
			lineNm = $(this).parents("tr").find("td").eq(2).text();
			$("#delCodes").val($(this).parents("tr").attr("code"))
			cAlert("라인명 : " + lineNm + "\r\n라인을 삭제하시겠습니까?","confirm","deleteLine");
		});
		
		// 즐겨찾기 라인 추가
		tbody.on("click",".plusLineBtn",function(){
			$(this).parents("tbody").append(
				$("<tr>").append(
						$("<td>"),
						$("<td>").append("<input class='checkbox' type='checkbox'>"),
						$("<td>").append($("<input type='text' id='lineBoxNm' name='lcbAuthlNm' placeholder='결재라인명 입력' autocomplete='off'>"))
						.append("<input type='hidden' name='lcbLineNo'>")
						.append("<input type='hidden' name='lcbEmpl' value='${authMember.emplNo }'")
				)
			);
			$(this).parents("tr").remove();
			
		});
		
		// 체크박스 클릭시 딜리트 데이터에 데이터 쌓기
		$(document).on("click", ".checkbox",function(){
			delNm = [];
			code = [];
			$(document).find(".checkbox").each(function(i){
				if($(this).is(":checked")){
					delNm.push($(this).parents("tr").find("td:last-child").text());
					code.push($(this).parents("tr").attr("code"));
				}
			});
			$("#delNms").val(delNm)
			$("#delCodes").val(code)
		});
		
		//검색 버튼
		$(".small-search").on("click", function(){
			action = $(this).data("action");
			code = $(this).parents("td").find(".code");
			nm = $(this).parents("td").find(".nm");
			data = $(this).data("command")
			var nWidth = 900;
			var nHeight = 950;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name = action;
			popup = window.open(
					"${ cPath }/search/" + action + ".do?command="+data,
					"searchTable",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				code.val($("#code").val());
				nm.val($("#nm").val());
			});
		});
		
		// 즐겨찾기 라인 검색 및 리스트 뿌리기
		$("#searchForm").paging({
				searchUI : "#searchUI",
				btnSelector : "#searchBtn"
			}).ajaxForm({
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				let lineList = pagingVO.dataList;
				let trTags = [];
				if(lineList.length > 0){
					$(lineList).each(function(idx, line){
							trTags.push(
								$("<tr>").append(
									$("<td>").append("<button type='button' class='minusLineBtn' style='cursor:pointer;'>-</button>"),
									$("<td>").append("<input class='checkbox' type='checkbox'>"),
									$("<td class='emplSelect'>").html(line.lcbAuthlNm)
								).attr("code", line.lcbLineNo)
							)
						});
						trTags.push(
							$("<tr>").append(
								$("<td>").append("<button type='button' class='plusLineBtn' style='cursor:pointer;'>+</button>").attr("colspan", "4")
							).attr("id","noUnderLine")
						)
				} else {
					trTags.push(
						$("<tr>").append(
							$("<td>").append("<button type='button' class='plusLineBtn' style='cursor:pointer;'>+</button>"),
							$("<td>").attr("colspan", "4").html("등록한 결재라인이 없습니다.").css("color", "black")
						).attr("id","noUnderLine")
					);
				}
				tbody.append(trTags);
			}
		}).submit();
		
		// 결재라인 없을 때
		$("#list-table").on("mouseover","#noUnderLine",function(){
			$(this).css("text-decoration","none").css("cursor","default");
		})
		
		//체크박스 올
		$('.checkAll').on('click',function(){
			ck = $(this).prop('checked');
			$(this).parents('table').find('.checkbox').prop('checked', ck);
		});
		
		$(tbody).on("change",".checkbox",function(){
			allbox = $(".checkbox").length; 
			//전체선택 체크박스 제외 체크된박스 개수 구하기
			checkAll = $(".checkAll")
			cnt = $(".checkbox:checked").length;
			//체크박스가 다 체크될 경우 전체선택체크박스도 체크
			if(cnt == allbox){
				checkAll.prop('checked',true);
			}else{
				checkAll.prop('checked',false);
			}
		});
		
		// 조직도 팬시트리
		$("#emplTree").fancytree({
			autoCollapse: false,
			autoExpand: true,
			extensions: ["dnd5"],
			source:{
				url: "${ cPath }/empl/deptFancy.do",
				cache: true,
				expanded: true
			},
			lazyLoad: function(event, data){
				var node = data.node;
				if((node.title.indexOf("(") > 0)&&(node.title.indexOf("대표이사") != 0)){
					data.result = {
						url: "${ cPath }/empl/emplFancy.do",
						data: {deptParent: node.key, forAuthl: true},
						cache: false,
						expanded: true
					};
				}else{
					data.result = {
						url: "${ cPath }/empl/deptFancy.do",
						data: {deptParent: node.key, forAuthl: true},
						cache: false,
						expanded: true
					};
				}
			},
	      	 dnd5: {
	 	        autoExpandMS: 400,
	 	        focusOnClick: true,
	 	        preventVoidMoves: true, // Prevent dropping nodes 'before self', etc.
	 	        preventRecursion: true, // Prevent dropping nodes on own descendants
	 	        dragStart: function(node, data) {
	 	        	selectedNo=node.key	
	 	        	selectedNm=node.title.substring(0,node.title.indexOf("("))
	 	        	switchLine = false;
	 	        	 if(data.node.isFolder()) return false;
	 	          		return true;
	 	        }
	       }
	       ,click : function(e, data){
	    	   e.stopPropagation();
	    	   if(data.node.key == "001"){
		    	  	$("#repDiv").slideDown();
	    	   }else{
					$("#repDiv").slideUp();
	    	   }
	       }
	       ,init : function(){
	    	   $.ui.fancytree.getTree("#emplTree").expandAll();
	       }
		});
		// 전체 접기 버튼
		$("#collapseBtn").on("click",function(){
			$.ui.fancytree.getTree("#emplTree").expandAll(false);
		});
		
		// 전체 열기 버튼
		$("#expandBtn").on("click",function(){
			$.ui.fancytree.getTree("#emplTree").expandAll();
		});

		// 결재자 정보 dnd
		var selectedTr;
		var changedTr;
		
		// 대표이사 정보 dnd
		$("#repDiv").on("dragstart",".author",function(e){
			selectedTr = this;
			selectedNo = $(selectedTr).data("emplno");
	        selectedNm = $(selectedTr).find("td:nth-child(2)").text();
	        selectedNm = selectedNm.substring(0,selectedNm.indexOf("("));
			selectedPstNm = $(selectedTr).find("td:nth-child(3)").text();
			selectedType = "일반결재";
			selectedTypeCode = "I100";
		});

		
		$("#repDiv .author").draggable({
			  cursor: "move",
		      cursorAt: { top: -10, left: -20 },
		      helper: function( event ) {
		    	  selectedNo = $(this).data("emplno");
		        return $( "<div class='ui-widget-header'>"+$(this).find("td:nth-child(2)").text()+"("+$(this).data("emplno")+")</div>" );
		      }
	    });
		
		$("#lineDetail").on("dragstart",".author",function(e){
			selectedTr = this;
			switchLine = true;
			matched = true;
			
			selectedNo = $(this).data("emplno");
	        selectedNm = $(this).find("td:nth-child(2)").text();
			selectedPstNm = $(this).find("td:nth-child(3)").text();
			selectedType = $(this).find("td:nth-child(4)").text();
			selectedTypeCode = $(this).find("td:nth-child(4)").data("code");
			
			if(selectedNo == "${authMember.emplNo }"){
				$("#searchUI").css("cursor","default")
				$("#listDiv").css("cursor","default")
				$("#bottom").css("cursor","default")
				$("#preventClickDiv").css("cursor","default")
				$("body").css("cursor","default")
				cAlert("본인은 결재선에서 변경할 수 없습니다.");
				return false;
			}
			if($(selectedTr).find("td:first-child").text() == "+"){
				$("#searchUI").css("cursor","default")
				$("#listDiv").css("cursor","default")
				$("#bottom").css("cursor","default")
				$("#preventClickDiv").css("cursor","default")
				$("body").css("cursor","default")
				return false;
			}
			
		}).on("dragenter",".author", function(e){
	        e.preventDefault();
	        e.stopPropagation();
	    }).on("dragover",".author", function(e){
	        e.preventDefault();
	        $(this).css("background-color", "#4472C4").css("color","white");
	        e.stopPropagation();
	    }).on("dragleave",".author", function(e){
	        e.preventDefault();
	        $(this).css("background-color", "").css("color","");
	        e.stopPropagation();
	    }).on("drop",".author", function(e){
	        e.preventDefault();
	        $("#repDiv").slideUp();
	        if(lineClick){
	        	newLine = true;
	        }
	        console.log("selectedTr : ",selectedTr)
	        
			changedTr = this;
			changedNo = $(this).data("emplno");
			changedNm = $(this).find("td:nth-child(2)").text();
			console.log("changedTr :", changedTr)
	        
			if(changedNo == "${authMember.emplNo }"){
				$("#searchUI").css("cursor","default")
				$("#listDiv").css("cursor","default")
				$("#bottom").css("cursor","default")
				$("#preventClickDiv").css("cursor","default")
				$("body").css("cursor","default")
				cAlert("본인은 결재선에서 변경할 수 없습니다.");
				switchLine = false;
				return false;
			}
			
	        $(changedTr).css("background-color", "").css("color","").draggable({
				  cursor: "move",
			      cursorAt: { top: -10, left: -20 },
			      helper: function( event ) {
			    	  selectedNo = $(this).data("emplno");
			        return $( "<div class='ui-widget-header'>"+$(this).find("td:nth-child(2)").text()+"("+$(this).data("emplno")+")</div>" );
			      }
			    }).droppable({
			        accept: ".author",
			        classes: {
			          "ui-droppable-active": "ui-state-active",
			          "ui-droppable-hover": "ui-state-hover"
			        }
			      });

	        currentId = $(authLineTbody).find("tr");
	        // 자리바꾸기 아니면 기존에 등록되어 있는 결재자인지 확인한다.
	        if(!switchLine){
		        $.each(currentId,function(i,v){
		        	matched = ($(v).data("emplno") == selectedNo)
		        	if(matched) {
			        	cAlert("이미 결재선에 등록된 결재자입니다.")
			        	return false;
		        	}
		        });
		        if(matched){
		        	matched = false;
		        	return false;
		        }
	        }
	        
	        changedNo        = $(changedTr).data("emplno")        
	        changedNm        = $(changedTr).find("td:nth-child(2)").text()       
	        changedPstNm     = $(changedTr).find("td:nth-child(3)").text()  
	        changedTypeCode  = $(changedTr).find("td:nth-child(4)").data("code") 
	        changedType      = $(changedTr).find("td:nth-child(4)").text()       
	        
	        // 가져다 놓으면 +버튼을 누르는 함수를 실행한다.
       			thisTd = $(changedTr).find("td:first-child");
	        	if(thisTd.text() == "+"){clickPlusBtn(thisTd);}
	        	
	        	if(switchLine){
		       		$(changedTr).removeData("emplno").attr("data-emplno",selectedNo)
	        		$(changedTr).find("td:nth-child(2)").empty().text(selectedNm);
	        		$(changedTr).find("td:nth-child(3)").empty().text(selectedPstNm);
	        		$(changedTr).find("td:nth-child(4)").attr("data-code",selectedTypeCode);
	        		$(changedTr).find("td:nth-child(4)").empty().text(selectedType);
	        		
	        		$(selectedTr).removeData("emplno").attr("data-emplno",changedNo)
		       		$(selectedTr).find("td:nth-child(2)").empty().text(changedNm);
		       		$(selectedTr).find("td:nth-child(3)").empty().text(changedPstNm);
		       		$(selectedTr).find("td:nth-child(4)").attr("data-code",changedTypeCode);
		       		$(selectedTr).find("td:nth-child(4)").empty().text(changedType);

	        	}else{
	        		$.ajax({
			        	url:"${cPath}/group/esign/selectAuth.do",
			        	method:"post",
			        	data:{emplNo:selectedNo},
			        	success:function(res){
			        		$(changedTr).removeData("emplno").attr("data-emplNo",res.authorId)
			        		$(changedTr).find("td:nth-child(2)").empty().text(res.authorNm);
			        		$(changedTr).find("td:nth-child(3)").empty().text(res.pstNm);
			        		$(changedTr).find("td:nth-child(4)").attr("data-code",selectedTypeCode==""?"I100":selectedTypeCode);
			        		$(changedTr).find("td:nth-child(4)").empty().text(selectedType==""?"일반결재":selectedType);
			        	}
			        });
	        	}
	        console.log("==================================================")
	        e.stopPropagation();
	    })
		
		
	}); //$function end
</script>
</body>
</html>