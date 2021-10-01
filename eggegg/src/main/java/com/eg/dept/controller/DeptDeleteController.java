package com.eg.dept.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.eg.dept.service.DeptService;

@Controller
public class DeptDeleteController {

	@Inject
	private DeptService service;
	
	@RequestMapping(value="/empl/deptDelete.do", method=RequestMethod.POST)
	public String deptDelete() {
		return "dept/deptList";
	}
}
