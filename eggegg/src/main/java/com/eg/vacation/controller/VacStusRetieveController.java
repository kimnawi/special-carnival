package com.eg.vacation.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.vacation.service.VacService;
import com.eg.vo.PagingVO;
import com.eg.vo.VacStatusVO;

@Controller
public class VacStusRetieveController {

	@Inject
	private VacService service;
	
	@RequestMapping("/vac/vacStusList.do")
	public String vacStusList() {
		return "/vac/vacStusList";
	}
	
	@RequestMapping(value="/vac/vacStusList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<VacStatusVO> listForAjax(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("detailSearch") VacStatusVO detailSearch
		){
		PagingVO<VacStatusVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveVacStusList(pagingVO);
		return pagingVO;
	}
}
