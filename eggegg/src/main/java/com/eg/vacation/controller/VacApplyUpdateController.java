package com.eg.vacation.controller;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.commons.ServiceResult;
import com.eg.empl.dao.EmplDAO;
import com.eg.vacation.dao.VacDAO;
import com.eg.vacation.service.VacService;
import com.eg.validate.groups.UpdateGroup;
import com.eg.vo.EmplVO;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.VacStatusVO;

@Controller
@RequestMapping("/vac/vacApplyUpdate.do")
public class VacApplyUpdateController {

	@Inject
	private VacDAO dao;
	@Inject
	private VacService service;
	@Inject
	private EmplDAO emplDao;
	
	@ModelAttribute("empl")
	public EmplVO emplInfo(
			@AuthenticationPrincipal EmplVOWrapper wrapper
		) {
		Integer emplNo = wrapper.getAdaptee().getEmplNo();
		return emplDao.selectEmplDetail(emplNo);
	}
	
	@ModelAttribute("command")
	public String command() {
		return "UPDATE";
	}
	
	@GetMapping
	public String vacDetail(
			@RequestParam("vacstusCode") String vacstusCode
			, @AuthenticationPrincipal EmplVOWrapper wrapper
			, Model model
		) {
		Integer emplNo = wrapper.getAdaptee().getEmplNo();
		
		VacStatusVO vacStus = new VacStatusVO();
		vacStus.setVacstusCode(vacstusCode);
		vacStus.setEmplNo(emplNo);
		
		vacStus = dao.selectVacApplyDetail(vacStus);
		
		model.addAttribute("vacStus", vacStus);
		
		return "/vac/vacApplyForm";
	}
	
	@PostMapping
	public String vacApplyUpdate(
			@Validated(UpdateGroup.class) @ModelAttribute("vacApply") VacStatusVO vacStus
			, Errors errors
			, Model model
			, RedirectAttributes redirectAttributes
		) {
		
		String message = null;
		String success = null;
		
		String[] vacstusDeArray = vacStus.getVacstusDe().split(",");
		vacStus.setVacstusDeArray(vacstusDeArray);
		String vacstusCode = vacStus.getVacstusCode().split(",")[0];
		vacStus.setVacstusCode(vacstusCode);
		
		System.out.println("------------VacApplyUpdateController----------------\n" + vacStus);
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyVacApply(vacStus);
			switch (result) {
			case OK:
				success = "SUCCESS";
				break;
			default:
				message = "서버 오류, 잠시 후에 다시 시도하세요.";
				break;
			}
		}
		redirectAttributes.addFlashAttribute("message", message);
		model.addAttribute("success", success);
		model.addAttribute("vacApply", vacStus);
		
		return "/vac/vacApplyForm";
	}
	
}
