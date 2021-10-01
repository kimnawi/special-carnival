package com.eg.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {

	@RequestMapping("/admin/retrieveDriveRoot.do")
	public String driveForm() {
		return "admin/driveList";
	}

	
	@RequestMapping("/admin/retrieveUnsaved.do")
	public String unsavedForm() {
		return "admin/unsavedList";
	}

	
	@RequestMapping("/admin/retrieveBoard.do")
	public String boardForm() {
		return "admin/boardList";
	}
	
	
	@RequestMapping("/admin/retrieveCommons.do")
	public String commonsForm() {
		return "admin/commonsList";
	}
	
}
