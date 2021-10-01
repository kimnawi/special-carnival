package com.eg.group.mail.controller;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.group.mail.service.MailService;

public class MailUpdateController {

	@Inject
	private MailService service;
	
	@RequestMapping("/group/mail/moveCategory.do")
	public String moveCategory() {
		return "mail/mailsList";
	}
	
	@RequestMapping("/group/mail/temporarySave.do")
	public String temporarySaved() {
		return "mail/mailForm";
	}
	
	@RequestMapping("/group/mail/impMail.do")
	public String moveImport() {
		return "mail/mailList";
	}
	
	//리스트에서 삭제
	@RequestMapping("/group/mail/receiveMailList.do")
	public String deleteMail() {
		return "mail/mailList";
	}
	
		
}
