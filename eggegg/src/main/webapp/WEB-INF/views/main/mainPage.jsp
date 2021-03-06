<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authMember"/>
	<security:authentication property="authorities" var="authMemRoles"/>
</security:authorize>
<script src="${ cPath }/resources/js/clock.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/js/fullcalendar/main.min.css">
<style>
body{
	background: #FCFCFE;
}
.mainDiv{
	margin: 0 0 0 30px;
	float: left;
	height: 800px;
	border: 1px solid #DDE4FF;
	background: white;
	border-radius: 4px;
	padding: 5px;
}
#schedule{
	width: 800px;
}
#esign, #email{
	width: 600px;
	height: 390px;
	margin-bottom: 20px;
}
#hrdStatus{
	width: 400px;
}
hr{
	margin: 5px 0;
}
#title{
	font-weight: bold;
	margin-left: 15px;
	font-size: 19px;
}
#clock{
	font-size: 40px;
	text-align: center;
	font-weight: bold;
	margin: 30px;
}
#hrdTable{
	border-collapse: collapse;
	text-align: center;
	width: 100%;
}
#hrdTable thead{
	border-top: 2px solid #EAEAEA;
}
.last{
	border-bottom: 2px solid #EAEAEA;
}
#hrdTable th, td{
	padding: 5px 10px;
}
#hrdTable th{
	background: #FCFCFE;
	width: 120px;
}
.empty{
	padding-top: 50px;
}
.middle{
	border-bottom: 2px solid #EAEAEA;
	border-top: 2px solid #EAEAEA;
}
#profileImg{
	text-align: center;
	margin-bottom: 20px;
	height: 150px;
}
.profile{
	height: 100%;
}
#ms{
	width :100%;
	text-align: center;
}
#ms tr{
	border-top: 1px solid #EAEAEA;
	border-bottom: 1px solid #EAEAEA;
}
#df{
	width: 100%;
	text-align: center;
}
#df tr{
	border-top: 1px solid #EAEAEA;
	border-bottom: 1px solid #EAEAEA;
}
th{
	text-align: center;
	background: #FCFCFE;
}
.draftTitle{
	width : 320px;
}
td.draftTitle{
	text-align: left;
}
td.msgContent{
	text-align: left;
}
.msgContent{
	width :340px;
}
#dfm, #msm{
	height: 305px;
	overflow: auto;
	margin-top: 5px;
}
#dfTitle, #msTitle{
	display: inline-block;
    background: #9e9e9e;
    font-size: 14px;
    border-radius: 5px;
    padding: 2px 10px;
    color: white;
    font-weight: bold;
}
.msgContent{
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;  
    word-break: break-all;
}
</style>
<body>
<%-- ${sessionScope.matched } --%>
<input type="hidden" value="${ authMemRoles }">
<div id="schedule" class="mainDiv">
	<div id="top">
		<span id="title">????????????</span>
		<hr color="#DDE4FF">
	</div>
	<div id='calendar-container'>
		<div id='calendar'></div>
	</div>
</div>
<div id="hrdStatus" class="mainDiv">
	<div id="top">
		<span id="title">???/??????</span>
		<hr color="#DDE4FF">
	</div>
	<div id="clock"></div>
	<div id="profileImg">
		<c:if test="${ empty empl.file }">
			<img class="profile" alt="???????????????" src="${ cPath }/resources/images/profile.png">
		</c:if>
		<c:if test="${ not empty empl.file }">
			<img class="profile" alt="???????????????" src="${ cPath }/group/esign/getSignImage.do?link=${ empl.file.commonPath }">
		</c:if>
	</div>
	<div>
		<table id="hrdTable">
			<c:if test="${ empty atvl }">
				<tr>
					<td colspan="2" class="empty"><strong>${ authMember.emplNm }</strong>?????? ??????????????? ????????????.</td>
				</tr>
			</c:if>
			<c:if test="${ not empty atvl }">
				<thead>
					<tr>
						<th>??????</th>
						<td>${ atvl.atvlAttTm }</td>
					</tr>
					<tr>
						<th>??????</th>
						<td>
							<c:if test="${ empty atvl.atvlLvTm }">
							??????????????? ????????????.
							</c:if>
							<c:if test="${ not empty atvl.atvlLvTm }">
							${ atvl.atvlLvTm }
							</c:if>
						</td>
					</tr>
					<tr class="middle"><td colspan="2">&ensp;</td></tr>
				</thead>
				<tbody>
					<tr>
						<th>??????</th>
						<td>${ authMember.emplNm }</td>
					</tr>
					<tr>
						<th>??????</th>
						<td>${ atvl.atvlPlace }</td>
					</tr>
					<tr class="last">
						<th>???/??????</th>
						<td>${ atvl.atvlForm }</td>
					</tr>
				</tbody>
			</c:if>
		</table>
	</div>
</div>
<div id="esign" class="mainDiv">
	<div id="top">
		<span id="title">????????????</span>
		<hr color="#DDE4FF">
	<div>
		&ensp;<span id="dfTitle">> ?????? ????????????</span>
		<div id="dfm">
			<table id="df">
				<thead>
					<tr>
						<th>?????? ??????</th>
						<th class="draftTitle">??????</th>
						<th>?????????</th>
						<th>????????????</th>
					</tr>
				</thead>
				<tbody id="dfb">
				</tbody>
			</table>
		</div>
		</div>
	</div>
</div>
<div id="email" class="mainDiv">
	<div id="top">
		<span id="title">??????</span>
		<hr color="#DDE4FF">
		<div>
			&ensp;<span id="msTitle">> ????????? ?????????</span>
			<div id="msm">
				<table id="ms">
					<thead>
						<tr>
							<th>?????????</th>
							<th id="msgContent">??????</th>
							<th>?????? ??????</th>
						</tr>
					</thead>
					<tbody id="msb">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<form id="updatePWForm">
	<input type="hidden" name="emplNo" value="${authMember.emplNo}">
	<input type="hidden" name="emplPw"> 
</form>
<script src="${ cPath }/resources/js/fullcalendar/main.min.js"></script>
<script src="${ cPath }/resources/js/fullcalendar/locale/ko.js"></script>
<script>
localStorage.setItem("selectedHead","");
	$(function(){
		$.ajax({
			url: "${ cPath }/scheMain.do",
			dataType: "json",
			success: function(scheList){
				var events = [];
				for(i = 0; i < scheList.length; i++){
					sche = scheList[i];
					let eve ={
						title: sche.smTitle,
						start: sche.smStartTmCal,
						end: sche.smEndTmCal
					};
					events.push(eve);
				}
				renderCalendar(events);
			}
		});
		calendar = null;
		function renderCalendar(events){
			var calendarEl = $('#calendar')[0];
			calendar = new FullCalendar.Calendar(calendarEl, {
				height: '700px', // calendar ?????? ??????
				expandRows: true, // ????????? ?????? ?????? ?????????
				// ????????? ????????? ??????
				headerToolbar: {
					left: 'dayGridMonth,listWeek prev',
					center: 'title',
					right: 'next today'
				},
				initialView: 'dayGridMonth', // ?????? ?????? ?????? ????????? ????????? ??????(?????? ??????: ???)
				navLinks: true, // ?????????  ???????????? Day???????????? Week???????????? ??????
				editable: true, // ?????? ???????
				selectable: true, // ?????? ?????? ????????? ????????????
				nowIndicator: true, // ?????? ?????? ??????
				dayMaxEvents: true, // ???????????? ???????????? ?????? ?????? (+ ??? ???????????? ??????)
				locale: 'ko', // ????????? ??????
				events: events
			});
			calendar.render();
			$(".fc-next-button").removeClass("fc-button-primary");
			$(".fc-prev-button").removeClass("fc-button-primary");
			$(".fc-toolbar-title").css("font-size", "20px");
		}
		printClock();
		const regex = /^(?=.*[a-z]+)(?=.*[A-Z]+)(?=.*[0-9]+)(?=.*[!@#\\$%\\^\\&\\*]+).{4,8}$/;
		// ????????????????????? 0000?????? ??????????????? ????????? ???
		if("${sessionScope.matched }" == "matched"){
			$("#cAlert").css("height","300px")
			$("#cAlertContent").css("height","160px")
			cAlert("<span style='font-size:16px;'>?????? ??????????????? ?????????????????????. ??????????????? ?????????????????? </span> <br> <span style='font-size:14px; color:red;'> ?????? : ???????????????+??????+????????????(!,@,#,$,%,^,&,*) 4~8???</span><br>","prompt","changePW");
		}
		$("#alertResult").on("change",function(){
			if($(FNNAME).val() == "changePW"){
				if($(this).val()==""){
					// ???????????? ????????? ??? ???????????? ?????????
					location.href="${cPath}/login/logout.do"
				}else{
					$("input[name='emplPw']").val($(this).val());
					$("#updatePWForm").ajaxForm({
						url:"${cPath}/empl/emplUpdate.do",
						method:"post",
						dataType:"json",
						success : function(res){
							if(res.result == "FAIL"){
								console.log("??????")
								$("input[name='emplPw']").val("").change();
							}else{
								<c:remove var="matched" scope="session"/>
							}
						}
					}).submit();
				}
			}
		});
		
		$("input[name='emplPw']").on("change",function(){
			if($("input[name='emplPw']").val() == ""){
				cAlert("<span style='font-size:16px;'>???????????? ????????? ?????? ??????????????? ?????????????????? </span> <br> <span style='font-size:14px; color:red;'> ?????? : ???????????????+??????+????????????(!,@,#,$,%,^,&,*) 4~8???</span><br>","prompt","changePW");
			}
		});
		
		$("#cAlert").on("keyup","#alertPrompt",function(){
			$(".caution").remove();
			if(!regex.exec($(this).val()) && $(this).val() != ""){
				$(this).after($("<br class='caution'><span style='color:red;' class='caution'>????????????!!</span>"))
			}
		})
		
		$.ajax({
			url: "${ cPath }/draftMain.do",
			dataType: "json",
			method: "post",
			success: function(res){
				let trTags = [];
				if(res.length > 0){
					$.each(res,function(i,v){
						date = v.draftDate;
						title = v.draftTitle;
						writer = v.writer.emplNm;
						progress = v.draftProgress;
						tr = $("<tr>").append(
							$("<td>").html(date),
							$("<td class='draftTitle'>").html(title),
							$("<td>").html(writer),
							$("<td>").html(progress)
						);
						trTags.push(tr);
					})
				} else {
					trTags.push(
						$("<tr>").html(
							$("<td>").attr("colspan", "4").html("??? ????????? ??????????????? ????????????.")
						)
					)
				}
				$("#dfb").append(trTags);
			},
			error: function(xhr){
				alert(xhr.status);
			}
		}); 
		$.ajax({
			url: "${ cPath }/msgMain.do",
			dataType: "json",
			method: "post",
			success: function(res){
				let trTags = [];
				if(res.length > 0){
					$.each(res,function(i,v){
						sender = v.empl.emplNm;
						content = v.msgContent;
						date = v.msgSdate;
						tr = $("<tr>").append(
							$("<td>").html(sender),
							$("<td class='msgContent'>").html(content),
							$("<td>").html(date)
						);
						trTags.push(tr);
					})
				} else{
					trTags.push(
						$("<tr>").html(
							$("<td>").attr("colspan","3").html("????????? ????????? ????????????.")	
						)		
					)
				}
				$("#msb").append(trTags);
			},
			error: function(xhr){
				alert(xhr.status);
			}
		}); 
	});
</script>
</body>
