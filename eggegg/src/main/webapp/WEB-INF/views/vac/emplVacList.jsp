<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원별휴가일수조회</title>
<link rel="stylesheet" href="${ cPath }/resources/css/list.css">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
</head>
<style>
	#searchUI{
		margin-left: 10px;
	}
	#searchUI table th{
		padding-left: 30px;
	}
	.selectEmplVac{
		color: #4472C4;
		cursor: pointer;
	}
	.selectEmplVac:hover{
		text-decoration: underline;
	}
	#excel{
		margin-left: 10px;
	}
	#list-table{
		width: 40%;
	}
	.emplNmList{
		position: absolute;
		display: inline-block;
		width: 937px;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
		word-break: break-all;
	}
	.searchImg {
		position: relative;
	    width: 25px;
	    right: 3px;
	    top: -1px;
	    margin: 0px;
	    padding: 0px;
	    z-index: 1;
	}
	.small-search {
	    position: relative;
	    display: inline;
	    top: -2px;
	    left:1px;
	    width: 33px;
	    height: 33px;
	    text-align: center;
	    vertical-align: middle;
	    z-index: 1;
	    bottom: 3px;
	    border: 1px solid black;
	    border-radius: 2px;
	}
	#searchUI input[type=text]:not(.nm), #searchUI input[type=date]{
		width: 250px;
	}
	.nm{
		width: 218px;
	}
	#searchUI{
		width: 99%;
	}
	#searchUI th{
		width: 150px;
	}
	#searchUI .btnArea{
		text-align: right;
	}
	.btnArea input{
		margin: 0 3px;
	}
</style>
<body>
	<div id="top">
		<span id="title">사원별휴가일수조회</span>
		<hr color="#F1F4FF">
	</div>
	<div id="searchUI">
		<form>
			<table>
				<tr>
					<td id="land"></td>
					<th>
						휴가코드
					</th>
					<td>
						<input type="hidden" class="code" name="vcatnCode">
						<button class="small-search" data-action="vcatnSearch" type="button">
							<img class="searchImg" src="${ cPath }/resources/images/Search.png">
						</button><input type="text" class="nm" name="vcatnNm" placeholder="휴가코드" readonly>
					</td>
					<th>
						사원
					</th>
					<td>
						<input type="hidden" class="code" name="emplNo">
						<button class="small-search" data-action="emplSearch" type="button">
							<img class="searchImg" src="${ cPath }/resources/images/Search.png">
						</button><input type="text" class="nm" name="emplNm" placeholder="사원" readonly>
					</td>
					<td class='btnArea'>
						<input type="button" id="searchBtn" value="검색"><input type="reset" value="초기화">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<table id="list-table">
		<thead>
			<tr>
				<th>휴가코드</th>
				<th>휴가명</th>
				<th>사용기간</th>
				<th>등록인원수</th>
				<th class="emplNmList">등록사원</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5" style="text-align: right;">
					<div id="pagingArea"></div>
				</td>
			</tr>
		</tfoot>
	</table>
	<form id="searchForm">
		<input type="hidden" name="page">
		<input type="hidden" name="vcatnCode" value="${ pagingVO.detailSearch.vcatnCode }">
		<input type="hidden" name="emplNo" value="${ pagingVO.detailSearch.emplNo }">
	</form>
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
			var nWidth = 900;
			var nHeight = 950;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name = action;
			popup = window.open(
					"${ cPath }/search/" + action + ".do",
					"searchTable",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				code.val($("#code").val());
				nm.val($("#nm").val());
			});
		});
		//검색 초기화
		$(document).ajaxComplete(function(event, xhr, options){
			searchForm.get(0).reset();
		});
		$("#searchUI input[type=reset]").on("click", function(){
			$("#searchUI input[type=hidden]").val("");
		});
		let tbody = $("#list-table tbody");
		let pagingArea = $("#pagingArea");
		let searchForm = $("#searchForm").paging().ajaxForm({
			dataType: "json",
			success: function(pagingVO){
				tbody.empty();
				pagingArea.empty();
				let vcatnList = pagingVO.dataList;
				let trTags = [];
				if(vcatnList.length > 0){
					$(vcatnList).each(function(idx, vcatn){
						emplNm = "";
						if(vcatn.empl != null){
							emplNm = vcatn.empl.emplNm;
						}
						trTags.push(
							$("<tr>").append(
								$("<td class='selectEmplVac'>").html(vcatn.vcatnCode),
								$("<td class='selectEmplVac'>").html(vcatn.vcatnNm),
								$("<td>").html(vcatn.vcatnStart + " ~ " + vcatn.vcatnEnd),
								$("<td>").html(vcatn.emplCount),
								$("<td class='emplNmList'>").html(emplNm).attr("title", emplNm)
							).data("vcatn", vcatn)
						)
						idxs = idx;
					});
					while(idxs != 15){
						trTags.push(
							$("<tr>").append(
								$("<td>").attr("colspan", "5").css("border", "none").css("height", "40px")
							)		
						);
						idxs += 1;
					}
					pagingArea.html(pagingVO.pagingHTML);
				} else {
					trTags.push(
						$("<tr>").append(
							$("<td>").attr("colspan", "5").html("조건에 맞는 휴가코드가 없습니다.")
						)
					)
					
				}
				tbody.append(trTags);
			}
		}).submit();
		$(tbody).on("click", ".selectEmplVac", function(){
			let vcatnCode = $(this).parents("tr").data().vcatn.vcatnCode;
			vcatnSelect = $(this).parents("tr").find("td");
			vcatnSelect.css("background", "#FEFAE5");
			vcatnSelect.not(".selectEmplVac").css("color", "#AAAAAA");
			var nWidth = 1700;
			var nHeight = 950;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name = "vacInsert";
			popup = window.open(
					"${ cPath }/vac/vacInsert.do?vcatnCode=" + vcatnCode,
					"searchTable",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				vcatnSelect.css({"background":"transparent"});
			});
		});
	});
</script>
</body>
</html>