package com.eg.empl.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eg.empl.dao.EmplDAO;
import com.eg.empl.service.EmplService;
import com.eg.vo.AbTypeVO;
import com.eg.vo.AcademicVO;

@Controller
@RequestMapping("/empl/emplAcadBack.do")
public class EmplAcadBackController {

	@Inject
	public EmplService service;
	@Inject
	public EmplDAO emplDAO;
	
	@ModelAttribute("abTypeList")
	public List<AbTypeVO> abTypeList(){
		List<AbTypeVO> abTypeList = emplDAO.abTypeList();
		return abTypeList;
	}
	
	@GetMapping
	public String acadBackForm(
			@RequestParam("abEmpl") int abEmpl
			, Model model
		) {
		AcademicVO acad = emplDAO.selectEmplAcademic(abEmpl);
		model.addAttribute("acad", acad);
		return "/empl/emplAcadBackForm";
	}
	
}
