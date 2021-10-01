package com.eg.group.drive.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.file.service.CommonFileService;
import com.eg.group.drive.service.DriveService;
import com.eg.util.AES256Util;
import com.eg.vo.CommonFileVO;
import com.eg.vo.HistoryVO;
import com.eg.vo.PagingVO;

@Controller
public class DriveHistoryController {

	@Inject
	DriveService service;
	@Inject
	CommonFileService FileService;
	@Inject
	AES256Util encoder;
	
	@RequestMapping("/group/schedule/drive/historyView.do")
	public String historyForm(
			) {
		return "/drive/historyList";
	}

	@RequestMapping(value="/group/schedule/drive/historyView.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<HistoryVO> dataForHistoryForm(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
			String link
			) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {
		link = link.replaceAll(" ", "+");
		CommonFileVO fileVO = FileService.retrieveCommonFileByPath(link);
		HistoryVO historyVO = new HistoryVO();
		historyVO.setCommonNo(fileVO.getCommonNo());
		PagingVO<HistoryVO> pagingVO = new PagingVO<>(8,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(historyVO);
		service.retrieveHistoryList(pagingVO);
		return pagingVO;
	}
	
}
