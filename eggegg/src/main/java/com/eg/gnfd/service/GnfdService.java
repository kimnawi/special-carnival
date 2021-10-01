package com.eg.gnfd.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.vo.OfficialOrderVO;
import com.eg.vo.PagingVO;
import com.eg.vo.gnfdListVO;

@Service
public interface GnfdService {

	/**
	 * 인사발령리스트
	 * @param pagingVO
	 */
	public void retrieveGnfdList(PagingVO<OfficialOrderVO> pagingVO);
	
	/**
	 * 인사발령정보 수정
	 * @param gnfd
	 * @return
	 */
	public ServiceResult modifyGnfd(OfficialOrderVO gnfd);
	
	/**
	 * 인사발령정보 삭제
	 * @param gnfdStdrde
	 * @return
	 */
	public ServiceResult removeGnfd(String gnfdStdrde);
	
	/**
	 * 인사발령 등록
	 * @param gnfd
	 * @return
	 */
	public ServiceResult createGnfd(gnfdListVO gnfdList);
	
	/**
	 * 기안서번호 입력
	 * @param paramMap
	 * @return
	 */
	public ServiceResult modifyDraftNo(Map<String, Object> paramMap);
	
	/**
	 * 인사발령현황
	 * @param pagingVO
	 */
	public void retrieveGnfdStatus(PagingVO<OfficialOrderVO> pagingVO);
}
