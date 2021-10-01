package com.eg.empl.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.commons.ServiceResult;
import com.eg.empl.dao.EmplDAO;
import com.eg.empl.service.EmplService;
import com.eg.file.service.CommonFileService;
import com.eg.group.drive.service.FTPFileService;
import com.eg.util.AES256Util;
import com.eg.vo.CommonFileVO;
import com.eg.vo.EmplVO;

@Controller
@RequestMapping("/empl/emplInsert.do")
public class EmplInsertController {

	@Inject
	private EmplService service;
	@Inject
	private EmplDAO emplDAO;
	@Inject
	@Named("ftpPoolService")
	FTPFileService ftpFileService;
	@Inject
	AES256Util encoder;
	@Inject
	CommonFileService fileService;
	
	@ModelAttribute("command")
	public String addCommand() {
		return "INSERT";
	}
	
	@GetMapping
	public String emplForm(Model model) {
		int emplNo = emplDAO.selectNextEmplNo();
		EmplVO emplVo = new EmplVO();
		emplVo.setEmplNo(emplNo);
		model.addAttribute("empl", emplVo);
		return "/empl/emplForm";
	}
	
	@PostMapping
	public String emplInsert(
		@Validated @ModelAttribute("empl") EmplVO empl
		, Errors errors
		, Model model
		, RedirectAttributes redirectAttributes
		, MultipartFile uploadFile
		, String path		
		) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {

		String message = null;
		String success = null;
		path = encoder.encrypt(path);
		
		if(!errors.hasErrors()) {
			if(uploadFile.getSize() != 0) {
				Map<String,Object> pathResult = new HashMap<>();
				try {
					ftpFileService.uploadFile(uploadFile, path, pathResult);
					String resultPath = (String) pathResult.get("resultPath");
					CommonFileVO commonFileVO = fileService.retrieveCommonFileByPath(resultPath);
					commonFileVO = new CommonFileVO();
					commonFileVO.setCommonPath(resultPath);
					int commonNo = fileService.createCommonFile(commonFileVO);
					empl.setCommonNo(commonNo);
				} catch (Exception e) {
					e.printStackTrace();
					message = "프로필 사진 업로드 실패";
					success = "FAIL";
				}
			}
			ServiceResult result = service.createEmpl(empl);
			switch (result) {
			case OK:
				success = "SUCCESS";
				break;
			default:
				message = "서버 오류, 잠시 후에 다시 시도해주세요.";
				break;
			}
		}
		
		redirectAttributes.addFlashAttribute("message", message);
		model.addAttribute("success", success);
		model.addAttribute("empl", empl);
		
		return "/empl/emplForm";
	}
}
