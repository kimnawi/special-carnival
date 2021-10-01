/**
 * <pre>
 * </pre>
 * 
 * @author 이기정
 * @since 2021. 8. 20.
 * @version 1.0
 * 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2021. 8. 20.      admin       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
$(function(){

	$(".controlBtn").on("click", function(){
		let gopage = $(this).data("gopage");
		if(gopage){
			location.href = gopage;
		}
	}).css("cursor","pointer");
	
	var li = $("#sidebarMenu>ul").children("li");
	$.each(li,function(i,v){
		$(v).find("ul").siblings("div").append($("<span>",{
			text:"▼",
			class:"menuToggle"
			})
		)
	})
	
	$(".menuToggle").on("click",function(e){
		e.preventDefault();
		if($(this).css("transform")=="none"){
			$(this).css({"transform":"rotate(180deg)"});
		}else{
			$(this).css({"transform":"none"});
		}
		$(this).parent().siblings("ul").slideToggle(500);
		return false;
	})
	
	
});
const ChangeContent = $(".changeContent")
ChangeContent.on("click",function(){
	const notChange = $(".notChange").css("background","none").css("color","black").css("font-weight","normal");
	ChangeContent.css("background","none").css("color","black").css("font-weight","normal")
	if($(this).parent("ul")[0]){
		$(this).parent("ul").siblings("div").css("background","#3A4CA8").css("color","white")
		$(this).css("color","#333E91").css("font-weight","bolder")
	}else{
		$(this).css("background","#3A4CA8").css("color","white")
	}
	url = $(this).data("url");
	$.ajax({
		url : url,
		dataType : 'html',
		success : function(data){
			$("main").children().remove();
			$("main").html(data);
		}
	});
})

 function isEmpty(data) {
    if(typeof(data) === 'object'){
    	if(JSON.stringify(data) === '{}' || JSON.stringify(data) === '[]'){
        return true;
	    }else if(!data){
	        return true;
	    }
	    return false;
    }else if(typeof(data) === 'string'){
    	if(!data.trim()){
    		return true;
    	} 
    	return false;
    }else if(typeof(data) === 'undefined'){
    	return true;
    }else if(isNaN(data) == true){ 
    	return true;
	}else if(data === 0){ 
		return true;
	}else{
        return false;
    }
}