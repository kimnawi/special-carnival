package com.eg.empl.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.commons.ServiceResult;
import com.eg.empl.dao.EmplDAO;
import com.eg.empl.service.EmplService;
import com.eg.file.service.CommonFileService;
import com.eg.group.drive.service.FTPFileService;
import com.eg.util.AES256Util;
import com.eg.validate.groups.PasswordGroup;
import com.eg.vo.AcademicVO;
import com.eg.vo.AdGroupAllVO;
import com.eg.vo.CommonFileVO;
import com.eg.vo.EmplVO;
import com.eg.vo.QualificateVO;

@Controller
@RequestMapping("/empl/emplUpdate.do")
public class EmplUpdateController {

	@Inject
	private EmplService service;
	@Inject
	private EmplDAO dao;
	@Inject
	@Named("ftpPoolService")
	FTPFileService ftpFileService;
	@Inject
	AES256Util encoder;
	@Inject
	CommonFileService fileService;
	
	
	@ModelAttribute("command")
	public String addCommand() {
		return "UPDATE";
	}
	
	@GetMapping
	public String emplForm(
			@RequestParam("emplNo") int emplNo
			, Model model
			, @RequestParam(value="sal",required=false) String sal
			, HttpServletResponse resp
			) throws Exception {
		EmplVO empl = service.retrieveEmpl(emplNo);
		List<QualificateVO> qualList = dao.selectEmplQualificate(emplNo);
		AcademicVO academic = dao.selectEmplAcademic(emplNo);
		model.addAttribute("empl", empl);
		model.addAttribute("sal",sal);
		model.addAttribute("qualList", qualList);
		model.addAttribute("academic", academic);
		return "/empl/emplForm";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping
	public String emplUpdate(
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
		String[] alCode = empl.getAlCode().split(",");
		String[] faAmount = empl.getFaAmount().split(",");
		String[] deCode = empl.getDeCode().split(",");
		String[] mdAmount = empl.getMdAmount().split(",");
		List<AdGroupAllVO> fixAl = new ArrayList<>();
		List<AdGroupAllVO> monthDe = new ArrayList<>();
		for(int i =0; i<alCode.length;i++) {
			AdGroupAllVO vo = new AdGroupAllVO();
			vo.setAlCode(alCode[i]);
			vo.setEmplNo(String.valueOf(empl.getEmplNo()));
			if(faAmount[i] == null) {
				vo.setFaAmount("0");
			}else{
				vo.setFaAmount(faAmount[i]);
			}
			fixAl.add(vo);
		}
		empl.setFixAl(fixAl);
		for(int i = 0; i<deCode.length;i++) {
			AdGroupAllVO vo = new AdGroupAllVO();
			vo.setDeCode(deCode[i]);
			vo.setEmplNo(String.valueOf(empl.getEmplNo()));
			if(mdAmount[i] == null) {
				vo.setMdAmount("0");
			}else {
				vo.setMdAmount(mdAmount[i]);
			}
			monthDe.add(vo);
		}
		empl.setMonthDe(monthDe);
		if(!errors.hasErrors()) {
			if(uploadFile.getSize() != 0) {
				Map<String,Object> pathResult = new HashMap<>();
				try {
					ftpFileService.uploadFile(uploadFile, path, pathResult);
					String resultPath = (String) pathResult.get("resultPath");
					CommonFileVO commonFileVO = fileService.retrieveCommonFileByPath(resultPath);
					
					if(commonFileVO == null) {
						commonFileVO = new CommonFileVO();
						commonFileVO.setCommonPath(resultPath);
						int commonNo = fileService.createCommonFile(commonFileVO);
						empl.setCommonNo(commonNo);
					}else if(!empl.getCommonNo().equals(commonFileVO.getCommonNo())){
						empl.setCommonNo(commonFileVO.getCommonNo());
					}
				} catch (Exception e) {
					e.printStackTrace();
					message = "프로필 사진 업로드 실패";
					success = "FAIL";
				}
			}
				ServiceResult result = service.modifyEmpl(empl);
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
	
	@PostMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String,Object> changePW(
			@Validated(value=PasswordGroup.class) EmplVO empl,
			Errors error
			){
		Map<String,Object> result = new HashMap<>();
		if(error.hasErrors()) {
			result.put("result","FAIL");
			return result;
		}
		ServiceResult sResult = service.modifyEmplPw(empl);
		result.put("result",sResult);	
		return result;
	}
}
