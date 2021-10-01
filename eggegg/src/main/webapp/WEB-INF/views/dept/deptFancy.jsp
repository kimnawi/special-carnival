<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/js/fancytree/skin-win8/ui.fancytree.min.css">
<script type="text/javascript" src="${ cPath }/resources/js/fancytree/jquery.fancytree-all-deps.min.js"></script>
<link rel="stylesheet" href="${ cPath }/resources/css/list.css">
<title>Insert title here</title>
<style>
	main{
		width: 84%;
		padding: 30px 0 0;
	}
	#center{
		height: 100%;
	}
	#tree, #emplListDiv{
		height: 85%;
	}
	#emplListDiv{
		width: 1260px;
	}
	#tree{
		float: left;
		width: 300px;
		margin: 5px 10px;
		background: #FCFCFE;
	}
	ul.fancytree-container{
		margin: 10px;
		border: none;
	}
	#tree ul {
		display: flex;
		align-content: flex-start;
		flex-direction: column;
		flex-wrap: wrap;
		overflow: auto;
	}
	#tree .fancytree-icon{
		display: none;
	}
	#tree>ul>li>span>span {
		font-weight: bold;
		font-size: 1.1em;
	}
	#tree>ul>li>ul>li>span {
		font-weight: bold;
	}
	#tree ul{
		background: #FCFCFE;
		padding: 0 10px;
	}
	#tree span{
		margin: 3px;
	}
	#emplListDiv{
		float: left;
		padding: 10px;
	}
	#top{
		width: 100%;
	}
	#title{
		margin: 30px;
		font-size: 20px;
		font-weight: bold;
	}
	hr{
		margin: 5px 0px;
	}
	#deptTitle{
		margin: 10px;
		font-weight: bold;
	}
	#list-table thead tr th:first-child{
		width: 47px;
		padding: 5px 10px;
	}
	#list-table{
		margin-left: 0;
	}
</style>
</head>
<body>
<div id="top">
	<span id="title">조직도등록</span>
	<hr color="#F1F4FF">
</div>
<div id="center">
	<div id="tree"></div>
	<div id="emplListDiv">
		<div id="top">
			<span id="deptTitle">전체</span>
			<hr color="#FCFCFE">
		</div>
		<div id="topBtnDiv">
			<input type="button" id="allEmpl" value="전체사원보기">
			<input type="button" id="updateDeptLeader" value="부서장지정">
		</div>
		<table id="list-table">
			<thead>
				<tr>
					<th>
						<input type="checkbox" class="checkAll">
					</th>
					<th>사원번호</th>
					<th>성명</th>
					<th>소속부서</th>
					<th>직위/직급</th>
					<th>부서장</th>
				</tr>
			</thead>
			<tbody></tbody>
			<tfoot>
				<tr>
					<td colspan="6">
						<div id="pagingArea"></div>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</div>
<input type="button" id="fancyAll">
<div id="searchUI">
	<input type="hidden" id="searchDeptCode" name="deptCode">
	<input type="hidden" id="searchBtn">
</div>
<form id="searchForm">
	<input type="hidden" name="page">
	<input type="hidden" name="deptCode" value="${ pagingVO.detailSearch.deptCode }">
</form>
<form id="deptLeaderForm" action="${ cPath }/empl/deptUpdateLeader.do" method="post">
	<input type="hidden" name="deptCode">
	<input type="hidden" name="deptLeader">
</form>
<script src="${ cPath }/resources/js/paging.js"></script>
<script>
	$(function(){
		$("#allEmpl").hide();
		$("#updateDeptLeader").hide();
		
		let tbody = $("#list-table tbody");
		let pagingArea = $("#pagingArea");
		let deptTitle = $("#deptTitle");
		//검색 초기화
		$(document).ajaxComplete(function(event, xhr, options){
			searchForm.get(0).reset();
			searchForm.find("[name='page']").val("");
		});
		//전체사원보기
		$("#allEmpl").on("click", function(){
			deptTitle.html("전체");
      		$("#searchDeptCode").val("");
			$("#searchBtn").click();
			$("#allEmpl").hide();
			$("#updateDeptLeader").hide();
		});
		let searchForm = $("#searchForm").paging().ajaxForm({
			url: "${ cPath }/empl/deptEmplList.do",
			dataType: "json",
			success: function(pagingVO){
				$("input[type=checkbox]").prop('checked', false);
				tbody.empty();
				pagingArea.empty();
				let emplList = pagingVO.dataList;
				let trTags = [];
				if(emplList.length > 0){
					$(emplList).each(function(idx, empl){
						let deptNm = "";
						let pstNm = "";
						if(empl.dept != null){
							deptNm = empl.dept.deptNm;
						}
						if(empl.position != null){
							if(empl.position.pstNm != null){
								pstNm = empl.position.pstNm;
							}
						}
						if(empl.deptLeaderAt == '0'){
							trTags.push(
								$("<tr>").append(
									$("<td>").append($("<input class='checkbox'>").attr("type", "checkbox")),
									$("<td class='emplNo'>").html(empl.emplNo),
									$("<td>").html(empl.emplNm),
									$("<td>").html(deptNm),
									$("<td>").html(pstNm),
									$("<td>").html("일반")
								).data("empl", empl)
							)
						} else if(empl.deptLeaderAt == '1'){
							trTags.push(
								$("<tr>").append(
									$("<td>").append($("<input class='checkbox'>").attr("type", "checkbox")),
									$("<td class='emplNo'>").html(empl.emplNo),
									$("<td>").html(empl.emplNm),
									$("<td>").html(deptNm),
									$("<td>").html(pstNm),
									$("<td>").html("부서장").css("color", "red")
								).data("empl", empl)
							)
						}
						idxs = idx;
					});
					while(idxs < 15){
						trTags.push(
							$("<tr>").append(
									$("<td>").attr("colspan", "6").css("border", "none")
								)
						)
						idxs += 1;
					}
					pagingArea.html(pagingVO.pagingHTML);
				} else {
					trTags.push(
						$("<tr>").html(
							$("<td>").attr("colspan", "6").html("해당하는 부서원이 없습니다.")	
						)
					);
				}
				tbody.append(trTags);
			}
		}).submit();
		//팬시트리
		deptCode = "";
		$("#tree").fancytree({
			source:{
				url: "${ cPath }/empl/deptFancy.do",
				cache: true
			},
			lazyLoad: function(event, data){
				var node = data.node;
				data.result = {
					url: "${ cPath }/empl/deptFancy.do",
					data: {deptParent: node.key},
					cache: false
				};
			},
			init: function(){
				$.ui.fancytree.getTree("#tree").expandAll();
			},
		    beforeSelect: function(event, data){
		        if(data.node.isFolder()){
		          return false;
		        }
	      	},
	      	click: function(event, data){
	      		var node = data.node;
	      		deptCode = node.key;
	      		deptNm = node.title;
	      		deptTitle.html(deptNm);
	      		$("input[name=deptCode]").val(deptCode);
	      		$("#searchBtn").click();
	      		$("#allEmpl").show();
	    		$("#updateDeptLeader").show();
	      	},
	      	loadChildren : function(){
	            $.ui.fancytree.getTree("#tree").expandAll();
	        }
		});
      	$("#updateDeptLeader").on("click", function(){
			cnt = $("input[type=checkbox]:checked", tbody).length;
			if(cnt < 1){
				cAlert("사원을 선택하세요.");
			} else if(cnt > 1) {
				cAlert("부서장은 부서 당 한 명만 지정할 수 있습니다.<br>한 명을 선택하세요.");
			} else {
				emplNo = $("input[type=checkbox]:checked", tbody).parents("tr").find(".emplNo").html();
				$("input[name=deptLeader]").val(emplNo);
				data = $("#deptLeaderForm").serialize();
				$.ajax({
					url: "${ cPath }/empl/deptUpdateLeader.do",
					data: data,
					dataType: "text",
					type: "post",
					success: function(res){
						$("input[name=deptCode]").val(deptCode);
			      		$("#searchBtn").click();
					},
					error: function(xhr){
						alert(xhr.status);
					}
				});
			}
		});
		//체크박스 클릭
		$('.checkAll').on('click',function(){
			ck = $(this).prop('checked');
			$(this).parents('table').find('.checkbox').prop('checked', ck);
		});
		$(tbody).on("change",".checkbox",function(){
			allbox = $("input:checkbox").length-1; 
			//전체선택 체크박스 제외 체크된박스 개수 구하기
			cnt = $("input[type=checkbox]:checked", tbody).length;
			//체크박스가 다 체크될 경우 전체선택체크박스도 체크
			if(cnt == allbox){
				$(".checkAll").prop('checked',true);
			}else{
				$(".checkAll").prop('checked',false);
			}
		});
	});
</script>
</body>
</html>