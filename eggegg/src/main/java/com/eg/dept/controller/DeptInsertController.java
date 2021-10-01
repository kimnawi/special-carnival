package com.eg.dept.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.dept.service.DeptService;

@Controller
@RequestMapping("/dept/deptInsert.do")
public class DeptInsertController {

	@Inject
	private DeptService service;
	
	@GetMapping
	public String deptForm() {
		return "dept/deptForm";
	}
	
	@PostMapping
	public String deptInsert() {
		return "dept/deptList";
	}
}
