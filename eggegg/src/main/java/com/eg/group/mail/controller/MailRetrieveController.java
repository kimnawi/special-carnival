package com.eg.group.mail.controller;

import java.io.IOException;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eg.group.mail.service.CredentialManager;
import com.eg.group.mail.service.MailService;
import com.eg.vo.EmplVOWrapper;
import com.google.api.client.auth.oauth2.Credential;

@Controller
public class MailRetrieveController {

	@Inject
	private MailService service;
	@Inject
	private CredentialManager credentialManager;
	
	@RequestMapping("/group/mail/receiveMailList.do")
	public String selectReceiveMailList(
			@AuthenticationPrincipal EmplVOWrapper wrapper,
			@RequestParam(required=false) String command
			) throws IOException {
		
		Credential code = credentialManager.loadCredential(String.valueOf(wrapper.getAdaptee().getEmplNo()));
		if(code == null) {
			credentialManager.sendAuthorizationCodeRequest();
		}
		
		if("content".equals(command)) {
			// 메뉴 메일 부분 클릭했을 때
			return "/mail/mailList";
		}else {
			// 헤더 메일 부분 클릭했을 때
			return "mail/mailList";
		}
	}

//	@RequestMapping("/mail_client/callback")
//	public String oauthMailList(
//			String code
//			) {
//		System.out.println("여기로 -----------------------------------------------");
//		credentialManager.createAndStoreCredential(authorizationCode, userId);
//		if("content".equals(command)) {
//			// 메뉴 메일 부분 클릭했을 때
//			return "/mail/mailList";
//		}else {
//			// 헤더 메일 부분 클릭했을 때
//			return "mail/mailList";
//		}
//	}
	
	
	@RequestMapping("/group/mail/oauth.do")
	public String oauth(
			) {
		 String uri = credentialManager.sendAuthorizationCodeRequest();
		 System.out.println(uri);
		 System.out.println(uri);
		 System.out.println(uri);
		 System.out.println(uri);
		 System.out.println(uri);
		 System.out.println(uri);
		 System.out.println(uri);
		return uri;
				
	}
	
	@RequestMapping("/group/mail/mailDetail.do")
	public String selectDetailMail() {
		return "/mail/mailList";
	}
	
	@RequestMapping("/group/mail/sendedMailList.do")
	public String sendedMailList() {
		return "/mail/mailList";
	}

	@RequestMapping("/group/mail/tempMailList.do")
	public String tempMailList() {
		return "/mail/mailList";
	}
}
