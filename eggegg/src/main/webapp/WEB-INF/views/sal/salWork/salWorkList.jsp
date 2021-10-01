<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${cPath}/resources/js/paging.js"></script>
<script src="${cPath}/resources/js/jquery.form.min.js"></script>
<style>
main {
 	width: 84%; 
	padding: 30px 0 0;
}
#title{
	font-size: 20px;
	margin: 10px;
	margin-bottom: 20px;
	font-weight: bold;
}
hr{
	margin: 5px 0px;
}
#bottom{
	width: 98%;
	position: fixed;
	bottom: 75px;
	z-index: 2;
}
#searchUI{
	float:right;
}
tfoot td{
	text-align: center;
	border:none;
}
.th3{
	width : 400px;
}
.th10{
	width : 150px;
}
.th11{
	width : 150px;
}
td, th{
	border : 1px solid #EAEAEA;
	padding: 5px 10px;
	height: 36px;
}
th{
	text-align: center;
	background: #FCFCFE;
}
#sal{
	margin : 10px;
	width: 99%;
}
.cen{
	text-align: center;
}
.right{
	text-align: right;
}	
#sal .a{
	color: #4472C4;
}
#sal .a:hover {
	text-decoration: underline;	
	cursor: pointer;
}
#black{
	display:none;
	position:absolute;
	z-index: 6;
	top:0;
	left:0;
	width: 300%;
	height: 300%;
	background: rgba(0,0,0,0.6);
}
.search{
	border: none;
}
#background{
	position:fixed;
	bottom: 63px;
	height: 50px;
	width: 100%;
	background: white;
	z-index: 1;
}
#new{
	background: #3A4CA8;
	color: white;
	border-radius: 3px;
	padding: 1px 10px;
	margin: 2px 0px 2px 10px;
}
#spinner{
	position: absolute;
    left: 15%;
    top: 11%;
}
</style>
</head>
<body>
	<div id="top">
		&ensp;&ensp;&ensp;<span id="title">급여계산/대장</span>
		<hr color="#F1F4FF">
	</div>
	<table id="sal">
		<thead>
			<tr>
				<td colspan="10" class="search">
					<div id="searchUI">
						<input type="text" placeholder="급여대장명칭" name="piNm" value="${pagingVO.detailSearch.piNm}" />
						<input type="button" value="검색" id="searchBtn">
					</div>	
				</td>
			</tr>
			<tr>
				<th class="th1">신고귀속</th>
				<th class="th2">급여구분</th>
				<th class="th3">대장명칭</th>
				<th class="th4">지급일</th>
				<th class="th5">사전작업</th>
				<th class="th6">급여계산</th>
				<th class="th7">인원수</th>
				<th class="th8">급여대장</th>
				<th class="th10">지급총액</th>
				<th class="th11">상여지급액</th>
			</tr>
		</thead>
		<tbody>
		
		</tbody>
		<tfoot>
			<tr>
				<td colspan="10">
					<div id="pagingArea"></div>
				</td> 
			</tr>
		</tfoot>
	</table>
<div id="bottom">
	<hr color="#F1F4FF">
	<input type="button" value="신규" id="new">
</div>
<div id="background"></div>
<form id="searchForm">
	<input type="hidden" name="page">
	<input type="hidden" name="piNm" value="${pagingVO.detailSearch.piNm}">
</form>
<div id="black">
	<img id="spinner" src="${cPath }/resources/images/Spinner.gif">
</div>
</body>
<script>
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



$("#new").on("click",function(){
	var nWidth = 700;
	var nHeight = 500;
	var curX = window.screenLeft;
	var curY = window.screenTop;
	var curWidth = document.body.clientWidth;
	var curHeight = document.body.clientHeight;
	var nLeft = curX + (curWidth / 2) - (nWidth / 2);
	var nTop = curY + (curHeight / 2) - (nHeight / 2);
	window.name = "salWorkList";
	popup = window.open(
			"${cPath}/sal/createSalary.do",
			"salaryForm",
			"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
	popup.addEventListener('beforeunload',function(){
		setTimeout(() => {
			window.location.reload();
			}, 1000);
	})		
	
})

$(function(){
	$("#black").on("click",function(){
		e.stopPropagation();
		return false;
	})
	
	lert = $("#alertResult");
	$("tbody").on("click",".cal",function(){
		cAlert("기존 자료를 삭제하고 다시 계산합니다.","confirm");
		date = $(this).parent().parent().find(".date").text();
		date = date.replace(" ","");	
	})
	$("#alertResult").on("change",function(){
		if($(this).val() != 'true'){
			return false;
		}
		if($(FNNAME).val() == 'close'){
			$(PREVENTDIV).hide();
			FNNAME.value = "";
			$(this).val("false");
			window.location.reload();
			return false;
		}
		$("#black").show();
		$.ajax({
			url: "${ cPath }/sal/calculate.do",
			data: {"stdate": date},
			dataType: "text",
			method: "post",
			success: function(res){
				$("#black").css("display","none");
				cAlert("계산이 완료되었습니다.","","close");
				
			},
			error: function(xhr){
				alert(xhr.status);
			}
		}); 
	});
	$("tbody").on("click",".retrieve",function(){
		date = $(this).parent().parent().find(".date").text();
		date = date.replace(" ","");		
		var nWidth = 1500;
		var nHeight = 900;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);
		window.name = "salWorkList";
		popup = window.open(
				"${cPath}/sal/payInfo.do?stdate="+date,
				"salaryForm",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		popup.addEventListener('beforeunload',function(){
			setTimeout(() => {
				window.location.reload();
				}, 500);
		})					
		
	})
	
	$("tbody").on("click",".work",function(){
		date = $(this).parent().parent().find(".date").text();
		date = date.replace(" ","");
		var nWidth = 1000;
		var nHeight = 900;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);
		window.name = "salWorkList";
		popup = window.open(
				"${cPath}/sal/workpopup.do?stdate="+date,
				"salaryForm",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		popup.addEventListener('beforeunload',function(){
			setTimeout(() => {
				window.location.reload();
				}, 500);
		})			
		
		
	})
	
	$("tbody").on("click",".date",function(){
		date = $(this).text();
		date = date.replace(" ","");
		var nWidth = 700;
		var nHeight = 500;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);
		window.name = "salWorkList";
		popup = window.open(
				"${cPath}/sal/salUpdate.do?stdate="+date,
				"salaryForm",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		popup.addEventListener('beforeunload',function(){
			setTimeout(() => {
				window.location.reload();
				}, 500);
		})	
		
		
	})
	
	
	
	function makeTrTag(sal){
		bonus = "";
		if(sal.piBonusamount == null){
			bonus = "";
		}else{
			bonus = comma(sal.piBonusamount);
		}
		if(sal.piSum == null){
			sum = "";
		}else{
			sum = comma(sal.piSum);
		}
		return $("<tr>").append(
			$("<td class='cen'>").html("<span class='a date'>"+sal.piStdate+"</span>"),
			$("<td class='cen'>").html(sal.piType),		
			$("<td>").html(sal.piNm),
			$("<td class='cen'>").html(sal.piPayday),
			$("<td class='cen'>").html("<span class='a work'>근무기록확정</span>"),
			$("<td class='cen'>").html("<span class='a cal'>전체계산</span>"),
			$("<td class='cen'>").html(sal.empl),
			$("<td class='cen'>").html("<span class='a retrieve'>조회</span>"),
			$("<td class='right'>").html(sum),
			$("<td class='right'>").html(bonus)
		);
	}
	function makeTag(){
		return $("<tr>").append(
			$("<td>").html("&nbsp;").css("border", "none"),
			$("<td>").html("&nbsp;").css("border", "none"),
			$("<td>").html("&nbsp;").css("border", "none"),		
			$("<td>").html("&nbsp;").css("border", "none"),		
			$("<td>").html("&nbsp;").css("border", "none"),		
			$("<td>").html("&nbsp;").css("border", "none"),		
			$("<td>").html("&nbsp;").css("border", "none"),		
			$("<td>").html("&nbsp;").css("border", "none"),		
			$("<td>").html("&nbsp;").css("border", "none"),		
			$("<td>").html("&nbsp;").css("border", "none")
		);
	}
	
	let tbody = $("tbody");
	let pagingArea = $("#pagingArea");
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
		url : "${cPath}/sal/salWorkList.do",
		success:function(pagingVO){
			tbody.empty();
			pagingArea.empty();
			let salList = pagingVO.dataList;
			let trTags = [];
			idxs = 0;
			if(salList && salList.length > 0){
				$(salList).each(function(idx, sal){
					trTags.push( makeTrTag(sal) );
					idxs = idx;
				});
				while(idxs!=14){
					trTags.push(makeTag());
					idxs +=1;
				}
				pagingArea.html(pagingVO.pagingHTML);
			}else{
				trTags.push(
					$("<tr>").html(
						$("<td>").attr("colspan", "11").html("조건에 맞는 결과가 없음.")	
					)
				);
				while(idxs!=14){
					trTags.push(makeTag());
					idxs +=1;
				}
			}
			tbody.append(trTags);
		} // success end
	}).submit();
	
	
})



</script>
</html>