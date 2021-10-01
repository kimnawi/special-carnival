package com.eg.hrd.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.hrd.service.HrdService;
import com.eg.vo.AttendeLvffcVO;
import com.eg.vo.PagingVO;

@Controller
public class HrdRetrieveController {

	@Inject
	private HrdService service;
	
	@RequestMapping("/vac/hrdList.do")
	public String hrdList(
		) {
		return "/hrd/hrdList";
	}
	
	@RequestMapping(value="/vac/hrdList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<AttendeLvffcVO> hrdListCntAjax(
			@RequestParam(value="atvlMonth", required=false) String atvlMonth
		){
		if(atvlMonth == null || atvlMonth.length() == 0) {
			SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
			Date today = new Date();
			atvlMonth = format.format(today).substring(2);
		}
		List<AttendeLvffcVO> attendeLvffcList = service.retrieveAtvlCntList(atvlMonth);
		return attendeLvffcList;
	}
	
	@RequestMapping(value="/vac/hrdEmplList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<AttendeLvffcVO> hrdListAjax(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @RequestParam(value="atvlEmpl", required=false) String atvlEmpl
			, @ModelAttribute("detailSearch") AttendeLvffcVO detailSearch
			){
		String[] atvlEmplArray = atvlEmpl.split(",");
		detailSearch.setAtvlEmplArray(atvlEmplArray);
		
		PagingVO<AttendeLvffcVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveAtvlList(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/vac/hrdStatus.do")
	public String hrdStatus() {
		return "/hrd/hrdStatus";
	}
	
	@RequestMapping(value="/vac/hrdStatus.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<AttendeLvffcVO> atvlStatusAjax(
			@RequestParam(value="atvlEmpl", required=false) String atvlEmpl
			, @ModelAttribute("detailSearch") AttendeLvffcVO detailSearch
		){
		String[] atvlEmplArray = atvlEmpl.split(",");
		detailSearch.setAtvlEmplArray(atvlEmplArray);
		
		PagingVO<AttendeLvffcVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveAtvlStatus(pagingVO);
		
		return pagingVO;
	}
}
