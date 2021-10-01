package com.eg.adgroup.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.adgroup.dao.AdGroupDAO;
import com.eg.adgroup.service.AdGroupService;
import com.eg.search.service.SearchService;
import com.eg.vo.AdGroupAllVO;
import com.eg.vo.AdGroupVO;
import com.eg.vo.AllowanceVO;
import com.eg.vo.DeductionVO;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;
import com.eg.vo.ProjectVO;

@Controller
public class AdGroupRetrieveController {
	@Inject
	private SearchService service2;
	
	@Inject
	private AdGroupService service;
	@Inject
	private AdGroupDAO DAO;
	
	@RequestMapping(value="/sal/adGroupList.do")
	public String adGroupList(
			Model model
	) {
		model.addAttribute("selectedMenu","ResistAD");
		return "sal/adgroup/adGroupList";
	}
	
	@RequestMapping(value="/sal/adGroupList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<AdGroupVO> listforAjax(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
			@ModelAttribute("detailSearch") AdGroupVO detailSearch
	){
		PagingVO<AdGroupVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveGroupList(pagingVO);
		
		return pagingVO;
	}
	
	@ResponseBody
	@RequestMapping(value="/sal/excelGroup.do")
	public void excel() throws IOException{
		Date today = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd-HH-mm",Locale.KOREA);
		String dTime = formatter.format(today);
		
		String filePath = "D://excel/수당공제그룹"+dTime+".xlsx";
		
		FileOutputStream fos = new FileOutputStream(filePath);
		
		//새 엑셀 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		//새 시트 생성
		XSSFSheet sheet = workbook.createSheet("수당_공제그룹");
		
		CellStyle style =  workbook.createCellStyle();
		style.setBorderBottom(BorderStyle.THIN);
		style.setBorderRight(BorderStyle.THIN);
		style.setBorderTop(BorderStyle.THIN);
		style.setBorderLeft(BorderStyle.THIN);
		
		List<AdGroupVO> list = service.retrieveGroupList();
		
		XSSFRow curRow;
		
		int row = list.size();
		Cell cell = null;
		
		curRow = sheet.createRow(0);
		cell = curRow.createCell(0);
		cell.setCellValue("수당/공제그룹코드");
		cell.setCellStyle(style);
		
		cell = curRow.createCell(1);
		cell.setCellValue("수당/공제그룹명");
		cell.setCellStyle(style);

		
		for(int i=1;i<=row;i++) {
			AdGroupVO vo = list.get(i-1);
			curRow = sheet.createRow(i);
			cell = curRow.createCell(0);
			cell.setCellValue(vo.getAdgCode());
			cell.setCellStyle(style);
			
			cell = curRow.createCell(1);
			cell.setCellValue(vo.getAdgNm());
			cell.setCellStyle(style);
			
		}
		
		workbook.write(fos);
		fos.close();
		
	}
	
	@RequestMapping(value="/sal/allowanceList.do")
	public String alList(
	Model model		
	) {
		List<AllowanceVO> list = DAO.alList();
		model.addAttribute("alList", list);
		return "//sal/adgroup/allowanceList";
	}
	
	@RequestMapping(value="/sal/popDeductionList.do")
	public String deList(
	Model model
	) {
		List<DeductionVO> list = DAO.deList();
		model.addAttribute("deList",list);
		return "//sal/adgroup/deductionList";
	}
	
	@RequestMapping(value="/sal/selectGroup.do")
	@ResponseBody
	public AdGroupAllVO selectgroup(
	@RequestParam(value="code") String code		
	) {
		AdGroupAllVO group = service.retrieveAdGroup(code);
		
		List<EmplVO> empl = DAO.selectGroup(code);
		group.setEmpl(empl);
		return group;
	}
	
	@RequestMapping("/sal/emplSearch.do")
	public String emplList() {
		return "/sal/adgroup/searchEmpl";
	}
	
	@RequestMapping(value="/sal/emplSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
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
		service2.searchEmplList(pagingVO);
		return pagingVO;
	}
	
}