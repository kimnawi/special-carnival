package com.eg.adgroup.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.adgroup.dao.AdGroupDAO;
import com.eg.adgroup.service.AdGroupService;
import com.eg.commons.ServiceResult;
import com.eg.vo.AdGroupAllVO;
import com.eg.vo.EmplVO;

import edu.emory.mathcs.backport.java.util.Arrays;

@Controller
public class AdGroupUpdateController {
	@Inject
	private AdGroupService service;
	@Inject
	private AdGroupDAO DAO;
	@ModelAttribute("command")
	public String addCommand() {
		return "UPDATE";
	}
	@RequestMapping(value="/sal/groupDetail.do",method=RequestMethod.GET)
	public String detailForm(
		@RequestParam(value="code") String code,
		Model model
	) {
		AdGroupAllVO vo = service.retrieveAdGroup(code);
		int cnt1 = DAO.countAl(code);
		int cnt2 = DAO.countDe(code);
		AdGroupAllVO group = new AdGroupAllVO();
		group.setAdgNm(vo.getAdgNm());
		if(cnt1> 0) {
			List<AdGroupAllVO> alGroup = service.selectAlGroup(code);
			group.setAlGroup(alGroup);
		}
		if(cnt2 > 0) {
			List<AdGroupAllVO> deGroup = service.selectDeGroup(code);
			group.setDeGroup(deGroup);
		}
		group.setAdgCode(code);
		
		
		model.addAttribute("group",group);
		
		return "//sal/adgroup/adGroupForm";
		
	}
	@RequestMapping(value="/sal/groupDetail.do",method=RequestMethod.POST)
	public String groupUpdate(
		@Validated @ModelAttribute(value="adGroup") AdGroupAllVO list
		, Errors errors
		, RedirectAttributes redirectAttributes
		, Model model			
	) {
		String message = null;
		String success = null;
		if(!errors.hasErrors()) {
			
		String alCode[] = list.getAlCode().split(",");
		String deCode[] = list.getDeCode().split(",");
		String alAmount[] = list.getAlgAmount().split(",");
		String adAmount[] = list.getAdgAmount().split(",");
		AdGroupAllVO vo = new AdGroupAllVO();
		List<AdGroupAllVO> alList = new ArrayList<AdGroupAllVO>();
		List<AdGroupAllVO> deList = new ArrayList<AdGroupAllVO>();
		vo.setAdgCode(list.getAdgCode());
		vo.setAdgNm(list.getAdgNm());
		for(int i =0; i< alCode.length;i++) {
			if(alCode[i].length()>0) {
				AdGroupAllVO vos = new AdGroupAllVO();
				vos.setAdgCode(list.getAdgCode());
				vos.setAlCode(alCode[i]);
				vos.setAlgAmount(alAmount[i]);
				alList.add(vos);
			}
		}
		vo.setAlGroup(alList);
		for(int i = 0; i< deCode.length; i++) {
			if(deCode[i].length() >0) {
				AdGroupAllVO vos = new AdGroupAllVO();
				vos.setAdgCode(list.getAdgCode());
				vos.setDeCode(deCode[i]);
				vos.setAdgAmount(adAmount[i]);
				deList.add(vos);
			}
		}
		vo.setDeGroup(deList);
			ServiceResult result = service.modifyGroup(vo); 
			switch(result) {
			case OK:
				success = "SUCCESS";
				break;
			
			default:
				message = "서버 오류, 잠시 후에 다시 시도해주세요.";
				break;
			}
		}
		
		redirectAttributes.addFlashAttribute("message",message);
		model.addAttribute("success",success);
		model.addAttribute("group",list);
		return "/sal/adgroup/adGroupForm";
	}
	
	@RequestMapping(value="/sal/UpdateEmplGroup.do", method= RequestMethod.POST)
	public String updateempl(
		@Validated @ModelAttribute(value="empl") AdGroupAllVO vo	
		, Errors errors
		, RedirectAttributes redirectAttributes
		, Model model
		) {
		String message = null;
		
		String[] emplNo = vo.getEmplNo().split(",");
		String[] emplAdgper = vo.getEmplAdgper().split(",");
		String[] emplDel = null;
		if(vo.getEmplDel() != null) {
			emplDel = vo.getEmplDel().split(",");
		}
		
		List<EmplVO> list = new ArrayList<>();
		if(emplDel != null) {
			for(int i =0; i<emplDel.length;i++) {
				EmplVO emp = new EmplVO();
				emp.setEmplDel(Integer.parseInt(emplDel[i]));
				list.add(emp);
			}
		}
		
		
		for(int i =0; i<emplNo.length;i++) {
			if(emplNo[i].length()>0) {
				EmplVO emp = new EmplVO();
				emp.setEmplNo(Integer.parseInt(emplNo[i]));
				emp.setEmplAdgper(Integer.parseInt(emplAdgper[i]));
				emp.setAdgCode(vo.getAdgCode());
				list.add(emp);
			}
		}
		vo.setEmpl(list);
		ServiceResult result = service.modifyEmpl(vo);
		
		return "redirect:/sal/adGroupList.do";
	}
}
