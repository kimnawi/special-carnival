package com.eg.gnfd.controller;

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
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.gnfd.dao.GnfdDAO;
import com.eg.gnfd.service.GnfdService;
import com.eg.vo.GnfdTypeVO;
import com.eg.vo.OfficialOrderVO;
import com.eg.vo.PagingVO;

@Controller
public class GnfdRetrieveController {

	@Inject
	private GnfdDAO dao;
	@Inject
	private GnfdService service;
	
	@ModelAttribute("gnfdTypeList")
	public List<GnfdTypeVO> gnfdTypeList(){
		List<GnfdTypeVO> gnfdTypeList = dao.selectGnfdTypeList();
		return gnfdTypeList;
	}
	
	@RequestMapping("/empl/gnfdList.do")
	public String gnfdList() {
		return "/gnfd/gnfdList";
	}
	
	@RequestMapping(value="/empl/gnfdList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<OfficialOrderVO> listForAjax(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @RequestParam(value="emplNo", required=false) String emplNo
			, @ModelAttribute("detailSearch") OfficialOrderVO detailSearch
		){
		String[] emplNoArray = emplNo.split(",");
		detailSearch.setEmplNoArray(emplNoArray);
		
		PagingVO<OfficialOrderVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveGnfdList(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/empl/gnfdDraft.do")
	public String gnfdDraftForm(
			@RequestParam("what") String gnfdStdrde
			, Model model
		) {
		OfficialOrderVO gnfd = dao.selectGnfdDetail(gnfdStdrde);
		model.addAttribute("gnfd", gnfd);
		return "/gnfd/gnfdDraft";
	}
	
	@RequestMapping("/empl/gnfdStatus.do")
	public String emplStatus() {
		return "/gnfd/gnfdStatus";
	}
	
	@RequestMapping(value="/empl/gnfdStatus.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<OfficialOrderVO> listForAjaxStatus(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @RequestParam(value="emplNo", required=false) String emplNo
			, @ModelAttribute("detailSearch") OfficialOrderVO detailSearch
		) {
		String[] emplNoArray = emplNo.split(",");
		detailSearch.setEmplNoArray(emplNoArray);
		
		PagingVO<OfficialOrderVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		
		service.retrieveGnfdStatus(pagingVO);
		return pagingVO;
	}
	
	@RequestMapping("/empl/gnfdExcel.do")
	public void excel(
			HttpServletResponse resp
		) throws IOException {
		XSSFWorkbook workbook = new XSSFWorkbook();
		XSSFSheet sheet = workbook.createSheet("인사발령리스트");
		
		CellStyle style = workbook.createCellStyle();
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
		
		List<OfficialOrderVO> gnfdList = dao.selectGnfdExcel();
		
		XSSFRow curRow;
		
		int row = gnfdList.size();
		Cell cell = null;
		curRow = sheet.createRow(0);
		
		cell = curRow.createCell(0);
		
		cell = curRow.createCell(0);
		cell.setCellValue("발령코드");
		cell.setCellStyle(style2);
		cell = curRow.createCell(1);
		cell.setCellValue("발령일자");
		cell.setCellStyle(style2);
		cell = curRow.createCell(2);
		cell.setCellValue("사번");
		cell.setCellStyle(style2);
		cell = curRow.createCell(3);
		cell.setCellValue("사원명");
		cell.setCellStyle(style2);
		cell = curRow.createCell(4);
		cell.setCellValue("발령구분명");
		cell.setCellStyle(style2);
		cell = curRow.createCell(5);
		cell.setCellValue("이전 직위/직급");
		cell.setCellStyle(style2);
		cell = curRow.createCell(6);
		cell.setCellValue("발령 직위/직급");
		cell.setCellStyle(style2);
		cell = curRow.createCell(7);
		cell.setCellValue("이전 부서");
		cell.setCellStyle(style2);
		cell = curRow.createCell(8);
		cell.setCellValue("발령 부서");
		cell.setCellStyle(style2);
		cell = curRow.createCell(9);
		cell.setCellValue("적요");
		cell.setCellStyle(style2);
		
		for(int i = 1; i <= row; i++) {
			OfficialOrderVO vo = gnfdList.get(i - 1);
			curRow = sheet.createRow(i);
			
			cell = curRow.createCell(0);
			cell.setCellValue(vo.getGnfdStdrde());
			cell.setCellStyle(style);
			cell = curRow.createCell(1);
			cell.setCellValue(vo.getGnfdDe());
			cell.setCellStyle(style);
			cell = curRow.createCell(2);
			cell.setCellValue(vo.getEmplNo());
			cell.setCellStyle(style);
			cell = curRow.createCell(3);
			cell.setCellValue(vo.getEmpl().getEmplNm());
			cell.setCellStyle(style);
			cell = curRow.createCell(4);
			cell.setCellValue(vo.getGnfd().getCtNm());
			cell.setCellStyle(style);
			cell = curRow.createCell(5);
			cell.setCellValue(vo.getGnfdBposition());
			cell.setCellStyle(style);
			cell = curRow.createCell(6);
			cell.setCellValue(vo.getPosition().getPstNm());
			cell.setCellStyle(style);
			cell = curRow.createCell(7);
			cell.setCellValue(vo.getDeptBnm());
			cell.setCellStyle(style);
			cell = curRow.createCell(8);
			cell.setCellValue(vo.getDept().getDeptNm());
			cell.setCellStyle(style);
			cell = curRow.createCell(9);
			cell.setCellValue(vo.getGnfdSumry());
			cell.setCellStyle(style);
		}
		Date today = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd-HH-mm",Locale.KOREA);
		String dTime = formatter.format(today);
		String localFile = "인사발령리스트" + dTime + ".xlsx";
		
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
