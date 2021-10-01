package com.eg.hrd.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.vo.AttendeLvffcVO;
import com.eg.vo.PagingVO;

@Service
public interface HrdService {

	/**
	 * 일별 출/퇴인원 출력
	 * @param atvlMonth
	 * @return
	 */
	public List<AttendeLvffcVO> retrieveAtvlCntList(String atvlMonth);
	
	/**
	 * 출/퇴근 리스트 출력
	 * @param atvl
	 */
	public void retrieveAtvlList(PagingVO<AttendeLvffcVO> pagingVO);

	/**
	 * 큐알인증(출근)
	 * @param atvlEMpl
	 * @return
	 */
	public ServiceResult insertAttende(String atvlEmpl);
	
	/**
	 * 큐알인증(퇴근)
	 * @param atvlEmpl
	 * @return
	 */
	public ServiceResult updateLvffc(String atvlEmpl);
	
	/**
	 * 출/퇴근 현황
	 * @param pagingVO
	 */
	public void retrieveAtvlStatus(PagingVO<AttendeLvffcVO> pagingVO);
}
