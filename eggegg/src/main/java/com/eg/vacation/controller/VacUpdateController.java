package com.eg.vacation.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.vacation.service.VacService;

@Controller
@RequestMapping("/vac/vacUpdate.do")
public class VacUpdateController {

	@Inject
	private VacService service;
	
	@GetMapping
	public String vacForm() {
		return "vac/vacForm";
	}
	
	@PostMapping
	public String vacList() {
		return "vac/vacList";
	}
}
