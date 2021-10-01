<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<title>EGGEGG | 최종학력입력</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
	*{
		font-family: 'Noto Sans KR', sans-serif;
		font-size: 18px;
	}
	table{
		border-collapse: collapse;
		background: #FCFCFE; 
		width: 100%;
	}
	th{
		text-align: inherit;
	}
	th, td{
		padding: 5px 15px;
	}
	#title{
		font-size: 20px;
		font-weight: bold;
		margin-left: 20px;
	}
	#bottom{
		width: 97%;
		position: absolute;
		bottom: 10px;
	}
	.saveBtn {
	    display: inline-block;
	    text-decoration: none;
	    color: white;
	    padding: 1px 12px;
	    background: #3A4CA8;
	    border-radius: 3px;
	}
	.required{
		color: red;
	}
	.list-table input[type=text]{
		width: 220px;
	}
	.list-table input[type=date]{
		width: 223px;
	}
	.list-table select{
		width: 228px;
	}
</style>
</head>
<body>
	<div id="top">
		<span id="title">최종학력입력</span>
		<hr color="#F1F4FF">
	</div>
	<form:form id="emplAcadBackForm">
		<table class="list-table">
			<tr>
				<th>학력 <span class="required">*</span></th>
				<td>
					<select name="abType">
						<option value>== 학력 ==</option>
						<c:forEach items="${ abTypeList }" var="abType">
							<option value="${ abType.ctTable }">${ abType.ctNm }</option>
						</c:forEach>
					</select>
					<form:errors path="abType" element="label" id="abType-error" cssClass="error" for="abType"/>
				</td>
			</tr>
			<tr>
				<th>학교명 <span class="required">*</span></th>
				<td>
					<input type="text" name="abSchool" placeholder="학교명" value="${ acad.abSchool }">
					<form:errors path="abSchool" element="label" id="abSchool-error" cssClass="error" for="abSchool"/>
				</td>
			</tr>
			<tr>
				<th>입학일자</th>
				<td>
					<input name="abAdmission" type="date" value="${ acad.abAdmission }">
					<form:errors path="abAdmission" element="label" id="abAdmission-error" cssClass="error" for="abAdmission"/>
				</td>
			</tr>
			<tr>
				<th>졸업일자</th>
				<td>
					<input name="abGraduation" type="date" value="${ acad.abGraduation }">
					<form:errors path="abGraduation" element="label" id="abGraduation-error" cssClass="error" for="abGraduation"/>
				</td>
			</tr>
			<tr>
				<th>전공명</th>
				<td>
					<input type="text" name="abMajor" placeholder="전공명" value="${ acad.abMajor }">
					<form:errors path="abMajor" element="label" id="abMajor-error" cssClass="error" for="abMajor"/>
				</td>
			</tr>
			<tr>
				<th>졸업구분</th>
				<td>
					<select name="abGrdtype">
						<option value>== 졸업구분 ==</option>
						<option value="재학">재학</option>
						<option value="중퇴">중퇴</option>
						<option value="수료">수료</option>
						<option value="휴학">휴학</option>
						<option value="졸업">졸업</option>
					</select>
					<form:errors path="abGrdtype" element="label" id="abGrdtype-error" cssClass="error" for="abGrdtype"/>
				</td>
			</tr>
		</table>
		<div id="bottom">
			<hr color="#F1F4FF">
			<input type="button" class="saveBtn" id="inputAcad" value="입력">
			<input type="reset" value="초기화">
			<input type="button" class="close" value="닫기">
		</div>
	</form:form>
	${closeScript }
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script>
	$(function(){
		$("#title").on("click", function(){
			$("select[name=abType]").val("E400");
			$("input[name=abSchool]").val("서강대학교");
			$("input[name=abAdmission]").val("2013-03-04");
			$("input[name=abGraduation]").val("2018-02-16");
			$("input[name=abMajor]").val("경영학과");
			$("select[name=abGrdtype]").val("졸업");
		});
		<c:if test="${ message ne NULL }">
			alert("${ message }");
		</c:if>
		$(".close").on("click", function(){
			window.close();
		});
		//학력구분
		abType = '${ acad.abType }';
		$("select[name=abType]").val(abType);
		//졸업구분
		abGrdtype = "${ acad.abGrdtype }";
		$("select[name=abGrdtype]").val(abGrdtype);
		
		$("#emplAcadBackForm").on("click", "#inputAcad", function(){
			abType = $('select[name=abType]').val();
			abSchool = $('input[name=abSchool]').val();
			abAdmission = $('input[name=abAdmission]').val();
			abGraduation = $('input[name=abGraduation]').val();
			abMajor = $('input[name=abMajor]').val();
			abGrdtype = $('select[name=abGrdtype]').val();
			$(opener.document).find("input[name='acad.abType']").val(abType);
			$(opener.document).find("input[name='acad.abSchool']").val(abSchool);
			$(opener.document).find("input[name='acad.abAdmission']").val(abAdmission);
			$(opener.document).find("input[name='acad.abGraduation']").val(abGraduation);
			$(opener.document).find("input[name='acad.abMajor']").val(abMajor);
			$(opener.document).find("input[name='acad.abGrdtype']").val(abGrdtype);
			window.close();
		});
	});
</script>
</body>
</html>