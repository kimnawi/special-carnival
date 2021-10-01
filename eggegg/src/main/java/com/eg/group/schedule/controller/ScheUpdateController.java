package com.eg.group.schedule.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.group.schedule.service.ScheService;

@Controller
@RequestMapping("/group/schedule/scheduleUpdate.do")
public class ScheUpdateController {
	@Inject
	private ScheService service;
	
	@GetMapping
	public String scheduleForm() {
		return "schedule/scheduleForm";
	}
	
	@PostMapping
	public String scheduleUpdate() {
		return "schedule/shceduleList";
	}
}
