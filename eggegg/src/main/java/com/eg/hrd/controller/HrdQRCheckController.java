package com.eg.hrd.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.commons.ServiceResult;
import com.eg.hrd.dao.HrdDAO;
import com.eg.hrd.service.HrdService;

@Controller
@RequestMapping("/vac/hrdQRCheck.do")
public class HrdQRCheckController {

	@Inject
	private HrdDAO dao;
	@Inject
	private HrdService service;
	
	@GetMapping
	public String QRCheckForm() {
		return "/hrd/hrdQRCheckForm";
	}
	
	@PostMapping
	@ResponseBody
	public String insertQRHrd(
			@RequestParam("atvlEmpl") String atvlEmpl
		) {
		String message = null;
		ServiceResult result = null;
		
		String confirm = dao.selectAtvlConfirm(atvlEmpl);
		if(confirm == null || confirm.length() < 1) {
			result = service.insertAttende(atvlEmpl);
			switch (result) {
			case OK:
				message = "AT";
				break;
			default:
				message = "서버 오류, 잠시 후에 다시 시도하세요.";
				break;
			}
		} else {
			result = service.updateLvffc(atvlEmpl);
			switch (result) {
			case OK:
				message = "LV";
				break;
			default:
				message = "서버 오류, 잠시 후에 다시 시도하세요.";
				break;
			}
		}
		return message;
	}
}
