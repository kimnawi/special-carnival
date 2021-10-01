package com.eg.vacation.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.vacation.service.VacService;
import com.eg.vo.PagingVO;
import com.eg.vo.VacStatusVO;

@Controller
public class VacStatusController {
	
	@Inject
	private VacService service;
	
	@RequestMapping("/vac/vacStatus.do")
	public String vacStatus() {
		//휴가현황
		return "/vac/vacStatus";
	}
	
	@RequestMapping(value="/vac/vacStatus.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<VacStatusVO> ajaxVacStatus(
			@ModelAttribute("detailSearch") VacStatusVO detailSearch
		){
		PagingVO<VacStatusVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(detailSearch);
 		service.retrieveVacStatus(pagingVO);
		return pagingVO;
	}
	
	/*@RequestMapping("/vac/vacLeftStatus.do")
	public String vacLeftStatus() {
		//휴가잔여일수현황
		return "/vac/vacLeftStatus";
	}
	
	@RequestMapping("/vac/vacUseStatus.do")
	public String vacUseStatus() {
		//휴가사용실적현황
		return "/vac/vacUseStatus";
	}
	
	@RequestMapping("/vac/vacTallyStatus.do")
	public String vacTallyStatus() {
		//휴가집계표
		return "/vac/vacTallyStatus";
	}*/
	
}
