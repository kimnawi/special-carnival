<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비과세유형</title>
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
* {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 18px;
}
tr{
	height:36px;
}
table{
	border-collapse: collapse;
	width: 100%;
}
td,th{
	border: 1px solid #EAEAEA;
	text-align: center;
}
th{
	background : #FCFCFE;
}
#th1{
	width : 140px;
} 
#th2{
 	width : 400px;
}
#th3{
	width : 90px;
}
#th4{
 	width : 500px;
}
#th5{
	width : 170px;
}
#th6{
 	width : 250px;
}
tfoot td{
	text-align: center;
}
#searchUI{
	position: static;
	margin-bottom : 5px;
	text-align: right;
}
h4{
	display:inline-block;
	margin : 0px;
}
.link:hover{
	text-decoration: underline;
	color:blue;
	cursor: pointer;
}
.link{
	color:#4472C4;
}
.link:hover{
	color:#4472C4;
}
tfoot td{
	border: none;
}
.pageLink{
	color:black;
	text-decoration: none;
}
#pagingArea{
	margin-top: 30px;
}
#title{
	margin: 10px;
	font-size: 20px;
	font-weight: bold;
}
#bottom{
	width: 97%;
	position: fixed;
	bottom: 10px;
	z-index: 1;
}
.long{
	text-align: left;
}
</style>
<body>
	<div id="top">
		<span id="title">인사발령조회</span>
		<hr color="#F1F4FF">
	</div>
<div id="searchUI">
	<input type="text" name="tfNm" placeholder="비과세유형명" value="${pagingVO.detailSearch.tfNm}" />
	<input type="button" value="검색" id="searchBtn">
</div>
<table>
	<thead>
		<tr>
			<th id="th1">비과세유형코드</th>
			<th id="th2">비과세유형명</th>
			<th id="th3">소득코드</th>
			<th id="th4">관계법령</th>
			<th id="th5">지급명세서작성여부</th>
			<th id="th6">적요</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="6">
				<div id="pagingArea" class="d-flex justify-content-center"></div>
			</td>
		</tr>
	</tfoot>
</table>
	<div id="bottom">
		<hr color="#F1F4FF">
		<button type="button" onclick="window.close()">닫기</button>
	</div>
<form id="searchForm">
	<input type="hidden" name="page">
	<input type="hidden" name="tfNm" value="${pagingVO.detailSearch.tfNm}">
</form>
<script type="text/javascript" src="${cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="${cPath}/resources/js/paging.js"></script>
<script src="${cPath}/resources/js/jquery.form.min.js"></script>
</body>
<script>
	$(function(){
		let tbody = $("tbody");
		$(tbody).on("click",".link",function(){
			code =$(this).parent().attr("code");
			nm = $(this).parent().attr("nm");
			opener.document.getElementById("nm").value = nm;
			opener.document.getElementById("code").value = code;
			window.close();
		})
		
		$(document).ajaxComplete(function(event, xhr, options){
			searchForm.find("[name='page']").val("");
		}).ajaxError(function(event, xhr, options, error){
			console.log(event);
			console.log(xhr);
			console.log(options);
			console.log(error);
		});
		let pagingArea = $("#pagingArea");
		function makeTrTag(tax){
			return $("<tr>").append(
				$("<td class='link'>").html(tax.tfCode),		
				$("<td class='long'>").html(tax.tfNm),		
				$("<td>").html(tax.tfIncome),		
				$("<td class='long'>").html(tax.tfLaw),		
				$("<td>").html(tax.tfWrite),		
				$("<td class='long'>").html(tax.tfSumry)		
			).attr("code",tax.tfCode).attr("nm",tax.tfNm);
		}
		function makeTag(){
			return $("<tr>").append(
				$("<td>").html(),		
				$("<td>").html(),		
				$("<td>").html(),		
				$("<td>").html(),
				$("<td>").html()
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
				let taxList = pagingVO.dataList;
				console.log(taxList);
				let trTags = [];
				idxs = 0;
				if(taxList && taxList.length > 0){
					$(taxList).each(function(idx, tax){
						trTags.push( makeTrTag(tax) );
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
							$("<td>").attr("colspan", "6").html("조건에 맞는 결과가 없음.")	
						)			
					);
				}
				tbody.append(trTags);
			} // success end
		}).submit();
	})
	
</script>
</html>