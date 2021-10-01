package com.eg.gnfd.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.commons.ServiceResult;
import com.eg.gnfd.dao.GnfdDAO;
import com.eg.gnfd.service.GnfdService;
import com.eg.vo.GnfdTypeVO;
import com.eg.vo.OfficialOrderVO;
import com.eg.vo.gnfdListVO;

@Controller
@RequestMapping("/empl/gnfdInsert.do")
public class GnfdInsertController {

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
	public String gnfdForm() {
		return "/gnfd/gnfdInsertForm";
	}
	
	@PostMapping
	public String insertGnfd(
			@ModelAttribute("gnfdListVO") gnfdListVO gnfdList
			, Errors errors
			, Model model
		) {
		String success = null;
		
		OfficialOrderVO[] gnfd = gnfdList.getGnfd();
		if(!errors.hasErrors()) {
			ServiceResult result = service.createGnfd(gnfdList);
			if(result.equals(ServiceResult.OK)) {
				success = "SUCCESS";
			}
		}
		model.addAttribute("success", success);
		model.addAttribute("gnfd", gnfd);
		return "/gnfd/gnfdInsertForm";
	}
}
