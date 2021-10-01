package com.eg.group.mail.controller;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.group.mail.service.MailService;

public class MailDeleteController {

	@Inject
	private MailService service;
	
	//DB에서 삭제
	@RequestMapping("/group/mail/realMailDelete.do")
	public String deletePermanence() {
		return "mail/mailList";
	}	

	
	
}
