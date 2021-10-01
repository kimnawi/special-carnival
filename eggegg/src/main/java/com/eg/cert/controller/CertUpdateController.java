package com.eg.cert.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.cert.service.CertService;

@Controller
@RequestMapping("/cert/certUpdate.do")
public class CertUpdateController {

	@Inject
	private CertService service;
	
	@GetMapping
	public String certForm() {
		return "cert/certForm";
	}
	
	@PostMapping
	public String certUpdate() {
		return "cert/certList";
	}
}
