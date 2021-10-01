package com.eg.allowance.controller;

import java.util.List;

import javax.inject.Inject;

import org.hibernate.validator.internal.util.privilegedactions.GetResource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.allowance.service.AllowanceService;
import com.eg.vo.AllowanceVO;
import com.eg.vo.PagingVO;
import com.eg.vo.TaxFreeVO;

@Controller
public class AllowanceRetrieveController {
	
	@Inject
	private AllowanceService service;
	
	
	@RequestMapping(value="/sal/extrapayList.do")
	public String allowanceList(
	Model model,
	@RequestParam(value="use", required=false,defaultValue= "yes") String use 
	) {
		
		List<AllowanceVO> alList = service.retrieveAlList();
		model.addAttribute("alList",alList);
		model.addAttribute("use",use);
		model.addAttribute("selectedMenu","ResistAllow");
		return "sal/allowance/allowanceList";
	}
	
	@RequestMapping("/sal/taxFreeList.do")
	public String taxList() {
		return "//sal/allowance/taxFreeList";
	}
	
	@RequestMapping(value="/sal/taxFreeList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<TaxFreeVO> taxListAjax(
			@RequestParam(value="page",required=false, defaultValue="1") int currentPage,
			@ModelAttribute("detailSearch") TaxFreeVO detailSearch
	) {
		PagingVO<TaxFreeVO> pagingVO = new PagingVO<>(15,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		
		service.retrieveTaxFreeList(pagingVO);
		
		return pagingVO;
	}
	
}
