package com.eg.cert.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.cert.service.CertService;

@Controller
public class CertRetrieveController {

	@Inject
	private CertService service;
	
	@RequestMapping("/cert/certList.do")
	public String certList() {
		return "cert/certList";
	}

	@RequestMapping("/cert/certPrint.do")
	public String certPrint() {
		return "print";
	}
}