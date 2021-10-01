package com.eg.group.schedule.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.group.schedule.service.ScheService;

@Controller
@RequestMapping("/schedule/scheInsert.do")
public class ScheInsertController {
	@Inject
	private ScheService service;
	
	@GetMapping
	public String scheForm() {
		return "/schedule/scheForm";
	}
	@PostMapping
	public String scheInsert() {
		return "/schedule/scheList";
	}
}
