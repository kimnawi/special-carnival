package com.eg.group.atdlv.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.group.atdlv.service.AtdlvService;

@Controller
@RequestMapping("/group/atdlv/atdlvInsert.do")
public class AtdlvInsertController {
	
	@Inject
	private AtdlvService service;
	
	@GetMapping
	public String atdlvForm() {
		return "atdlv/atdlvForm";
	}
	
	@PostMapping
	public String atdlvInsert() {
		return "atdlv/atdlvList";
	}
	
}
