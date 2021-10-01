
/**
 * <pre>
 * Custom Alert 을 위한 자바스크립트
 * </pre>
 * @author 이기정
 * @since 2021. 9. 11.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2021. 9. 11.      admin       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
**/
//친애하는 나위에게 
//나위야 나는 너의 수호천사야
//언제나 너의 곁에서 너를 지켜주었었는데..
//벌써 이렇게나 커서 혼자 상담도 가고...크흡
//나는 이제 너를 보내줄 때가 온 것 같아서 
//기쁘기도 하고 한편으로는 슬프구나..
//나위와 함께한 모든 날들이 행복한 추억으로 남아있단다
//나 없이도 행복하게 밝게 잘 살려무나 (질척
//나 잊어버리질말구..! (질척
//너의 다정함 나는 알아 !
const FNNAME = $("#fnName");
const PREVENTDIV = $("#preventClickDiv").css("display","none");
const CALERTBODY = $("#cAlertBody");
const CALERTFOOT = $("#cAlertFooter");
const ALERTYESBTN = $("#alertYesBtn");
const CANCLEBTN = $("<button type='button' id='alertCancelBtn' onclick='closeAlert(false)'>취소</button>");
const ALERTCONTENT = $("#cAlertContent");
var promFlag = 0;
var confirmFlag = 0;

function cAlert(text, type, fnName){
//	console.log(fnName)
//	console.log(text)
	ALERTCONTENT.html(text);
	PREVENTDIV.css("display","");
	$(FNNAME).val(fnName);
	if(type=="prompt"){
		CALERTBODY.find("p").append("<br>").append("<input type='text' id='alertPrompt'>");
		ALERTYESBTN.text("입력").after(CANCLEBTN);
		promFlag = true;
	}else if(type=="confirm"){
		ALERTYESBTN.text("확인").after(CANCLEBTN);
		confirmFlag = true;
	}else{
		ALERTYESBTN.text("확인")
		$(CANCLEBTN).remove();
	}
};

PREVENTDIV.on("click",function(e){
	e.stopPropagation();
});

ALERTYESBTN.on("click",function(){
	closeAlert(true)
});

CALERTFOOT.on("click","#alertCancelBtn",function(){
	closeAlert(false)
});


$("#closeAlertBtn").on("click",function(){
	closeAlert()
});

function closeAlert(bool){
	if(promFlag && bool){
		alertPromVal = CALERTBODY.find("#alertPrompt").val();
		CALERTBODY.find("#alertPrompt").remove();
		$("#alertResult").val(alertPromVal);		
	}else if(confirmFlag && bool){
		$("#alertResult").val(bool);
	}
	confirmFlag = false;
	promFlag = false;
	$("#alertResult").focus().blur().change();
	ALERTCONTENT.empty();
	PREVENTDIV.css("display","none");
};
// 엔터키를 눌렀을때
$(document).on("keyup",function(e,key){
	if(e.keyCode == '13' && FNNAME.val() != "ahReturnCn"){
		$(e.currentTarget).click();
		closeAlert(true)
	}
});

