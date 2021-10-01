package com.eg.empl.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eg.empl.dao.EmplDAO;
import com.eg.vo.QualificateVO;

@Controller
@RequestMapping("/empl/emplQual.do")
public class EmplQualController {

	@Inject
	private EmplDAO emplDAO;
	
	@GetMapping
	public String emplQualForm(
			@RequestParam("qcEmpl") int qcEmpl
			, Model model
		) {
		List<QualificateVO> qualList = emplDAO.selectEmplQualificate(qcEmpl);
		model.addAttribute("qualList", qualList);
		return "/empl/emplQualForm";
	}
}
