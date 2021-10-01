package com.eg.group.mail.controller;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.group.mail.service.MailService;

public class MailInsertController {

	@Inject
	private MailService service;
	
	@RequestMapping("/group/mail/replyMail.do")
	public String replyMail() {
		return "mail/mailForm";
	}
	
	@RequestMapping("/group/mail/deliveryMail.do")
	public String deliveryMail() {
		return "mail/mailList";
	}
	
	@RequestMapping("/group/mail/writeMail.do")
	public String sendMailForm() {
		return "mail/mailForm";
	}
	
	
}
