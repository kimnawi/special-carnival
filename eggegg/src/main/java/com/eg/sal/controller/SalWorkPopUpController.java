package com.eg.sal.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.commons.ServiceResult;
import com.eg.sal.dao.SalDAO;
import com.eg.sal.service.SalService;
import com.eg.vo.AllowanceVO;
import com.eg.vo.EmplVO;
import com.eg.vo.PayInfoVO;
import com.eg.vo.WorkHistoryVO;
import com.eg.vo.WorkVO;

@Controller
public class SalWorkPopUpController {

	@Inject
	private SalService service;	
	
	@Inject
	private SalDAO DAO;
	
	@RequestMapping(value="/sal/workpopup.do")
	public String form(
		@RequestParam(value="stdate") String stDate,
		Model model		
		) {
		String[] z = stDate.split("-");
		String mix = z[0] +"-"+ z[1] + " -"+z[2];
		List<EmplVO> emplList = DAO.workConfirmEmpl(mix);
		List<AllowanceVO> alList = DAO.workConfirmAl();
		model.addAttribute("empl",emplList);
		model.addAttribute("alList",alList);
		model.addAttribute("stdate",mix);
		return "//sal/salWork/workForm";
	}
	@ResponseBody
	@RequestMapping(value="/sal/workHistory.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<WorkHistoryVO> history(
		@RequestParam(value="stDate") String stDate	
	){
		String[] z = stDate.split("-");
		String mix = z[0] +"-"+ z[1] + " -"+z[2];
		List<WorkHistoryVO> list = DAO.workHistory(mix);
				
		return list;
	}
	
	@RequestMapping(value="/sal/workpopup.do",method=RequestMethod.POST)
	public String confirm(
	@ModelAttribute(value="workConfirm") WorkHistoryVO historyVO,
	Model model
	) {
		List<AllowanceVO> alList = DAO.workConfirmAl();
		historyVO.setAlCnt(alList.size());
		ServiceResult result = service.confirmWork(historyVO);
		String success = null;
		switch(result) {
		case OK:
			success = "SUCCESS";
			break;
		default:
			break;	
		}
		model.addAttribute("success",success);		
		
		return "//sal/salWork/workForm";
	}
	
	@RequestMapping(value="/sal/workMapping.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<WorkVO> workHistory(
	@RequestParam(value="stDate") String stDate		
	) {
		PayInfoVO vo = DAO.checkDay(stDate);
		List<WorkVO> work = DAO.workList(vo);
		return work;
	}
	
	
}
