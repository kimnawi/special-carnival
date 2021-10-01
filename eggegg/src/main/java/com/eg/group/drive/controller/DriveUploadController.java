package com.eg.group.drive.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.group.drive.service.FTPFileService;
import com.eg.util.AES256Util;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.FTPFileWrapper;

@Controller
@RequestMapping("/group/schedule/drive/driveUpload.do")
@Lazy
public class DriveUploadController {
	
	@Inject
	@Named("ftpPoolService")
	private FTPFileService service;

	@Inject
	AES256Util encoder;
	
	@PostMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> upload(
			@RequestPart(required=true) MultipartFile uploadFile,
			@RequestParam(required=true) String paths,
			@RequestParam(required=false) String command,
			@AuthenticationPrincipal EmplVOWrapper wrapper,
			HttpServletRequest req
			) throws Exception{
		Map<String, Object> result = new HashMap<>();
		if(!"DRIVE".equals(command)) {
			paths=encoder.encrypt(paths);
		}else if("DRIVE".equals(command)) {
			result.put("command","DRIVE");
			result.put("authEmplNo",wrapper.getAdaptee().getEmplNo());
			result.put("userIp",getClientIpAddr(req));
		}
		service.uploadFile(uploadFile,paths,result);
		return result;
	}
	
	

	/**
	 * 정확한 ip주소 받아오기
	 * @param request
	 * @return
	 */
	public static String getClientIpAddr(HttpServletRequest request) {
	    String ip = request.getHeader("X-Forwarded-For");
	 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("HTTP_CLIENT_IP");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getRemoteAddr();
	    }
	 
	    return ip;
	}
}
