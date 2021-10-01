package com.eg.dept.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.dept.service.DeptService;
import com.eg.vo.DeptVO;
import com.google.inject.internal.Errors;

@Controller
public class DeptUpdateLeaderController {

	@Inject
	private DeptService service;
	
	@RequestMapping(value="/empl/deptUpdateLeader.do", method=RequestMethod.POST)
	@ResponseBody
	public String deptUpdateLeader(
			@Validated @ModelAttribute("dept") DeptVO dept
			, Errors errors
			, Model model
		) {
		if(!errors.hasErrors()) {
			service.updateDeptLeader(dept);
		}
		return "redirect:/empl/deptFancy.do";
	}
}
