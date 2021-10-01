package com.eg.group.drive.controller;

import java.io.File;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.commons.ServiceResult;
import com.eg.group.drive.service.FTPFileService;
import com.eg.group.drive.service.FTPFileService.CommandType;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.FTPFileWrapper;

@Controller
@RequestMapping("/group/schedule/drive/driveList.do")
@Lazy
public class DriveController {

	@Inject
	@Named("ftpPoolService")
	private FTPFileService service;
	
	@GetMapping
	public String form(
			int who,
			@AuthenticationPrincipal EmplVOWrapper wrapper,
			RedirectAttributes rattr,
			@RequestParam(required=false) String command
			) {
		int authEmplNo = (int)(wrapper.getAdaptee()).getEmplNo();
		String viewName = "drive/driveList";
		if(!StringUtils.isBlank(command)) viewName = "/"+viewName;
		if(who == authEmplNo) return viewName;
		rattr.addFlashAttribute("errorMessage","자신의 드라이브만 조회 가능");
		return "redirect:/";
	}
	
	@PostMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> fileManage(
		@RequestParam(required=true) CommandType command, 
		@RequestParam(required=true) 	String srcFile,
		@RequestParam(required=false) 	String destFolder
	) throws Exception {
		ServiceResult result = service.fileManage(command, srcFile, destFolder);
		Map<String, Object> resultMap = Collections.singletonMap("success", result);
		return resultMap;
	}
	
	@GetMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE,params="fileList")
	@ResponseBody
	public List<FTPFileWrapper> fileListView(
			@RequestParam(value="fileList", required=false) String base
			) throws Exception {
		return service.fileList(base);
	}
	
	@GetMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<FTPFileWrapper> view(
			@RequestParam(value="base", required=false) String base
			) throws Exception {
		return service.traversing(base);
	}
	
	@GetMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE,params="privateBase")
	@ResponseBody
	public List<FTPFileWrapper> privateView(
			@AuthenticationPrincipal EmplVOWrapper wrapper,
			@RequestParam(value="privateBase", required=false) String base
			) throws Exception {
		form(Integer.parseInt(base), wrapper, null, null);
		base = "first:private"+File.separator+base+File.separator;
		return service.traversing(base);
	}

	@GetMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE,params="publicBase")
	@ResponseBody
	public List<FTPFileWrapper> publicView(
			@RequestParam(value="publicBase", required=false) String base
			) throws Exception {
		base = "first:public"+File.separator;
		return service.traversing(base);
	}
	
}
