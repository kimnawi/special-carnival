package com.eg.deduction.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.eg.deduction.service.DeductionService;
import com.eg.vo.AllowanceVO;
import com.eg.vo.DeductionVO;

@Controller
public class DeductionUpdateController {
	@Inject
	private DeductionService service;
	
	@RequestMapping(value="/sal/deductionUpdate.do", method=RequestMethod.POST)
	public String updateDed(
	@ModelAttribute("deduction") DeductionVO deList,		
	@RequestParam(value="use") String use
	) {
		String[] code = deList.getDeCode().split(",");
		String[] name = deList.getDeNm().split(",");
		List<DeductionVO> deductionList = new ArrayList<>();
		for(int i = 0; i<name.length ; i++) {
			DeductionVO vo = new DeductionVO();
			vo.setDeCode(code[i]);
			vo.setDeNm(name[i]);
			deductionList.add(vo);
		}
		service.modifyDeduction(deductionList);
		
		return "redirect:/sal/deductionList.do?use="+use;
	}
	
	@RequestMapping(value="/sal/deductionDelete.do")
	public String deleteDed(
			@RequestParam(value="deCode") String deCode,
			@RequestParam(value="use") String use
	) {
		String[] code = deCode.split(",");
		for (int i = 0; i < code.length; i++) {
			service.removeDeduction(code[i]);
		}
		
		return "redirect:/sal/deductionList.do?use="+use;
	}
	
	@RequestMapping(value="/sal/deductionContinue.do")
	public String continueDed(
			@RequestParam(value="deCode") String deCode,
			@RequestParam(value="use") String use
	) {
		String[] code = deCode.split(",");
		for (int i = 0; i < code.length; i++) {
			service.continueDeduction(code[i]);
		}
		
		return "redirect:/sal/deductionList.do?use="+use;
	}
	@RequestMapping(value="/sal/deductionStop.do")
	public String stopDed(
			@RequestParam(value="deCode") String deCode,
			@RequestParam(value="use") String use
	) {
		String[] code = deCode.split(",");
		for (int i = 0; i < code.length; i++) {
			service.stopDeduction(code[i]);
		}
		
		return "redirect:/sal/deductionList.do?use="+use;
	}
	
}
