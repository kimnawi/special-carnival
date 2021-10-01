package com.eg.vacation.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.commons.ServiceResult;
import com.eg.vacation.dao.VacDAO;
import com.eg.vacation.service.VacService;
import com.eg.vo.EmplVO;
import com.eg.vo.VacHistoryListVO;
import com.eg.vo.VacHistoryVO;
import com.eg.vo.VacationVO;

@Controller
@RequestMapping("/vac/vacInsert.do")
public class VacInsertController {

	@Inject
	private VacService service;
	@Inject
	private VacDAO dao;
	
	@GetMapping
	public String vacList(
			@RequestParam("vcatnCode") String vcatnCode
			 , Model model
		) {
		//휴가코드별 사원 리스트, 사원별휴가일수
		List<EmplVO> empl = service.retrieveVacEmplList(vcatnCode);
		VacationVO vacDetail = dao.selectVacDetail(vcatnCode);
		
		model.addAttribute("empl", empl);
		model.addAttribute("vacDetail", vacDetail);
		
		return "/vac/vacEmplList";
	}
	
	@PostMapping
	public String vacInsert(
			@ModelAttribute("VacHistoryListVO") VacHistoryListVO vacHistoryVOList
			, Errors errors
			, Model model
			, RedirectAttributes redirectAttributes
		) {
		String message = null;
		String success = null;
		
		VacHistoryVO[] vacHistory = vacHistoryVOList.getVacHistory();
		
		for(int i = 0; i < vacHistoryVOList.getVacHistory().length; i++) {
			if(!errors.hasErrors()) {
				if(vacHistory[i].getEmplNo() != null) {
					ServiceResult result = service.modifyEmplVac(vacHistory[i]);
					switch (result) {
					case OK:
						success = "SUCCESS";
						break;
					default:
						message = "서버 오류, 잠시 후에 다시 시도해주세요.";
						break;
					}
				}
			}
		}
		redirectAttributes.addFlashAttribute("message", message);
		model.addAttribute("success", success);
		model.addAttribute("vacHistory", vacHistory);
		
		return "redirect:/vac/vacInsert.do?vcatnCode=" + vacHistory[0].getVcatnCode();
	}
	
}
