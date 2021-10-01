<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authEmpl"/>
</security:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EGGEGG | 인사카드등록</title>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="${ cPath }/resources/css/emplForm.css">
</head>
<body>
	<div id="top">
		<span id="title">인사카드등록</span>
		<hr color="#F1F4FF">
	</div>
	<div id="test">
	<form:form commandName="empl" id="emplForm" method="post" enctype="multipart/form-data">
		<table>
			<c:if test="${ command eq 'UPDATE' }">
				<thead>
					<tr>
						<td colspan="4">
							<button type="button" id="base">기본</button>
							<button type="button" id="sal">급여지급사항</button>
						</td>
					</tr>
				</thead>
			</c:if>
			<tbody id="basic">
				<tr>
					<th>사원번호 <span class="required">*</span></th>
					<td style="width: 450px;">
						<input type="text" name="emplNo" placeholder="사원번호" id="emplNo" value="${ empl.emplNo }" readonly>
						<form:errors path="emplNo" element="label" id="emplNo-error" cssClass="error" for="emplNo"/>
						<c:if test="${ command eq 'INSERT' }">
							<input name="emplPw" type="hidden" value="0000">
						</c:if>
						<c:if test="${ command eq 'UPDATE' }">
							<input name="emplPw" type="hidden" value="${ empl.emplPw }"> 
						</c:if>
					</td>
					<th>성명 <span class="required">*</span></th>
					<td>
						<input type="text" name="emplNm" placeholder="성명" value="${ empl.emplNm }"><br>
						<form:errors path="emplNm" element="label" id="emplNm-error" cssClass="error" for="emplNm"/>
					</td>
				</tr>
				<tr>
					<th>영문성명 <span class="required">*</span></th>
					<td>
						<input type="text" name="emplEngnm" placeholder="영문성명" value="${ empl.emplEngnm }">
						<form:errors path="emplEngnm" element="label" id="emplEngnm-error" cssClass="error" for="emplEngnm"/>
					</td>
					<th>제2외국어성명</th>
					<td>
						<input type="text" name="emplFornm" placeholder="제2외국어성명" value="${ empl.emplFornm }">
						<form:errors path="emplFornm" element="label" id="emplFornm-error" cssClass="error" for="emplFornm"/>
					</td>
				</tr>
				<tr>
					<th>입사일자 <span class="required">*</span></th>
					<td>
						<input name="emplEcny" type="date" value="${ empl.emplEcny }">
						<form:errors path="emplEcny" element="label" id="emplEcny-error" cssClass="error" for="emplEcny"/>
					</td>
					<th>입사구분 <span class="required">*</span></th>
					<td>
						<input name="emplEntrance" class="code" value="${ empl.emplEntrance }" type="hidden" placeholder="입사구분">
						<button  data-action="entranceSearch" class="small-search" type="button">
							<img class="searchImg" src="${ cPath }/resources/images/Search.png">
						</button><input type="text" class="nm entranceCtNm" placeholder="입사구분" value="${ empl.entrance.ctNm }" readonly>
						<form:errors path="emplEntrance" element="label" id="emplEntrance-error" cssClass="error" for="emplEntrance"/>
					</td>
				</tr>
				<tr>
					<th>모바일 <span class="required">*</span></th>
					<td>
						<input type="text" name="emplMobile" placeholder="모바일" value="${ empl.emplMobile }">
						<form:errors path="emplMobile" element="label" id="emplMobile-error" cssClass="error" for="emplMobile"/>
					</td>
					<th>내선전화</th>
					<td>
						<input type="text" name="emplTel" placeholder="전화" value="${ empl.emplTel }">
						<form:errors path="emplTel" element="label" id="emplTel-error" cssClass="error" for="emplTel"/>
					</td>
				</tr>
				<tr>
					<th>Email <span class="required">*</span></th>
					<td>
						<input type="text" name="emplEmail" placeholder="Email" value="${ empl.emplEmail }">
						<form:errors path="emplEmail" element="label" id="emplEmail-error" cssClass="error" for="emplEmail"/>
					</td>
					<th>여권번호</th>
					<td>
						<input type="text" name="emplPassport" placeholder="여권번호" value="${ empl.emplPassport }">
						<form:errors path="emplPassport" element="label" id="emplPassport-error" cssClass="error" for="emplPassport"/>
					</td>
				</tr>
				<c:if test="${ command eq 'UPDATE' }">
					<tr>
						<th>부서</th>
						<td>
							<input type="text" value="${ empl.dept.deptNm }" placeholder="부서명" disabled>
						</td>
						<th>프로젝트</th>
						<td>
							<input type="text" value="${ empl.project.prjNm }" placeholder="프로젝트명" disabled>
						</td>
					</tr>
					<tr>
						<th>직위/직급</th>
						<td>
							<input type="text" placeholder="직위/직급명" value="${ empl.position.pstNm }" disabled>
						</td>
						<th>직책</th>
						<td>
							<input type="text" placeholder="직책" value="${ empl.emplAuthority }" disabled>
						</td>
					</tr>
				</c:if>
				<tr>
					<th rowspan="3">주소 <span class="required">*</span></th>
					<td class="adres">
						<label class="dsrs">우편번호<span class="required">*</span></label>
						<button class="adresSearch" type="button">
							<img class="searchImg" src="${ cPath }/resources/images/Search.png">
						</button><input name="emplZip" class="nm" id="emplZip" type="text" placeholder="우편번호" value="${ empl.emplZip }" readonly>
						<form:errors path="emplZip" element="label" id="emplZip-error" cssClass="error" for="emplZip"/>
					</td>
					<th>세대주여부</th>
					<td>
						<c:if test="${ command eq 'UPDATE' }">
							<c:if test="${ empl.emplHshAt eq '1' }">
								<input type="radio" name="head" value="1" checked> 세대주
								<input type="radio" name="head" value> 세대원
							</c:if>
							<c:if test="${ empl.emplHshAt ne '1'}">
								<input type="radio" name="head" value="1"> 세대주
								<input type="radio" name="head" value checked> 세대원
							</c:if>
						</c:if>
						<c:if test="${ command eq 'INSERT' }">
							<input type="radio" name="head" value="1"> 세대주
							<input type="radio" name="head" value checked> 세대원
						</c:if>
						<input type="hidden" name="emplHshAt">
					</td>
				</tr>
				<tr>
					<td colspan="3" class="adres">
						<label class="dsrs">주소<span class="required">*</span></label>
						<input type="text" style="width: 745px;" name="emplAdres" placeholder="주소" id="emplAdres" value="${ empl.emplAdres }" readonly>
						<form:errors path="emplAdres" element="label" id="emplAdres-error" cssClass="error" for="emplAdres"/>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="adres">
						<label class="dsrs">상세주소</label>
						<input type="text" style="width: 745px;" name="emplDetAdres" placeholder="상세주소" id="emplDetAdres" value="${ empl.emplDetAdres }">
						<form:errors path="emplDetAdres" element="label" id="empl`DetAdres-error" cssClass="error" for="emplDetAdres"/>
					</td>
				</tr>
				<tr>
					<th rowspan="2">급여통장</th>
					<td colspan="3" class="salbank">
						<label class="dsrs">은행</label>
						<input name="salarybank.bankCode" class="code" value="${ empl.salarybank.bankCode }" type="hidden" placeholder="은행코드">
						<button class="small-search" type="button" data-action="bankSearch">
							<img class="searchImg" src="${ cPath }/resources/images/Search.png">
						</button><input type="text" placeholder="은행" class="nm bankNm" value="${ empl.salarybank.bank.bankNm }" readonly>
						<form:errors path="salarybank.bankCode" element="label" id="salarybank.bankCode-error" cssClass="error" for="salarybank.bankCode"/>
					</td>
				</tr>
				<tr>
					<td class="salbank">
						<label class="dsrs">계좌번호</label>
						<input name="salarybank.slryAcnutno" style="width: 285px;" type="text" placeholder="계좌번호" value="${ empl.salarybank.slryAcnutno }">
						<form:errors path="salarybank.slryAcnutno" element="label" id="salarybank.slryAcnutno-error" cssClass="error" for="salarybank.slryAcnutno"/>
					</td>
					<td colspan="2" class="salbank">
						<label class="dsrs">예금주</label>
						<input name="salarybank.slryDpstr" style="width: 285px;" type="text" placeholder="예금주" value="${ empl.salarybank.slryDpstr }">
						<form:errors path="salarybank.slryDpstr" element="label" id="salarybank.slryDpstr-error" cssClass="error" for="salarybank.slryDpstr"/>
					</td>
				</tr>
				<tr>
					<th>최종학력</th>
					<td colspan="3">
						<a data-action="emplAcadBack" id="insertAcadBack">입력</a>&ensp;&ensp;&ensp;&ensp;
						<input type="hidden" name="acad.abEmpl" value="${ empl.emplNo }" readonly>
						<input type="hidden" name="acad.abType" id="abType" value="${ academic.abType }" readonly>
						<input type="text" name="acad.abSchool" id="abSchool" value="${ academic.abSchool }" readonly>
						<input type="hidden" name="acad.abAdmission" id="abAdmission" value="${ academic.abAdmission }" readonly>
						<input type="hidden" name="acad.abGraduation" id="abGraduation" value="${ academic.abGraduation }" readonly>
						<input type="text" name="acad.abMajor" id="abMajor" value="${ academic.abMajor }" readonly>
						<input type="text" name="acad.abGrdtype" id="abGrdtype" value="${ academic.abGrdtype }" readonly>
					</td>
				</tr>
				<tr>
					<th>자격/면허</th>
					<td colspan="3" class="qualListTd">
						<input type="hidden" id="idx">
						<div id="qualInsertBtn">
							<a data-action="emplQual" id="insertQual">입력</a>
						</div>
						<c:forEach items="${ qualList }" var="qual" varStatus="status">
							<div>
								<input type="hidden" value="${ qual.qcEmpl }" name="qualVOList.qual[${ status.index }].qcEmpl">
								<input type="text" value="${ qual.qcNm }" name="qualVOList.qual[${ status.index }].qcNm" class="qcNm">
								<input type="text" value="${ qual.qcScore }" name="qualVOList.qual[${ status.index }].qcScore">
								<input type="hidden" value="${ qual.qcDate }" name="qualVOList.qual[${ status.index }].qcDate">
								<input type="hidden" value="${ qual.qcExpire }" name="qualVOList.qual[${ status.index }].qcExpire">
								<span class="deleteQual">×</span><br>
							</div>
						</c:forEach>
						<c:forEach begin="${ fn:length(qualList) }" end="${ fn:length(qualList) + 3 }" varStatus="status">
							<div>
								<input type="hidden" name="qualVOList.qual[${ status.index }].qcEmpl">
								<input type="text" name="qualVOList.qual[${ status.index }].qcNm" class="qcNm">
								<input type="text" name="qualVOList.qual[${ status.index }].qcScore">
								<input type="hidden" name="qualVOList.qual[${ status.index }].qcDate">
								<input type="hidden" name="qualVOList.qual[${ status.index }].qcExpire">
								<span class="deleteQual">×</span><br>
							</div>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th>증명사진</th>
					<td colspan="3">
						<input name="commonNo" type="hidden" value="${ empl.commonNo }">
						<a id="insertImg">업로드</a>
						<input id="profileImg" name="uploadFile" type="file" accept="image/*"  hidden>
						<input type="hidden" name="path" value="/commons/profileImg/${ empl.emplNo }/">
						<c:if test="${ not empty empl.commonNo }">
							&ensp;&ensp;&ensp;<a id="profileView">증명사진보기</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>적요</th>
					<td colspan="3">
						<textarea name="emplSumry" placeholder="적요" cols="100" rows="2" style="resize:none;">${ empl.emplSumry }</textarea>
						<form:errors path="emplSumry" element="label" id="emplSumry-error" cssClass="error" for="emplSumry"/>
					</td>
				</tr>
				<c:if test="${ command eq 'UPDATE'}">
					<tr>
						<th>퇴사일자</th>
						<td>
							<input name="retire.emplRetire" type="date" value="${ empl.retire.emplRetire }">
							<form:errors path="retire.emplRetire" element="label" id="retire.emplRetire-error" cssClass="error" for="retire.emplRetire"/>
						</td>
						<th>퇴사사유</th>
						<td>
							<input name="retire.emplRetResn" value="${ empl.retire.emplRetResn }" type="text" placeholder="퇴사사유">
							<form:errors path="retire.emplRetResn" element="label" id="retire.emplRetResn-error" cssClass="error" for="retire.emplRetResn"/>
						</td>
					</tr>
				</c:if>
			</tbody>
			
			<c:set var="alGroup" value="${empl.alGroup }" />
			<c:set var="deGroup" value="${empl.deGroup }" />
			<c:set var="fixAl" value="${empl.fixAl}" />
			<c:set var="monthDe" value="${empl.monthDe}" />

			<tbody id="salary">
			<tr>
				<td colspan="4" style="background:white;"><p>> 고정수당</p></td>
			</tr>
			<tr>
				<td colspan="2" class="cen">수당항목명</td>
				<td colspan="2" class="cen">금액</td>
			</tr>
			<c:forEach items="${fixAl}" var="al">
				<c:if test="${al.alProvide eq '고정'}"> 
					<c:set var="loop_flag" value="false" />
					<c:forEach items="${alGroup}" var="group">
						<c:if test="${not loop_flag}"> 
							<c:if test="${al.alCode eq group.alCode}">
								<tr>
								<td colspan="2" class="back">
								${group.alNm}
								<input type="hidden" value="${group.alCode}" name="alCode">
								</td>
								<td colspan="2" class="back">
								<input type="text" value=<fmt:formatNumber value="${group.faAmount}"/> readonly class="group amount back">
								<input type="hidden" value="${group.faAmount}" name="faAmount">
								</td>
								<tr>
								<c:set var="loop_flag" value="true" />
							</c:if>
						</c:if>
					</c:forEach>
					<c:if test="${not loop_flag}">
						<tr>
						<td colspan="2" class="back">
						${al.alNm}
						<input type="hidden" value="${al.alCode}" name="alCode">
						</td>
						<td colspan="2" class="back">
						<input type="text" value=<fmt:formatNumber value="${al.faAmount}"/> name="faAmount" class="amount back uncom" onkeyup="inputNumberFormat(this)" >
						</td>
						<tr>
					</c:if>
				</c:if>
			</c:forEach>
			<tr>
				<td colspan="4" style="background:white;"><p>> 일급수당</p></td>
			</tr>
			<tr>
				<td colspan="2" class="cen">수당항목명</td>
				<td colspan="2" class="cen">금액</td>
			</tr>
			<c:forEach items="${fixAl}" var="al">
				<c:if test="${al.alProvide eq '변동(일)'}"> 
					<c:set var="loop_flag" value="false" />
					<c:forEach items="${alGroup}" var="group">
						<c:if test="${not loop_flag}"> 
							<c:if test="${al.alCode eq group.alCode}">
								<tr>
									<td colspan="2" class="back">
										${group.alNm}
										<input type="hidden" value="${group.alCode}" name="alCode">
									</td> 
									<td colspan="2" class="back">
										<input type="text" value=<fmt:formatNumber value="${group.faAmount}"/> readonly class="group amount back" onkeyup="inputNumberFormat(this)">
										<input type="hidden" value="${group.faAmount}" name="faAmount">
									</td>
								<tr>
								<c:set var="loop_flag" value="true" />
							</c:if>
						</c:if>
					</c:forEach>
					<c:if test="${not loop_flag}">
						<tr>
							<td colspan="2" class="back">
								${al.alNm}
								<input type="hidden" value="${al.alCode}" name="alCode">
							</td>
							<td colspan="2" class="back">
								<input type="text" name="faAmount" value=<fmt:formatNumber value="${al.faAmount}" /> class="amount back uncom" onkeyup="inputNumberFormat(this)">
							</td>
						<tr>
					</c:if>
				</c:if>
			</c:forEach>
			<tr>
				<td colspan="4" style="background:white;"><p>> 시급수당</p></td>
			</tr>
			<tr>
				<td colspan="2" class="cen ">수당항목명</td>
				<td colspan="2" class="cen ">금액</td>
			</tr>
			<c:forEach items="${fixAl}" var="al">
				<c:if test="${al.alProvide eq '변동(시간)'}"> 
					<c:set var="loop_flag" value="false" />
					<c:forEach items="${alGroup}" var="group">
						<c:if test="${not loop_flag}"> 
							<c:if test="${al.alCode eq group.alCode}">
								<tr>
									<td colspan="2" class="back">
										${group.alNm}
										<input type="hidden" value="${group.alCode}" name="alCode">
									</td>  
									<td colspan="2" class="back">
										<input type="text" value=<fmt:formatNumber value="${group.faAmount}"/> readonly class="group amount back" onkeyup="inputNumberFormat(this)">
										<input type="hidden" value="${group.faAmount}" name="faAmount">
									</td>
								<tr>
								<c:set var="loop_flag" value="true" />
							</c:if>
						</c:if>
					</c:forEach>
					<c:if test="${not loop_flag}">
						<tr>
							<td colspan="2" class="back">
								${al.alNm}
								<input type="hidden" value="${al.alCode}" name="alCode">
							</td>
							<td colspan="2" class="back">
								<input type="text" name="faAmount" value=<fmt:formatNumber value="${al.faAmount}" /> class="amount back uncom" onkeyup="inputNumberFormat(this)">
							</td>
						<tr>
					</c:if>
				</c:if>
			</c:forEach>
			
			<tr>
				<td colspan="4" style="background:white;"><p>> 월정공제(공제항목01~06번은 기본 항목으로 제외)</p></td>
			</tr>
			<tr>
				<td colspan="2" class="cen ">공제항목명</td>
				<td colspan="2" class="cen ">금액</td>
			</tr>
			<c:forEach items="${monthDe}" var="de">
				<c:set var="loop_flag" value="false" />
				<c:forEach items="${deGroup}" var="group">
					<c:if test="${not loop_flag}"> 
						<c:if test="${de.deCode eq group.deCode}">
							<tr>
								<td colspan="2" class="back">
									${group.deNm}
									<input type="hidden" value="${group.deCode}" name="deCode">
								</td> 
								<td colspan="2" class="back"><input type="text" value=<fmt:formatNumber value="${group.mdAmount}"/> readonly class="group amount back">
									<input type="hidden" value="${group.mdAmount}" name="mdAmount">
								</td>
							<tr>
							<c:set var="loop_flag" value="true" />
						</c:if>
					</c:if>
				</c:forEach>
				<c:if test="${not loop_flag}">
					<tr>
						<td colspan="2" class="back">
							${de.deNm}
							<input type="hidden" value="${de.deCode}" name="deCode">
						</td>
						<td colspan="2" class="back">
							<input type="text" name="mdAmount" value=<fmt:formatNumber value="${de.mdAmount}" /> class="amount back uncom" onkeyup="inputNumberFormat(this)">
						</td>
					<tr>
				</c:if>
			</c:forEach>
			</tbody>
		</table>
	</form:form>
	</div>
<div id="profileViewDiv" hidden></div>
<div id="bottom">
	<hr color="#F1F4FF">
	<input type="submit" class="saveBtn" value="저장">
	<input type="button" onclick="window.close()" value="닫기">
</div>
<input type="hidden" id="code">
<input type="hidden" id="nm">
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
<script src="${ cPath }/resources/js/jquery.validate.min.js"></script>
<script>
	$(function(){
		<c:if test="${ command eq 'INSERT' }">
			$("#title").on("click", function(){
				$("input[name=emplNm]").val("이하솜");
				$("input[name=emplEngnm]").val("LEE HA SOM");
				$("input[name=emplFornm]").val("李하솜");
				$("input[name=emplMobile]").val("010-8978-2534");
				$("input[name=emplTel]").val("999");
				$("input[name=emplEmail]").val("somsom03@gmail.com");
				$("input[name=emplPassport]").val("K54507898");
				$("input[name=emplZip]").val("34948");
				$("input[name=emplAdres]").val("대전 중구 중앙로 76");
				$("input[name=emplDetAdres]").val("404호");
				$("input[name='salarybank.slryAcnutno']").val("1008-089-219587");
				$("input[name='salarybank.slryDpstr']").val("이하솜");
				$("input[name='emplEntrance']").val("B100");
				$(".entranceCtNm").val("신입");
				$("input[name='salarybank.bankCode']").val("020");
				$(".bankNm").val("우리은행");
			});
		</c:if>
		$("#profileView").on("mouseover", function(){
			var popH = $(this).offset().top;
			$("#profileViewDiv").css("top", popH-280+"px");
			$("#profileViewDiv").show();
			$("#profileViewDiv").append(
				$("<img>").attr("alt", "증명사진").attr("src", "${ cPath }/group/esign/getSignImage.do?link=${empl.file.commonPath}")
				.css("max-width", "300px").css("max-height", "300px")
			);
		});
		$("#profileView").on("mouseout", function(){
			$("#profileViewDiv").empty();
			$("#profileViewDiv").hide();
		});
		$("#insertImg").on("click", function(){
			<c:if test="${ command eq 'INSERT' }">
				cAlert("증명 사진을 등록하시겠습니까?", "confirm");
			</c:if>
			<c:if test="${ command eq 'UPDATE' }">
				cAlert("증명 사진을 변경하시겠습니까?", "confirm");
			</c:if>
		});
		$("#alertResult").on("change",function(){
			if($(this).val() != 'true'){
				return false;
			} else {
				$("#profileImg").click();
			}
		});
		$("input[name=head]").on("change", function(){
			head = $("input[name=head]:checked").val();
			$("input[name=emplHshAt]").val(head);
		});
		//정규식
		$.validator.addMethod("regx", function(value, element, regexpr){
			return regexpr.test(value);
		});
		$("#emplForm").validate({
			onkeyup: function(element){
				$(element).valid();
			},
			rules: {
				emplNo: {
					required: true
				},
				emplNm: {
					required: true,
					minlength: 1,
					regx: /^[가-힣]*$/
				},
				emplEngnm: {
					required: true,
					regx: /^[a-zA-Z\s]*$/
				},
				emplTel: {
					required: false,
					regx: /^(?:[1-9]{3,4}|)$/
				},
				emplMobile: {
					required: true,
					regx: /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/
				},
				emplPassport: {
					required: false,
					regx: /^(?:([a-zA-Z]{1}|[a-zA-Z]{2})\d{8}|)$/
				},
				emplEmail: {
					required: true,
					email: true
				},
				emplEcny: {
					required: true
				},
				emplAdres: {
					required: true
				},
				emplZip: {
					required: true
				},
				emplEntrance: {
					required: true
				}
			},
			messages: {
				emplNo: {
					required: "사원번호를 입력하세요."
				},
				emplNm: {
					required: "성명을 입력하세요.",
					minlength: $.validator.format( "1글자 이상 입력해주세요" ),
					regx: "한글로만 입력하세요."
				},
				emplEngnm: {
					required: "영문성명을 입력하세요.",
					regx: "영문으로만 입력하세요."
				},
				emplTel: {
					regx: "3자리 또는 4자리 숫자로 입력하세요."
				},
				emplMobile: {
					required: "전화번호를 입력하세요.",
					regx: "000-0000-0000 형식으로 입력하세요."
				},
				emplPassport: {
					regx: "여권번호를 다시 확인하세요."
				},
				emplEmail: {
					required: "이메일을 입력하세요.",
					email: "이메일 주소를 다시 확인하세요."
				},
				emplEcny: {
					required: "입사일자를 입력하세요."
				},
				emplAdres: {
					required: "주소를 입력하세요."
				},
				emplZip: {
					required: "우편번호를 입력하세요."
				},
				emplEntrance: {
					required: "입사구분을 입력하세요."
				}
			},
			submitHandler: function(form){
				form.submit();
			},
			invalidHandler: function(form, validator){
			}
		});
		<c:if test="${ message ne NULL }">
			alert("${ message }");
		</c:if>
		<c:if test="${ success eq 'SUCCESS' }">
			window.close();
		</c:if>
		//검색
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
		//최종학력 등록폼
		$("#insertAcadBack").on("click", function(){
			action = $(this).data("action");
			abEmpl = $("#emplNo").val();
			var nWidth = 500;
			var nHeight = 400;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name = action;
			popup = window.open(
					"${ cPath }/empl/" + action + ".do?abEmpl=" + abEmpl,
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		});
		//자격증 등록폼
		$("#insertQual").on("click", function(){
			action = $(this).data("action");
			qcEmpl = $("#emplNo").val();
			var nWidth = 1000;
			var nHeight = 900;
			var curX = window.screenLeft;
			var curY = window.screenTop;
			var curWidth = document.body.clientWidth;
			var curHeight = document.body.clientHeight;
			var nLeft = curX + (curWidth / 2) - (nWidth / 2);
			var nTop = curY + (curHeight / 2) - (nHeight / 2);
			window.name = action;
			popup = window.open(
					"${ cPath }/empl/" + action + ".do?qcEmpl=" + qcEmpl,
					"taxFree",
					"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
			popup.addEventListener('beforeunload', function(){
				$(".qcNm").each(function(){
					if($(this).val().length > 0 && $(this).val() != null){
						$(this).parent().show();
					}
// 					height = $("#qualInsertBtn").parent().css("height");
// 					$("#qualInsertBtn").css("height", height);
				});
			});
		});
		$(".qcNm").each(function(){
			if($(this).val().length  == 0 || $(this).val() == null){
				$(this).parent().hide();
			}
		});
		<c:if test="${ command eq 'INSERT' }">
			//입사일자 (default 오늘)
			today = new Date();
			today = today.toISOString().slice(0, 10);
			$("input[name=emplEcny]").val(today);
		</c:if>
		//주소 검색
		$(".adresSearch").on("click", function(){
			new daum.Postcode({
		        oncomplete: function(data) {
		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		            var roadAddr = data.roadAddress; // 도로명 주소 변수
		            var jibunAddr = data.jibunAddress; // 지번 주소 변수
		            // 우편번호와 주소 정보를 해당 필드에 넣는다.
		            document.getElementById('emplZip').value = data.zonecode;
		            if(roadAddr !== ''){
		                document.getElementById("emplAdres").value = roadAddr;
		            } 
		            else if(jibunAddr !== ''){
		                document.getElementById("emplAdres").value = jibunAddr;
		            }
		        }
		    }).open();
		});
// 		qualBtnHeight = $("#qualInsertBtn").parent().css("height");
// 		$("#qualInsertBtn").css("height", qualBtnHeight);
		$(document).on("click", ".deleteQual", function(){
			$(this).parent().remove();
		});
// 		---------------------------------------급여관련------------------------------
		$("#base").on("click",function(){
			$(this).css("background","#3A4CA8");
			$(this).css("color","white");
			$("#sal").css("background","#EAEAEA");
			$("#sal").css("color","#929292");
			$("#basic").show();
			$("#salary").hide();
		})	
		$("#sal").on("click",function(){
			$("#basic").hide();
			$("#salary").show();	
			$(this).css("background","#3A4CA8");
			$(this).css("color","white");
			$("#base").css("background","#EAEAEA");
			$("#base").css("color","#929292");
		})
		$(".saveBtn").on("click",function(){
			money = $("#salary").find(".uncom");
			for(i=0; i<money.length;i++){
				money.eq(i).removeAttr('onkeyup');
				tmp = money.eq(i).val();
				if(tmp != 0){
					tmp = uncomma(tmp);
				}
				money.eq(i).val(tmp);
			}
			$("#emplForm").submit();
		})
		<c:if test="${sal eq 'sal'}">
		$("#sal").click();
		</c:if>
	});
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
</script>
<jsp:include page="/includee/cAlert.jsp"/>
</body>
<style>
	#cAlert{
		left: 10%;
		top: 10%;
	}
</style>
</html>