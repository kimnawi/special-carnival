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
		<span id="title">일정관리</span>
		<hr color="#DDE4FF">
	</div>
	<div id='calendar-container'>
		<div id='calendar'></div>
	</div>
</div>
<div id="hrdStatus" class="mainDiv">
	<div id="top">
		<span id="title">출/퇴근</span>
		<hr color="#DDE4FF">
	</div>
	<div id="clock"></div>
	<div id="profileImg">
		<c:if test="${ empty empl.file }">
			<img class="profile" alt="프로필사진" src="${ cPath }/resources/images/profile.png">
		</c:if>
		<c:if test="${ not empty empl.file }">
			<img class="profile" alt="프로필사진" src="${ cPath }/group/esign/getSignImage.do?link=${ empl.file.commonPath }">
		</c:if>
	</div>
	<div>
		<table id="hrdTable">
			<c:if test="${ empty atvl }">
				<tr>
					<td colspan="2" class="empty"><strong>${ authMember.emplNm }</strong>님의 출근기록이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${ not empty atvl }">
				<thead>
					<tr>
						<th>출근</th>
						<td>${ atvl.atvlAttTm }</td>
					</tr>
					<tr>
						<th>퇴근</th>
						<td>
							<c:if test="${ empty atvl.atvlLvTm }">
							퇴근기록이 없습니다.
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
						<th>성명</th>
						<td>${ authMember.emplNm }</td>
					</tr>
					<tr>
						<th>장소</th>
						<td>${ atvl.atvlPlace }</td>
					</tr>
					<tr class="last">
						<th>내/외근</th>
						<td>${ atvl.atvlForm }</td>
					</tr>
				</tbody>
			</c:if>
		</table>
	</div>
</div>
<div id="esign" class="mainDiv">
	<div id="top">
		<span id="title">전자결재</span>
		<hr color="#DDE4FF">
	<div>
		&ensp;<span id="dfTitle">> 결재 대기문서</span>
		<div id="dfm">
			<table id="df">
				<thead>
					<tr>
						<th>기안 일자</th>
						<th class="draftTitle">제목</th>
						<th>기안자</th>
						<th>진행상태</th>
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
		<span id="title">쪽지</span>
		<hr color="#DDE4FF">
		<div>
			&ensp;<span id="msTitle">> 미확인 쪽지함</span>
			<div id="msm">
				<table id="ms">
					<thead>
						<tr>
							<th>발신자</th>
							<th id="msgContent">내용</th>
							<th>발신 일자</th>
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
				height: '700px', // calendar 높이 설정
				expandRows: true, // 화면에 맞게 높이 재설정
				// 해더에 표시할 툴바
				headerToolbar: {
					left: 'dayGridMonth,listWeek prev',
					center: 'title',
					right: 'next today'
				},
				initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
				navLinks: true, // 날짜를  선택하면 Day캘린더나 Week캘린더로 링크
				editable: true, // 수정 가능?
				selectable: true, // 달력 일자 드래그 설정가능
				nowIndicator: true, // 현재 시간 마크
				dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
				locale: 'ko', // 한국어 설정
				events: events
			});
			calendar.render();
			$(".fc-next-button").removeClass("fc-button-primary");
			$(".fc-prev-button").removeClass("fc-button-primary");
			$(".fc-toolbar-title").css("font-size", "20px");
		}
		printClock();
		const regex = /^(?=.*[a-z]+)(?=.*[A-Z]+)(?=.*[0-9]+)(?=.*[!@#\\$%\\^\\&\\*]+).{4,8}$/;
		// 메인페이지에서 0000으로 로그인하면 보여줄 거
		if("${sessionScope.matched }" == "matched"){
			$("#cAlert").css("height","300px")
			$("#cAlertContent").css("height","160px")
			cAlert("<span style='font-size:16px;'>초기 비밀번호로 접속하셨습니다. 비밀번호를 변경해주세요 </span> <br> <span style='font-size:14px; color:red;'> 형식 : 영대소문자+숫자+특수문자(!,@,#,$,%,^,&,*) 4~8자</span><br>","prompt","changePW");
		}
		$("#alertResult").on("change",function(){
			if($(FNNAME).val() == "changePW"){
				if($(this).val()==""){
					// 취소버튼 눌렀을 때 로그아웃 시키기
					location.href="${cPath}/login/logout.do"
				}else{
					$("input[name='emplPw']").val($(this).val());
					$("#updatePWForm").ajaxForm({
						url:"${cPath}/empl/emplUpdate.do",
						method:"post",
						dataType:"json",
						success : function(res){
							if(res.result == "FAIL"){
								console.log("실패")
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
				cAlert("<span style='font-size:16px;'>비밀번호 형식에 맞게 비밀번호를 변경해주세요 </span> <br> <span style='font-size:14px; color:red;'> 형식 : 영대소문자+숫자+특수문자(!,@,#,$,%,^,&,*) 4~8자</span><br>","prompt","changePW");
			}
		});
		
		$("#cAlert").on("keyup","#alertPrompt",function(){
			$(".caution").remove();
			if(!regex.exec($(this).val()) && $(this).val() != ""){
				$(this).after($("<br class='caution'><span style='color:red;' class='caution'>형식확인!!</span>"))
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
							$("<td>").attr("colspan", "4").html("내 차례의 기안문서가 없습니다.")
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
							$("<td>").attr("colspan","3").html("미확인 쪽지가 없습니다.")	
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
