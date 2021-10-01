package com.eg.allowance.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.eg.allowance.service.AllowanceService;
import com.eg.vo.AllowanceVO;
@Controller
public class AllowanceUpdateController {

	
	@Inject
	private AllowanceService service;
	
	@RequestMapping(value="/sal/extrapayUpdate.do", method=RequestMethod.POST)
	public String updateAll(
	@ModelAttribute("allowance") AllowanceVO alList,		
	@RequestParam(value="use") String use
	) {
		String[] code = alList.getAlCode().split(",");
		String[] name = alList.getAlNm().split(",");
		String[] provide = alList.getAlProvide().split(",");
		String[] tfcode = alList.getTfCode().split(",");
		List<AllowanceVO> allowList = new ArrayList<>();
		for(int i = 0; i<name.length ; i++) {
			AllowanceVO vo = new AllowanceVO();
			vo.setAlCode(code[i]);
			vo.setAlNm(name[i]);
			vo.setAlProvide(provide[i]);
			vo.setTfCode(tfcode[i]);
			allowList.add(vo);
		}
		service.modifyAllowance(allowList);
		
		return "redirect:/sal/extrapayList.do?use="+use;
	}
	
	@RequestMapping(value="/sal/extraDelete.do")
	public String deleteAll(
			@RequestParam(value="alCode") String alCode,
			@RequestParam(value="use") String use
	) {
		String[] code = alCode.split(",");
		for (int i = 0; i < code.length; i++) {
			service.removeAllowance(code[i]);
		}
		
		return "redirect:/sal/extrapayList.do?use="+use;
	}
	
	@RequestMapping(value="/sal/extraContinue.do")
	public String continueAll(
			@RequestParam(value="alCode") String alCode,
			@RequestParam(value="use") String use
	) {
		String[] code = alCode.split(",");
		for (int i = 0; i < code.length; i++) {
			service.continueAllowance(code[i]);
		}
		
		return "redirect:/sal/extrapayList.do?use="+use;
	}
	@RequestMapping(value="/sal/extraStop.do")
	public String stopAll(
			@RequestParam(value="alCode") String alCode,
			@RequestParam(value="use") String use
	) {
		String[] code = alCode.split(",");
		for (int i = 0; i < code.length; i++) {
			service.stopAllowance(code[i]);
		}
		
		return "redirect:/sal/extrapayList.do";
	}
	
	
	
}
