package com.eg.vacation.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.commons.ServiceResult;
import com.eg.vacation.service.VacService;

@Controller
public class VacDeleteController {

	@Inject
	private VacService service;
	
	@RequestMapping(value="/vac/vacDelete.do", method=RequestMethod.POST)
	public String vacDelete(
			@RequestParam("vcatnCode") String vcatnCode
			, @RequestParam("emplNo") String emplNo
			, RedirectAttributes redirectAttributes
		) {
		Map<String, Object> vacEmpl = new HashMap<>();
		vacEmpl.put("vcatnCode", vcatnCode);
		vacEmpl.put("emplNo", emplNo);
		
		ServiceResult result = service.deleteEmplVac(vacEmpl);
		
		String messge = null;
		
		switch (result) {
		case OK:
			break;
		default:
			messge = "서버 오류, 잠시 후에 다시 시도하세요.";
			break;
		}
		redirectAttributes.addFlashAttribute("message", messge);
		return "redirect:/vac/vacInsert.do?vcatnCode=" + vcatnCode.split(",")[0];
	}
}
