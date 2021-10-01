package com.eg.commute.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.commute.service.CommuteService;

@Controller
@RequestMapping("/commute/commuteInsert.do")
public class CommuteInsertController {

	@Inject
	private CommuteService service;
	
	@GetMapping
	public String commuteForm() {
		return "commute/commuteForm";
	}
	
	@PostMapping
	public String commuteList() {
		return "commute/commuteList";
	}
}
