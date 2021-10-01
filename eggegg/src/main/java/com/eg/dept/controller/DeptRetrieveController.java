package com.eg.dept.controller;

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
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.dept.service.DeptService;
import com.eg.vo.DeptVO;
import com.eg.vo.PagingVO;

@Controller
public class DeptRetrieveController {

	@Inject
	private DeptService service;
	
	@ModelAttribute("List")
	public List<DeptVO> deptList(){
		List<DeptVO> deptList = service.retrieveDept();
		return deptList;
	}
	
	@RequestMapping("/empl/deptList.do")
	public String deptList(
			Model model,
			@RequestParam(value="use", required=false, defaultValue="yes") String use
	) {
		model.addAttribute("use",use);
		model.addAttribute("selectedMenu", "ResistDept");
		return "dept/deptList";
	}
	@RequestMapping(value="/empl/deptList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<DeptVO> listforAjax(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
			@ModelAttribute("detailSearch") DeptVO detailSearch
	){
		PagingVO<DeptVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveDeptList(pagingVO);
		
		return pagingVO;
	}

	@RequestMapping("/empl/deptListY.do")
	public String deptListY(
			Model model,
			@RequestParam(value="use", required=false, defaultValue="yes") String use
			) {
		model.addAttribute("use",use);
		model.addAttribute("selectedMenu", "ResistDept");
		
		return "dept/deptList";
	}
	@RequestMapping(value="/empl/deptListY.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<DeptVO> listforAjaxY(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
			@ModelAttribute("detailSearch") DeptVO detailSearch
			){
		PagingVO<DeptVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveDeptListY(pagingVO);
		
		return pagingVO;
	}
	
	@RequestMapping(value="/empl/selectDept.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public DeptVO selectDepartment(
			@RequestParam String deptCode
	) {
		DeptVO department = new DeptVO();
		department = service.retrieveDept(deptCode);
		
		return department;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/empl/excelDept.do")
	public void excel(
	) throws IOException{
		Date today = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd-HH-mm",Locale.KOREA);
		String dTime = formatter.format(today);
		String filePath = "D://excel/부서"+dTime+".xlsx";
		
		FileOutputStream fos = new FileOutputStream(filePath);
		
		//새 엑셀 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		//새 시트 생성
		XSSFSheet sheet = workbook.createSheet("프로젝트");
		
		CellStyle style =  workbook.createCellStyle();
		style.setBorderBottom(BorderStyle.THIN);
		style.setBorderRight(BorderStyle.THIN);
		style.setBorderTop(BorderStyle.THIN);
		style.setBorderLeft(BorderStyle.THIN);
		
		List<DeptVO> list = service.retrieveDept();
		
		XSSFRow curRow;
		
		int row = list.size();
		Cell cell = null;
		
		curRow = sheet.createRow(0);
		cell = curRow.createCell(0);
		cell.setCellValue("부서코드");
		cell.setCellStyle(style);
		
		cell = curRow.createCell(1);
		cell.setCellValue("부서명");
		cell.setCellStyle(style);

		cell = curRow.createCell(2);
		cell.setCellValue("상위부서코드");
		cell.setCellStyle(style);

		cell = curRow.createCell(3);
		cell.setCellValue("상위부서명");
		cell.setCellStyle(style);
		
		cell = curRow.createCell(4);
		cell.setCellValue("사용구분");
		cell.setCellStyle(style);
		
		for(int i=1;i<=row;i++) {
			DeptVO vo = list.get(i-1);
			curRow = sheet.createRow(i);
			cell = curRow.createCell(0);
			cell.setCellValue(vo.getDeptCode());
			cell.setCellStyle(style);
			
			cell = curRow.createCell(1);
			cell.setCellValue(vo.getDeptNm());
			cell.setCellStyle(style);
			
			cell = curRow.createCell(2);
			cell.setCellValue(vo.getDeptParent());
			cell.setCellStyle(style);
			
			cell = curRow.createCell(3);
			cell.setCellValue(vo.getDeptPnm());
			cell.setCellStyle(style);
			
			cell = curRow.createCell(4);
			cell.setCellValue(vo.getDeptUse());
			cell.setCellStyle(style);
		}
		
		workbook.write(fos);
		workbook.close();
		fos.close();
	}
	
}
