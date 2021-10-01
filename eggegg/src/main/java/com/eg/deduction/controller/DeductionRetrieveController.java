package com.eg.deduction.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eg.deduction.service.DeductionService;
import com.eg.vo.AllowanceVO;
import com.eg.vo.DeductionVO;

@Controller
public class DeductionRetrieveController {
	
	@Inject
	private DeductionService service;
	
	@RequestMapping(value="/sal/deductionList.do")
	public String deductionList(
			Model model,
	@RequestParam(value="use", required=false,defaultValue= "yes") String use 
	) {
		
		List<DeductionVO> deList = service.retrieveDeList();
		model.addAttribute("deList",deList);
		model.addAttribute("use",use);
		model.addAttribute("selectedMenu","ResistDeduc");
		return "sal/deduction/deductionList";
	}
	
}
