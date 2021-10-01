package com.eg.vacation.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.vacation.dao.VacDAO;
import com.eg.vacation.service.VacService;
import com.eg.vo.EmplVO;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.PagingVO;
import com.eg.vo.VacStatusVO;

@Controller
@RequestMapping("/vac/vacApply.do")
public class VacApplyController {

	@Inject
	private VacService service;
	@Inject
	private VacDAO dao;
	
	@GetMapping
	public String vacApplyList(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @AuthenticationPrincipal EmplVOWrapper wrapper
			, Model model	
			, String command
		) {
		Integer emplNo = wrapper.getAdaptee().getEmplNo();
		EmplVO empl = dao.selectEmplVacInfo(emplNo);
		String viewName ="";
		if("content".equals(command)) {
			// 메뉴 전자결재 부분 클릭했을 때
			viewName = "/vac/vacApply";
		}else {
			// 헤더 전자결재 부분 클릭했을 때
			viewName = "vac/vacApply";
		}
		model.addAttribute("empl", empl);
		return viewName;
	}
	
	@GetMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<VacStatusVO> listForAjax(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("detailSearch") VacStatusVO detailSearch
			, @AuthenticationPrincipal EmplVOWrapper wrapper
		){
		Integer emplNo = wrapper.getAdaptee().getEmplNo();
		
		PagingVO<VacStatusVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		pagingVO.setEmplNo(emplNo);
		
		service.retrieveVacApplyList(pagingVO);
		
		return pagingVO;
	}
	
}
