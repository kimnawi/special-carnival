<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isFullyAuthenticated()">
   <security:authentication property="principal.adaptee" var="authEmpl"/>
</security:authorize>
<script src="${ cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script src="${ cPath }/resources/js/paging.js"></script>
<script src="${ cPath }/resources/js/jquery.form.min.js"></script> 
<head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
* {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 18px;
}
body{
	overflow: hidden;
}
table {
	border-collapse: collapse;
	width: 95%;
}

thead th {
	background: #FCFCFE;
}

#list-table {
	margin: 10px;
	height: 520px;
	overflow: auto;
	
}
th{
	text-align: center;
}
td, th {
	border: 1px solid #EAEAEA;
	padding: 5px 10px;
	height: 30px;
}
td:nth-child(1){
	text-align: center;
}
td:nth-child(2){
	text-align: center;
	width: 120px;
}
td:nth-child(3){
	width: 300px;
	text-align: left;
    word-break: break-all;
}
td:nth-child(4){
	width: 300px;
	text-align: left;
    word-break: break-all;
	overflow: hidden;
}
td:nth-child(5){
	text-align: right;
}
td:nth-child(6){
	text-align: center;
	width: 80px;
}
td:nth-child(7){
	text-align: center;
	width: 100px;
}
td{
	text-align: center;
}

.sort {
	font-size: 0.5em;
	vertical-align: 0.3em;
}

#list-table tfoot td {
	border: none;
	text-align: center;
}

#bottom {
	position: relative;
	bottom: 30px;
}

.histUpdate {
	cursor: pointer;
	color: #4472C4;
}

.histUpdate:hover {
	color: #4472C4;
	text-decoration: underline;
}

#title {
	margin: 10px;
	font-weight: bold;
}

hr {
	margin: 5px 0px;
	width: 1550px;
}

#searchUI tfoot td {
	text-align: inherit;
}
#searchButton{
    position: absolute;
    right: 150px;
    top: 115px;
}
#newBtn, #searchBtn, #searchButton {
    display: inline-block;
    color: white;
    width: 60px;
    height: 36px;
    background: #3A4CA8;
    border-radius: 3px;
    text-align: center;
    font-weight: bolder;
}

#searchButton {
	top: 120px;
}

.withImg {
    width: 326px;
    margin-left: 0px;
    position: relative;
    padding-left: 0px;
    z-index: 0;
    left: -1px;
    top: 2.1px;
    height: 32.64px;
}

.withoutImg {
	width: 360px;
}

.saveBtn, .resetBtn{
   	width: 115px;
    height: 34px;
}

.selectListBtn, .selectedListBtn{
    border-radius: 15px;
    width: 100px;
    height: 30px;
    border: 1.8px solid #bdbdbd;
    box-shadow: 1.6px 1.6px 2px 0.3px;
    background: #f5f5f5;
    padding: 0;
    font-weight: 600;
}

.selectedListBtn{
	background: #3a4ca8;
	border: 1px solid black;
    box-shadow: 1.6px 1.6px 2px 0.3px black;
	color: white;
}
#selectNav{
	position:relative;
	left: 30px;
	margin-top: 10px; 
}
thead>tr>th:nth-child(3){
	width: 230px;
}
.resetBtn {
    display: inline-block;
    color: black;
    background: #EAEAEA;
    border: 1px solid rgb(118, 118, 118);
    border-radius: 3px;
    text-align: center;
    padding: 3px 10px;
    width: auto;
}
#bottom{
	width: 97%;
	position: fixed;
	bottom: 10px;
	z-index: 1;
}
</style>
</head>
<body>
<div id="top">
<span id="title">파일이력</span> 
	<hr color="#F1F4FF">
</div>
<table id="list-table">
	<thead>
		<tr>
			<th>작업일시</th>
			<th>행위</th>
			<th>파일 경로</th>
			<th>파일명</th>
			<th>파일 크기</th>
			<th>작업자</th>
			<th>IP</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="12">
				<div id="pagingArea"></div>
			</td>
		</tr>
	</tfoot>
</table>
<br>
<form id="searchForm" hidden>
	<input type="text" name="page">
	
</form>
<div id="bottom">
	<hr color="#F1F4FF">
	<button type="button" class="resetBtn" id="closeBtn" onclick="window.close()">닫기</button>
</div>
<script>
$(function(){
	//리스트
	var today = new Date();
	var startDate = new Date(today.getFullYear(), today.getMonth(), 2);
	today = today.toISOString().slice(0, 10);
	startDate = startDate.toISOString().slice(0, 10);
	var tbody = $("#list-table tbody");
	var pagingArea = $("#pagingArea");
	var searchForm = $("#searchForm").paging().ajaxForm({
		dataType: "json",
		success: function(pagingVO){
			tbody.empty();
			pagingArea.empty();
			let histList = pagingVO.dataList;
			let trTags = [];
			if(histList.length > 0){
				$(histList).each(function(idx, hist){
						
					trTags.push(
						$("<tr>").append(
							$("<td>").html(hist.histDe.substring(0,hist.histDe.length-2)),
							$("<td>").html(hist.histNm),
							$("<td>").html((hist.histPath).replaceAll("\\","/")),
							$("<td>").html(hist.fileNm),
							$("<td>").html((hist.fileSize/1000)+"MB"),
							$("<td>").html(hist.emplNm),
							$("<td>").html(hist.ip)
						)
					)
					idxs = idx;
				});
				while(idxs < 8){
					trTags.push(
						$("<tr>").append(
							$("<td>").attr("colspan", "12").css("border", "none")
						).attr("data-innertd","0")
					);
					idxs += 1;
				}
				pagingArea.html(pagingVO.pagingHTML);
			} else {
				trTags.push(
					$("<tr>").html(
						$("<td>").attr("colspan", "12").html("파일 이력이 없습니다.")	
					).attr("data-innertd","0")
				);
			}
			tbody.append(trTags);
			
		}   
	}).submit();

}); // $function end	

</script>
</body>
