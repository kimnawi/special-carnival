package com.eg.vacation.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.vacation.service.VacService;
import com.eg.vo.PagingVO;
import com.eg.vo.VacHistoryVO;
import com.eg.vo.VacationVO;

@Controller
public class VacRetrieveController {

	@Inject
	private VacService service;
	
	@RequestMapping("/vac/emplVacList.do")
	public String emplVacList(
			@RequestParam(required=false) String command
			) {
		String viewName = "";
		if("content".equals(command)) {
			// 메뉴 전자결재 부분 클릭했을 때
			viewName = "/vac/emplVacList";
		}else {
			// 헤더 전자결재 부분 클릭했을 때
			viewName = "vac/emplVacList";
		}
		return viewName;
	}
	
	@RequestMapping(value="/vac/emplVacList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<VacationVO> listForAjax(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @RequestParam(value="emplNo", required=false) String emplNo
			, @ModelAttribute("detailSearch") VacationVO detailSearch
		){
		String[] emplNoArray = emplNo.split(",");
		detailSearch.setEmplNoArray(emplNoArray);
		
		PagingVO<VacationVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveVcatnList(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/vac/vacCalc.do")
	@ResponseBody
	public List<VacHistoryVO> vacCalc(
			@RequestParam("vcatn[]") String vcatnCode
			, @RequestParam("emplNo[]") String emplNo
			, Model model
		) {
		Map<String, Object> vacEmpl = new HashMap<>();
		vacEmpl.put("vcatnCode", vcatnCode);
		vacEmpl.put("emplNo", emplNo);
		
		List<VacHistoryVO> vacHistoryList = service.retrieveVacCalc(vacEmpl);
		model.addAttribute("vacHistoryList", vacHistoryList);
		
		return vacHistoryList;
	}

	@RequestMapping("/vac/vacExcelForm.do")
	public void excel(
			HttpServletResponse resp
		) throws IOException {
		//새 엑셀 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		//새 시트 생성
		XSSFSheet sheet = workbook.createSheet("사원별휴가일수입력");
		
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
		
		XSSFRow curRow;
		
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
		
		String localFile = "사원별휴가일수입력양식.xlsx";
		
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
