package com.eg.group.chat.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.group.chat.service.ChatService;

@Controller
public class ChatRetrieveController {

	@Inject
	private ChatService service;
	
	@RequestMapping("/chat/chatList.do")
	public String chatlList() {
		
		return "chat/chatList";
	}
	
	@RequestMapping("/chat/chatView.do")
	public String chatView() {
		
		return "chat/chatView";
	}
}
