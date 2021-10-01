<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<security:authorize access="isFullyAuthenticated()">
   <security:authentication property="principal.adaptee" var="authEmpl"/>
</security:authorize>
<link rel="stylesheet" href="${ cPath }/resources/css/list.css">
<style>
table {
	border-collapse: collapse;
	width: 90%;
}
thead th {
	background: #FCFCFE;
}

#list-table {
	margin: 10px;
	height: 670px;
	overflow: auto;
}
th{
	text-align: center;
}
td, th {
	border: 1px solid #EAEAEA;
	padding: 5px 10px;
	height: 30px;
}

td:nth-child(3){
	text-align: left;
	width: 420px;
}
td{
	text-align: center;
}

.sort {
	font-size: 0.5em;
	vertical-align: 0.3em;
}

.searchImg {
	position: relative;
    width: 23px;
    right: 5px;
    margin: 0px;
    padding: 0px;
    z-index: 1;
    bottom: 3px;
}

.small-search {
	position: relative;
	display: inline;
	width: 32px;
	height: 32px;
	text-align: center;
	vertical-align: middle;
	z-index: 1;
	bottom: 1px;
	left: 4px;
}

#searchUI {
	position: absolute;
	top: 155px;
}

#searchUI table {
	background: #FCFCFE;
	width: 100%;
}

#searchUI tbody td, #searchUI tbody th {
	border: none;
	padding: 5px 10px;
}

#searchUI tfoot td {
	border: none;
	background: white;
}

#list-table tfoot td {
	border: none;
	text-align: center;
}

#bottom {
	position: relative;
	bottom: 30px;
}

.draftUpdate {
	cursor: pointer;
	color: #4472C4;
}

.draftUpdate:hover {
	color: #4472C4;
	text-decoration: underline;
}

#title {
	margin: 10px;
	font-weight: bold;
}

hr {
	margin: 5px 0px;
}

#searchUI tfoot td {
	text-align: inherit;
}
#newBtn, #searchBtn {
    background: #3A4CA8;
	color: white;
	border-radius: 3px;
	padding: 1px 10px;
	margin: 2px 0px 2px 10px;
	font-weight: normal;
}
.withImg {
    width: 327px;
    margin-left: 0px;
    position: relative;
    padding-left: 0px;
    z-index: 0;
    height: 32.64px;
	left: -4px;
}

.withoutImg {
	width: 360px;
}

.selectListBtn, .selectedListBtn{
    background: #EAEAEA;
	border-color : #929292;
	border-width : 1px;
	color: black;
	border-radius: 20px;
	padding: 3px 10px;
	cursor: pointer;
	width: 90px;
}
#bottom{
	position: fixed;
	bottom: 75px;
}
.selectedListBtn{
	background: #3a4ca8;
	border: 1px solid black;
    box-shadow: 1.6px 1.6px 2px 0.3px black;
	color: white;
}
#selectNav{
	position:relative;
	left: 30px;
	margin-top: 10px; 
}
#uploadSignBtn{
	font-weight: normal;
}
.searchImg {
	position: relative;
    width: 25px;
    right: 3px;
    top: -1px;
    margin: 0px;
    padding: 0px;
    z-index: 1;
}
.small-search {
    position: relative;
    display: inline;
    left:1px;
    width: 33px;
    height: 33px;
    text-align: center;
    vertical-align: middle;
    z-index: 1;
    bottom: 3px;
    border: 1px solid black;
    border-radius: 2px;
}
</style>
</head>
<body>
	<div id="top">
		&ensp;&ensp;&ensp;
		<c:choose>
		<c:when test="${not empty param.ownerId }">
			<span id="title"><spring:message code="MyDraft"/></span> 
		</c:when>
		<c:otherwise>
			<span id="title">기안서 통합관리</span> 
		</c:otherwise>
		</c:choose>
		<button id="searchButton" type="button"><spring:message code="searchBtn"/></button>
	</div>
	<hr color="#F1F4FF">
	<div id="selectNav">
		<c:choose>
		<c:when test="${not empty param.ownerId }">
			<button class="selectedListBtn" type="button" data-searchword="전체" id="firstSelect"><spring:message code="whole"/></button>
			<button class="selectListBtn" type="button" data-searchword="임시저장"><spring:message code="temp"/></button>
		</c:when>
		<c:otherwise>
			<button class="selectedListBtn" type="button" data-searchword="전체" id="firstSelect"><spring:message code="whole"/></button>
		</c:otherwise>
		</c:choose>
		<button class="selectListBtn" type="button" data-searchword="결재중"><spring:message code="onProcess"/></button>
		<button class="selectListBtn" type="button" data-searchword="반려"><spring:message code="Returned"/></button>
		<button class="selectListBtn" type="button" data-searchword="결재완료"><spring:message code="completion"/></button>
	</div>
	<table id="list-table">
		<thead>
			<tr>
				<th><input type="checkbox" class="checkAll"></th>
				<th><spring:message code="timeForDraft"/></th>
				<th><spring:message code="title"/></th>
				<th><spring:message code="class"/></th>
				<th><spring:message code="writer"/></th>
				<th><spring:message code="next"/></th>
				<th><spring:message code="process"/></th>
				<th><spring:message code="check"/> </th>
				<th><spring:message code="view"/></th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="12">
					<div id="pagingArea"></div>
				</td>
			</tr>
		</tfoot>
	</table>
	<div id="searchUI">
		<form>
			<table>
				<tbody>
					<tr>
						<th>기준일자</th>
						<td>
						<span class="dateForm"> 
							<input name="simpleSearch.startDate" type="date"> ~ <input name="simpleSearch.endDate" type="date">
						</span>
						</td>
					</tr>
					<tr>
						<th>기안서No.</th>
						<td>
							<input class="withoutImg" name="draftNo" type="text" placeholder="기안서No.">
						</td>
					</tr>
					<tr>
						<th>구분</th>
						<td>
							<button class="small-search" data-action="commonTableSearch.do?typePrefix=F" type="button">
								<img class="searchImg" src="${ cPath }/resources/images/Search.png">
							</button>
							<input class="withImg" id="ctCode" name="draftType" type="hidden">
							<input class="withImg" id="ctNm" type="text" placeholder="구분">
						</td>
					</tr>
					<tr>
						<th>기안자</th>
						<td>
							<button class="small-search" data-action="emplSearch.do" type="button">
								<img class="searchImg" src="${ cPath }/resources/images/Search.png">
							</button>
						 	<input class="withImg" id="nm" name="writer.emplNm" type="text" placeholder="기안자">
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input class="withoutImg" type="text" name="draftTitle" placeholder="제목"></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2">
							<input type="button" id="searchBtn"	value="검색">
							<input type="reset" value="다시 작성">
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
	<div id="bottom">
		<hr color="#F1F4FF">
		<button type="button" class="saveBtn" data-action="draftForm.do?command=INSERT&formNo=0" id="newBtn"><spring:message code="newBtn"/></button>
		<button type="button" class="resetBtn" id="uploadSignBtn"><spring:message code="signImage"/></button>
	</div>
	<form id="searchForm" hidden>
		<input type="text" name="page"> 
		<input type="text" name="simpleSearch.startDate" value="${pagingVO.simpleSearch.startDate }"> 
		<input type="text" name="simpleSearch.endDate" value="${pagingVO.simpleSearch.endDate }"> 
		<input type="text" name="simpleSearch.SearchType" value="전체"> 
		<input type="text" name="simpleSearch.SearchWord" value="${param.ownerId}"> 
		<input type="text" name="draftNo" value="${ pagingVO.detailSearch.draftNo }"> 
		<br>
		<input type="text" name="draftType" value="${pagingVO.detailSearch.draftType }">
		<input type="text" name="writer.emplNm" value="${pagingVO.detailSearch.writer.emplNm }">
		<input type="text" name="draftTitle" value="${pagingVO.detailSearch.draftTitle }">
	</form>
	<input type="hidden" id="nm">
	<input type="hidden" id="code">
	<script src="${ cPath }/resources/js/paging.js"></script>
	<script src="${ cPath }/resources/js/jquery.form.min.js"></script> 
	<script>
	$(function(){
		// 검색에서 구분 텍스트 삭제시 code도 삭제
		$("#ctNm").on("keyup",function(){
			if($(this).val()==""){
				$("#ctCode").val("")
			}
		})
		
		// 신규버튼 클릭 시 상세로 들어감.
		$(document).on("click",".saveBtn",function(){
			action=$(this).data("action");
			window.name = action;
			window.open(
				"${ cPath }/group/esign/" + action,
				"draftDetail",
				"status=no, resizable=no, menubar=no, toolbar=no, location=no, scrollbars=no, height= 900px, width=1130px, left=500px, top=30px");
		});
		
		
		// 리스트 상태에 따른 조건 버튼
		$("#selectNav").on("click",".selectListBtn",function(){
			$(".selectedListBtn").attr("class","selectListBtn");
			$(this).attr("class","selectedListBtn");
			data = $(this).data("searchword");
			$("#searchForm>input[name='simpleSearch.SearchType']").val(data)
			$("#searchForm").submit();
		});
		
		
		//도장버튼 누르면 창 띄워주기
	    $("#uploadSignBtn").on("click",function(){
	       window.open(
	       "${cPath}/group/esign/signImage.do",
	       "taxFree",
	       "status=no, resizable=no, menubar=no, toolbar=no, location=no, scrollbars=no ,height= 700px, width=900px, left=500px, top=150px");
	    });
		
		//검색 버튼
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
			window.name = action;
			popup = window.open(
					"${ cPath }/search/" + action,
					"searchTable",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				code.val($("#code").val());
				nm.val($("#nm").val());
			});
		});
		
		//리스트
		let tbody = $("#list-table tbody");
		let pagingArea = $("#pagingArea");
		let searchForm = $("#searchForm").paging().ajaxForm({
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				pagingArea.empty();
				let draftList = pagingVO.dataList;
				let trTags = [];
				if(draftList.length > 0){
					$(draftList).each(function(idx, draft){
						if(draft.draftProgress == "반려" || draft.draftProgress == "결재완료"){
							draft.nextAuthor = "-";
						}
							var tr = $("<tr>").append(
									$("<td>").append($("<input class='checkbox'>").attr("type", "checkbox")),
									$("<td>").html(draft.draftDate.substring(0,draft.draftDate.length-2)),
									$("<td>").html(draft.draftTitle),
									$("<td>").html(draft.draftTypeNm),
									$("<td>").html(draft.writer.emplNm),
									$("<td>").html(draft.nextAuthor),
									$("<td>").html(draft.draftProgress),
									$("<td>").append($("<a class='draftUpdate' data-action='draftSignForm.do?draftNo="+draft.draftNo+"&command=SIGN'>").html("보기")),
// 									$("<td>").append($("<a>").html("복사")),
									$("<td>").append($("<a class='draftUpdate' data-action='draftForm.do?formNo="+draft.draftNo+"&command=VIEW'>").html("조회")),
// 									$("<td>").html("연결전표")
								).data("draftNo",draft.draftNo)
							if(draft.draftProgress != "임시저장" && draft.nextAuthor != "-" && draft.nextAuthorId == "${authEmpl.emplNo}"){
								tr.css("font-weight","bolder");								
							}
							trTags.push(tr);
						idxs = idx;
					});
					while(idxs < 15){
						trTags.push(
							$("<tr>").append(
								$("<td>").attr("colspan", "12").css("border", "none")
							).attr("data-innertd","0")
						);
						idxs += 1;
					}
					pagingArea.html(pagingVO.pagingHTML);
				} else {
					trTags.push(
						$("<tr>").html(
							$("<td>").attr("colspan", "12").html("해당하는 결재문서가 없습니다.")	
						).attr("data-innertd","0")
					);
				}
				tbody.append(trTags);
				
			}   
		}).submit();
		
		//tr 클릭하면 배경 색 변경
		$(tbody).on("click","tr",function(){
			if($(this).data("innertd") == 0) return false;
			$(tbody).find("tr").css("background","none");
			$(this).css("background","#ffffd7");
		});
		
		//검색창 slide
		let searchUI = $("#searchUI").hide();
		$("#searchButton").on("click", function(){
			if(searchUI.is(":visible")){
				searchUI.slideUp();
			} else {
				searchUI.slideDown();
			}
		});
		
		today = new Date();
		startDate = new Date(today.getFullYear(), today.getMonth(), 2);
		today = today.toISOString().slice(0, 10);
		startDate = startDate.toISOString().slice(0, 10);
		
		//검색 버튼 클릭 시 검색창 닫음
		$("#searchBtn").on("click", function(){
			emplTenureAtt = $("input[name=emplTenureAtt]:checked").val();
			$("#searchForm input[name=tenureAtt]").val(emplTenureAtt);
			searchUI.slideUp();
			
		});
		//체크박스 클릭
		$('.checkAll').on('click',function(){
			ck = $(this).prop('checked');
			$(this).parents('table').find('.checkbox').prop('checked', ck);
		});
		$(tbody).on("change",".checkbox",function(){
			allbox = $("input:checkbox").length-1; 
			//전체선택 체크박스 제외 체크된박스 개수 구하기
			cnt = $("#cb input[type=checkbox]:checked").length;
			//체크박스가 다 체크될 경우 전체선택체크박스도 체크
			if(cnt == allbox){
				$(".checkAll").prop('checked',true);
			}else{
				$(".checkAll").prop('checked',false);
			}
		});
	});
	$(document).on("click",".draftUpdate",function(){
		action=$(this).data("action");
		window.name = action;
		window.open(
			"${ cPath }/group/esign/" + action,
			"draftDetail",
			"status=no, resizable=no, menubar=no, toolbar=no, location=no, scrollbars=no, height= 950px, width=1100px, left=400px, top=30px");
	})
</script>
</body>
