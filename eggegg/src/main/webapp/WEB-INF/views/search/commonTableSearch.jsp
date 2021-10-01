<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 기안서구분리스트</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script src="${ cPath }/resources/js/common.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 18px;
}
table{
	border-collapse: collapse;
	width: 100%;
}
th{
	text-align: center;
}
thead th{
	background: #FCFCFE;
}
td, th{
	border: 1px solid #EAEAEA;
	padding: 3px 10px;
	height: 36px;
}
tfoot td{
	border: none;
	text-align: center;
}
#pagingArea{
	margin-top: 30px;
}
#title{
	margin: 10px;
	font-size: 20px;
	font-weight: bold;
}
tbody tr td:first-child, tr th:first-child {
	text-align: center;
}
thead td{
	border: none;
}
thead td:last-child{
	text-align: right;
}
tbody tr{
	cursor: pointer;
	color: #4472C4;
}
tbody tr:hover{
	color: #4472C4;
	text-decoration: underline;
}
#bottom{
	width: 97%;
	position: fixed;
	bottom: 10px;
}
</style>
</head>
<body>
	<div id="top">
		<span id="title">기안서구분리스트</span>
		<hr color="#F1F4FF">
	</div>
	<table>
		<thead>
			<tr>
				<th>기안서구분</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<td>
					<div id="pagingArea"></div>
				</td>
			</tr>
		</tfoot>
	</table>
	<div id="bottom">
		<hr color="#F1F4FF">
		<input type="button" onclick="window.close()" value="닫기">
	</div>
<form id="searchForm">
	<input type="hidden" name="page">
	<input type="hidden" name="simpleSearch.typePrefix" value="${param.typePrefix }">
</form>
<script>
	$(function(){
		let tbody = $("tbody");
		let thead = $("thead");
		$(tbody).on("click", ".CTSelect", function(){
			nm = $(this).parent().attr("ctNm");
			code = $(this).parent().attr("ctCode");
			opener.document.getElementById("ctNm").value = nm;
			opener.document.getElementById("ctCode").value = code;
			window.close();
		});
		$(document).ajaxComplete(function(event, xhr, options){
			isEmptyBigo()
			searchForm.get(0).reset();
		});
		function isEmptyBigo(){
			cnt=2;
			for(var i=0;i<3;i++){
				tds = tbody.find("td:nth-child("+cnt+")")
				th = thead.find("th:nth-child("+cnt+")")
				$.each(tds,function(i,v){
					if(isEmpty($(v).text())){
					tds.remove();
					th.remove();
					}else{
						cnt++;
					}
				})
			}
		}
		
		let pagingArea = $("#pagingArea");
		let searchForm = $("#searchForm").paging().ajaxForm({
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				pagingArea.empty();
				let CTList = pagingVO.dataList;
				let trTags = [];
				if(CTList.length > 0){
					$(CTList).each(function(idx, ct){
							if(ct.ctUse=='Y'){
						trTags.push(
									$("<tr>").append(
										$("<td class='CTSelect'>").html(ct.ctNm),
										$("<td>").html(ct.ctNote1),
										$("<td>").html(ct.ctNote2),
										$("<td>").html(ct.ctNote3)
									).attr("ctNm", ct.ctNm).attr("ctCode",ct.ctTable)
						);
							}else{
						trTags.push(
									$("<tr>").append(
										$("<td class='CTSelect'>").html(ct.ctNm),
										$("<td>").html(ct.ctNote1),
										$("<td>").html(ct.ctNote2),
										$("<td>").html(ct.ctNote3)
									).attr("ctNm", ct.ctNm).attr("ctCode",ct.ctTable)
						);
							}
						idxs = idx;
						});
					while(idxs != 15){
						trTags.push(
							$("<tr>").append(
								$("<td>").css("border", "none").css("cursor","default")
							)		
						);
						idxs += 1;
					}
					pagingArea.html(pagingVO.pagingHTML);
				} else {
					trTags.push(
						$("<tr>").append(
							$("<td>").html("조건에 맞는 기안서구분이 없습니다.").css("color", "black")
						)
					);
				}
				tbody.append(trTags);
			}
		}).submit();
	});

</script>
</body>
</html>