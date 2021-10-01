package com.eg.group.msg.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.commons.ServiceResult;
import com.eg.group.msg.service.MsgService;
import com.eg.vo.MsgVO;

@Controller
@RequestMapping("/msg/msgInsert.do")
public class MsgInsertController {

	@Inject
	private MsgService service;

	
	@ModelAttribute("command")
	public String addCommand() {
		return "INSERT";
	}
	
	@GetMapping
	public String msgForm(Model model) {
		MsgVO msgVo = new MsgVO();
		model.addAttribute("msg", msgVo);
		return "msg/msgForm";
	}
	
	@PostMapping
	public String msgInsert(
		@Validated @ModelAttribute("msg") MsgVO msg
		, @RequestParam(value="senderCode", required=false) String msgSenderCode
		, @RequestParam(value="senderNm", required=false) String msgSenderNm
		, Errors errors
		, RedirectAttributes redirectAttributes) {
		String viewName = null;
		String message = null;
		
		if(!errors.hasErrors()) {
			msg.setMsgContent(msg.getMsgContent().replaceAll("\\r", "").replaceAll("\\n", "<br>"));
			
			String[] receivers = msg.getMsgReceiver().split(",");
			
			ServiceResult result = null;
			
			for(int i = 0; i < receivers.length; i++) {
				MsgVO msgVO = new MsgVO();
				
				msgVO.setMsgSender(msg.getMsgSender());
				msgVO.setMsgContent(msg.getMsgContent());
				msgVO.setMsgReceiver(receivers[i]);
				result = service.createMsg(msgVO);
				
			}			
			
			switch (result) {
			case OK:
				viewName = "redirect:/msg/msgList.do";
				break;
			default:
				viewName = "/msg/msgForm";
				message = "서버 오류, 잠시 후에 다시 시도해주세요.";
				break;
			}
		} else {
			viewName = "/msg/msgForm";
		}
		redirectAttributes.addFlashAttribute("message", message);
		
		return viewName;
	}
}
