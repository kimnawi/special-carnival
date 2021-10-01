package com.eg.group.esign.controller;

import java.io.File;

import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.group.drive.service.FTPFileService;
import com.eg.group.drive.service.FTPFileServiceImpl_WithPool;
import com.eg.group.esign.service.EsignService;
import com.eg.vo.AuthVO;
import com.eg.vo.DraftFormVO;
import com.eg.vo.DraftVO;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.PagingVO;

@Controller
public class EsignRetrieveController {
	@Inject
	private EsignService service;
	
	@Inject
	@Named("ftpPoolService")
	private FTPFileService ftpService;
	
	@RequestMapping("/group/esign/draftList.do")
	public String draftList(
				@RequestParam(required=false) String command
			) {
		if("content".equals(command)) {
			// 메뉴 전자결재 부분 클릭했을 때
			return "//esign/draftList";
		}else {
			// 헤더 전자결재 부분 클릭했을 때
			return "esign/draftList";
		}
	}
	
	@RequestMapping(value="/group/esign/draftList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<DraftVO> listForAJAX(
				@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
				PagingVO<DraftVO> pagingVO,
				DraftVO detailSearch,
				@RequestParam(required=false) String command,
				@AuthenticationPrincipal EmplVOWrapper wrapper
			){
		pagingVO.setCurrentPage(currentPage);
		detailSearch.setDraftWriter(wrapper.getAdaptee().getEmplNo());
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveDraftList(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/group/esign/draftForm.do")
	public String draftForm(
			Integer formNo,
			String command,
			Model model
			) {
		Integer target = formNo;
		String viewName = "/esign/draftForm";
			
		// 결재를 위한 양식 선택(command=INSERT) 혹은 양식 수정을 위한 선택(command=UPDATE)
		if("INSERT".equals(command)||"UPDATE".equals(command)) {
			if("UPDATE".equals(command)){
				viewName = "/esign/draftFormEdit";
			}
			model.addAttribute("draftFormVO",service.retrieveDraftForm(target));
			return viewName;
		}else {
			// 기안문 수정(command=VIEW)을 위한 선택
			model.addAttribute("draft",service.retrieveDraft(target));
			return viewName;
		}
	}
		
	
	@RequestMapping("/group/esign/signImage.do")
	public String signImageUpload() {
		return "//esign/signImage";
	}

	@RequestMapping("/group/esign/getSignImage.do")
	public void signImage(
			String link,
			HttpServletResponse resp
			) throws Exception {
		ftpService.getImgFile(link, resp);
	}
	
	@RequestMapping("/group/esign/draftFormList.do")
	public String draftFormList() {
		return "/esign/draftFormList";
	}
	
	@RequestMapping(value="/group/esign/draftFormList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<DraftFormVO> dataForListAJAX(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
			@AuthenticationPrincipal EmplVOWrapper wrapper,
			DraftFormVO detailSearch
			){
		PagingVO<DraftFormVO> pagingVO = new PagingVO<>(6, 5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		Integer emplNo = wrapper.getAdaptee().getEmplNo();
		return service.retrieveDraftFormList(pagingVO,emplNo);
	}
	
	@RequestMapping(value="/group/esign/selectAuth.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public AuthVO selectAuth(
				Integer emplNo
			) {
		return service.retrieveAuth(emplNo);
	}
}
