package com.eg.dept.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.dept.service.DeptService;
import com.eg.empl.service.EmplService;
import com.eg.vo.DeptWrapperVO;
import com.eg.vo.EmplFancyWrapperVO;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;

@Controller
public class DeptFancyController {

	@Inject
	private DeptService service;
	
	@Inject
	private EmplService emplService;
	
	@RequestMapping(value="/empl/deptFancy.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<DeptWrapperVO> deptFancyListAjax(
			@RequestParam(value="deptParent", required=false) String deptParent
			, Model model
			, @RequestParam(required=false) Boolean forAuthl
		){
		Map<String, Object> map = new HashMap<>();
		map.put("deptParent", deptParent);
		map.put("forAuthl", forAuthl);
		return service.retrieveDeptFancyList(map);
	}

	@RequestMapping(value="/empl/emplFancy.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<EmplFancyWrapperVO> emplFancyListAjax(
			@RequestParam(value="deptParent", required=false) String deptParent
			, Model model
			){
		PagingVO<EmplFancyWrapperVO> pagingVO = new PagingVO<>();
		EmplVO adaptee = new EmplVO();
		adaptee.setDeptCode(deptParent);
		EmplFancyWrapperVO wrapper = new EmplFancyWrapperVO(adaptee);
		pagingVO.setDetailSearch(wrapper);
		service.retrieveEmplFancyList(pagingVO);
		return pagingVO.getDataList();
	}
	
	@RequestMapping(value="/empl/deptFancy.do")
	public String deptFancy() {
		return "/dept/deptFancy";
	}
	
	@RequestMapping(value="/empl/deptEmplList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<EmplVO> deptEmplListForAjax(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("detailSearch") EmplVO detailSearch
		) {
		PagingVO<EmplVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveDeptEmplList(pagingVO);
		return pagingVO;
	}
	
}
