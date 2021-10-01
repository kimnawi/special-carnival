package com.eg.vacation.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.eg.commons.ServiceResult;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;
import com.eg.vo.VacHistoryVO;
import com.eg.vo.VacStatusVO;
import com.eg.vo.VacationVO;

@Service
public interface VacService {

	/**
	 * 휴가리스트
	 * @param pagingVO
	 */
	public void retrieveVcatnList(PagingVO<VacationVO> pagingVO);
	
	/**
	 * 휴가코드별 사원 리스트 & 사원별 휴가일수
	 * @param vcatnCode
	 * @return
	 */
	public List<EmplVO> retrieveVacEmplList(String vcatnCode);
	
	/**
	 * 사원별 휴가일수 등록 및 수정
	 * @param empl
	 * @return
	 */
	public ServiceResult modifyEmplVac(VacHistoryVO vacHistory);
	
	/**
	 * 사원별 휴가일수 삭제
	 * @param empl
	 * @return
	 */
	public ServiceResult deleteEmplVac(Map<String, Object> vacEmpl);
	
	/**
	 * 사원별휴가일수 계산
	 * @param vacHistory
	 * @return
	 */
	public List<VacHistoryVO> retrieveVacCalc(Map<String, Object> vacEmpl);
	
	/**
	 * 휴가신청이력 조회
	 * @param pagingVO
	 */
	public void retrieveVacApplyList(PagingVO<VacStatusVO> pagingVO);
	
	/**
	 * 사원리스트 엑셀 파일 업로드
	 * @param excelfile
	 * @return
	 */
	public List<Map<String, Object>> uploadExcel(MultipartFile excelFile);

	/**
	 * 휴가 신청
	 * @param vacStus
	 * @return
	 */
	public ServiceResult createVacApply(VacStatusVO vacStus);
	
	/**
	 * 휴가신청 삭제
	 * @param vacStus
	 * @return
	 */
	public ServiceResult removeVacApply(VacStatusVO vacStus);
	
	/**
	 * 휴가신청정보 수정
	 * @param vacStus
	 * @return
	 */
	public ServiceResult modifyVacApply(VacStatusVO vacStus);
	
	/**
	 * 휴가조회리스트 출력
	 * @param pagingVO
	 */
	public void retrieveVacStusList(PagingVO<VacStatusVO> pagingVO);
	
	/**
	 * 휴가신청 기안서번호 입력
	 * @param paramMap
	 * @return
	 */
	public ServiceResult modifyDraftNo(Map<String, Object> paramMap);

	public void reflectionTest();
	
	/**
	 * 휴가현황
	 * @param pagingVO
	 * @return
	 */
	public void retrieveVacStatus(PagingVO<VacStatusVO> pagingVO);
}
