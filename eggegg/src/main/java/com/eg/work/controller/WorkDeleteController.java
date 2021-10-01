package com.eg.work.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eg.commons.ServiceResult;
import com.eg.work.service.WorkService;

@Controller
public class WorkDeleteController {
	@Inject
	private WorkService service;
	
	@RequestMapping(value="/sal/workDelete.do")
	public String workDelete(
		@RequestParam(value="stdate") String stdate
	) {
		
		ServiceResult result = service.removeWork(stdate);
		
		
		
		return "redirect:/sal/workList.do";
	}
	
	
}
