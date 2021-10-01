package com.eg.cert.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.eg.cert.service.CertService;

@Controller
public class CertDeleteController {

	@Inject
	private CertService service;
	
	@RequestMapping(value="/cert/certDelete.do", method=RequestMethod.POST)
	public String certDelete() {
		return "cert/certList";
	}
	
}
