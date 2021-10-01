package com.eg.group.chat.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.eg.group.chat.service.ChatService;

@Controller
public class ChatDeleteController {

	@Inject
	private ChatService service;
	
	@RequestMapping(value="/chat/chatDelete.do", method=RequestMethod.POST)
	public String chatDelete() {
		return "chat/chatList";
	}
}
