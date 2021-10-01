package com.eg.group.schedule.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.group.schedule.service.ScheService;
import com.eg.vo.EmplVO;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.PagingVO;
import com.eg.vo.ScheVO;

@Controller
public class ScheRetrieveController {
	@Inject
	private ScheService service;
	
	@RequestMapping("/schedule/scheList.do")
	public String shceList(
		@RequestParam(required=false) String command
		) {
		if("content".equals(command)) {
			return "/schedule/scheList";
		}else {
			return "schedule/scheList";
		}		
	}

	@RequestMapping(value="/schedule/scheList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<ScheVO> listForAjax(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
		  , @ModelAttribute("detailSearch") ScheVO detailSearch
		  , @AuthenticationPrincipal EmplVOWrapper wrapper
	  ){
		int emplNo = wrapper.getAdaptee().getEmplNo();
		EmplVO empl = new EmplVO();
		empl.setEmplNo(emplNo);
		detailSearch.setEmpl(empl);
		
		PagingVO<ScheVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveScheList(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/schedule/scheView.do")
	public String scheView(
		@RequestParam(value="what", required=false) String scheNo
		, Model model
	) {
		ScheVO sche = service.retrieveSche(scheNo);
		model.addAttribute("sche", sche);
		return "/schedule/scheView";
	}

}
