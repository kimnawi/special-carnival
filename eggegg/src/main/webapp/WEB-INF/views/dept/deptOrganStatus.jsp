<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${ cPath }/resources/css/deptOrganStatus.css">
</head>
<body>
	<div id="top">
		<span id="title">조직도현황</span>
		<hr color="#F1F4FF">
	</div>
	<div id="chart_div">
	</div>
	<div id="bottom">
		<hr color="#F1F4FF">
		<input type="button" class="print" value="인쇄">
	</div>
	<div id="emplInfo"></div>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="${ cPath }/resources/js/querywrapper.js"></script>
<script src="${ cPath }/resources/js/print.min.js"></script>
<script>
	$(function(){
		LoadGoogle();
		var chart_div = document.getElementById('chart_div').innerHTML;
		$(".print").on("click", function(){
			printJS('chart_div', 'html');
		});
		$("#chart_div").on("click", ".emplNmA", function(){
			$("#emplInfo").empty();
			var emplNo = $(this).parent().find(".emplNo").val();
			var popH = $(this).offset().top;
			var popW = $(this).offset().left;
			$.ajax({
				url: "${ cPath }/empl/deptOrganEmpl.do?who=" + emplNo,
				dataType: "json",
				success: function(empl){
					commonPath = "resources/images/profile.png";
					if(empl.file != null){
						commonPath = "group/esign/getSignImage.do?link="+empl.file.commonPath;
					}
					$("#emplInfo").append(
						$("<table id='info-table'>").append(
							$("<tr class='infoClose'>").append(
								$("<td class='imageArea'>").attr("rowspan", "6").append(
									$("<img>").attr("alt", "프로필사진").attr("src", "${ cPath }/"+commonPath).css("max-height", "166px")
								),
								$("<td style='padding:0 10px;'>").append(
									$("<span style='font-size:10px;'>").text("×")
								).attr("colspan", "2")
							),
							$("<tr class='emplDept' style='border-bottom: 1px solid #D9D9D9'>").append(
								$("<th style='font-size: 17px; padding-top:0;'>").html(empl.dept.deptNm + "&ensp;&ensp;" + empl.emplNm).attr("colspan", "2")
							),
							$("<tr>").append(
								$("<th>").html("직위/직급"),
								$("<td>").html(empl.position.pstNm)
							),
							$("<tr>").append(
								$("<th>").html("내선전화"),
								$("<td>").html(empl.emplTel)
							),
							$("<tr>").append(
								$("<th>").html("모바일"),
								$("<td>").html(empl.emplMobile)
							),
							$("<tr>").append(
								$("<th>").html("이메일"),
								$("<td>").html(empl.emplEmail)
							)
						)
					)
					$("#info-table").css('top',popH+23+'px').css('left',popW-10+'px');
				}
			});
		});
	});
	$("#emplInfo").on("click", ".infoClose span", function(){
		$("#emplInfo").empty();
	});
	function LoadGoogle(){
        if(typeof google != 'undefined' && google && google.load){
        	google.charts.load('current', {packages:["orgchart"]});
            google.charts.setOnLoadCallback(drawChart);

            function drawChart() {
		        var data = new google.visualization.DataTable();
		        data.addColumn('string', 'Name');
		        data.addColumn('string', 'Manager');
				data.addColumn('string', 'ToolTip');
				
				let rows = [];
				<c:forEach items="${ deptList }" var="dept" varStatus="i">
					<c:set value="${ dept.emplList }" var="emplList"/>
					rows.push(
						[{'v':'${ dept.deptCode }'
						, 'f':'<div class="deptNmOrgan" style="margin: 0; color: white; background: #3A4CA8; width: 100%">${ dept.deptNm }</div>'
						 + '<table class="deptEmpl">'
						 + '	<c:forEach items="${ emplList }" var="empl">'
						 + '		<c:if test="${ not empty empl.emplNo }">'
						 + '			<c:if test="${ empl.emplPst == \'부서장\' }">'
						 + '				<tr style="background: #F8F8F8; border-bottom: 2px solid #EAEAEA">'
						 + '					<td style="border: 1px solid #EAEAEA">'
						 + '						<input class="emplNo" type="hidden" value="${ empl.emplNo }">'
						 + '						<a class="emplNmA" style="font-weight: bold;">${ empl.emplNm }</a>'
						 + '					</td>'
						 + '					<td style="border: 1px solid #EAEAEA; font-weight: bold;">${ empl.emplPst }</td>'
						 + '				</tr>'
						 + '			</c:if>'
						 + '			<c:if test="${ empl.emplPst != \'부서장\' }">'
						 + '				<tr style="background: white; border-bottom: 1px solid #EAEAEA">'
						 + '					<td style="border: 1px solid #EAEAEA">'
						 + '						<input class="emplNo" type="hidden" value="${ empl.emplNo }">'
						 + '						<a class="emplNmA">${ empl.emplNm }</a>'
						 + '					</td>'
						 + '					<td style="border: 1px solid #EAEAEA">${ empl.emplPst }</td>'
						 + '				</tr>'
						 + '			</c:if>'
						 + '		</c:if>'
						 + '	</c:forEach>'
						 + '</table>'}
						, '${ dept.deptParent }', '${ dept.deptCode }']
					)
				</c:forEach>
				data.addRows(rows);
			var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
			chart.draw(data, {'allowHtml':true});
          }
        } else {
        	setTimeout(LoadGoogle, 30);
        }
    }
    LoadGoogle();
</script>
</body>
</html>