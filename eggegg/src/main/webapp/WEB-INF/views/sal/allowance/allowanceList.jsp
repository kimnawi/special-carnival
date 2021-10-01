<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="${cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${cPath }/resources/js/jquery.form.min.js"></script>
<title>수당리스트</title>
<link rel="stylesheet" href="${ cPath }/resources/css/allowanceAllowanceList.css">
</head>
<body>
<div id ="top">
	&ensp;&ensp;&ensp;<span id="title">수당리스트</span>
</div>
	<hr color="#F1F4FF">
<br>
<form:form method="post" action="${cPath}/sal/extrapayUpdate.do?use=${use}" commandName="allowance" id="form">
	<table>
		<tr >
			<th class="emplListTd"><input type="checkbox" class="checkAll"></th>
			<th id="th1">수당항목코드</th>
			<th id="th2" class="hang">수당항목명</th>
			<th id="th3">표시순서</th>
			<th id="th4" class="hang">비과세유형</th>
			<th id="th5">지급유형</th>
		</tr>
		<tbody id="cb">
			<c:forEach items="${alList}" var="al" >
				<c:choose>
					<c:when test="${use eq 'no'}">
						<tr class="${al.alUse}">
							<td class="cen">
								<input class="checkbox" type="checkbox" value="${al.alCode}">
							</td>
							<td ><input class="td1" disabled name="alCode" type="text" value="${al.alCode}"></td>
							<td class="input"><input disabled name="alNm" type="text" value="${al.alNm}"></td>
							<td class="seq">${al.alSeq}</td>
							<td class="input tfdb"><input readonly type="text" disabled name="tfNm" value="${al.tfNm}" /></td>
							<td style="display:none;"> <input type="text" disabled name="tfCode" value="${al.tfCode}"></td>
							<td>
							<select name="alProvide" >
								<option value="고정">고정</option>
								<option value="변동(시간)" ${(al.alProvide eq "변동(시간)") ? "selected" : ""}>변동(시간)</option>
								<option value="변동(일)" ${(al.alProvide eq "변동(일)") ? "selected" : ""}>변동(일)</option>
							</select>
							</td>
						</tr>			
					</c:when>
					<c:otherwise>
						<c:if test="${al.alUse eq 'Yes'}">
						<tr>
							<td class="cen emplListTd">
								<input class="checkbox" type="checkbox" value="${al.alCode}">
							</td>
							<td><input class="td1" disabled name="alCode" type="text" value=${al.alCode}></td>
							<td class="input"><input disabled name="alNm" type="text" value=${al.alNm} ></td>
							<td class="seq">${al.alSeq}</td>
							<td class="input tfdb"><input type="text" disabled readonly name="tfNm" value="${al.tfNm}" /></td>
							<td style="display:none;"> <input type="text" disabled name="tfCode" value=${al.tfCode}></td>
							<td>
							<select name="alProvide" >
								<option value="고정">고정</option>
								<option value="변동(시간)" ${(al.alProvide eq "변동(시간)") ? "selected" : ""}>변동(시간)</option>
								<option value="변동(일)" ${(al.alProvide eq "변동(일)") ? "selected" : ""}>변동(일)</option>
							</select>
							</td>
						</tr>
						</c:if>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tbody>
	</table>
</form:form>
<div id="bottom">
	<hr color="#F1F4FF">
	<input type="button" id="save" class="saveBtn" value="저장">
	<div class="dropup" style="display : inline-block;">
	  <button class="dropbtn">사용중단/재사용 <span class="sort">▲</span></button>
	  <div class="dropup-content">
	    <a id="stop">사용중단</a>
	    <a id="delete">삭제</a>
	    <a id="continue">재사용</a>
	  </div>
	</div>
	<c:choose>
		<c:when test="${use eq 'yes' }">
			<input type="button" value="사용중단포함" id="useNo" >
		</c:when>
		<c:when test="${use eq 'no' }">
			<input type="button" value="사용중단미포함" id="useYes">
		</c:when>
	</c:choose>
</div>
<div id="background"></div>
<input type="hidden"id="nm">
<input type="hidden"id="code">
<script>
	$(function(){
		//삭제 버튼 기능
		$("#delete").on("click",function(){
			cnt = $("#cb input[type=checkbox]:checked").length;
			val = $("#cb input[type=checkbox]:checked");
			value="";
			for(i = 0; i<val.length;i++){
				if(i!=0){
					value+=",";
				}
				value += val.eq(i).val();
			}
			if(cnt == 0 ){
				cAlert("리스트에 선택된 자료가 없습니다.<br>체크박스에 체크한 후 다시 시도 바랍니다.");
			}else{
				location.href="${cPath}/sal/extraDelete.do?alCode="+value+"&use=${use}";
			}	
		})
		//사용중단 버튼 기능
		$("#stop").on("click",function(){
			cnt = $("#cb input[type=checkbox]:checked").length;
			val = $("#cb input[type=checkbox]:checked");
			value="";
			for(i = 0; i<val.length;i++){
				if(i!=0){
					value+=",";
				}
				value += val.eq(i).val();
			}
			if(cnt == 0 ){
				cAlert("리스트에 선택된 자료가 없습니다.<br>체크박스에 체크한 후 다시 시도 바랍니다.");
			}else{
				location.href="${cPath}/sal/extraStop.do?alCode="+value+"&use=${use}";
			}	
		})
		
		//재사용 버튼 기능
		$("#continue").on("click",function(){
			cnt = $("#cb input[type=checkbox]:checked").length;
			val = $("#cb input[type=checkbox]:checked");
			value="";
			for(i = 0; i<val.length;i++){
				if(i!=0){
					value+=",";
				}
				 value += val.eq(i).val();
			}
			if(cnt == 0 ){
				cAlert("리스트에 선택된 자료가 없습니다.<br>체크박스에 체크한 후 다시 시도 바랍니다.");
			}else{
				location.href="${cPath}/sal/extraContinue.do?alCode="+value+"&use=${use}";
			}	
		})
		
		//체크박스전체선택
		$('.checkAll').on('click',function(){
			ck = $(this).prop('checked');
		
			$(this).parents('table').find('.checkbox').prop('checked', ck);
		})
		//체크박스 전체 개수구하기
		allbox = $("input[type=checkbox]").length-1; 
		$('.checkbox').on("change",function(){
			//전체선택 체크박스 제외 체크된박스 개수 구하기
			cnt = $("#cb input[type=checkbox]:checked").length;
			//체크박스가 다 체크될 경우 전체선택체크박스도 체크
			if(cnt == allbox){
				$(".checkAll").prop('checked',true);
			}else{
				$(".checkAll").prop('checked',false);
			}
		})
		
		
		//사용중단포함
		$("#useNo").on("click",function(){
			location.href="?use=no";
		})
		//사용중단미포함
		$("#useYes").on("click",function(){
			location.href="?use=yes";
		})
		
		//input버튼을 누를경우 text가 활성화되게 만드는 것
		$("tbody").on("click",".input",function(){
			input = $(this).find("input[type=text]");
			input.removeAttr('disabled');
			input.focus();
// 			console.log($(this).find("input").val());
		})
		
		//input버튼을 벗어나면 비활성화
		$("tbody").on("focusout",".input",function(){
			input.attr('disabled','disabled');
		})
		//input버튼을 누를경우 text가 활성화되게 만드는 것
		$("tbody").on("click",".tfdb",function(){
			names = $(this).parent().find("input[name=tfNm]");
			codes = $(this).parent().find("input[name=tfCode]");

			var nWidth = 1500;
			var nHeight = 1000;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name ="allowance";
			popup = window.open(
					"${cPath}/sal/taxFreeList.do",
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload',function(){
				names.val($("#nm").val());
				codes.val($("#code").val());
			})
		})
		
		
		//저장버튼 클릭시 이벤트
		$("#save").on("click",function(){
			target = $("#form");
			var disabled = target.find(':disabled').removeAttr('disabled');
			target.submit();
			
			disabled.attr('disabled','disabled');
		})
		
	})
</script>
</body>
</html>