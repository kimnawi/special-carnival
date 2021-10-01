package com.eg.adgroup.controller;	

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eg.adgroup.service.AdGroupService;

@Controller
public class AdGroupDeleteController {

	@Inject
	private AdGroupService service;
	
	@RequestMapping(value="/sal/groupDelete.do")
	public String deleteGroup(
			@RequestParam(value="code") String codes
		) {
		String[] code = codes.split(",");
		for(int i = 0; i< code.length; i++) {
			service.removeGroup(code[i]);
		}
		return "redirect:/sal/adGroupList.do";
		
	}
	
}
