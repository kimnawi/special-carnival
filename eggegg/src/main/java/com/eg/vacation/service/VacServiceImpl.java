package com.eg.vacation.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.eg.commons.ServiceResult;
import com.eg.vacation.dao.VacDAO;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;
import com.eg.vo.VacHistoryVO;
import com.eg.vo.VacStatusVO;
import com.eg.vo.VacationVO;

@Service(value="com.eg.vacation.service.VacService")
public class VacServiceImpl implements VacService {

	@Inject
	private VacDAO dao;
	
	@Override
	public void retrieveVcatnList(PagingVO<VacationVO> pagingVO) {
		int totalRecord = dao.selectTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<VacationVO> dataList = dao.selectVacationList(pagingVO);
		pagingVO.setDataList(dataList);
	}

	@Override
	public List<EmplVO> retrieveVacEmplList(String vcatnCode) {
		return dao.selectVacDayList(vcatnCode);
	}

	@Transactional
	@Override
	public ServiceResult modifyEmplVac(VacHistoryVO vacHistory) {
		ServiceResult result = null;
		if(vacHistory.getEmplNo() != null && vacHistory.getVcatnCode() != null) {
			int rowcnt = dao.insertEmplVac(vacHistory);
			if(rowcnt > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAIL;
			}
			return result;
			
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Transactional
	@Override
	public ServiceResult deleteEmplVac(Map<String, Object> vacEmpl) {
		ServiceResult result = null;
		String[] vcatnCodeArray = vacEmpl.get("vcatnCode").toString().split(",");
		String[] emplNoArray = vacEmpl.get("emplNo").toString().split(",");
		int rowcnt = 0;
		for(int i = 0; i < emplNoArray.length; i++) {
			if(emplNoArray[i].length() > 0 && emplNoArray[i] != null) {
				VacHistoryVO vacHistory = new VacHistoryVO();
				vacHistory.setVcatnCode(vcatnCodeArray[i]);
				vacHistory.setEmplNo(Integer.parseInt(emplNoArray[i]));
				rowcnt += dao.deleteEmplVac(vacHistory);
			}
		}
		
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public List<VacHistoryVO> retrieveVacCalc(Map<String, Object> vacEmpl) {
		String[] vcatnCodeArray = vacEmpl.get("vcatnCode").toString().split(",");
		String[] emplNoArray = vacEmpl.get("emplNo").toString().split(",");
		VacHistoryVO vacHistory = new VacHistoryVO();
		vacHistory.setVcatnCodeArray(vcatnCodeArray);
		vacHistory.setEmplNoArray(emplNoArray);
		
		List<VacHistoryVO> vacHistoryList = dao.selectVacCalc(vacHistory);
		
		return vacHistoryList;
	}

	@Override
	public void retrieveVacApplyList(PagingVO<VacStatusVO> pagingVO) {
		int totalRecord = dao.selectVacApplyTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<VacStatusVO> dataList = dao.selectVacApplyList(pagingVO);
		pagingVO.setDataList(dataList);
	}

	@Override
	public List<Map<String, Object>> uploadExcel(MultipartFile excelFile) {
		List<Map<String, Object>> emplList = new ArrayList<>();
		try {
			OPCPackage opcPackage = OPCPackage.open(excelFile.getInputStream());
			XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
			
			XSSFSheet sheet = workbook.getSheetAt(0);
			
			for(int i = 1; i < sheet.getLastRowNum() + 1; i++) {
				Map<String, Object> empl = new HashMap<>();
				XSSFRow row = sheet.getRow(i);
				
				if(null == row) {
					continue;
				}
				//사번
				XSSFCell cell = row.getCell(0);
				if(null != cell) {
					empl.put("emplNo", (int) cell.getNumericCellValue());
				}
				//사원명
				cell = row.getCell(1);
				if(null != cell) {
					empl.put("emplNm", cell.getStringCellValue());
				}
				//부서명
				cell = row.getCell(2);
				if(null != cell) {
					empl.put("deptNm", cell.getStringCellValue());
				}
				//직위/직급명
				cell = row.getCell(3);
				if(null != cell) {
					empl.put("pstNm", cell.getStringCellValue());
				}
				//입사일자
				cell = row.getCell(4);
				if(null != cell) {
					empl.put("emplEcny", cell.getStringCellValue().replace('/', '-'));
				}
				emplList.add(empl);
			}
			workbook.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return emplList;
	}

	@Transactional
	@Override
	public ServiceResult createVacApply(VacStatusVO vacStus) {
		ServiceResult result = null;
		String vacstusCode = vacStus.getVacstusCode();
		String[] vacstusDeArray = vacStus.getVacstusDeArray();
		int emplNo = vacStus.getEmplNo();
		String vacstusSumry = vacStus.getVacstusSumry();
		String vacstusHalfAt = vacStus.getVacstusHalfAt();
		int rowcnt = 0;
		for(int i = 0; i < vacstusDeArray.length; i++) {
			vacStus.setVacstusCode(vacstusCode);
			vacStus.setVacstusDe(vacstusDeArray[i]);
			vacStus.setEmplNo(emplNo);
			vacStus.setVacstusSumry(vacstusSumry);
			vacStus.setVacstusHalfAt(vacstusHalfAt);
			rowcnt += dao.insertVacStatus(vacStus);
		}
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult removeVacApply(VacStatusVO vacStus) {
		ServiceResult result = null;
		int rowcnt = dao.deleteVacStatus(vacStus);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult modifyVacApply(VacStatusVO vacStus) {
		System.out.println("--------------------VacServiceImpl----------------------------\n" + vacStus);
		ServiceResult result = null;
		int rowcnt = dao.deleteVacStatus(vacStus);
		if(rowcnt > 0) {
			String vacstusCode = vacStus.getVacstusCode();
			String[] vacstusDeArray = vacStus.getVacstusDeArray();
			int emplNo = vacStus.getEmplNo();
			String vacstusSumry = vacStus.getVacstusSumry();
			String vacstusHalfAt = vacStus.getVacstusHalfAt();
			for(int i = 0; i < vacstusDeArray.length; i++) {
				vacStus.setVacstusCode(vacstusCode);
				vacStus.setVacstusDe(vacstusDeArray[i]);
				vacStus.setEmplNo(emplNo);
				vacStus.setVacstusSumry(vacstusSumry);
				vacStus.setVacstusHalfAt(vacstusHalfAt);
				rowcnt += dao.insertVacStatus(vacStus);
			}
			if(rowcnt > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAIL;
			}
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public void retrieveVacStusList(PagingVO<VacStatusVO> pagingVO) {
		int totalRecord = dao.selectVacStusTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<VacStatusVO> dataList = dao.selectVacStusList(pagingVO);
		pagingVO.setDataList(dataList);
	}

	@Transactional
	@Override
	public ServiceResult modifyDraftNo(Map<String, Object> paramMap) {
		ServiceResult result = ServiceResult.FAIL;
		int rowcnt = dao.updateDraftNo(paramMap);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public void reflectionTest() {
		System.out.println("떠라");
	}

	
	@Override
	public void retrieveVacStatus(PagingVO<VacStatusVO> pagingVO) {
		List<VacStatusVO> dataList = dao.selectVacStatus(pagingVO);
		pagingVO.setDataList(dataList);
	}

}
