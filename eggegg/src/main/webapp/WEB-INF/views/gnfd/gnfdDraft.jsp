<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isFullyAuthenticated()">
	<security:authentication property="principal.adaptee" var="authMember"/>
	<security:authentication property="authorities" var="authMemRoles"/>
</security:authorize>
<body>
<p>&nbsp;</p>

<h1 style="text-align:center"><span style="font-size:36px">인 사 발 령 기 안 서</span></h1>

<p>&nbsp;</p>

<table align="center" border="1" cellpadding="0" cellspacing="0" style="height:810px; border-collapse: collapse;">
	<tbody>
		<tr>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:130px">
			<p style="text-align:center">발&nbsp;&nbsp;령&nbsp;&nbsp;코&nbsp;&nbsp;드</p>
			</td>
			<td class="gnfdStdrde" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:250px">&nbsp;</td>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:130px">
			<p style="text-align:center">입&nbsp;&nbsp;사&nbsp;&nbsp;구&nbsp;&nbsp;분</p>
			</td>
			<td class="emplEntrance" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:250px"></td>
		</tr>
		<tr>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:130px">
			<p style="text-align:center">사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 번</p>
			</td>
			<td class="emplNo" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:250px">&nbsp;</td>
			<td style="border-bottom:1px solid #000000; border-right:1px solid #000000; width:130px">
			<p style="text-align:center">사&nbsp;&nbsp;&nbsp;원&nbsp;&nbsp;&nbsp;명</p>
			</td>
			<td style="border-bottom:1px solid #000000; border-right:1px solid #000000; width:250px; text-align:center;">
			<p class="emplNm"></p>
			</td>
		</tr>
		<tr>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:130px">
			<p style="text-align:center">발&nbsp;&nbsp;령&nbsp;&nbsp;일&nbsp;&nbsp;자</p>
			</td>
			<td class="gnfdDe" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:250px">&nbsp;</td>
			<td style="border-bottom:1px solid #000000; border-right:1px solid #000000; width:130px">
			<p style="text-align:center">발&nbsp;&nbsp;령&nbsp;&nbsp;구&nbsp;&nbsp;분</p>
			</td>
			<td class="gnfdType" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:250px">
			&nbsp;
			</td>
		</tr>
		<tr>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:130px">
			<p style="text-align:center">이&nbsp;&nbsp;전&nbsp;&nbsp;부&nbsp;&nbsp;서</p>
			</td>
			<td class="deptBnm" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:250px"></td>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:130px">
			<p style="text-align:center">발&nbsp;&nbsp;령&nbsp;&nbsp;부&nbsp;&nbsp;서</p>
			</td>
			<td class="deptAnm" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:250px"></td>
		</tr>
		<tr>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:130px">
			<p style="text-align:center">이전 직위/직급</p>
			</td>
			<td class="gnfdBposition" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:250px"></td>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:130px">
			<p style="text-align:center">발령 직위/직급</p>
			</td>
			<td class="gnfdAposition" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:250px"></td>
		</tr>
		<tr>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:130px">
			<p style="text-align:center">적&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;요</p>
			</td>
			<td colspan="3" style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; vertical-align:top;">
			<p class="gnfdSumry" style="margin: 20px;">
			<br />
			<br />
			<br />
			<br />
			&nbsp;</p>
			</td>
		</tr>
		<tr>
			<td colspan="4" style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; vertical-align:top;">
			<p style="text-align:center"><br />
			<br />
			&nbsp; &nbsp;<br />
			<br />
			&nbsp;</p>

			<p style="text-align:right"><span class="today">년&nbsp;&nbsp;&nbsp; 월&nbsp;&nbsp;&nbsp; </span>일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
			&nbsp;</p>

			<p style="text-align:right">작&nbsp;&nbsp;&nbsp;성&nbsp;&nbsp;&nbsp;자&nbsp;&nbsp;:&nbsp;&nbsp;<span class="writer"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (인)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
			<br />
			&nbsp;</p>

			<p style="text-align:center"><span style="font-size:24px">&nbsp; 대 표 이 사&ensp;&ensp;귀 하</span></p>
			</td>
		</tr>
	</tbody>
</table>
<script>
	$(function(){
		//인사발령신청정보 가져오기
		$(".gnfdStdrde").html("${ gnfd.gnfdStdrde }");
		$(".emplNo").html("${ gnfd.emplNo }");
		$(".emplNm").html("${ gnfd.empl.emplNm }");
		gnfdDe = "${ gnfd.gnfdDe }";
		if(null != gnfdDe){
			start = new Date(gnfdDe);
			gnfdDeStr = "&ensp;&ensp;&ensp;년&ensp;&ensp;월&ensp;&ensp;일";
			if(start != 'NaN'){
				gnfdDeStr = start.getFullYear() + "년&nbsp;&nbsp;" + (start.getMonth()+1) + "월&nbsp;&nbsp;" + start.getDate() + "일";
			}
			$(".gnfdDe").html(gnfdDeStr);
		}
		$(".gnfdType").html("${ gnfd.gnfd.ctNm }");
		$(".emplEntrance").html("${ gnfd.empl.entrance.ctNm }");
		$(".deptBnm").html("${ gnfd.deptBnm }");
		$(".deptAnm").html("${ gnfd.dept.deptNm }");
		$(".gnfdBposition").html("${ gnfd.gnfdBposition }");
		$(".gnfdAposition").html("${ gnfd.position.pstNm }");
		$(".gnfdSumry").html("${ gnfd.gnfdSumry }<br><br><br><br>");
		
		today = new Date();
		today = today.toISOString().slice(0, 10);
		today = new Date(today);
		today = today.getFullYear() + '년&nbsp;&nbsp;' + (today.getMonth()+1) + '월&nbsp;&nbsp;' + today.getDate()
		$(".today").html(today);
		$(".writer").html("${ authMember.emplNm }");
	});
</script>
</body>
