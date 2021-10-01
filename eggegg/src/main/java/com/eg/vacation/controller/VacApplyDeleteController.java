package com.eg.vacation.controller;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.commons.ServiceResult;
import com.eg.vacation.service.VacService;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.VacStatusVO;

@Controller
public class VacApplyDeleteController {

	@Inject
	private VacService service;
	
	@RequestMapping(value="/vac/vacApplyDelete.do", method=RequestMethod.POST)
	public String vacApplyDelete(
			@RequestParam("vacstusCode") String vacstusCode
			, @AuthenticationPrincipal EmplVOWrapper wrapper
			, RedirectAttributes redirectAttributes
			) {
		Integer emplNo = wrapper.getAdaptee().getEmplNo();
		
		VacStatusVO vacStus = new VacStatusVO();
		vacStus.setVacstusCode(vacstusCode);
		vacStus.setEmplNo(emplNo);
		
		ServiceResult result = service.removeVacApply(vacStus);
		String message = "";
		
		if(result.equals(ServiceResult.FAIL)) {
			message = "서버 오류, 잠시 후에 다시 시도하세요.";
		}
		redirectAttributes.addFlashAttribute("message", message);
		
		return "/vac/vacApplyForm";
	}
}
