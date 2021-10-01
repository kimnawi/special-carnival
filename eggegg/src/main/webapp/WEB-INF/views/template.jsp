<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!doctype html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <title>EGGEGG | ERP&GROUPWARE</title>
	<tiles:insertAttribute name="preScript" />
  </head>
  <body>
	<header>
		<tiles:insertAttribute name="headerMenu"/>
	</header>
<div class="container-fluid">
  <div class="row">
	<tiles:insertAttribute name="leftMenu"/>
    <main>
		<tiles:insertAttribute name="content"/>
    </main>
  </div>
</div>
	<tiles:insertAttribute name="footer"/>
	<tiles:insertAttribute name="cAlert"/>
  </body>
</html>
