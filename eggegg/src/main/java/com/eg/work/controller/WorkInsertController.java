package com.eg.work.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.commons.ServiceResult;
import com.eg.vo.EmplVO;
import com.eg.vo.WorkVO;
import com.eg.work.service.WorkService;

import edu.emory.mathcs.backport.java.util.Arrays;

@Controller
public class WorkInsertController {
	@Inject
	private WorkService service;
	
	@RequestMapping("/sal/workForm.do")
	public String workForm(
		Model model	
	) {
		model.addAttribute("selectedMenu","ResistWork");
		return "sal/work/workForm";
	}
	@RequestMapping("/sal/workForm2.do")
	public String workForm2(
			@RequestParam(value="stdate") String stdate,
			Model model
			) {
		List<WorkVO> workList = service.popWorkList(stdate);
		int sum = 0;
		for(int i=0;i<workList.size();i++) {
			sum += Integer.parseInt(workList.get(i).getWorkHour());
		}
		model.addAttribute("stdate",stdate);
		model.addAttribute("work",workList);
		model.addAttribute("sum",sum);
		return "//sal/work/workFormPopUp";
	}
	
	
	@RequestMapping("/sal/workInsert.do")
	public String workInsert(
		Model model,
		@ModelAttribute(value="work") WorkVO vo
	) {
		String[] alCode = vo.getAlCode().split(",");
		String[] prjCode = vo.getPrjCode().split(",");
		String[] workHour = vo.getWorkHour().split(",");
		String[] workDate = vo.getWorkDate().split(",");
		List<WorkVO> list = new ArrayList<WorkVO>();
		for(int i = 0; i<workDate.length;i++) {
			WorkVO work = new WorkVO();
			work.setEmplNo(vo.getEmplNo());
			if(prjCode.length<= i) {
				work.setPrjCode("");
			}else {
				work.setPrjCode(prjCode[i]);
			}
			work.setWorkHour(workHour[i]);
			work.setWorkDate(workDate[i]);
			work.setWorkStdate(vo.getWorkStdate());
			work.setAlCode(alCode[i]);
			list.add(work);
		}
		service.createWork(list);
		
		model.addAttribute("selectedMenu","resistWork");
		return "sal/work/workForm";
	}
	
	@RequestMapping(value="/sal/workUpdate.do",method=RequestMethod.POST)
	public String workInsert2(
			Model model,
			@ModelAttribute(value="work") WorkVO vo
			) {
		String success = null;
		String[] emplNo = vo.getEmplNo().split(",");
		String[] alCode = vo.getAlCode().split(",");
		String[] prjCode = vo.getPrjCode().split(",");
		String[] workHour = vo.getWorkHour().split(",");
		String[] workDate = vo.getWorkDate().split(",");
		String[] emplDel = null;
		String[] dateDel = null;
		String[] codeDel = null;
		List<WorkVO> delList = new ArrayList<>();
		if(vo.getEmplDel()!= null) {
			emplDel = vo.getEmplDel().split(",");
			dateDel = vo.getDateDel().split(",");
			codeDel = vo.getCodeDel().split(",");
			
			for(int i = 0; i<emplDel.length;i++) {
				WorkVO delvo = new WorkVO();
				delvo.setEmplDel(emplDel[i]);
				delvo.setDateDel(dateDel[i]);
				delvo.setCodeDel(codeDel[i]);
				delvo.setWorkStdate(vo.getWorkStdate());
				delList.add(delvo);
			}
		}
		WorkVO workVO = new WorkVO();
		workVO.setDeleteList(delList);
		
		List<WorkVO> list = new ArrayList<WorkVO>();
		for(int i = 0; i<workDate.length;i++) {
			WorkVO work = new WorkVO();
			work.setEmplNo(vo.getEmplNo());
			if(prjCode.length<= i) {
				work.setPrjCode("");
			}else {
				work.setPrjCode(prjCode[i]);
			}
			work.setEmplNo(emplNo[i]);
			work.setWorkHour(workHour[i]);
			work.setWorkDate(workDate[i]);
			work.setWorkStdate(vo.getWorkStdate());
			work.setAlCode(alCode[i]);
			list.add(work);
		}
		workVO.setUpdateList(list);
		ServiceResult result = service.modifyWorkList(workVO);
		List<WorkVO> workList = service.popWorkList(vo.getWorkStdate());
		int sum = 0;
		for(int i=0;i<workList.size();i++) {
			sum += Integer.parseInt(workList.get(i).getWorkHour());
		}
		model.addAttribute("work",workList);
		model.addAttribute("sum",sum);
		success = "SUCCESS";
		model.addAttribute("selectedMenu","resistWork");
		model.addAttribute("success", success);
		return "//sal/work/workFormPopUp";
	}
	
	
}
