<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<body>
<p>&nbsp;</p>

<h1 style="text-align:center"><span style="font-size:36px">휴 가 신 청 서</span></h1>

<p>&nbsp;</p>

<table align="center" border="1" cellpadding="0" cellspacing="0" style="height:810px; width:842px; border-collapse: collapse;">
	<tbody>
		<tr>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:106px">
			<p style="text-align:center">사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 번</p>
			</td>
			<td class="emplNo" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:300px">&nbsp;</td>
			<td style="border-bottom:1px solid #000000; border-right:1px solid #000000; width:106px">
			<p style="text-align:center">성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 명</p>
			</td>
			<td style="border-bottom:1px solid #000000; border-right:1px solid #000000; width:297px; text-align:center;">
			<p class="emplNm"></p>
			</td>
		</tr>
		<tr>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:106px">
			<p style="text-align:center">부&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 서</p>
			</td>
			<td class="deptNm" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:300px">&nbsp;</td>
			<td style="border-bottom:1px solid #000000; border-right:1px solid #000000; width:106px">
			<p style="text-align:center">직&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 위</p>
			</td>
			<td class="pstNm" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:297px">
			&nbsp;
			</td>
		</tr>
		<tr>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:106px">
			<p style="text-align:center">휴&nbsp;&nbsp;가&nbsp;&nbsp;기&nbsp;&nbsp;간</p>
			</td>
			<td colspan="3" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:300px">
				<span class="vacstusStart">&ensp;&ensp;&ensp;년&ensp;&ensp;월&ensp;&ensp;</span>&nbsp;일 부터
				&ensp; ~ &ensp; 
				<span class="vacstusEnd">&ensp;&ensp;&ensp;년&ensp;&ensp;월&ensp;&ensp;</span>&nbsp;일 까지 (<span class="vacstusCount">&ensp;&ensp;</span>&nbsp;일간)
			</td>
		</tr>
		<tr>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:106px">
			<p style="text-align:center">휴&nbsp;&nbsp;가&nbsp;&nbsp;구&nbsp;&nbsp;분</p>
			</td>
			<td class="vacstusHalfAt" colspan="3" style="border-bottom:1px solid #000000; border-right:1px solid #000000; text-align:center; width:300px">&nbsp; ☑ 연차 &ensp;&ensp;□ 반차</td>
		</tr>
		<tr>
			<td style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; width:106px">
			<p style="text-align:center">사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;유</p>
			</td>
			<td colspan="3" style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; vertical-align:top; width:730px">
			<p class="vacstusSumry" style="margin: 20px;">
			<br />
			<br />
			<br />
			<br />
			&nbsp;</p>
			</td>
		</tr>
		<tr>
			<td colspan="4" style="border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; vertical-align:top; width:836px">
			<p style="text-align:center"><br />
			<br />
			&nbsp; 상기 기록사실에 허위가 없습니다.&nbsp;<br />
			<br />
			&nbsp;</p>

			<p style="text-align:right"><span class="today">년&nbsp;&nbsp;&nbsp; 월&nbsp;&nbsp;&nbsp; </span>&nbsp;일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
			&nbsp;</p>

			<p style="text-align:right">작&nbsp;&nbsp;&nbsp;성&nbsp;&nbsp;&nbsp;자&nbsp;&nbsp;:&nbsp;&nbsp;<span class="emplNm"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (인)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
			<br />
			&nbsp;</p>

			<p style="text-align:center"><span style="font-size:24px">&nbsp; 대 표 이 사&ensp;&ensp;귀 하</span></p>
			</td>
		</tr>
	</tbody>
</table>
<script>
	$(function(){
		//휴가신청폼 정보 가져오기
		$(".emplNo").html("${ empl.emplNo }");
		$(".emplNm").html("${ empl.emplNm }");
		$(".deptNm").html("${ empl.dept.deptNm }");
		$(".pstNm").html("${ empl.position.pstNm }");
		$(".draftTitle").val("휴가신청서_${ empl.emplNm }");
		vacstusStart = "${ vacStus.vacstusStart }";
		if(null != vacstusStart){
			start = new Date(vacstusStart);
			vacstusStartStr = "&ensp;&ensp;&ensp;년&ensp;&ensp;월&ensp;&ensp;";
			if(start != 'NaN'){
				vacstusStartStr = start.getFullYear() + "&nbsp;년&nbsp;&nbsp;&nbsp;" + (start.getMonth()+1) + "&nbsp;월&nbsp;&nbsp;&nbsp;" + start.getDate();
			}
			$(".vacstusStart").html(vacstusStartStr);
		}
		vacstusEnd = "${ vacStus.vacstusEnd }";
		if(null != vacstusEnd){
			end = new Date(vacstusEnd);
			vacstusEndStr = "&ensp;&ensp;&ensp;년&ensp;&ensp;월&ensp;&ensp;";
			if(end != 'NaN'){
				vacstusEndStr = end.getFullYear() + "&nbsp;년&nbsp;&nbsp;&nbsp;" + (end.getMonth()+1) + "&nbsp;월&nbsp;&nbsp;&nbsp;" + end.getDate();
			}
			$(".vacstusEnd").html(vacstusEndStr);
		}
		$(".vacstusCount").html("${ vacStus.vacstusCount }");
		vacstusHalfAt = "${ vacStus.vacstusHalfAt }";
		if(vacstusHalfAt == 'No'){
			$(".vacstusHalfAt").html("&nbsp; ☑ 연차 &ensp;&ensp;□ 반차");
		} else if (vacstusHalfAt == 'Yes'){
			$(".vacstusHalfAt").html("&nbsp; □ 연차 &ensp;&ensp;☑ 반차");
		}
		$(".vacstusSumry").html("${ vacStus.vacstusSumry }<br><br><br><br>");
		
		today = new Date();
		today = today.toISOString().slice(0, 10);
		today = new Date(today);
		today = today.getFullYear() + '&nbsp;년&nbsp;&nbsp;&nbsp;' + (today.getMonth()+1) + '&nbsp;월&nbsp;&nbsp;&nbsp;' + today.getDate()
		$(".today").html(today);
	});
</script>
</body>