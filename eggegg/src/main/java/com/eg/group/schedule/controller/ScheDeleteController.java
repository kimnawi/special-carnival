package com.eg.group.schedule.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.eg.group.schedule.service.ScheService;

@Controller
public class ScheDeleteController {
	@Inject
	private ScheService service;
	
	@RequestMapping(value="/group/schedule/scheduleDelete.do", method=RequestMethod.POST)
	public String scheduleDelete() {
		return "schedule/scheduleList";
	}
}
