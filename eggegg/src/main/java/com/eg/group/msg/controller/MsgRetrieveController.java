package com.eg.group.msg.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.group.msg.service.MsgService;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.MsgVO;
import com.eg.vo.PagingVO;

@Controller
public class MsgRetrieveController {

	@Inject
	private MsgService service;
	
	@RequestMapping("/msg/msgList.do")
	public String msgList() {		
		return "msg/msgList";
	}

	@RequestMapping(value="/msg/msgList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<MsgVO> listForAjax(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
		  , @RequestParam(value="msgSender", required=false) String msgSender
		  , @RequestParam(value="msgReceiver", required=false) String msgReceiver
		  , @ModelAttribute("detailSearch") MsgVO detailSearch
	  ){
	    String[] msgSenderArr = msgSender.split(",");
	    detailSearch.setMsgSenderArr(msgSenderArr);
	    String[] msgReceiverArr = msgReceiver.split(",");
	    detailSearch.setMsgReceiverArr(msgReceiverArr);
		
		PagingVO<MsgVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveMsgList(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/msg/msgView.do")
	public String msgView(
		@RequestParam("what") int msgNo
		, @RequestParam(value="msgSender", required=false) String msgSender
		, @RequestParam(value="msgReceiver", required=false) String msgReceiver
		, @AuthenticationPrincipal EmplVOWrapper wrapper
		, Model model
	) {
		String authEmpl = String.valueOf(wrapper.getAdaptee().getEmplNo());
		System.out.println(authEmpl);
		System.out.println(msgReceiver);
		System.out.println(msgSender);
		if((!authEmpl.equals(msgReceiver)) && (!authEmpl.equals(msgSender)) ) {
			model.addAttribute("message","접근권한이 없습니다.");
			return "msg/msgView";
		}
		MsgVO msg = service.retrieveMsg(msgNo);
		model.addAttribute("msg", msg);
		return "msg/msgView";
	}
}
