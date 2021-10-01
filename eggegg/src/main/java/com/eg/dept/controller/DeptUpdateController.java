package com.eg.dept.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.commons.ServiceResult;
import com.eg.dept.service.DeptService;
import com.eg.vo.DeptVO;

@Controller
public class DeptUpdateController {

	@Inject
	private DeptService service;
	
	@RequestMapping(value="/empl/deptDelete.do")
	public String deleteDed(
			@RequestParam(value="deptCode") String deptCode,
			@RequestParam(value="use") String use
	) {
		String[] code = deptCode.split(",");
		for (int i = 0; i < code.length; i++) {
			service.removeDept(code[i]);
		}
		if("yes".equals(use)) {
			return "redirect:/empl/deptList.do?use="+use;
		}else {
			return "redirect:/empl/deptListY.do?use="+use;
		}
		
	}
	
	@RequestMapping(value="/empl/deptContinue.do")
	public String continueDed(
			@RequestParam(value="deptCode") String deptCode,
			@RequestParam(value="use") String use
	) {
		String[] code = deptCode.split(",");
		for (int i = 0; i < code.length; i++) {
			service.continueDept(code[i]);
		}
		if("yes".equals(use)) {
			return "redirect:/empl/deptList.do?use="+use;
		}else {
			return "redirect:/empl/deptListY.do?use="+use;
		}
	}
	@RequestMapping(value="/empl/deptStop.do")
	public String stopDed(
			@RequestParam(value="deptCode") String deptCode,
			@RequestParam(value="use") String use
	) {
		String[] code = deptCode.split(",");
		for (int i = 0; i < code.length; i++) {
			service.stopDept(code[i]);
		}
		if("yes".equals(use)) {
			return "redirect:/empl/deptList.do?use="+use;
		}else {
			return "redirect:/empl/deptListY.do?use="+use;
		}
	}
	@RequestMapping(value="/empl/departmentInsert.do", method=RequestMethod.POST)
	public String insertDepartment(
	@ModelAttribute(value="dept") DeptVO dept,
	BindingResult errors,
	RedirectAttributes redirectAttributes
	) {
		ServiceResult result = service.createDept(dept);
		String viewName = null;
		String message = null;
		switch(result) {
		case OK:
			viewName = "redirect:/empl/deptList.do";
			break;
		default:
			viewName = "dept/deptList";
			message = "서버 오류, 다시 시도";
		}
		redirectAttributes.addFlashAttribute("message",message);
		return viewName;
	}
	
}
