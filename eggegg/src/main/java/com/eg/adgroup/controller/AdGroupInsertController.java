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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.adgroup.dao.AdGroupDAO;
import com.eg.adgroup.service.AdGroupService;
import com.eg.commons.ServiceResult;
import com.eg.vo.AdGroupAllVO;
import com.eg.vo.AdGroupVO;

import edu.emory.mathcs.backport.java.util.Arrays;

@Controller
@RequestMapping(value="/sal/adGroupInsert.do")
public class AdGroupInsertController {
	@Inject
	private AdGroupService service;
	
	@Inject
	private AdGroupDAO DAO;
	
	@ModelAttribute("command")
	public String command() {
		return "INSERT";
	}
	
	@GetMapping
	public String groupForm(
			Model model
	) {
		String code = DAO.selectNextCode();
		AdGroupAllVO adGroupVO = new AdGroupAllVO();
		adGroupVO.setAdgCode(code);
		model.addAttribute("group",adGroupVO);
		return "//sal/adgroup/adGroupForm";
	}
	
	@PostMapping
	public String groupInsert(
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
			ServiceResult result = service.createAdGroup(vo); 
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
	
	
}
