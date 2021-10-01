package com.eg.commute.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.commute.service.CommuteService;

@Controller
public class CommuteRetrieveController {

	@Inject
	private CommuteService service;
	
	@RequestMapping("/commute/commuteCount.do")
	public String commuteCount() {
		//출/퇴근기록부 인원현황
		return "commute/commuteCount";
	}
	
	@RequestMapping("/commute/commuteList.do")
	public String commuteList() {
		//출/퇴근기록 조회
		return "commute/commuteList";
	}
	
	@RequestMapping("/commute/commuteStatus.do")
	public String commuteStatus() {
		//출/퇴근현황
		
		return "commute/commuteStatus";
	}
	
	@RequestMapping("/commute/lateStatus.do")
	public String lateStatus() {
		//지각현황
		return "commute/lateStatus";
	}
	
	@RequestMapping("/commute/comlateStatus.do")
	public String comlateStatus() {
		//출퇴근/근태현황
		return "commute/comlateStatus";
	}
	
	
}
