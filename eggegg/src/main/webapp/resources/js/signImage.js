/**
 * <pre>
 * 
 * </pre>
 * @author 이기정
 * @since 2021. 8. 23.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2021. 8. 23.      admin       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
**/
$(function(){
	$("#imageBtn").on("click",function(){
		$("input[type='file']").click();
	});
	
	var cropper;
	const result = $('#result');
	const inputFile = $('input[type="file"]');
	const resultBox = $('#resultBox');
	const originalDiv = $("#originalDiv");
	const originalBtnDiv = $(".originalBtnDiv")
    // 사진 업로드 버튼
    $('#photoBtn').on('change', function(){
    	if($('.cropper-container').length != 0){
    		cAlert("초기화 후 올려주세요");
    		$("#resetPhoto").click();
    		return false;
    	}
        
        var image = $('#originalImage');
        var imgFile = $('#photoBtn').val();
        var fileForm = /(.*?)\.(jpg|jpeg|png)$/;
        
        
        // 이미지의 확장자 확인 후 노출
        if(imgFile.match(fileForm)) {
        	var reader = new FileReader(); 
        	reader.onload = function(event) { 
        		image.attr("src", event.target.result);
        		cropper = image.cropper( {
        			dragMode: 'move',
        			viewMode:1,
        			aspectRatio: 1,
        			autoCropArea:0.9,
        			minCropBoxWidth:200,
       				restore: false,
                    guides: true,
                    center: false,
                    highlight: true,
                    cropBoxMovable: false,
                    cropBoxResizable: false,
                    toggleDragModeOnDblclick: false
                });
        		originalBtnDiv.eq(0).css("width","333px")
           };
           
        	reader.readAsDataURL(event.target.files[0]);
        } else{
        	cAlert("이미지 파일(jpg, png형식의 파일)만 올려주세요");
        	return; 
        }
	});
    // 초기화 버튼
    $('#resetPhoto').on('click', function(){
    	var photoBtn = $('#photoBtn');
    	var image = $('#originalImage');
    	originalBtnDiv.eq(0).css("width","330px")

    	if(photoBtn.val() != ""){
        	photoBtn.val('');
        	originalDiv.empty().append('<img id="originalImage" src="">');
        	result.attr("src","")
        	result.css("border", "none")
        	
        }else{
        	cAlert('업로드된 사진이 없습니다.');
        }
    });
    var flag = false;
    // 미리보기 버튼
    $("#arrowImg").on("click", function(){
    	var image = $('#originalImage');
    	if(inputFile.val() != ""){
    		canvas = image.cropper('getCroppedCanvas',{
    			width:200,
    			height:200
    		});
    		result.attr('src',canvas.toDataURL("image/jpg"));
    		result.css("border", "1px solid black")
    		flag=true;
	    }else{
	    	cAlert('사진을 업로드 해주세요');
	    	$('input[type="file"]').focus();
	    	return;
	    }
    })
    
    
    // 업로드 버튼
    
    var canvas;
    $('#complete').on('click', function(){
    	var fileName = inputFile.val().substring(inputFile.val().lastIndexOf('\\')+1)
    	if(inputFile.val() != "" && flag){

    		var uploadedPath = "";
	    	canvas.toBlob(function (blob) {
	    		var formData = new FormData();
	    		formData.append("uploadFile", blob, fileName, 0.7);
	    		formData.append("paths", "commons\\signImage\\"+emplNo);
	    		
	    		$.ajax({
	    			url : cPath+'/group/schedule/drive/driveUpload.do',
	           		method: 'POST',
	                data: formData,
	                processData: false,
	                contentType: false,
	                error: function () {
	                	cAlert('업로드 실패');
	                	resultBox.remove()
	                },
	    		}).done(function(res){
	    			cAlert('업로드 성공',"","close");
	    			originalDiv.empty().append('<img id="originalImage" src="">');
	    			result.attr("src","").css("border","none")
	    			originalBtnDiv.eq(0).css("width","330px")

	    			$.ajax({
	    				url : cPath+'/group/esign/updateSignImage.do',
	    				method: "POST",
	    				data:{path:res.resultPath},
	    				success : function(res){
	    					console.log("두번째 ajax",res)
	    				}
	    				
	    			})
	    		});
	    		
	    	})//canvas end;
    	}else if(inputFile.val() != "" && !flag){
    		cAlert('화살표 버튼을 눌러 확인 해주세요');
    	}else{
    		cAlert('사진을 업로드 해주세요');
    		$('input[type="file"]').focus();
    		return;
    	}
    });
    
    $("#alertResult").on("change",function(){
    	if($(FNNAME).val() == "close"){
    		window.close();
    	}
    })
    
})//$function end;