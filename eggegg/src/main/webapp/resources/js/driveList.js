/**
 * 
 * </pre>
 * 
 * @author 이기정
 * @since 2021. 8. 27.
 * @version 1.0
 * 
 * <pre>
 * 
 * [[개정이력(Modification Information)]] 수정일 수정자 수정내용 -------- --------
 *          ---------------------- 2021. 8. 27. admin 최초작성 Copyright (c) 2021 by
 *          DDIT All right reserved
 * 
 * </pre>
 */

$(function(){
	$("span","#title").on("click",function(){
		if($("#qDiv").is(":visible")){
			$("#qDiv").slideUp();
		}else{
			$("#qDiv").slideDown();
		}
	})
	
	// 최초 진입시 본인 계정 드라이브 파일리스트 보여주기
	fileList("first:private\\"+emplNo+"\\MyDrive\\")
	var path = $("#path");
	const uploadFile = $("input[name='uploadFile']");
	const RDIV = $("#rClickDiv").hide();
	const NFDIV = $("#newFolderDiv").hide();
	const divParam = {};
	
	// 클릭시 css 변경
	$("#fileTable tbody").on("click",".fileLink",function(){
		$(".fileLink").css("background","white");
		$(".fileLink").removeAttr("id");
		$(this).css("background","#ffffd7");
		$(this).attr("id","selectedTr");
	}).on("dblclick",".fileLink",function(){
		location.href=cPath+"/download?link="+$(this).data("link")
	}).on("drag",".fileLink",function(e){
		e.preventDefault();
	}).on('mousedown', "tr", function(event) {
		$(".fileLink").css("background","white");
		$(this).css("background","#ffffd7");
		$(".fileLink").removeAttr("id");
		$(this).attr("id","selectedTr");
		$(RDIV).hide();
		if ((event.button == 2) || (event.which == 3)) {
			xValue = event.originalEvent.clientX;
			yValue = event.originalEvent.clientY;
			$(RDIV).css("transform","translate("+xValue+"px,"+yValue+"px)")
			$(RDIV).slideDown();
		}
		divParam.srcFile = $(this).data("link");
	});
	
	$("#copySpan").on("click",function(){
	  divParam.destFolder = $("#path").val();
	  divParam.command = "COPY"
	});
	
	var commandProcess = function(param) {
		console.log("commandParam", param);
		console.log("commandParam", param.tree);
		let command = param.command;
		let srcFile = param.data.otherNode.key;
		let destFolder = null;
		let srcParent = param.data.otherNode.parent;
		console.log("=======id",param.data.otherNode.tree._id)
		
		if (command == "MOVE" && param.data.otherNode.tree._id == 2){
			cAlert("공유 폴더에서는 복사만 가능합니다.")
			$("#command").val("");
			return false;
		}
		if (command == "DELETE" && param.data.otherNode.tree._id == 2){
			cAlert("공유 폴더는 관리자만 삭제 가능합니다.")
			return false;
		}
		if (command == "DELETE" && srcParent.isRoot()) {
			cAlert("기본 폴더는 삭제할 수 없습니다.")
			return false;
		}
		if (param.node) {
			destFolder = param.node.key;
		}
		$.ajax({
			url : "driveList.do",
			data : {
				command : command,
				srcFile : srcFile,
				destFolder : destFolder
			},
			method : "post",
			dataType : "json",
			success : function(resp) {
				console.log("commandProcessRes", resp)
				if (resp.success != "OK") {
					return;
				}
				
				if(command=='DELETE'||command=='MOVE'||command=='COPY'){
					console.log("하하하")
					srcParent.load(true);
				}
				if (param.node)
					param.node.load(true);
			}
		});
	}
	dnd5 = {
		autoExpandMS : 400,
		focusOnClick : true,
		preventVoidMoves : true, // Prevent dropping nodes 'before self', etc.
		preventRecursion : true, // Prevent dropping nodes on own descendants
		dragStart : function(node, data) {
			return true;
		},
		dragEnter : function(node, data) {
			console.log("==============dragEnter=============");
			console.log("들어갈 폴더", node.key);
			console.log("옮길 파일", data.otherNode.key);
			console.log("===================================");
			let pass = false;
			pass = node.folder && node != data.otherNode.parent;
			return pass;
		},
		dragDrop : function(node, data) {
		
			// 서버사이드의 진짜 자원에 대한 커맨드 처리
			console.log("==============dragDrop=============");
			console.log(node);
			console.log(data);
			console.log("=====================================");
			let param = {
				node : node,
				data : data,
				command : data.originalEvent.ctrlKey ? "COPY" : "MOVE"
			}
			commandProcess(param);
		}
		
	}
	
	var tree1 = null;
	
	$("#tree1").fancytree({
		extensions : [ "dnd5" ],
		selectMode : 1,
		source : {
			url : location.pathname,
			data : {
				privateBase : emplNo
			},
			cache : false
		},
		lazyLoad : function(event, data) {
			var node = data.node;
			// Load child nodes via Ajax GET /getTreeData?mode=children&parent=1234
			data.result = {
				url : location.pathname,
				data : {
					base : node.key
				},
				cache : false
			};
		},
		init : function(event, data) {
			tree1 = data.tree;
			 $.ui.fancytree.getTree("#tree1").expandAll();
		},
		dnd5 : dnd5,
		dblclick : function(event, ui) {
			var node = $.ui.fancytree.getTree("#tree1").getActiveNode();
			console.log("dblclickNode", node)
			// 다운로드 펑션
		},
		click : function(event, data) {
			$(path).val(data.node.key);
			fileList(data.node.key);
			$("#moveSpan").show();
			$("#delSpan").show();
		}
	});
	
	
	
	var tree2 = null;
	$("#tree2").fancytree({
		extensions : [ "dnd5" ],
		selectMode : 1,
		source : {
			url : location.pathname,
			data : {
				publicBase : emplNo
			},
			cache : false
		},
		lazyLoad : function(event, data) {
			var node = data.node;
			// Load child nodes via Ajax GET /getTreeData?mode=children&parent=1234
			data.result = {
				url : location.pathname,
				data : {
					base : node.key
				},
				cache : false
			};
		},
		beforeSelect: function(event, data){
		        if(data.node.isFolder()){
		          return false;
		        }
      	},
		init : function(event, data) {
			tree2 = data.tree;
			$.ui.fancytree.getTree("#tree2").expandAll();
		},
		dnd5 : dnd5,
		click : function(node, data) {
			$(path).val(data.node.key);
			fileList(data.node.key);
			$("#moveSpan").hide();
			$("#delSpan").hide();
		}
	});
	
	// 전체 접기 버튼
	$("#collapseBtn").on("click",function(){
		$.ui.fancytree.getTree("#tree1").expandAll(false);
	});
	
	// 전체 열기 버튼
	$("#expandBtn").on("click",function(){
		$.ui.fancytree.getTree("#tree1").expandAll();
	});
	
	
	// 파일리스트
	function fileList(fileList) {
		$.ajax({
			url : location.pathname,
			data : {
				fileList : fileList
			},
			success : function(res) {
				var contents = [];
				if(res.length != 0){
					
					$.each(res, function(i, v) {
						var name = v.name;
						var fileImg = name
								.substring(name.lastIndexOf(".") + 1, name.length);
						var fileType = name.substring(name.lastIndexOf(".") + 1,
								name.length);
						switch (fileType) {
						case "png":
						case "jpg":
						case "gif":
							fileType = "사진 파일"
							break;
						case "txt":
						case "hwp":
						case "docx":
							fileType = "텍스트 문서"
							break;
						case "show":
						case "ppt":
						case "pptx":
							fileType = "파워포인트 파일"
							break;
						case "zip":
							fileType = "압축 파일"
							break;
						case "pdf":
							fileType = "PDF 파일"
							break;
						case "xls":
						case "xlsx":
							fileType = "엑셀 파일"
							break;
						case "mp3":
						case "wma":
							fileType = "음악 파일"
							break;
						case "mp4":
						case "avi":
						case "wav":
							fileType = "영상 파일"
							break;
						default:
							fileType = "기타"
							fileImg = "etc"
								break;
						}
						var fileSize = "";
		
						if(v.fileSize > (1024*1024)){
							fileSize = Math.round(v.fileSize / (1024*1024)) + "MB";
						}else if (v.fileSize > 1024) {
							fileSize = Math.round(v.fileSize / 1024) + "KB";
						} else {
							fileSize = Math.round(v.fileSize) + "Byte";
						}
		
						td = $("<tr>").append("<td><input type='checkbox' name='selectedFile' value='"+v.link+"'></td>")
								.append("<td class='fileName' title='" + name+ "'><div class='imgDivWrap'><div class='" + fileImg + " imgDiv'></div></div>" + name + "</td>")
								.append("<td>" + (v.modified).substring(0,(v.modified).length-3) + "</td>")
								.append("<td>" + fileType + "</td>")
								.append("<td>" + fileSize + "</td>")
								.append("<td><span class='viewHistory'>보기</span></td>")
								.attr("data-link",v.link)
								.attr("class","fileLink")
						contents.push(td);
					});
				}else{
					td = $("<tr>").append("<td colspan='8' rowspan='5' style='height:400px'> 선택한 폴더에 저장된 파일이 없습니다. </td>");
					contents.push(td);
				}
				$("#fileTable tbody").empty().append(contents);
			}
		});
	}
	
	// 폴더 삭제(트리에서)
	$(window).on("keyup", function(event) {
		if (event.keyCode != 46)
			return;
		cAlert("폴더를 삭제하시겠습니까?(삭제시 하위 폴더 및 파일까지 모두 삭제 됩니다.)","confirm","deleteFolder");
	});
	
	//파일 압축 다운로드
	$("#zipBtn").on("click",function(){
		cAlert("압축파일명","prompt","ZIP");
	});
	
	// 이름변경 span
	$("#changeSpan").on("click",function(){
		$("#command").val("CHANGENM");
		cAlert("변경할 파일명을 입력해주세요(확장자 포함)","prompt","CHANGENM");
	});
	$("#changeDivSpan").on("click",function(){
		$("#command").val("CHANGENM");
		$("#srcFile").val($("#path").val())
		cAlert("변경할 폴더명을 입력해주세요","prompt","CHANGENM");
	});
	
	$("#alertResult").on("change",function(){
		if($(this).val() == "") return false;
		$("#destFolder").val($(this).val()).change();
	});
	
	// 복사 span
	$("#copySpan").on("click",function(){
		$("#command").val("COPY");
		selectFolder();
	});
	
	// 이동 span
	$("#moveSpan").on("click",function(){
		$("#command").val("MOVE");
		selectFolder();
	});
	
	// 이름변경, 복사, 이동 등 ajaxForm
	$("#destFolder").on("change",function(){
		var comval = $("#command").val()
		if(comval != "NFOLDER"){
			$("#srcFile").val($("#fileTable").find("#selectedTr").data("link"));
		}
		if(comval != "" && $(this).val() != "true"){
			$("#fileMangeForm").ajaxForm({
				success: function(res){
					console.log(res)
					if(res.result == "OK"){
						if(comval != "NFOLDER"){
							console.log("성공",$("#path").val())
							var path = ($("#path").val()=="")||($("#path").val()==undefined)?"first:private\\"+emplNo+"\\MyDrive\\":$("#path").val() 
							console.log("성공",path)
									fileList(path)
						}else{
							//트리 리로드(새폴더 생성)
							$(this).val("")
							folderParent.load(true);
						}
					}else{
						cAlert("변경 실패 개발자에게 문의해주세요.")
						$("#command").val("");
					}
				}
			}).submit();
		}
	})
	
	selectFolder = function(){
		var nWidth = 300;
		var nHeight = 550;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 5) - (nWidth / 2);
		var nTop = curY + (curHeight / 3) - (nHeight / 2);
		popup = window.open(
				"driveFileManage.do",
				"selectFolder",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
		
	}
	
	
	// 이력보기 span
	$("#histSpan").on("click",function(){
		$("#fileTable").find("#selectedTr").find(".viewHistory").click();
	});
	
	// 삭제 span
	$("#delSpan").on("click",function(){
		$("#fileTable").find("#selectedTr").find("input[type='checkbox']").attr("checked","checked")
		deleteFunction();
	});
	
	// 선택 삭제
	$("#deleteBtn").on("click",function(){
		deleteFunction();
	});
	
	deleteFunction = function(){
		$("#selectForm").ajaxForm({
			url: cPath+"/group/schedule/drive/driveDelete.do",
			method: "post",
			success : function(res){
				if(res.result == "OK"){
					cAlert("삭제 성공, 삭제한 파일 갯수:"+res.count);
					fileList($(path).val())
				}else{
					cAlert("삭제 실패, 개발자에게 문의해주세요");
				}
			}
		}).submit();
	}
	
	//cAlert 관련
	$("#alertResult").on("change",function(){
		
		if($(FNNAME).val() == "ZIP"){
			var filename = $(this).val();
			var selectedFile = $("#selectForm").serialize();
			var newA = $("<a>").attr({
				href:"zip.do?"+selectedFile,
				download:filename+".zip"
			});
			newA.get(0).click();
		};
		
		if($(FNNAME).val() == "deleteFolder" && $(this).val() == "true"){
			var srcFile = tree1.getActiveNode();
			if(srcFile != null){
				commandProcess({
					command : "DELETE",
					data : {
						otherNode : srcFile
					}
				});
				$("#fileTable tbody").empty()
			}else{
				cAlert("개인폴더만 삭제 가능 합니다")
			}
			FNNAME.val("")
			$(this).val("")
		}		

		if($(FNNAME).val() == "newFolder"){
			$("#destFolder").val($("#alertResult").val());
		};		
		$("#newFolderDiv").slideUp();
	});
	
	// 파일 업로드
	$("#uploadBtn").on("click",function(){
		if($(path).val()=="") {
			cAlert("폴더를 선택해주세요");
			return false;
		}
		$(uploadFile).click();
	});
	
	uploadFile.on("change",function(){
		$("#uploadForm").ajaxForm({
			success:(res)=>{
				if(res.result=="실패"){
					cAlert(res.result);
				}else{
					fileList($(path).val());
					$(this).val("");
				}
			}
		}).submit();
		return false;
	})
	
	
	// 파일 이력관리
	function recordHist(command,filePath){
//		case "INSERT" // case "MODIFY" : // case "DELETE" : 
//			$.ajax({
//				url:"",
//				data:{
//					command:command,
//					filePath:filePath
//					},
//				success : function(res){
//					
//				}
//			});
	}
	
	
	// 이력 보기
	$("#fileTable").on("click",".viewHistory", function() {
		var nWidth = 1500;
		var nHeight = 700;
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);
		window.name = "History";
		var link = $(this).parents("tr").data("link");
		console.log(link)
		popup = window.open(
				"historyView.do?link="+link,
				"history",
				"status=no, resizable=no, menubar=no,toolbar=no, location=no, scrollbars=no ,height=" + nHeight  + "px, width=" + nWidth  + "px, left="+ nLeft + "px, top="+ nTop+"px");
	});

	// 우클릭 이벤트 막기
	$(document).on("contextmenu",function(e){
		e.stopPropagation()
		return false;
	}).on("click",function(e){
		e.stopPropagation()
		$(RDIV).hide().css("transition","");
	});
	
	var folderParent = "";
	// 트리에서 오른쪽 클릭
	$(".tree").on("contextmenu","span",function(e){
		folderParent = $.ui.fancytree.getNode(e)
		$("#srcFile").val($.ui.fancytree.getNode(e).key)
		$(NFDIV).hide();
		xValue = e.originalEvent.clientX;
		yValue = e.originalEvent.clientY;
		
		if($(this).parents("div[class='tree']").attr("id") == "tree2"){
			$("#delFolderSpan").hide();
		}else{
			$("#delFolderSpan").show();
		}
		
		
		$(NFDIV).css("transform","translate("+xValue+"px,"+yValue+"px)").css("transition","all 0s")
		$(NFDIV).show();
	}).on("click",function(){
		$(NFDIV).hide();
	})
	
	// 새폴더 만들기
	$("#nFolderSpan").on("click",function(){
		$("#command").val("NFOLDER");
		cAlert("생성할 폴더 이름","prompt","newFolder");
	});
	
	$("#delFolderSpan").on("click",function(){
		cAlert("폴더를 삭제하시겠습니까?(삭제시 하위 폴더 및 파일까지 모두 삭제 됩니다.)","confirm","deleteFolder");
	});
});