package com.eg.hrd.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.eg.hrd.service.HrdService;

@Controller
public class HrdDeleteController {

	@Inject
	private HrdService service;
	
	@RequestMapping(value="/hrd/hrdDelete.do", method=RequestMethod.POST)
	public String HrdDelete() {
		return "hrd/hrdList";
	}
}
