package com.eg.group.atdlv.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.group.atdlv.service.AtdlvService;

@Controller
public class AtdlvRetrieveController {
	@Inject
	private AtdlvService service;
	
	@RequestMapping("/group/atdlv/atdlvRetrieve.do")
	public String atdlvList() {
		return "atdlv/atdlvList";
	}
}
