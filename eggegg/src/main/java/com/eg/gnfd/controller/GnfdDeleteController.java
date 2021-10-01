package com.eg.gnfd.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.eg.commons.ServiceResult;
import com.eg.gnfd.service.GnfdService;

@Controller
public class GnfdDeleteController {

	@Inject
	private GnfdService service;
	
	@RequestMapping(value="/empl/gnfdDelete.do", method=RequestMethod.POST)
	public String deleteGnfd(
			@RequestParam("what") String gnfdStdrde
			, Model model
		) {
		String success = null;
		if(gnfdStdrde != null && gnfdStdrde.length() > 0) {
			ServiceResult result = service.removeGnfd(gnfdStdrde);
			if(result.equals(ServiceResult.OK)) {
				success = "SUCCESS";
			}
		}
		model.addAttribute("success", success);
		return "/gnfd/gnfdForm";
	}
}
