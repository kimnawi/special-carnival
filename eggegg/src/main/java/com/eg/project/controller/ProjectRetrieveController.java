package com.eg.project.controller;

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
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.MediaType;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.project.service.ProjectService;
import com.eg.vo.PagingVO;
import com.eg.vo.ProjectVO;

@Controller
public class ProjectRetrieveController {
	
	@Inject
	private ProjectService service;
	
	@RequestMapping(value="/empl/createCode.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ProjectVO createCode() {
		String code = service.createCode();
		ProjectVO vo = new ProjectVO();
		vo.setPrjCode(code);
		return vo;
	}
	
	@RequestMapping(value="/empl/selectProject.do" ,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ProjectVO selectProject(
		@RequestParam(value="prjCode") String prjCode	
		) {
		ProjectVO project = new ProjectVO();
		project = service.retrieveProject(prjCode);
		
		return project;
	}
	
	@RequestMapping(value="/empl/selectProjectList.do" ,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ProjectVO> selectProject(
	) {
		List<ProjectVO> project = service.retrieveJsonProject();
		return project;
	}
	
	
	@RequestMapping("/empl/projectList.do")
	public String projectList(
			Model model,
		@RequestParam(value="use", required=false,defaultValue= "yes") String use 
	) {
		model.addAttribute("use",use);
		model.addAttribute("selectedMenu", "ResistProject");
		return "project/projectList";
	}
	
	@RequestMapping(value="/empl/projectList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<ProjectVO> listforAjax(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
			@ModelAttribute("detailSearch") ProjectVO detailSearch
	){
		PagingVO<ProjectVO> pagingVO = new PagingVO<>(15,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveProjectList(pagingVO);
		
		return pagingVO;
	}
	
	@RequestMapping("/empl/projectListY.do")
	public String projectListY(
			Model model,
			@RequestParam(value="use", required=false,defaultValue= "yes") String use 
			) {
		model.addAttribute("use",use);
		return "project/projectList";
	}
	
	@RequestMapping(value="/empl/projectListY.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<ProjectVO> listforAjaxY(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
			@ModelAttribute("detailSearch") ProjectVO detailSearch
			){
		PagingVO<ProjectVO> pagingVO = new PagingVO<>(15,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retrieveProjectListY(pagingVO);
		
		return pagingVO;
	}
	
	@ResponseBody
	@RequestMapping(value="/empl/excelProject.do")
	public void excel(
		HttpServletResponse resp
	) throws IOException {
		//새 엑셀 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		//새 시트 생성
		XSSFSheet sheet = workbook.createSheet("프로젝트");
		
		CellStyle style =  workbook.createCellStyle();
		style.setBorderBottom(BorderStyle.THIN);
		style.setBorderRight(BorderStyle.THIN);
		style.setBorderTop(BorderStyle.THIN);
		style.setBorderLeft(BorderStyle.THIN);
		
		List<ProjectVO> list = service.retrieveJsonProject();
		
		XSSFRow curRow;
		
		int row = list.size();
		Cell cell = null;
		
		curRow = sheet.createRow(0);
		cell = curRow.createCell(0);
		cell.setCellValue("프로젝트코드");
		cell.setCellStyle(style);
		
		cell = curRow.createCell(1);
		cell.setCellValue("프로젝트명");
		cell.setCellStyle(style);

		cell = curRow.createCell(2);
		cell.setCellValue("프로젝트기간");
		cell.setCellStyle(style);

		cell = curRow.createCell(3);
		cell.setCellValue("적요");
		cell.setCellStyle(style);
		
		cell = curRow.createCell(4);
		cell.setCellValue("사용구분");
		cell.setCellStyle(style);
		
		for(int i=1;i<=row;i++) {
			ProjectVO vo = list.get(i-1);
			curRow = sheet.createRow(i);
			cell = curRow.createCell(0);
			cell.setCellValue(vo.getPrjCode());
			cell.setCellStyle(style);
			
			cell = curRow.createCell(1);
			cell.setCellValue(vo.getPrjNm());
			cell.setCellStyle(style);
			
			cell = curRow.createCell(2);
			cell.setCellValue(vo.getPrjPeriod());
			cell.setCellStyle(style);
			
			cell = curRow.createCell(3);
			cell.setCellValue(vo.getPrjSumry());
			cell.setCellStyle(style);
			
			cell = curRow.createCell(4);
			cell.setCellValue(vo.getPrjUse());
			cell.setCellStyle(style);
		}
		Date today = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd-HH-mm",Locale.KOREA);
		String dTime = formatter.format(today);
		String localFile = "프로젝트리스트"+dTime+".xlsx";
		
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
