package com.eg.group.drive.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;

import com.eg.commons.exception.DataNotFoundException;
import com.eg.group.drive.service.FTPFileService;

@Controller
@RequestMapping("/group/schedule/drive/zip.do")
public class DriveZipController {

	@Inject
	@Named("ftpPoolService")
	private FTPFileService service;
	
	@Inject
	private WebApplicationContext container;
	
	@GetMapping
	public ResponseEntity<byte[]> archiveDownload(
		String[] selectedFile
	) throws Exception {
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();		
		service.compressFiles(baos, selectedFile);
		return ResponseEntity.ok()
							.header("Content-Length", baos.size()+"")
							.body(baos.toByteArray());
	}
	
}
