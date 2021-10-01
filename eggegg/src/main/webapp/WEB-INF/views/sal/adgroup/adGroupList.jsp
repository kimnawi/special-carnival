<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${cPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="${ cPath }/resources/css/adGroupList.css">
</head>
<body>
	<div id="top">
		<span id="title">수당/공제그룹등록</span>
		<hr color="#F1F4FF">
	</div>
<div id="maindiv">
	<table id="adgroup">
		<thead>
			<tr>
				<td colspan="4" class="header">
					<input class="sc2" type="text" placeholder="수당/공제그룹명" name="adgNm" value="${pagingVO.detailSearch.adgNm}" />
					<input type="button" value="검색" id="searchBtn">
				</td>
			</tr>
			<tr>
				<th class="emplListTd"><input type="checkbox" class="checkAll"></th>
				<th>수당/공제그룹코드</th>
				<th>수당/공제그룹명</th>
				<th>사원</th>
			</tr>
		</thead>
		<tbody id="cb">
		</tbody>
		<tfoot>
			<tr>
				<td colspan="4">
					<div id="pagingArea"></div>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
<div id="form">
	<h4>적용사원등록</h4>
	<form:form id="empl" commandName="empl" method="post" action="${cPath}/sal/UpdateEmplGroup.do">
		<div id="formtitle">
			<div class="lititle">
				수당/공제그룹코드
			</div>
			<div class="lispan">
				<span id="adgCode"></span>
				<input type="hidden" name="adgCode">
			</div>
			<br>
			<div class="lititle">
				수당/공제그룹명
			</div>
			<div class="lispan">
				<span id="adgNm"></span>
				<input type="hidden" name="adgNm">
			</div>
		</div>
		<div id="form2">
			<table>
				<thead>
					<tr>
						<th class="th1 emplListTd"><input type="checkbox" class="checkAll2"></th>
						<th class="plus"></th>
						<th class="th2">사원번호</th>
						<th class="th3">성명</th>
						<th class="th4">부서</th>
						<th class="th5">지급률</th>
					</tr>
				</thead>
				<tbody id="cb2">
					
					
				<c:forEach var="i" begin="1" end="3"> 
					<tr>
						<td class="emplListTd"><input type="checkbox" class="checkbox2"></td>
						<td class="plus"> + </td>
						<td><input type="text" name="emplNo"></td>
						<td class="cen "><span class="emplNm"></span></td>
						<td class="cen"><span class="deptNm"></span></td>
						<td><input class="per" type="text" name="emplAdgper" onkeyup="inputNumberFormat(this)"></td>
					</tr>
				</c:forEach>	
					
					
				</tbody>	
			</table>
		</div>
		<div id="hidden">
		
		</div>
		<input type="submit" id="realsave" style="display:none;">
	</form:form>
	<div id="bottom2">
		<input type="button" value="저장" id="save" class="saveBtn">
		<input type="button" value="선택삭제" id="remove">
	</div>
</div>
<div id="background"></div>
<div id="bottom">
	<hr color="#F1F4FF">
	<input type="button" value="신규" id="create">
	<input type="button" value="삭제" id="delete">
	<input type="button" value="Excel" id="exExcel">
</div>
<div id="bottom-background"></div>
<form id="searchForm">
	<input type="hidden" name="page">
	<input type="hidden" name="adgNm" value="${pagingVO.detailSearch.adgNm}">	
</form>
<input type="hidden" id="nm">
<input type="hidden" id="code">
<input type="hidden" id="dept">
<script src="${cPath}/resources/js/paging.js"></script>
<script src="${cPath}/resources/js/jquery.form.min.js"></script>
</body>

<script type="text/javascript">
//콤마찍는거
function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    if(str.length>1){
	    str = str.replace(/(^0+)/, "");
    }else{
	    str = str.replace(/(^0+)/, "0");
    }
    return str.replace(/[^\d]+/g, '');
}
$(function(){
	$("#save").on("click",function(){
			
		per = $("#cb2").find(".per");
		for(i=0; i<per.length; i++){
			per.eq(i).removeAttr('onkeyup');
			tmp = per.eq(i).val();
			tmp = uncomma(tmp);
			per.eq(i).val(tmp);
		}
		$("#realsave").click();
	})
	
	$("#cb2").on("click","input[name=emplNo]",function(){
		thisis = $(this);
		tr = $(this).parent().parent();
		No = tr.find("input[name=emplNo]");
		nm = tr.find(".emplNm");
		dept = tr.find(".deptNm");
		var nWidth = 800;
		var nHeight = 1000;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);
		
		parent = $(this).parents("#cb2").find('input[name=emplNo]');
		cnt = parent.length;
		
		window.name = "group";
		popup = window.open(
				"${ cPath }/sal/emplSearch.do",
				"emplSearch",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		popup.addEventListener('beforeunload', function(){
			success = 0;
			for(i = 0; i<cnt; i++){
				if(parent.eq(i).val() == $("#code").val()){
					success = 1;
				}
			}
			if(success == 0){
				No.val($("#code").val());
				No.attr("readonly","readonly");
				nm.text($("#nm").val());
				dept.text($("#dept").val());
				if(No.length > 0){
					tr.find(".per").attr("required","required");
				}
			}else{
				thisis.attr('data-original-title',"중복된 항목입니다.").tooltip();
			}
			
		});
	})
	$("#cb2").on("blur","input[name=emplNo]",function(){
		$(this).removeAttr('data-original-title');
	})
	
	$("input[type=reset]").on("click",function(){
		$("#empl")[0].reset();
	})
	
	$("#remove").on("click",function(){
		check = $(".checkbox2:checked");
		
		for(i=0; i<check.length; i++){
			tr = check.eq(i).parent().parent();
			tr.find("input[type=checkbox]").prop("checked",false);
			val = tr.find("input[name=emplNo]").val();
			$("#hidden").append("<input type='hidden' name='emplDel' value="+val+">");
			tr.find("input[name=emplNo]").val("").removeAttr("value");
			tr.find(".emplNm").text("");
			tr.find(".deptNm").text("");
			tr.find("input[name=emplAdgper]").val("").removeAttr("required");
			
		}
		
		
	})
	
	function makeTr(empl){
		if(empl.emplAdgper == null){
			empl.emplAdgper = '';
		}
		empl.emplAdgper = comma(empl.emplAdgper);
		dept = "";
		if(empl.dept != null){
			dept = empl.dept.deptNm;
		}
		
		
		return $("<tr>").append(
			$("<td>").html("<input type='checkbox' class='checkbox2'>"),
			$("<td class='plus'>").html(" + "),
			$("<td>").html("<input type='text' name='emplNo' readonly value="+empl.emplNo+">"),
			$("<td class='cen'>").html("<span class='emplNm'>"+empl.emplNm+"</span>"),
			$("<td class='cen'>").html("<span class='deptNm'>"+dept+"</span>"),
			$("<td>").html("<input type='text' required class='per' onkeyup='inputNumberFormat(this)' name='emplAdgper' value="+empl.emplAdgper+">")
			)
		
	}
	
	//등록 버튼 클릭 시
	$("#cb").on("click",".empl",function(){
		$("#form").css("pointer-events","auto");
		code =$(this).parent().parent().attr("code");
		console.log(code);
		$.ajax({
			url : "${cPath}/sal/selectGroup.do",
			data : {"code" : code},
			success : function(resp) {
				$("#adgCode").text(resp.adgCode);
				$("#adgNm").text(resp.adgNm);
				$("input[name=adgCode]").val(resp.adgCode);
				$("#form2 input[name=adgNm]").val(resp.adgNm);
				console.log(resp);
				let trTags = [];
				if(resp.empl && resp.empl.length > 0){
					$("#cb2").empty();
					$(resp.empl).each(function(idx,empl){
						trTags.push(makeTr(empl));
					});
				}
				for(i =0; i<3; i++){
					html = $("<tr>").append(
					$("<td>").html("<input type='checkbox' class='checkbox2'>"),
					$("<td class='plus'>").html(" + "),
					$("<td>").html("<input type='text' name='emplNo' readonly='readonly'>"),
					$("<td class='cen'>").html("<span class='emplNm'></span>"),
					$("<td class='cen'>").html("<span class='deptNm'></span>"),
					$("<td>").html("<input type='text' name='emplAdgper' class='per' onkeyup='inputNumberFormat(this)'>")
					)
					trTags.push(html);
				}
				$("#cb2").html(trTags);
			}
		});
	})
	
	
	//적용사원 테이블 항목추가
	$("#cb2").on("click",".plus",function(){
		html = "<tr>";
		html += "<td><input type='checkbox' class='checkbox2'>";
		html += "<td class='plus'> + </td>";
		html += "<td><input type='text' name='emplNo' readonly></td>";
		html += "<td class='cen'><span class='emplNm'></span></td>";
		html += "<td class='cen'><span class='deptNm'></span></td>";
		html += "<td><input type='text' class='per' name='emplAdgper' onkeyup='inputNumberFormat(this)'></td>";
		html += "</tr>";
		$(this).parent().after(html);
	})
	
	//삭제 버튼 기능
	$("#delete").on("click",function(){
		val = $("#cb input[type=checkbox]:checked")
		cnt = val.length;
		value= "";
		for(i = 0; i<cnt; i++){
			if(i!=0){
				value += ",";
			}
			value += val.eq(i).val();
		}
		if(cnt == 0){
			cAlert("리스트에 선택된 항목이 없습니다.<br>체크박스에 체크한 후 다시 시도 바랍니다.");
		}else{
			location.href="${cPath}/sal/groupDelete.do?code="+value;
		}
		
	})
	
	//코드누르면 디테일창
	$("#cb").on("click",".code",function(){
		code = $(this).text();
		var nWidth = 1100;
		var nHeight = 800;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);
		window.name = "adgroup";
		detail = window.open(
				"${cPath}/sal/groupDetail.do?code="+code,
				"adgroupForm",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		detail.addEventListener('beforeunload',function(){
			setTimeout(() => {
			window.location.reload();
			}, 200);
		})
		
	})
	//신규등록창
	$("#create").on("click",function(){
		var nWidth = 1100;
		var nHeight = 800;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);
		window.name = "adgroup";
		popup = window.open(
				"${cPath}/sal/adGroupInsert.do",
				"adgroupForm",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		popup.addEventListener('beforeunload',function(){
			setTimeout(() => {
				window.location.reload();
				}, 200);
		})
	})
	
	$("#exExcel").on("click",function(){
		$.ajax({
			url : "${cPath}/sal/excelGroup.do",
			dataType : "text",
			success : function(resp) {
				cAlert("다운완료");				
			}
		});
		
	})
	
	//체크박스전체선택
	$('.checkAll').on('click',function(){
		ck = $(this).prop('checked');
		$(this).parents('table').find('.checkbox').prop('checked', ck);
	})
	//체크박스전체선택
	$('.checkAll2').on('click',function(){
		ck = $(this).prop('checked');
		$(this).parents('table').find('.checkbox2').prop('checked', ck);
	})
	
	$(document).ajaxComplete(function(event, xhr, options){
		searchForm.find("[name='page']").val("");
		$(".checkAll").prop('checked',false);
	}).ajaxError(function(event, xhr, options, error){
		console.log(event);
		console.log(xhr);
		console.log(options);
		console.log(error);
	});
	let tbody = $("#cb");
	let pagingArea = $("#pagingArea");
	
	function makeTrTag(group){
		code = group.adgCode;
		return $("<tr>").append(
			$("<td>").html("<input type='checkbox' class='checkbox' value='"+code+"'>"),
			$("<td>").html("<span class='a code'>"+group.adgCode+"</span>"),		
			$("<td>").html(group.adgNm),		
			$("<td class='td3'>").html("<span class='a empl'>등록</span>")		
		).attr("code",group.adgCode).attr("class","tag");
	}
	function makeTag(){
		return $("<tr>").append(
			$("<td>").html(),
			$("<td>").html(),
			$("<td>").html(),		
			$("<td class='td3'>").html()
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
		url : "${cPath}/sal/adGroupList.do",
		success:function(pagingVO){
			tbody.empty();
			pagingArea.empty();
			let groupList = pagingVO.dataList;
			let trTags = [];
			idxs = 0;
			if(groupList && groupList.length > 0){
				$(groupList).each(function(idx, group){
					trTags.push( makeTrTag(group) );
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
						$("<td>").attr("colspan", "4").html("조건에 맞는 결과가 없음.")	
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
		allbox = $("#cb input:checkbox").length; 
		//전체선택 체크박스 제외 체크된박스 개수 구하기
		cnt = $("#cb input[type=checkbox]:checked").length;
		//체크박스가 다 체크될 경우 전체선택체크박스도 체크
		if(cnt == allbox){
			$(".checkAll").prop('checked',true);
		}else{
			$(".checkAll").prop('checked',false);
		}
	})
	//체크박스 전체 개수구하기
	$('#cb2').on("change",".checkbox2",function(){
		allbox = $("#cb2 input:checkbox").length; 
		//전체선택 체크박스 제외 체크된박스 개수 구하기
		cnt = $("#cb2 input[type=checkbox]:checked").length;
		console.log(allbox);
		console.log(cnt);
		//체크박스가 다 체크될 경우 전체선택체크박스도 체크
		if(cnt == allbox){
			$(".checkAll2").prop('checked',true);
		}else{
			$(".checkAll2").prop('checked',false);
		}
	})
	
})
</script>
</html>