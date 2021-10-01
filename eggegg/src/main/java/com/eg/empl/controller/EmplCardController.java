package com.eg.empl.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eg.empl.dao.EmplDAO;
import com.eg.vo.EmplVO;

@Controller
public class EmplCardController {

	@Inject
	private EmplDAO dao;
	
	@RequestMapping("/empl/emplCard.do")
	public String emplCard(
			@RequestParam("who") int emplNo
			, Model model
		) {
		EmplVO empl = dao.selectEmplCard(emplNo);
		model.addAttribute("empl", empl);
		return "/empl/emplCard";
	}
	
}
