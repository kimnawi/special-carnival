package com.eg.group.drive.controller;

import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.group.drive.service.FTPFileService;

@Controller
@RequestMapping("/download")
public class DriveDownloadController {

	@Inject
	@Named("ftpPoolService")
	private FTPFileService service;
	
	@ResponseBody
	@GetMapping
	public void download(
			String link,
			HttpServletResponse resp
			) throws Exception {
		link = link.replaceAll(" ", "+");
		service.downloadFile(link, resp);
	}
	
}
