<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 양식작성</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<script src="${cPath }/resources/ckeditor/ckeditor.js"></script>
<link rel="styleSheet" href="${cPath }/resources/css/main.css">
<link rel="styleSheet" href="${cPath }/resources/css/draftForm.css">
<style>
	#title{
		font-size: 20px;
		margin: 10px;
		margin-bottom: 20px;
		font-weight: bold;
	}
	.saveBtn{
		width: 70px;
	}
	.resetBtn{
		width: 70px;
	}
	.cke_editable>table{
		width: 900px;
	}
</style>
</head>
<body>
	<div id="top">
		<span id="title">양식작성</span>
		<hr color="#F1F4FF">
	</div>
	<form id="draftFormEdit" method="post" enctype="multipart/form-data">
		<c:if test="${param.command eq 'UPDATE' }">
			<input type="hidden" name="dfNo" value="${draftFormVO.dfNo }">
			<input type="hidden" name="emplNo" value="${draftFormVO.emplNo }">
			<input type="hidden" name="dfUse" value="${draftFormVO.dfUse }">
		</c:if>
		<div id="draftWrapper">
			양식 제목: <input type="text" name="dfTitle" value="${draftFormVO.dfTitle eq '빈양식'?'':draftFormVO.dfTitle  }">
			<br><br>
			<textarea id="draftFormContent" class="form-control" name="dfContent">
				${draftFormVO.dfContent }
			</textarea>
		</div>
		<div id='bottom'>
		    <hr color='#F1F4FF'> 
			<input type="submit" class="saveBtn" value="저장">
			<button type="button" class="resetBtn" id="deleteBtn">삭제</button>
			<button type="button" class="resetBtn" onclick="window.close()">닫기</button>
		  </div>
	</form>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
 
<script>
	$(function(){
		const command = "${param.command}".substring(0,1)+"${param.command}".substring(1,"${param.command}".length).toLowerCase()
		CKEDITOR.replace("draftFormContent", {
			width: '100%',
			height: '560'
		});
		
		
		var draftFormEdit = $("#draftFormEdit").ajaxForm({
			url:"${cPath}/group/esign/draftForm"+command+".do",
			dataType: "json",
			success: function(res){
				if(res.result == "OK") {
					alert("저장이 완료되었습니다.")
					opener.$("input[name='page']").val(1);
					opener.reload();
					window.close();
				}else if(res.result == "FAIL"){
					alert("에러 발생, 개발자에게 문의해주세요.")
				}else{
					alert(res.result)
				}
			},
			error : function(xhr){
				alert(xhr.status)
			} //ajaxForm end
		});
		
		
		
		$("input[type='submit']").on("click",function(){
			var content = CKEDITOR.instances.draftFormContent.getData();
			var dfContent = $("#draftFormContent");
			dfContent.empty();
			dfContent.text(content);
		});
		
		
		$("#deleteBtn").on("click",function(){
			data = $("form").serialize();
			if(!confirm("${draftFormVO.dfTitle } 양식을 삭제하시겠습니까?")) return false;
			$.post("${cPath}/group/esign/draftFormDelete.do",data,function(res){
				if(res.result == "OK") {
					alert("삭제가 완료되었습니다.")
					window.close();
				}else if(res.result == "FAIL"){
					alert("에러 발생, 개발자에게 문의해주세요.")
				}else{
					alert(res.result);
				}
			})
		});
	});//$function end
</script>
</body>
</html>