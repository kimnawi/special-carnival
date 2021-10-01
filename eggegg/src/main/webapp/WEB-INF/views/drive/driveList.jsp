<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
	<title>EGGEGG | EG드라이브</title>
</head>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authMember"/>
</security:authorize>
<link href="${ cPath }/resources/images/eggegg_ico.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="${cPath }/resources/js/fancytree/skin-win8/ui.fancytree.min.css">
<link rel="stylesheet" href="${cPath }/resources/css/driveList.css">
<script type="text/javascript" src="${cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="${cPath }/resources/js/fancytree/jquery.fancytree-all-deps.min.js"></script>
<script type="text/javascript"	src="https://cdnjs.cloudflare.com/ajax/libs/jquery.fancytree/2.36.1/jquery.fancytree-all.min.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script>
 <!-- jquery.contextmenu,  A Beautiful Site (http://abeautifulsite.net/) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.js"></script>

<div id="driveWrap">
	<div id="title">
		EGDrive <span>?</span>
		<div id="qDiv"> 드래그 : 폴더 이동, Ctrl+드래그 : 폴더 복사, DEL : 폴더 삭제 </div>
	</div>
	<div class="hrDiv" id="titleHr">
		<hr color="#F1F4FF">
	</div>
	<div id="tree1" class="tree">
		<input id="expandBtn" type="button" value="전체열기">
 		<input id="collapseBtn" type="button" value="전체접기">
	</div>
	<div id="tree2" class="tree"></div>
	<div id="content">
		<form id="selectForm" action="${cPath }/group/schedule/drive/zip.do">
			<table id="fileTable">
				<thead>
					<tr>
						<th>선택</th><th>파일명</th><th>수정일시</th><th>유형</th><th>파일크기</th><th>수정 이력</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</form>
	</div>
	<div class="hrDiv" id="bottomHr">
		<hr color="#F1F4FF">
	</div>
	<div id="btnDiv">
		<button class="saveBtn" type="button" id="uploadBtn">파일 업로드</button>
		<button class="resetBtn" type="button" id="deleteBtn">선택 삭제</button>
		<button class="resetBtn" type="button" id="zipBtn">선택 다운로드</button>
		<c:if test="${param.command eq 'popup' }">
			<button type="button" class="resetBtn" id="closeBtn" onclick="window.close()">닫기</button>
		</c:if>
	</div>
	<div id="rClickDiv">
		<span id="copySpan">복사</span>
		<span id="moveSpan">이동</span>
		<span id="delSpan">삭제</span>
		<span id="histSpan">이력보기</span>
		<span id="changeSpan">이름변경</span>
	</div>
	<div id="newFolderDiv">
		<span id="nFolderSpan">새폴더</span>
		<span id="delFolderSpan">폴더 삭제</span>
<!-- 		<span id="changeDivSpan">이름변경</span> -->
	</div>
</div>
<form id="uploadForm" action="${cPath }/group/schedule/drive/driveUpload.do?command=DRIVE" method="post" enctype="multipart/form-data" hidden>
	path: <input id="path" type="text" name="paths">
	<input type="file" name="uploadFile">
</form>
<form id="fileMangeForm" action="${cPath }/group/schedule/drive/driveFileManage.do" method="post" hidden>
	<input type="text" id="srcFile" name="srcFile">
	<input type="text" id="destFolder" name="destFolder">
	<input type="text" id="command" name="command">
</form>
<script>
	var emplNo = ${authMember.emplNo};
	var cPath = "${cPath}";
	
</script>
<script type="text/javascript" src="${cPath }/resources/js/driveList.js"></script>
<c:if test="${param.command eq 'popup' }">
	<jsp:include page="/includee/cAlert.jsp"/>
</c:if>
<style>
	#cAlert{
		left: 11%;
		top: 10%;
	}
</style>