package com.eg.dept.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.dept.dao.DeptDAO;
import com.eg.empl.service.EmplService;
import com.eg.vo.DeptVO;
import com.eg.vo.EmplVO;

@Controller
public class DeptOrganController {

	@Inject
	private DeptDAO dao;
	@Inject
	private EmplService emplService;
	
	@RequestMapping("/empl/deptOrganStatus.do")
	public String deptStatus(
			Model model
		) {
		List<DeptVO> deptList = dao.selectDeptOrganStatus();
		model.addAttribute("deptList", deptList);
		return "/dept/deptOrganStatus";
	}
	
	@RequestMapping(value="/empl/deptOrganEmpl.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public EmplVO emplInfo(
			@RequestParam("who") int emplNo
		) {
		EmplVO empl = emplService.retrieveEmpl(emplNo);
		return empl;
	}
	
}
