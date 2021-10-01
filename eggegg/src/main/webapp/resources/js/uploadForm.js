/**
 * 
 * </pre>
 * @author 이기정
 * @since 2021. 8. 27.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2021. 8. 27.      admin       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
**/


// 최초 진입시 본인 계정 드라이브 파일리스트 보여주기
const path = $("#path");
const uploadFile = $("input[name='uploadFile']");
$("#uploadBtn").on("click",function(){
	if($(path).val()=="") {
		cAlert("폴더를 선택해주세요");
		return false;
	}
	window.opener.$("#destFolder").val($(path).val()).trigger("change");
	window.close();
});

$("#tree1").fancytree({
	 selectMode : 1,
	 source: {
	    url: "driveList.do",
	    data : {privateBase : emplNo},
	    cache: false
	  },
	  lazyLoad: function(event, data){
	      var node = data.node;
	      data.result = {
	    	url: "driveList.do",
	        data: {base:node.key},
	        cache: false
	      };
	  },
	  init:function(event, data){
		  $.ui.fancytree.getTree("#tree1").expandAll();
	  },
	  click: function(node, data){
		  $(path).val(data.node.key);
	  }
});
$("#tree2").fancytree({
	selectMode : 1,
	source: {
		url: "driveList.do",
		data: {publicBase:emplNo},
		cache: false
	},
	lazyLoad: function(event, data){
		var node = data.node;
		data.result = {
				url: "driveList.do",
				data: {base:node.key},
				cache: false
		};
	},
	init:function(event, data){
		$.ui.fancytree.getTree("#tree2").expandAll();
	},
	click: function(node, data){
		$(path).val(data.node.key);
	}
});
