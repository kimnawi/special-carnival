package com.eg.search.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.search.service.SearchService;
import com.eg.vo.CommonTableVO;
import com.eg.vo.DeptVO;
import com.eg.vo.EmplVO;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.EntranceVO;
import com.eg.vo.LineBoxVO;
import com.eg.vo.PagingVO;
import com.eg.vo.PositionVO;
import com.eg.vo.ProjectVO;
import com.eg.vo.RolesVO;
import com.eg.vo.ScheSortVO;
import com.eg.vo.VacationVO;
import com.eg.vo.bankVO;

@Controller
public class SearchRetrieveController {

	@Inject
	private SearchService service;
	
	@RequestMapping("/search/deptSearch.do")
	public String deptList() {
		return "/search/deptSearch";
	}
	
	@RequestMapping(value="/search/deptSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<DeptVO> listForAjax(
		@RequestParam(value="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("detailSearch") DeptVO detailSearch
		){
		
		PagingVO<DeptVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.searchDeptList(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/search/prjSearch.do")
	public String prjList() {
		return "/search/prjSearch";
	}
	
	@RequestMapping(value="/search/prjSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<ProjectVO> listForAjax(
		@RequestParam(value="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("detailSearch") ProjectVO detailSearch
		){
		
		PagingVO<ProjectVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.searchProjectList(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/search/scheSearch.do")
	public String scheList() {
		return "/search/scheSearch";
	}
	
	@RequestMapping(value="/search/scheSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<ScheSortVO> listForAjax(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("detailSearch") ScheSortVO detailSearch
			){
		
		PagingVO<ScheSortVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.searchScheSortList(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/search/entranceSearch.do")
	public String entranceList(
			Model model
			) {
		List<EntranceVO> entranceList = service.searchEntranceList();
		model.addAttribute("entranceList", entranceList);
		return "/search/entranceSearch";
	}
	
	@RequestMapping("/search/pstSearch.do")
	public String pstList() {
		return "/search/pstSearch";
	}
	
	@RequestMapping(value="/search/pstSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<PositionVO> positionList(
			@ModelAttribute("detailSearch") PositionVO detailSearch
			, Model model
		) {
		PagingVO<PositionVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(1);
		pagingVO.setDetailSearch(detailSearch);
		service.searchPositionList(pagingVO);
		return pagingVO;
	}

	@RequestMapping("/search/bankSearch.do")
	public String bankList() {
		return "/search/bankSearch";
	}
	
	
	@RequestMapping(value="/search/bankSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<bankVO> listForAjax(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("detailSearch") bankVO detailSearch
		) {
		PagingVO<bankVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.searchBankList(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/search/roleSearch.do")
	public String roleList() {
		return "/search/roleSearch";
	}
	
	@RequestMapping(value="/search/roleSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<RolesVO> roleList(
			@ModelAttribute("detailSearch") RolesVO detailSearch
			, Model model
			) {
		PagingVO<RolesVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(1);
		pagingVO.setDetailSearch(detailSearch);
		service.searchRolesList(pagingVO);
		return pagingVO;
	}

	@RequestMapping("/search/commonTableSearch.do")
	public String draftTypeList() {
		return "/search/commonTableSearch";
	}
	
	@RequestMapping(value="/search/commonTableSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<CommonTableVO> commonTableSearchList(
			@RequestParam(value="page",defaultValue="1") int currentPage
			,PagingVO<CommonTableVO> pagingVO
			) {
		pagingVO.setCurrentPage(currentPage);
		service.searchCommonTableList(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/search/emplSearch.do")
	public String emplList() {
		return "/search/emplSearch";
	}
	
	@RequestMapping(value="/search/emplSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<EmplVO> ajaxForEmplList(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @RequestParam(value="emplEcnyStart", required=false) @DateTimeFormat(pattern="yyyy-MM-dd") Date emplEcnyStart
			, @RequestParam(value="emplEcnyEnd", required=false) @DateTimeFormat(pattern="yyyy-MM-dd") Date emplEcnyEnd
			, @ModelAttribute("detailSearch") EmplVO detailSearch
		){
		
		SimpleDateFormat fm = new SimpleDateFormat("yyyy/MM/dd");
		if(emplEcnyStart != null) {
			String strEmplEcnyStart = fm.format(emplEcnyStart);
			detailSearch.setEmplEcnyStart(strEmplEcnyStart);
		}
		if(emplEcnyEnd != null) {
			String strEmplEcnyEnd = fm.format(emplEcnyEnd);
			detailSearch.setEmplEcnyEnd(strEmplEcnyEnd);
		}
		
		PagingVO<EmplVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.searchEmplList(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/search/authlSearch.do")
	public String myAuthLineList() {
		return "/search/authlSearch";
	}
	
	@RequestMapping(value="/search/authlSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<LineBoxVO> ajaxForMyLineList(
			PagingVO<LineBoxVO> pagingVO,
			LineBoxVO detailSearch
		){
		pagingVO.setDetailSearch(detailSearch);
		service.searchMyLineList(pagingVO);
		return pagingVO;
	}

	@RequestMapping(value="/search/authlSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE, params="lcbLineNo")
	@ResponseBody
	public LineBoxVO ajaxForMyLine(
			@AuthenticationPrincipal EmplVOWrapper wrapper,
			int lcbLineNo
			){
			Map<String,Object> param = new HashMap<>();
			param.put("emplNo", wrapper.getAdaptee().getEmplNo());
			param.put("lineNo", lcbLineNo);
			return service.searchMyLine(param); 
	}
	
	@RequestMapping("/search/vcatnSearch.do")
	public String vcatnList() {
		return "/search/vcatnSearch";
	}
	
	@RequestMapping(value="/search/vcatnSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<VacationVO> listForAjax (
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("detailSearch") VacationVO detailSearch
		) {
		PagingVO<VacationVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.searchVcatnList(pagingVO);
		return pagingVO;
	}
}
