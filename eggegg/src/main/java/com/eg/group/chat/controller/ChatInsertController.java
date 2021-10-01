package com.eg.group.chat.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.group.chat.service.ChatService;

@Controller
@RequestMapping("/chat/chatInsert.do")
public class ChatInsertController {

	@Inject
	private ChatService service;
	
	@GetMapping
	public String chatForm() {
		return "chat/chatForm";
	}
	
	@PostMapping
	public String chatInsert() {
		return "chat/chatList";
	}
}
