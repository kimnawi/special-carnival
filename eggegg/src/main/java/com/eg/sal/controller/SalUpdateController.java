package com.eg.sal.controller;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eg.commons.ServiceResult;
import com.eg.sal.dao.SalDAO;
import com.eg.sal.service.SalService;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.PayInfoVO;

@Controller
@RequestMapping("/sal/salUpdate.do")
public class SalUpdateController {

	@Inject
	private SalService service;
	
	@Inject
	private SalDAO DAO;
	
	@ModelAttribute("command")
	public String addCommand() {
		return "UPDATE";
	}
	
	@GetMapping
	public String salForm(
		@RequestParam(value="stdate") String stDate,
		Model model
	) {
		String[] z = stDate.split("-");
		String mix = z[0] +"-"+ z[1] + " -"+z[2];
		PayInfoVO vo = DAO.selectSal(mix);
		String day = z[0] +"-"+z[1];
		model.addAttribute("vo",vo);
		return "//sal/salWork/salUpdateForm";
	}
	
	@PostMapping
	public String updateSal(
	@ModelAttribute(value="payInfo") PayInfoVO payInfoVO
	, @AuthenticationPrincipal EmplVOWrapper wrapper
	, Model model
	) {
		Integer emplNo = wrapper.getAdaptee().getEmplNo();
		payInfoVO.setPiWriter(emplNo);
		ServiceResult result = service.modifySalary(payInfoVO);
		String success = null;
		switch(result) {
		case OK:
			success = "SUCCESS";
			break;
		default:
			break;	
		}
		model.addAttribute("success",success);		
		
		return "//sal/salWork/salUpdateForm";
	}
	
	
	
	
}
