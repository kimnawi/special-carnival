package com.eg.commute.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.eg.commute.service.CommuteService;

@Controller
public class CommuteDeleteController {

	@Inject
	private CommuteService service;
	
	@RequestMapping(value="/commute/commuteDelete.do", method=RequestMethod.POST)
	public String commuteDelete() {
		return "commute/commuteList";
	}
}
