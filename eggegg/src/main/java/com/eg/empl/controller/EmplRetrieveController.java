package com.eg.empl.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
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

import com.eg.empl.dao.EmplDAO;
import com.eg.empl.service.EmplService;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;

@Controller
public class EmplRetrieveController {

	@Inject
	private EmplService service;
	@Inject
	private EmplDAO dao;
	
	@RequestMapping("/empl/emplList.do")
	public String emplList(
			@RequestParam(required=false) String command
		) {
		if("content".equals(command)) {
			// 메뉴 전자결재 부분 클릭했을 때
			return "/empl/emplList";
		}else {
			// 헤더 전자결재 부분 클릭했을 때
			return "empl/emplList";
		}
	}
	
	@RequestMapping(value="/empl/emplList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<EmplVO> listForAjax(
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
		service.retrieveEmplList(pagingVO);
		return pagingVO;
	}
	
	
	@RequestMapping("/empl/salEmplList.do")
	public String salEmplList(
		@RequestParam(required=false) String command
		, Model model
		) {
		model.addAttribute("selectedMenu","ResistPay");
		String viewName = "";
		if("content".equals(command)) {
			// 메뉴 급여관리 부분 클릭했을 때
			viewName = "/sal/emplsalary/emplList";
		}else {
			// 헤더 급여관리 부분 클릭했을 때
			viewName = "sal/emplsalary/emplList";
		}
		return viewName;
	}
	
	@RequestMapping(value="/empl/salEmplList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<EmplVO> listForAjax2(
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
		service.retrieveEmplList(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/empl/emplStatus.do")
	public String emplStatus() {
		return "empl/emplStatus";
	}

	@RequestMapping(value="/empl/findEmplNo.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public EmplVO findEmplNo(
			@ModelAttribute EmplVO empl
		){
		service.retrieveEmplNo(empl);
		return empl;
	}
	
	@RequestMapping("/empl/emplExcel.do")
	public void excel(
			HttpServletResponse resp
		) throws IOException {
		//새 엑셀 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		//새 시트 생성
		XSSFSheet sheet = workbook.createSheet("사원리스트");
		
		CellStyle style =  workbook.createCellStyle();
		style.setBorderBottom(BorderStyle.THIN);
		style.setBorderRight(BorderStyle.THIN);
		style.setBorderTop(BorderStyle.THIN);
		style.setBorderLeft(BorderStyle.THIN);
		
		XSSFFont font = workbook.createFont();
		font.setBold(true);
		CellStyle style2 = workbook.createCellStyle();
		style2.setFont(font);
		style2.setBorderBottom(BorderStyle.THIN);
		style2.setBorderRight(BorderStyle.THIN);
		style2.setBorderTop(BorderStyle.THIN);
		style2.setBorderLeft(BorderStyle.THIN);
		
		List<EmplVO> emplList = dao.selectEmplExcelList();
		
		XSSFRow curRow;
		
		int row = emplList.size();
		Cell cell = null;
		
		curRow = sheet.createRow(0);
		
		cell = curRow.createCell(0);
		cell.setCellValue("사원번호");
		cell.setCellStyle(style2);
		
		cell = curRow.createCell(1);
		cell.setCellValue("성명");
		cell.setCellStyle(style2);
		cell = curRow.createCell(2);
		cell.setCellValue("부서명");
		cell.setCellStyle(style2);
		cell = curRow.createCell(3);
		cell.setCellValue("직위/직급명");
		cell.setCellStyle(style2);
		cell = curRow.createCell(4);
		cell.setCellValue("입사일자");
		cell.setCellStyle(style2);
		cell = curRow.createCell(5);
		cell.setCellValue("재직구분");
		cell.setCellStyle(style2);
		cell = curRow.createCell(6);
		cell.setCellValue("계좌번호");
		cell.setCellStyle(style2);
		cell = curRow.createCell(7);
		cell.setCellValue("Email");
		cell.setCellStyle(style2);
		
		for(int i = 1; i <= row; i++) {
			EmplVO vo = emplList.get(i - 1);
			String deptNm = "";
			String pstNm = "";
			String slryAcnutno = "";
			if(vo.getDept() != null) {
				deptNm = vo.getDept().getDeptNm();
			}
			if(vo.getPosition() != null) {
				pstNm = vo.getPosition().getPstNm();
			}
			if(vo.getSalarybank() != null) {
				slryAcnutno = vo.getSalarybank().getSlryAcnutno();
			}
			curRow = sheet.createRow(i);
			
			cell = curRow.createCell(0);
			cell.setCellValue(vo.getEmplNo());
			cell.setCellStyle(style);
			cell = curRow.createCell(1);
			cell.setCellValue(vo.getEmplNm());
			cell.setCellStyle(style);
			cell = curRow.createCell(2);
			cell.setCellValue(deptNm);
			cell.setCellStyle(style);
			cell = curRow.createCell(3);
			cell.setCellValue(pstNm);
			cell.setCellStyle(style);
			cell = curRow.createCell(4);
			cell.setCellValue(vo.getEmplEcny());
			cell.setCellStyle(style);
			cell = curRow.createCell(5);
			cell.setCellValue(vo.getRetire().getEmplRetire());
			cell.setCellStyle(style);
			cell = curRow.createCell(6);
			cell.setCellValue(slryAcnutno);
			cell.setCellStyle(style);
			cell = curRow.createCell(7);
			cell.setCellValue(vo.getEmplEmail());
			cell.setCellStyle(style);
		}
		
		Date today = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd-HH-mm",Locale.KOREA);
		String dTime = formatter.format(today);
		String localFile = "사원리스트" + dTime + ".xlsx";
		
		byte[] bytes = localFile.getBytes();
		localFile = new String(bytes, "ISO-8859-1");
		
		File file = new File(localFile);
		FileOutputStream fos = null;
		fos = new FileOutputStream(file);
		
		resp.setContentType("application/octet-stream");
		resp.setHeader("Content-Disposition", "attatchment;filename=\""+localFile+"\"");
		
		workbook.write(fos);
		
		FileUtils.copyFile(file, resp.getOutputStream());
		if(fos != null) {
			workbook.close();
			fos.close();
		}
	}
}
