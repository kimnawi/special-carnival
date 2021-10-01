package com.eg.group.msg.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.eg.group.msg.service.MsgService;

@Controller
public class MsgDeleteController {
	@Inject
	private MsgService service;
	
	@RequestMapping(value="/msg/msgDelete.do", method=RequestMethod.POST)
	public String msgDelete(
		@RequestParam(value="what[]", required=false) String[] msgNo
		, Model model
	) {
		service.removeMsg(msgNo);
		return "msg/msgList";
	}
}