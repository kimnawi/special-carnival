<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authMember"/>
	<security:authentication property="authorities" var="authMemRoles"/>
</security:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 쪽지</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/emplForm.css">
<style>
	body{
		overflow: hidden;
	}
	main{
		width: 1500px;
		padding-top: 5px;
	}
	table{
		border-collapse: collapse;
		width: 98%;
	}
	thead th{
		background: #FCFCFE;
	}
	tbody{
		background: transparent; 
	}
	#list-table{
		margin: 10px;
	}
	th{
		width : auto;
		text-align: center;
	}
	td, th{
		font-size: 18px;
		border: 1px solid #EAEAEA;
		padding: 5px;
		height: 30px;
		overflow: hidden;
		text-align: center;
	}
	#idxs{
		border : 1px solid transparent;
	}
	.checklist{
		width : 10px;
	}
	.sender{
		width : 130px;
	}
	.receiver{
		width : 130px;
	}
	th .content{
		text-align: center;
	}
	.content{
		width : 500px;
	}
	.check{
		width : 130px;
		text-align: center;
	}
	input, button{
		font-size: 18px;
		cursor: pointer;
	}
	#insert, #searchButton, #searchBtn{
	background: #3A4CA8;
	color: white;
	border-radius: 3px;
	padding: 1px 10px;
	margin: 2px 0px 2px 10px;
	}	
	#searchUI tfoot td{
	text-align: inherit;
	}
	#searchButton{
		position: absolute;
		right: 20px;
		top : 2px;
		background: #3A4CA8;
		color: white;
		font-size: 16px;
		border-radius: 3px;
		padding: 2px 10px;
		margin: 2px 10px;
	}
	.searchImg {
		position: relative;
	    width: 25px;
	    right: 3px;
	    top: 2px;
	    margin: 0px;
	    padding: 0px;
	    z-index: 1;
	}
	.small-search {
	    position: relative;
	    display: inline;
	    left:1px;
	    width: 32px;
	    height: 32px;
	    text-align: center;
	    vertical-align: middle;
	    z-index: 1;
	    bottom: 3px;
	    border: 1px solid black;
	    border-radius: 2px;
	}
	#searchUI{
		position: absolute;
		top: 40px;
	}
	#searchUI table {
		background: #FCFCFE; 
	}
	#searchUI tbody td, #searchUI tbody th{
		border: none;
		text-align: inherit;
		padding: 5px 10px;
	}
	#searchUI tfoot td{
		border: none;
		background: white;
	}
	#list-table tfoot td{ 
		border: none;
		text-align: center;
	}
	div{
		width: 100%;
	}
	#bottom{
		position: absolute;
		bottom: 10px;
	}
	#insert, #searchButton{
		background: #3A4CA8;
		color: white;
		border-radius: 3px;
		padding: 2px 10px;
		margin: 2px 0px;
	}
	.msgSelect{
		cursor: pointer;
		color: #4472C4;
    	height: 27px;  	
	    overflow: hidden;
	    display: -webkit-box;
	    -webkit-line-clamp: 1;
	    -webkit-box-orient: vertical;  
	    word-break: break-all;
	}
	.msgSelect:hover{
		color: #4472C4;
		text-decoration: underline;
	}
	.sort{
		font-size: 0.5em;
		vertical-align: 0.3em;
		background: #EAEAEA;
		border-color : #929292;
		border-width : 1px;
		color: black;
		font-size: 16px;
		font-weight: lighter;
		border-radius: 20px;
		padding: 3px 10px;
		margin: 2px 10px;
		cursor: pointer;
	}
	.sort{
	background:#EAEAEA;
	border-color:#929292;
	color:black;
	}
	.sort.hover{
		background: #3A4CA8;
		border-color : #3A4CA8;
		color : white;
	}
 	#sendMsg{
		position: absolute;
		left : 115px;
	} 
 	#selfMsg{
		position: absolute;
		left : 202px;
	} 
	#msgSave{
		position: absolute;
		right : 20px;
	}
	#w{
		color:#C00000; 
		font-weight: bold;
		font-size: 0.8em;
		margin-bottom: 2px; 
	}
	#list-table tbody tr td:first-child{
		 text-align: center;
	}
	.hidden-col{
		display: none;
	}
	.searchEmpl{
		position: relative;
		width : 320px;
		left : -4px;
	}
	#searchContent{
		width : 353px;
	}
</style>
</head>
<body>
쪽지
<input id="searchButton" type="button" value="상세검색">
<hr color="#F1F4FF">
<br>
	<select id="receiveMsg" class ="sort" name="msgState">
		<option value="RMSG" hidden="hidden" selected>받은쪽지</option>
		<option value="ALL" style="background-color: #EAEAEA; color: black">전체</option>
		<option value="NCONFIRM" style="background-color: #EAEAEA; color: black">미확인</option>
		<option value="CONFIRM" style="background-color: #EAEAEA; color: black">확인</option>
	</select>
	<input type="button" id="sendMsg" class="sort" name="sendMsg" value="보낸쪽지">
	<input type="button" id="selfMsg" class="sort" name="selfMsg" value="내게쓴쪽지">
	<input type="button" id="msgSave" class="sort" name="msgSave" value="보관함">
	<table id="list-table">
		<thead>
			<tr>
				<th class="checklist"><input type="checkbox" class="checkAll"></th>
				<th class="sender">보낸사람</th>
				<th class="content">내용</th>
				<th class="sdate">발송일시</th>
				<th class="check">상태</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5">
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
						<th>발송일자</th>
						<td><span class="dateForm"> <input name="msgSdateStart" type="date"> ~ <input name="msgSdateEnd" type="date">
						</span></td>
					</tr>
					<tr>
						<th>보낸사람</th>
						<td><input type="hidden" class="code" name="msgSender">
							<button class="small-search" data-action="emplSearch" type="button">
								<img class="searchImg" src="${ cPath }/resources/images/Search.png">
							</button>
							<input class="nm searchEmpl" type="text" placeholder="보낸사람" readonly></td>
					</tr>
					<tr>
						<th>받는사람</th>
						<td><input type="hidden" class="code" name="msgReceiver">
							<button class="small-search" data-action="emplSearch" type="button">
								<img class="searchImg" src="${ cPath }/resources/images/Search.png">
							</button>
							<input class="nm searchEmpl" type="text" placeholder="받는사람" readonly></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><input id="searchContent" name="msgContent" type="text" placeholder="내용">
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" id="tfoot"><input type="button" id="searchBtn" value="검색"> 
						<input type="reset" value="초기화"></td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
		<input type="hidden" name="authMember" value="${ authMember.emplNo }">
	<form id="searchForm">
		<input type="hidden" name="page">
		<input type="hidden" name="msgSdateStart" value="${ pagingVO.detailSearch.msgSdateStart }">
		<input type="hidden" name="msgSdateEnd" value="${ pagingVO.detailSearch.msgSdateEnd }">
		<input type="hidden" name="msgSender" value="${ pagingVO.detailSearch.msgSender }">
		<input type="hidden" name="msgReceiver" value="${ pagingVO.detailSearch.msgReceiver }">
		<input type="hidden" name="authEmpl" value="${ pagingVO.detailSearch.authEmpl }">
		<input type="hidden" name="authEmplSender" value="${ pagingVO.detailSearch.authEmplSender }">
		<input type="hidden" name="authEmplReceiver" value="${ pagingVO.detailSearch.authEmplReceiver }">
		<input type="hidden" name="msgContent" value="${ pagingVO.detailSearch.msgContent }">
		<input type="hidden" name="msgState" value="${ pagingVO.detailSearch.msgState }">
		<input type="hidden" name="msgSave" value="${ pagingVO.detailSearch.msgSave }">
		<input type="hidden" name="msgSelf" value="${ pagingVO.detailSearch.msgSelf }">
	</form>
	<div id="bottom">
		<p id="w">※ 1주일이 지난 쪽지는 자동삭제됩니다. 필요시 보관을 이용하기 바랍니다.</p>
		<hr color="#F1F4FF">
		<button type="button" id="insert">신규</button>
		<button type="button" id="confirm">확인</button>
		<button type="button" id="save">보관</button>
		<button type="button" id="delete">선택삭제</button>
		<button type="button" id="close">닫기</button>
	</div>
<input type="hidden" id="nm">
<input type="hidden" id="code">
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
$(function(){
	
		//검색 버튼
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
		
		//검색창 slide
		let searchUI = $("#searchUI").hide();
		$("#searchButton").on("click", function(){
			if(searchUI.is(":visible")){
				searchUI.slideUp();
			} else {
				searchUI.slideDown();
			}
		});
		$("input[type=reset]").on("click", function(){
			$("#searchUI input[type=hidden]").val("");
		});
		
		//검색 초기화
		$(document).ajaxComplete(function(event, xhr, options){
			searchForm.find("[name='page']").val("");
		});	
		
		//받은 쪽지 상태 선택
		$("#receiveMsg").on("change", function(){
			$(this).css({'background':'#3A4CA8', 'border-color':'#3A4CA8', 'color':'white'});
			$("#sendMsg").css({'background':'#EAEAEA', 'border-color':'#929292', 'color':'black'});
			$("#selfMsg").css({'background':'#EAEAEA', 'border-color':'#929292', 'color':'black'});
			$("#msgSave").css({'background':'#EAEAEA', 'border-color':'#929292', 'color':'black', 'font-weight':'normal'});
			$(".sender").html("보낸사람");
			
			$("#confirm").css('display', '');
			$("#save").css('display', '');
			$("#delete").css('display', '');
			
			$("#searchForm input").val("");
			authMember = $("input[name=authMember]").val();
			$("#searchForm input[name=authEmpl]").val(authMember);
			msgState = this.value
			$("#searchForm input[name=msgState]").val(msgState);
			searchForm.submit();
		});

		//보낸쪽지함 선택
		$("#sendMsg").on("click", function(){
			$("#receiveMsg").css({'background':'#EAEAEA', 'border-color':'#929292', 'color':'black'});
			$(this).css({'background':'#3A4CA8', 'border-color':'#3A4CA8', 'color':'white'});
			$("#selfMsg").css({'background':'#EAEAEA', 'border-color':'#929292', 'color':'black'});
			$("#msgSave").css({'background':'#EAEAEA', 'border-color':'#929292', 'color':'black', 'font-weight':'normal'});
			$(".sender").html("받는사람");
			$("select").prop('selectedIndex',0);

			$("#confirm").css('display', 'none');
			$("#save").css('display', 'none');
			$("#delete").css('display', 'none');
			
			$("#searchForm input").val("");
			authMember = $("input[name=authMember]").val();
			$("#searchForm input[name=authEmplSender]").val(authMember);
			searchForm.submit();
		});
		
		//내게쓴쪽지함 선택
		$("#selfMsg").on("click", function(){
			$("#receiveMsg").css({'background':'#EAEAEA', 'border-color':'#929292', 'color':'black'});
			$("#sendMsg").css({'background':'#EAEAEA', 'border-color':'#929292', 'color':'black'});
			$(this).css({'background':'#3A4CA8', 'border-color':'#3A4CA8', 'color':'white'});
			$("#msgSave").css({'background':'#EAEAEA', 'border-color':'#929292', 'color':'black', 'font-weight':'normal'});
			$(".sender").html("보낸사람");
			$("select").prop('selectedIndex',0);
			
			$("#confirm").css('display', '');
			$("#save").css('display', '');
			$("#delete").css('display', '');
			
			$("#searchForm input").val("");
			authMember = $("input[name=authMember]").val();
			$("#searchForm input[name=authEmpl]").val(authMember);
			msgSelf = 'O';
			$("#searchForm input[name=msgSelf]").val(msgSelf);
			searchForm.submit();
		});
		
		//보관함 선택
		$("#msgSave").on("click", function(){
			$("#receiveMsg").css({'background':'#EAEAEA', 'border-color':'#929292', 'color':'black'});
			$("#sendMsg").css({'background':'#EAEAEA', 'border-color':'#929292', 'color':'black'});
			$("#selfMsg").css({'background':'#EAEAEA', 'border-color':'#929292', 'color':'black'});
			$(this).css({'background':'#FFD13F', 'border-color':'#FFD13F', 'color':'white', 'font-weight':'bold'});
			$(".sender").html("보낸사람");
			
			$("#confirm").css('display', '');
			$("#save").css('display', '');
			$("#delete").css('display', '');
			
			$("select").prop('selectedIndex',0);
			$("#searchForm input").val("");
			authMember = $("input[name=authMember]").val();
			$("#searchForm input[name=authEmpl]").val(authMember);
			msgSave = 'O';
			$("#searchForm input[name=msgSave]").val(msgSave);
			searchForm.submit();
		});
		
		//받은 쪽지 전체 리스트
		let tbody = $("#list-table tbody");
		let pagingArea = $("#pagingArea");
		authMember = $("input[name=authMember]").val();
		$("#searchForm input[name=authEmpl]").val(authMember);
		let searchForm = $("#searchForm").paging().ajaxForm({
			url: "${cPath}/msg/msgList.do", 
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				pagingArea.empty();
				let msgList = pagingVO.dataList;
				let trTags = [];
					if(msgList.length > 0){
						$(msgList).each(function(idx, msg){
						if(msg.msgRdate == null){
							check = "미확인";
							if(msg.msgSender != msg.msgReceiver && msg.msgReceiver != authMember){
								trTags.push(
									$("<tr>").append(
										$("<td>").append($("<input class='checkbox'>").attr("type", "checkbox")),
	 									$("<td class='hidden-col'>").html(msg.msgNo),
										$("<td class='receiver'>").html(msg.pmpl.emplNm),
									    $("<td class='content'>").append($("<a class='msgSelect'>").html(msg.msgContent)).css("text-align", "left"),
										$("<td class='sdate'>").html(msg.msgSdate),
										$("<td class='check'>").html(check).css("color", "#ED0000")
									).data("msg", msg)
								)
							}else{
								trTags.push(
									$("<tr>").append(
										$("<td>").append($("<input class='checkbox'>").attr("type", "checkbox")),
	 									$("<td class='hidden-col'>").html(msg.msgNo),
										$("<td class='sender'>").html(msg.empl.emplNm),
									    $("<td class='content'>").append($("<a class='msgSelect'>").html(msg.msgContent)).css("text-align", "left"),
										$("<td class='sdate'>").html(msg.msgSdate),
										$("<td class='check'>").html(check).css("color", "#ED0000")
									).data("msg", msg)
									)
							}
						}else{
							check = "확인";
							if(msg.msgSender != msg.msgReceiver && msg.msgReceiver != authMember){
								trTags.push(
									$("<tr>").append(
										$("<td>").append($("<input class='checkbox'>").attr("type", "checkbox")),
	 									$("<td class='hidden-col'>").html(msg.msgNo),
										$("<td class='sender'>").html(msg.pmpl.emplNm),
										$("<td class='content'>").append($("<a class='msgSelect'>").html(msg.msgContent)).css("text-align", "left"),
										$("<td class='sdate'>").html(msg.msgSdate),
										$("<td class='check'>").html(check)
									).data("msg", msg)
								)
							}else{
								trTags.push(
									$("<tr>").append(
										$("<td>").append($("<input class='checkbox'>").attr("type", "checkbox")),
	 									$("<td class='hidden-col'>").html(msg.msgNo),
										$("<td class='sender'>").html(msg.empl.emplNm),
										$("<td class='content'>").append($("<a class='msgSelect'>").html(msg.msgContent)).css("text-align", "left"),
										$("<td classd='sdate'>").html(msg.msgSdate),
										$("<td classd='check'>").html(check)
									).data("msg", msg)
								)
							}
						}
						idxs = idx;
					});
					while(idxs != 15){
						trTags.push(
							$("<tr>").append(
								$("<td id='idxs'>").attr("colspan", "5")
							)		
						);
						idxs += 1;
					}
					pagingArea.html(pagingVO.pagingHTML);
					searchUI.hide();
				} else {
					trTags.push(
						$("<tr>").html(
							$("<td>").attr("colspan", "5").html("쪽지가 없습니다.")	
						)	
					);
				}
				searchUI.hide();
				tbody.append(trTags);
			}
		}).submit();
		
		//쪽지 상세보기
		$(tbody).on("click", ".msgSelect", function(){
			searchUI.hide();
			msgNo = $(this).parents("tr").data().msg.msgNo;
			msgSender = $(this).parents("tr").data().msg.msgSender;
			msgReceiver = $(this).parents("tr").data().msg.msgReceiver;
			msgSelect = $(this).parents("tr").find("td");
			msgSelect.css({"background":"#FEFAE5", "color":"#AAAAAA"});
			
			msg = [];
			what = $(this).parents("tr").data().msg.msgNo;
			msg.push(what);
			$.ajax({
				url: "${cPath}/msg/msgStateUpdate.do", 
				type: "post",
				data: {"what" : msg},
				dataType: "text",
				success:function(res){
					var nWidth = 480;
					var nHeight = 465;
					var curX = window.screenLeft;
					var curY = window.screenTop;
					var curWidth = document.body.clientWidth;
					var curHeight = document.body.clientHeight;
					var nLeft = Math.ceil(( window.screen.width - nWidth )/2);
					var nTop = Math.ceil(( window.screen.height - nHeight )/2);
					window.name ="msgSelect";
					popup = window.open(
							"${ cPath }/msg/msgView.do?what=" + msgNo + "&msgSender=" + msgSender + "&msgReceiver=" + msgReceiver,
							"taxFree",
							"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
					popup.addEventListener('beforeunload', function(){
						msgSelect.css({"background":"transparent"});
					});
				}
			});
			
		});

		//쪽지 보내기
		$("#insert").on("click", function(){
			searchUI.hide();
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
					"${ cPath }/msg/msgInsert.do",
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		});
		
		//체크박스 클릭
		$('.checkAll').on('click',function(){
			ck = $(this).prop('checked');
			$(this).parents('table').find('.checkbox').prop('checked', ck);
		});
		$(tbody).on("change",".checkbox",function(){
			allbox = $("input:checkbox").length-1; 
			//전체선택 체크박스 제외 체크된박스 개수 구하기
			cnt = $("input[type=checkbox]:checked").length;
			//체크박스가 다 체크될 경우 전체선택체크박스도 체크
			if(cnt == allbox){
				$(".checkAll").prop('checked',true);
			}else{
				$(".checkAll").prop('checked',false);
			}
		});
		
		// 선택한 쪽지 삭제
		$("#delete").on("click", function(){
	    	 var checkbox = $("input:checkbox[class='checkbox']").is(":checked")
	    	 if(checkbox==true){
	         	cAlert("삭제 후엔 복구가 불가능합니다.<br>삭제하시겠습니까?", "confirm");
	    	 } else {
				cAlert("선택된 쪽지가 없습니다.")
				return false;
	    	 }
	      });
	      $("#alertResult").on("change",function(){
    	    if($(this).val() != 'true'){
    	      location.reload(true);
              return false;
            }
			msg = [];
			$(".checkbox:checked", tbody).each(function(){
				msg.push($(this).parents("tr").find(".hidden-col").text());
			});
			$.ajax({
				url: "${cPath}/msg/msgDelete.do",
				type: "post",
				data: {"what" : msg},
				dataType: "text",
				success: function(res){
					cAlert("삭제되었습니다.")
					$("#alertYesBtn").on("click", function(){
						location.reload(true);
					});
				}
			});
	    });
	      
		
		// 선택한 쪽지 확인(확인버튼)
		$("#confirm").on("click", function(){
			var checkbox = $("input:checkbox[class='checkbox']").is(":checked")
			if(checkbox==false){
				cAlert("선택된 쪽지가 없습니다.")
				return false;
			}
	    	  msg = [];
				$(".checkbox:checked", tbody).each(function(){
					msg.push($(this).parents("tr").find(".hidden-col").text());
				});
				$.ajax({
					url: "${cPath}/msg/msgStateUpdate.do",
					type: "post",
					data: {"what" : msg},
					dataType: "text",
					success: function(res){
						cAlert("확인되었습니다.")
						$("#alertYesBtn").on("click", function(){
							location.reload(true);
						});
					}
				});
		    });
		
		// 선택한 쪽지 보관
		$("#save").click(function(){
			var checkbox = $("input:checkbox[class='checkbox']").is(":checked")
			if(checkbox==false){
				cAlert("선택된 쪽지가 없습니다.")
				return false;
			}
    	 	msg = [];
			$(".checkbox:checked", tbody).each(function(){
				msg.push($(this).parents("tr").find(".hidden-col").text());
			});
			$.ajax({
				url: "${cPath}/msg/msgSaveUpdate.do", 
				type: "post",
				data: {"what" : msg},
				dataType: "text",
				success:function(res){
					cAlert("보관되었습니다.")	
					$("#alertYesBtn").on("click", function(){
						location.reload(true);
					 });
				}
			});
		});
		
		// 쪽지창 닫기
		$("#close").on("click", function(){
			window.close();
		});
});
</script>
<jsp:include page="/includee/cAlert.jsp"/>
</body>
<style>
	#cAlert{
		width: 400px;
		top : 10%;
		left: 10%;
	}
</style>
</html>