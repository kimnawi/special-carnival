package com.eg.gnfd.controller;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.eg.commons.ServiceResult;
import com.eg.gnfd.dao.GnfdDAO;
import com.eg.gnfd.service.GnfdService;
import com.eg.validate.groups.UpdateGroup;
import com.eg.vo.GnfdTypeVO;
import com.eg.vo.OfficialOrderVO;

@Controller
@RequestMapping("/empl/gnfdUpdate.do")
public class GnfdUpdateController {

	@Inject
	private GnfdDAO dao;
	@Inject
	private GnfdService service;
	
	@ModelAttribute("gnfdTypeList")
	public List<GnfdTypeVO> gnfdTypeList(){
		List<GnfdTypeVO> gnfdTypeList = dao.selectGnfdTypeList();
		return gnfdTypeList;
	}
	
	@GetMapping
	public String gnfdForm(
			@RequestParam("gnfdStdrde") String gnfdStdrde
			, Model model
		) {
		OfficialOrderVO gnfd = dao.selectGnfdDetail(gnfdStdrde);
		model.addAttribute("gnfd", gnfd);
		return "/gnfd/gnfdForm";
	}
	
	@PostMapping
	public String gnfdUpdate(
			@Validated(UpdateGroup.class) @ModelAttribute("gnfd") OfficialOrderVO gnfd
			, Errors errors
			, Model model
		) {
		String gnfdStdrde = gnfd.getGnfdStdrde().split(",")[0];
		gnfd.setGnfdStdrde(gnfdStdrde);
		
		String success = null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyGnfd(gnfd);
			if(result.equals(ServiceResult.OK)) {
				success = "SUCCESS";
			}
		}
		model.addAttribute("success", success);
		model.addAttribute("gnfd", gnfd);
		return "/gnfd/gnfdForm";
	}
}
