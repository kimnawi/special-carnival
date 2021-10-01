package com.eg.group.atdlv.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.eg.group.atdlv.service.AtdlvService;

@Controller
public class AtdlvDeleteController {

	@Inject
	private AtdlvService service;
	
	@RequestMapping(value="/group/atdlv/atdlvDelete.do", method=RequestMethod.POST)
	public String atdlvDelete() {
		return "atdlv/atdlvList";
	}
}
