package com.eg.group.drive.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.group.drive.service.FTPFileService;

@Controller
@RequestMapping("/group/schedule/drive/driveDelete.do")
@Lazy
public class DriveDeleteController {

	@Inject
	@Named("ftpPoolService")
	FTPFileService service;
	
	@PostMapping
	@ResponseBody
	public Map<String,Object> delete(
			String[] selectedFile
			) throws Exception{
		Map<String,Object> result = new HashMap<>();
		service.deleteAll(selectedFile,result);
		return result;
	}
	
}
