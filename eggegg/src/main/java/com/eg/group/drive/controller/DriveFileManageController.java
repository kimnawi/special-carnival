package com.eg.group.drive.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.http.HttpServletRequest;
import javax.xml.ws.Service;

import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.commons.ServiceResult;
import com.eg.group.drive.service.FTPFileService;
import com.eg.group.drive.service.FTPFileService.CommandType;
import com.eg.util.AES256Util;
import com.eg.vo.EmplVOWrapper;

@Controller
@RequestMapping("/group/schedule/drive/driveFileManage.do")
@Lazy
public class DriveFileManageController {

	@Inject
	@Named("ftpPoolService")
	private FTPFileService service;

	@Inject
	AES256Util encoder;
	
	@GetMapping
	public String folderForm(
			) {
		return "/drive/uploadForm";
	}
	
	@PostMapping
	@ResponseBody
	public Map<String, Object> fileManage(
			String srcFile,
			String destFolder,
			CommandType command,
			@AuthenticationPrincipal EmplVOWrapper wrapper,
			HttpServletRequest req
			) throws Exception{
		Map<String, Object> result = new HashMap<>();
		ServiceResult sResult = ServiceResult.FAIL;
		result.put("result",sResult);
		Integer driveOper = wrapper.getAdaptee().getEmplNo();
		String userIp = req.getRemoteAddr();
		if((CommandType.CHANGENM).equals(command)) {
			// 받아오는 파라미터가 같아서 이렇게 쓰지만 실제 srcFile == fromPath, destFolder == toFileNm임.
			sResult = service.changeNm(srcFile, destFolder, driveOper, userIp);
			result.put("result",sResult);
		}else if((CommandType.NFOLDER).equals(command)) {
			sResult = service.newFolder(srcFile, destFolder);
			result.put("result",sResult);
		}else {
			sResult = service.fileManage(command, srcFile, destFolder, String.valueOf(driveOper), userIp);
			result.put("result",sResult);
		}
		return result;
	}
	
}
