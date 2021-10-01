<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<link rel="stylesheet" href="${ cPath }/resources/css/projectList.css">
<body>
<div id="top">
	<span id="title">프로젝트등록</span>
	<hr color="#F1F4FF">
</div>
<div id="lll">
	<div id="searchUI">
		<input class="sc2" type="text" placeholder="프로젝트명" name="prjNm" value="${pagingVO.detailSearch.prjNm}" />
		<input type="button" value="검색" id="searchBtn">
	</div>
	<table id="propro">
		<thead>
			<tr>
				<th><input type="checkbox" class="checkAll"></th>
				<th id="th1">프로젝트코드</th>
				<th id="th2">프로젝트명</th>
				<th id="th3">프로젝트기간</th>
				<th id="th4">사용구분</th>
			</tr>
		</thead>
		<tbody id="cb">
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5" >
					<div id="pagingArea"></div>
				</td>
			</tr>
		</tfoot>
	</table>
	<form id="searchForm">
		<input type="hidden" name="page">
		<input type="hidden" name="prjCode" value="${pagingVO.detailSearch.prjCode}">
		<input type="hidden" name="prjNm" value="${pagingVO.detailSearch.prjNm }">
	</form>
</div>
<div id="form">
	<form:form commandName="prj" method="post" action="${cPath}/empl/projectInsert.do">
		<table>
			<thead>
				<tr>
					<td colspan="2">
						<strong style="font-size: 20px;">프로젝트등록 및 수정</strong>
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>프로젝트코드</th>
					<td><input type="text" name="prjCode" required value="${project.prjCode}" readonly /><input type="button" value="코드생성" id="newCode" style="float:right"> </td>
				</tr>
				<tr>
					<th>프로젝트명</th>
					<td><input type="text" name="prjNm" required value="${project.prjNm}" /></td>
				</tr>
				<tr>
					<th>시작일</th>
					<td><input type="date" name="start" /></td>
				</tr>
				<tr>
					<th>완료일</th>
					<td><input type="date" name="end" /></td>
				</tr>
				<tr>
					<th>적요</th>
					<td>
						<textarea rows="10" cols="50" name="prjSumry" id="prjSumry">${project.prjSumry}</textarea>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2" style="border:none;">
					<input type="submit" value="저장" class="saveBtn">
					<input type="reset" value="초기화">
					</td>
				</tr>
			</tfoot>
		</table>
	</form:form>
</div>
<div id="bottom">
	<hr color="#F1F4FF">
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
	<input type="button" value="Excel" id="exExcel">
</div>
<script type="text/javascript" src="${cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="${cPath}/resources/js/paging.js"></script>
<script src="${cPath}/resources/js/jquery.form.min.js"></script>
</body>
<script>
$(function(){
	$("#firstSelected").css("background", "none").css("color", "black");
	$("#exExcel").on("click",function(){
		$.ajax({
			url : "${cPath}/empl/excelProject.do",
			dataType : "text",
			success : function(resp) {
				
			}
		});
	})
	cod = $("#form input[name=prjCode]");
	nam = $("#form input[name=prjNm]");
	start = $("input[name=start]");
	end = $("input[name=end]");
	sumry = $("textarea[name=prjSumry]");
	$("#cb").on("click",".tag",function(){
		code = $(this).attr("code");
		$.ajax({
			url : "${cPath}/empl/selectProject.do",
			data : {"prjCode" : code},
			dataType : "json",
			success : function(resp) {
				date = resp.prjPeriod;
				dates = date.split("~");
				cod.val(resp.prjCode);
				nam.val(resp.prjNm);
				start.val(dates[0]);
				end.val(dates[1]);
				sumry.val(resp.prjSumry);
			}
		});
	})
	$("#newCode").on("click",function(){
		$.ajax({
			url : "${cPath}/empl/createCode.do",
			dataType : "json",
			success : function(resp) {
				$("input[name=prjCode]").val(resp.prjCode);
			}
		});
	})
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
			location.href="${cPath}/empl/projectDelete.do?prjCode="+value+"&use=${use}";
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
			location.href="${cPath}/empl/projectStop.do?prjCode="+value+"&use=${use}";
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
			location.href="${cPath}/empl/projectContinue.do?prjCode="+value+"&use=${use}";
		}	
	})
	
	//체크박스전체선택
	$('.checkAll').on('click',function(){
		ck = $(this).prop('checked');
	
		$(this).parents('table').find('.checkbox').prop('checked', ck);
	})

	
	
	//사용중단포함
	$("#useNo").on("click",function(){
		location.href="${cPath}/empl/projectListY.do?use=no"
	})
	//사용중단미포함
	$("#useYes").on("click",function(){
		location.href="${cPath}/empl/projectList.do?use=yes";
	})
	
	
	
	let tbody = $("#cb");
	let pagingArea = $("#pagingArea");
	
	$(document).ajaxComplete(function(event, xhr, options){
		searchForm.find("[name='page']").val("");
		$(".checkAll").prop('checked',false);
	}).ajaxError(function(event, xhr, options, error){
		console.log(event);
		console.log(xhr);
		console.log(options);
		console.log(error);
	});
	function makeTrTag(project){
		code = project.prjCode;
		if(project.prjUse == 'Yes'){
		return $("<tr>").append(
			$("<td>").html("<input type='checkbox' class='checkbox' value='"+code+"'>"),
			$("<td class='selectPrj'>").html(project.prjCode),		
			$("<td class='selectPrj'>").html(project.prjNm),		
			$("<td class='td4'>").html(project.prjPeriod),		
			$("<td class='td3'> ").html(project.prjUse)
		).attr("code",project.prjCode).attr("class","tag");
		}else{
			return $("<tr>").append(
				$("<td>").html("<input type='checkbox' class='checkbox' value='"+code+"'>"),
				$("<td class='selectPrj'>").html(project.prjCode),		
				$("<td class='selectPrj'>").html(project.prjNm),		
				$("<td class='td4'>").html(project.prjPeriod),		
				$("<td class='td3'> ").html(project.prjUse)
			).attr("code",project.prjCode).attr("class","tag red");
		}
		
	}
	function makeTag(){
		return $("<tr>").append(
			$("<td>").html(),		
			$("<td>").html(),		
			$("<td>").html(),		
			$("<td class='td4'>").html(),
			$("<td class='td3'> ").html()
		);
	}


	
	let searchForm = $("#searchForm").paging({
		pagingArea : "#pagingArea",
		pageLink : ".pageLink",
		searchUI : "#searchUI",
		btnSelector : "#searchBtn",
		pageKey : "page",
		pageParam : "page",
		searchUIChangeTrigger:true
	}).ajaxForm({
		dataType:"json",
		success:function(pagingVO){
			tbody.empty();
			pagingArea.empty();
			let projectList = pagingVO.dataList;
			let trTags = [];
			idxs = 0;
			if(projectList && projectList.length > 0){
				$(projectList).each(function(idx, project){
					trTags.push( makeTrTag(project) );
					idxs = idx;
				});
				while(idxs!=15){
					trTags.push(makeTag());
					idxs +=1;
				}
				pagingArea.html(pagingVO.pagingHTML);
			}else{
				trTags.push(
					$("<tr>").html(
						$("<td>").attr("colspan", "5").html("조건에 맞는 프로젝트가 없습니다.")	
					)			
				);
				while(idxs!=15){
					trTags.push(makeTag());
					idxs +=1;
				}
			}
			tbody.append(trTags);
		} // success end
	}).submit();
	
	
	
	//체크박스 전체 개수구하기
	$('#cb').on("change",".checkbox",function(){
		allbox = $("input:checkbox").length-1; 
		//전체선택 체크박스 제외 체크된박스 개수 구하기
		cnt = $("#cb input[type=checkbox]:checked").length;
		//체크박스가 다 체크될 경우 전체선택체크박스도 체크
		if(cnt == allbox){
			$(".checkAll").prop('checked',true);
		}else{
			$(".checkAll").prop('checked',false);
		}
	})
	
})
</script>
