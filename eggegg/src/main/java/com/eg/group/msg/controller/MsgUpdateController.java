package com.eg.group.msg.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.group.msg.service.MsgService;

@Controller
public class MsgUpdateController {
	@Inject
	private MsgService service;
	
	@RequestMapping(value="/msg/msgStateUpdate.do", method=RequestMethod.POST)
	public String msgStateUpdate(
		@RequestParam(value="what[]", required=false) String[] msgNo
		, Model model
	) {
		service.modifyMsgState(msgNo);
		return "msg/msgList";
	}
	
	@RequestMapping(value="/msg/msgSaveUpdate.do", method=RequestMethod.POST)
	@ResponseBody
	public String msgSaveUpdate(
			@RequestParam(value="what[]", required=false) String[] msgNo
			, Model model
			) {
		service.modifyMsgSave(msgNo);
		return "msg/msgList";
	}
}
