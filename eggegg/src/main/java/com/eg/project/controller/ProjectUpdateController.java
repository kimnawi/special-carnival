package com.eg.project.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.commons.ServiceResult;
import com.eg.project.service.ProjectService;
import com.eg.vo.ProjectVO;
@Controller
public class ProjectUpdateController {
	@Inject
	ProjectService service;
	
	@RequestMapping(value="/empl/projectDelete.do")
	public String deleteDed(
			@RequestParam(value="prjCode") String prjCode,
			@RequestParam(value="use") String use
	) {
		String[] code = prjCode.split(",");
		for (int i = 0; i < code.length; i++) {
			service.removeProject(code[i]);
		}
		if("yes".equals(use)) {
			return "redirect:/empl/projectList.do?use="+use;
		}else {
			return "redirect:/empl/projectListY.do?use="+use;
		}
		
	}
	
	@RequestMapping(value="/empl/projectContinue.do")
	public String continueDed(
			@RequestParam(value="prjCode") String prjCode,
			@RequestParam(value="use") String use
	) {
		String[] code = prjCode.split(",");
		for (int i = 0; i < code.length; i++) {
			service.continueProject(code[i]);
		}
		if("yes".equals(use)) {
			return "redirect:/empl/projectList.do?use="+use;
		}else {
			return "redirect:/empl/projectListY.do?use="+use;
		}
	}
	@RequestMapping(value="/empl/projectStop.do")
	public String stopDed(
			@RequestParam(value="prjCode") String prjCode,
			@RequestParam(value="use") String use
	) {
		String[] code = prjCode.split(",");
		for (int i = 0; i < code.length; i++) {
			service.stopProject(code[i]);
		}
		if("yes".equals(use)) {
			return "redirect:/empl/projectList.do?use="+use;
		}else {
			return "redirect:/empl/projectListY.do?use="+use;
		}
	}
	@RequestMapping(value="/empl/projectInsert.do", method=RequestMethod.POST)
	public String insertProject(
	@ModelAttribute(value="prj") ProjectVO project,
	BindingResult errors,
	RedirectAttributes redirectAttributes
	) {
		String date = project.getStart()+"~"+project.getEnd();
		project.setPrjPeriod(date);
		
		ServiceResult result = service.createProject(project);
		String viewName = null;
		String message = null;
		switch(result) {
		case OK:
			viewName = "redirect:/empl/projectList.do";
			break;
		default:
			viewName = "project/projectList";
			message = "서버 오류, 다시 시도";
		}
		redirectAttributes.addFlashAttribute("message",message);
		return viewName;
	}
	
}
