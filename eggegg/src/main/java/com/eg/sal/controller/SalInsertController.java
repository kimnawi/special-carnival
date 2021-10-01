package com.eg.sal.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.commons.ServiceResult;
import com.eg.sal.dao.SalDAO;
import com.eg.sal.service.SalService;
import com.eg.vo.EmplVO;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.PayInfoVO;

@Controller
@RequestMapping("/sal/createSalary.do")
public class SalInsertController {
	@Inject
	private SalService service;
	
	@Inject
	private SalDAO DAO;
	
	@GetMapping
	public String insertForm() {
		return "//sal/salWork/salForm";
	}
	
	
	@PostMapping
	public String insertSal(
	@ModelAttribute(value="payInfo") PayInfoVO payInfoVO
	, @AuthenticationPrincipal EmplVOWrapper wrapper
	, Model model
	) {
		Integer emplNo = wrapper.getAdaptee().getEmplNo();
		payInfoVO.setPiWriter(emplNo);
		ServiceResult result = service.createSalary(payInfoVO);
		
		String success = null;
		
		switch(result) {
		case OK:
			success = "SUCCESS";
			break;
		default:
			break;	
		}
		model.addAttribute("success",success);
		
		return "//sal/salWork/salForm";
	}
}
