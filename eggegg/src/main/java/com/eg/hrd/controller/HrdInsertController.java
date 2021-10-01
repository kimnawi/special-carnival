package com.eg.hrd.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.hrd.service.HrdService;

@Controller
@RequestMapping("/vac/hrdInsert.do")
public class HrdInsertController {
	
	@Inject
	private HrdService service;
	
	@GetMapping
	public String hrdForm() {
		return "hrd/hrdForm";
	}
	
	@PostMapping
	public String hrdInsert() {
		return "hrd/hrdList";
	}
	
}
