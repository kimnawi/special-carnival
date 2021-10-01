<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정관리등록</title>
<link rel="stylesheet" href="${ cPath }/resources/css/emplForm.css">
<style>
table{
	width: 900px;
}
#searchBtn{
 	margin-left: -10px;
}
#scheSort2{
	margin-left: -5px;
	margin-right: 0px;
}
input[type=checkbox] {
	zoom: 1.5;
	position: relative;
	top: 2px;
}
#date{
	margin-right: -2px;
}
#attendee{
	margin-left: -6px;
}
#shareEmpl{
	margin-left: -6px;
}
</style>
</head>
<body>
	<div id="top">
	<span id="title">일정관리등록</span>
	<hr color="#F1F4FF">
	<form:form commandName="sche" id="scheForm" method="post" enctype="multipart/form-data">
	<table>
		<tbody id="basic">
			<tr>
				<th>제목</th>
				<td colspan="3">
					<input type="text" id="scheTitle" name="scheTitle" placeholder="제목" style="width:740px">
				</td>
			</tr>
			<tr>
				<th>일정구분</th>
				<td>
					<input type="text" class="code" id="scheSort1" name="scheSort1" style="width:100px">
					<button id="searchBtn" class="small-search" data-action="scheSearch" type="button">
                  	<img class="searchImg" src="${ cPath }/resources/images/Search.png">
             		</button>
					<input type="text" class="nm" id="scheSort2" name="scheSort2" style="width:200px">
				</td>
				<th>캘린더</th>
				<td>
				<select style="width: 250px; height: 35px;">
					<option value="ALL" style="background-color: #EAEAEA; color: black">[기본]공유일정캘린더</option>
					<option value="MINE" style="background-color: #EAEAEA; color: black">개인일정캘린더</option>
				</select>
				</td>
			</tr>
			<tr>
				<th>장소</th>
				<td colspan="3">
					<input type="text" id="location" name="location" placeholder="장소" style="width:740px">
				</td>
			</tr>
			<tr>
				<th>날짜/시간</th>
				<td colspan="3">
					<input type="date" id="date" name="date" style="width:200px">&ensp;&ensp;&ensp;
					<span class="timeForm">
					<input type="time" id="startTime" name="startTime" style="width:200px">&ensp;~&ensp;<input type="time" id="endTime" name="endTime" style="width:200px">
					</span>
					<input type="checkbox" id="allDay">종일
				</td>
			</tr>
			<tr>
				<th>참석자</th>
				<td colspan="3">
					<span class="emplForm">
					<button id="searchBtn2" class="small-search" data-action="emplSearch" type="button">
                  	<img class="searchImg" src="${ cPath }/resources/images/Search.png">
             		</button>
					<input type="text" class="nm" id="attendee" name="attendee" placeholder="참석자" style="width:633px">
					</span>
					<input type="checkbox" class="allEmpl">전체
				</td>
			</tr>
			<tr>
				<th>공유자</th>
				<td colspan="3">
					<span class="emplForm">
					<button id="searchBtn3" class="small-search" data-action="emplSearch" type="button">
                  	<img class="searchImg" src="${ cPath }/resources/images/Search.png">
             		</button>
					<input type="text" class="nm" id="shareEmpl" name="shareEmpl" placeholder="공유자" style="width:633px">
					</span>
					<input type="checkbox" class="allEmpl">전체
				</td>
			</tr>
			<tr>
				<th>참석자권한</th>
				<td colspan="3">
					<input type="checkbox" id="checkbox2">편집가능
				</td>
			</tr>
			<tr>
				<th>첨부</th>
				<td colspan="3">
					<a>추가</a>
				</td>
			</tr>
			<tr>
				<td colspan="5">
					<textarea class="form-control" name="scheContent" id="scheContent"></textarea>
				</td>
			</tr>
		</tbody>
	</table>
	</form:form>
	</div>
	<div id="bottom">
	<hr color="#F1F4FF">
	<input type="submit" class="saveBtn" value="저장">
	<input type="button" class="close" onclick="window.close()" value="닫기">
	</div>
<input type="hidden" id="code">
<input type="hidden" id="nm">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script src="${cPath }/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(function(){

   // ckEditor 로딩
   CKEDITOR.replace("scheContent", {width: '99%', height: '300',});

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
	            "taxFree",
	            "status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
	      popup.addEventListener('beforeunload', function(){
				code.val($("#code").val());
				nm.val($("#nm").val());
			});
   		});
   
	// 종일 버튼
	let timeForm = $(".timeForm").show();
	$("#allDay").change(function(){
		if($(this).is(":checked")){
			$(this).parent().find(timeForm).hide();
			$("input[name=startTime]").val("");
			$("input[name=endTime]").val("");
		} else if(!$(this).is(":checked")) {
			$(this).parent().find(timeForm).show();
		}
	});
	
	// 전체 버튼
	let emplForm = $(".emplForm").show();
	$(".allEmpl").change(function(){
		if($(this).is(":checked")){
			$(this).parent().find(emplForm).hide();
			$("input[name=attendee]").val("");
			$("input[name=shareEmpl]").val("");
		} else if(!$(this).is(":checked")) {
			$(this).parent().find(emplForm).show();
		}
	});
});
</script>
</body>
</html>