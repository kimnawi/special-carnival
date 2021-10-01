<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<link rel="stylesheet" href = "${ cPath }/resources/css/deptList.css">
<body>
<div id="top">
	<span id="title">부서등록</span>
	<hr color="#F1F4FF">
</div>
<div id="lll">
	<div id="searchUI">
		<input class="sc2" type="text" placeholder="부서명" name="deptNm" value="${pagingVO.detailSearch.deptNm}" />
		<input type="button" value="검색" id="searchBtn">
	</div>
	<table id="propro">
		<thead>
			<tr>
				<th><input type="checkbox" class="checkAll"></th>
				<th id="th1">부서코드</th>
				<th id="th2">부서명</th>
				<th id="th3">상위부서명</th>
				<th id="th4">사용구분</th>
			</tr>
		</thead>
		<tbody id="cb">
		</tbody>
		<tfoot >
			<tr >
				<td colspan="5" >
					<div id="pagingArea"></div>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
<div id="form">
	<form:form commandName="dept" method="post" action="${cPath}/empl/departmentInsert.do">
		<table>
			<thead>
				<tr>
					<td colspan="2">
						<strong style="font-size: 20px;">부서등록 및 수정</strong>
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>부서명</th>
					<td class='formtd'>
					<input type="text" name="deptNm" required value="${dept.deptNm}"/>
					<input type="hidden" name="deptCode">
					<input type="hidden" name="deptParent">
					</td>
				</tr>
				<tr>
					<th>상위부서</th>
					<td class="formtd">
				 		<div class="select_box">
				 			<div class="box">
				 				<div class="select">--상위부서--</div>
				 				<ul class="list">
				 					<li class="selected">--상위부서--</li>
									<c:forEach items="${List}" var="dept">
									<li idx="${dept.deptCode}">${dept.deptNm}</li>
									</c:forEach>
				 				</ul>
				 			</div>
				 		</div>
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
	<form id="searchForm">
		<input type="hidden" name="page">
		<input type="hidden" name="deptNm" value="${pagingVO.detailSearch.deptNm }">
	</form>
</div>
<script type="text/javascript" src="${cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="${cPath}/resources/js/paging.js"></script>
<script src="${cPath}/resources/js/jquery.form.min.js"></script>
</body>
<script>

// 셀렉
function CustomSelectBox(selector){
    this.$selectBox = null,
    this.$select = null,
    this.$list = null,
    this.$listLi = null;
    CustomSelectBox.prototype.init = function(selector){
        this.$selectBox = $(selector);
        this.$select = this.$selectBox.find('.box .select');
        this.$list = this.$selectBox.find('.box .list');
        this.$listLi = this.$list.children('li');
    }
    CustomSelectBox.prototype.initEvent = function(e){
        var that = this;
        this.$select.on('click', function(e){
            that.listOn();
        });
        this.$listLi.on('click', function(e){
            that.listSelect($(this));
        });
        $(document).on('click', function(e){
            that.listOff($(e.target));
        });
    }
    CustomSelectBox.prototype.listOn = function(){
        this.$selectBox.toggleClass('on');
        if(this.$selectBox.hasClass('on')){
            this.$list.css('display', 'block');
        }else{
            this.$list.css('display', 'none');
        };
    }
    CustomSelectBox.prototype.listSelect = function($target){
        $target.addClass('selected').siblings('li').removeClass('selected');
        this.$selectBox.removeClass('on');
        this.$select.text($target.text());
        this.$list.css('display', 'none');
        par.val($target.attr('idx'));
    }
    CustomSelectBox.prototype.listOff = function($target){
        if(!$target.is(this.$select) && this.$selectBox.hasClass('on')){
            this.$selectBox.removeClass('on');
            this.$list.css('display', 'none');
        };
    }
    this.init(selector);
    this.initEvent();
}

// end 셀렉
$(function(){
	$("#firstSelected").css("background", "none").css("color", "black");
	
	$("input[type='reset']").on("click",function(){
		$("#form").find("div[class=select]").html("선택");
		par.val("");
		cod.val("");
	})
	
	  var select = new CustomSelectBox('.select_box');
	
	$("#exExcel").on("click",function(){
		$.ajax({
			url : "${cPath}/empl/excelDept.do",
			dataType : "text",
			success : function(resp) {
				cAlert("다운로드 완료")
			}
		});
		
	})
	
	nam = $("#form input[name=deptNm]");
	par = $("#form input[name=deptParent]");
	cod = $("#form input[name=deptCode]");
	$("#cb").on("click",".tag",function(){
		code = $(this).attr("code");
		$.ajax({
			url : "${cPath}/empl/selectDept.do",
			data : {"deptCode" : code},
			dataType : "json",
			success : function(resp) {
				console.log(resp);
				nam.val(resp.deptNm);
				if(resp.deptPnm != null){
					$("#form").find("div[class=select]").html(resp.deptPnm);
				}else{
					$("#form").find("div[class=select]").html("선택");
				}
				cod.val(resp.deptCode);
				par.val(resp.deptParent);
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
			location.href="${cPath}/empl/deptDelete.do?deptCode="+value+"&use=${use}";
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
			location.href="${cPath}/empl/deptStop.do?deptCode="+value+"&use=${use}";
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
			location.href="${cPath}/empl/deptContinue.do?deptCode="+value+"&use=${use}";
		}	
	})
	
	//체크박스전체선택
	$('.checkAll').on('click',function(){
		ck = $(this).prop('checked');
	
		$(this).parents('table').find('.checkbox').prop('checked', ck);
	})

	
	
	//사용중단포함
	$("#useNo").on("click",function(){
		location.href="${cPath}/empl/deptListY.do?use=no"
	})
	//사용중단미포함
	$("#useYes").on("click",function(){
		location.href="${cPath}/empl/deptList.do?use=yes";
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
	function makeTrTag(dept){
		code = dept.deptCode;
		
		if(dept.deptUse == 'Yes'){
		return $("<tr>").append(
			$("<td>").html("<input type='checkbox' class='checkbox' value='"+code+"'>"),
			$("<td class='selectDept'>").html(dept.deptCode),		
			$("<td class='selectDept'>").html(dept.deptNm),		
			$("<td class='td4'>").html(dept.deptPnm),		
			$("<td class='td3'> ").html(dept.deptUse)
		).attr("code",dept.deptCode).attr("class","tag");
		}else{
			return $("<tr>").append(
				$("<td>").html("<input type='checkbox' class='checkbox' value='"+code+"'>"),
				$("<td class='selectDept'>").html(dept.deptCode),		
				$("<td class='selectDept'>").html(dept.deptNm),		
				$("<td class='td4'>").html(dept.deptPnm),		
				$("<td class='td3'> ").html(dept.deptUse)
			).attr("code",dept.deptCode).attr("class","tag red");
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
		url: "${ cPath }/empl/deptList.do",
		dataType:"json",
		success:function(pagingVO){
			tbody.empty();
			pagingArea.empty();
			let deptList = pagingVO.dataList;
			let trTags = [];
			idxs = 0;
			if(deptList && deptList.length > 0){
				$(deptList).each(function(idx, dept){
					trTags.push( makeTrTag(dept) );
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
						$("<td>").attr("colspan", "5").html("조건에 맞는 결과가 없음.")	
					)			
				);
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
