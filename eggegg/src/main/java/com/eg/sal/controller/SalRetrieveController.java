package com.eg.sal.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.sal.service.SalService;
import com.eg.vo.PagingVO;
import com.eg.vo.PayInfoVO;

@Controller
public class SalRetrieveController {

	@Inject
	private SalService service;
	
	@RequestMapping(value="/sal/salWorkList.do")
	public String workList(
			Model model
			) {
		
		model.addAttribute("selectedMenu","SalCalc");
		return "sal/salWork/salWorkList";
	}
	
	@RequestMapping(value="/sal/salWorkList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<PayInfoVO> listforAjax(
		@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
		@ModelAttribute("detailSearch") PayInfoVO detailSearch
	){
		PagingVO<PayInfoVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveSalList(pagingVO);
		
		
		return pagingVO;
	}
	
}
