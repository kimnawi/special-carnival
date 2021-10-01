<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script src="${ cPath }/resources/js/html2canvas.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/list.css">
<style>
html,body{
	height: auto;
}
#draftFormList{
    display: grid;
    grid-template-columns: 400px 400px 400px;
    gap: 0 50px;
    width: 1400px;
    height: 670px;
    overflow: auto;
    justify-content: center;
}
#title {
	margin: 10px;
	font-weight: bold;
}
#bottom{
    position: relative;
    bottom: 30px;
}
#pagingArea{
	text-align: center;
	height: 28px;
}
#searchUI{
	text-align: right;
	padding-right: 240px;
}
.item div *{
	transform-origin: top left;
}
.item div table{
	width: 100%;
}
.item{
	height: 285px;
	text-align: center;
	overflow:auto;
	border : 1px solid #EAEAEA;
}

.item::-webkit-scrollbar {
    display: none; 
}
.item canvas{
	margin: 0 12%;
}
tbody th, td{
	width: 50px;
}
.item>span{
	font-size: 25px;
	text-decoration: underline;
	text-underline-position: under;
	color: #3a4ca8
}
.resetBtn{
	width: 90px;
	height: 33px;
	font-weight: normal;
	
}
.cForm{
	display: inline-block;
    position: relative;
    bottom: 11px;
    font-size: 14px;
}
canvas{
	transform: scale(0.3);
}
#newBtn, #searchBtn {
    background: #3A4CA8;
	color: white;
	border-radius: 3px;
	padding: 1px 10px;
	margin: 2px 0px 2px 10px;
	font-weight: normal;
}
#title{
    margin: 10px;
    font-weight: bold;
}
hr {
    margin: 5px 0px;
    width: 100%;
}
.capture table{
	margin: 0 auto;
}
#bottom{
	position: fixed;
	bottom: 75px;
}
#pagingArea{
	width: 80%;
}
</style>
</head>
<body>
	<div id="top">
		&ensp;&ensp;&ensp;
		<span id="title">
		<c:choose>
			<c:when test="${param.command eq 'UPDATE'}">
				결재 양식 목록
			</c:when>
			<c:otherwise>
				기안 양식 선택
			</c:otherwise>
		</c:choose>
		</span>
		<hr color="#F1F4FF">
	</div>
	<div id="searchUI">
		 <input type="text" name="dfTitle" placeholder="양식명으로 검색" id="searchInput"> 
		 <button type="button" id="searchBtn">검색</button>
	</div>
	<br>
		<form id="deleteForm">
			<div id="draftFormList">
				<div class="item" id="item1"></div>
				<div class="item" id="item2"></div>
				<div class="item" id="item3"></div>
				<div class="item" id="item4"></div>
				<div class="item" id="item5"></div>
				<div class="item" id="item6"></div>
			</div>
		</form>		
	<br>
	<form id="searchForm" hidden>
		<input type="hidden" name="page">
		<input type="hidden" name="dfTitle" value="${detailSearch.dfTitle }">
	</form>
	<div id="pagingArea"></div>
	<div id="bottom">
		<hr color="#F1F4FF">
		<button type="button" class="${param.command }" data-action="draftForm.do?command=${param.command }&formNo=0" id="newBtn">신규</button>
		<c:if test="${param.command eq 'UPDATE' }">
			<button type="button" class="resetBtn" id="deleteBtn">일괄삭제</button>
		</c:if>
	</div>
	<script>
	//리스트
command = "${param.command}"
function reload (){
	var itemList = $(".item");
	let tbody = $("#list-table tbody");
	let pagingArea = $("#pagingArea");
	let searchForm = $("#searchForm");
	searchForm.paging().ajaxForm({
		url: "${cPath}/group/esign/draftFormList.do",
		dataType: "json",
		success: function(pagingVO){
			$.each(itemList,function(i,v){
				$(v).empty();
			});
			pagingArea.empty();
			let draftFormList = pagingVO.dataList;
			if(draftFormList.length > 0){
				$(draftFormList).each(function(idx, draftForm){
					var formNo = draftForm.dfNo;
					var draftTitle = draftForm.dfTitle;
					var draftContent = draftForm.dfContent;
					var item = itemList[idx];
					var cForm = (draftForm.emplNo == '9999999')?"<br><span class=cForm>[공통양식]</span>":"";
					
					$(item).empty()
					.append(
						$("<span class='title'>").html(draftTitle+cForm)
						.attr("class",command).attr("data-action","draftForm.do?command="+command+"&formNo="+formNo)
						.css("cursor","pointer")
					)
					.append(
						$("<div>").attr("class",draftForm.dfUse)
						.css("overflow","hidden").css("height","auto"));
					if(command == 'UPDATE')	{$(item).prepend($("<input type='checkbox' name='deleteDfNo' value='"+formNo+"'>").css("transform","scale(1.7) translate(-10px, 0px)"))};
					
					$("main").append($("<div class='capture'>").html(draftContent).css("width","1000px").css("position","relative").css("left","2000px").css("bottom","800px").css("white-space","nowrap"));
				 });
				draw();
				pagingArea.html(pagingVO.pagingHTML);
			} else {
				$("#draftFormList").empty().html("등록된 양식이 없습니다.").css("text-align","center");
			}
		}
	}).submit();
	
	return "ok";
}
		reload();
		function draw(){
			captureList = $(".capture");
			html2canvas(captureList[0],{
				scale : 0.5
			}).then(canvas=>{
				$("#item1>div").empty().html(canvas);
				captureList[0].remove();
			});
			html2canvas(captureList[1]).then(function(canvas){
				$("#item2>div").empty().html(canvas);
				captureList[1].remove();
			});
			html2canvas(captureList[2]).then(function(canvas){
				$("#item3>div").empty().html(canvas);
				captureList[2].remove();
			});
			html2canvas(captureList[3]).then(function(canvas){
				$("#item4>div").empty().html(canvas);
				captureList[3].remove();
			});
			html2canvas(captureList[4]).then(function(canvas){
				$("#item5>div").empty().html(canvas);
				captureList[4].remove();
			});
			html2canvas(captureList[5]).then(function(canvas){
				$("#item6>div").empty().html(canvas);
				captureList[5].remove();
			});
		};
	$(function(){
		
		//일괄삭제버튼 클릭시
		$("#deleteBtn").on("click",function(){
			$("#deleteForm").ajaxForm({
				url: "${cPath}/group/esign/draftFormDelete.do",
				method : "POST",
				success : function(res){
					if(res.result == "OK"||res.result == "FAIL") {
							message = "";
							$.each(res.failDfNo,function(i,v){
								message += this +"번 양식"
								if(res.failDfNo.length-1 != i) message += ",";
								message += "삭제 실패(본인소유 양식이 아님.)";
							});
							(res.deleteCnt==undefined)?res.deleteCnt=0:res.deleteCnt=res.deleteCnt;
							message += "\n 선택 갯수 "+ (res.failDfNo.length + res.deleteCnt) +"개 중 삭제 갯수 : " + res.deleteCnt; 
							if(res.deleteCnt != 0) {
								$("input[name='page']").val(1);
								reload();
							}
							alert(message);
					}else{
						alert("에러 발생, 개발자에게 문의해주세요.")
					}
				}
			}).submit();
		});
		
		
	// 양식명 클릭 시 상세로 들어감.
	$(document).on("click","."+command,function(){
		action=$(this).data("action");
		window.name = action;
		window.open(
			"${ cPath }/group/esign/" + action,
			"draftDetail",
			"status=no, resizable=no, menubar=no, toolbar=no, location=no, scrollbars=no, height= 900px, width=1130px, left=500px, top=30px");
	});
	
	
}); // $function end
</script>
</body>
