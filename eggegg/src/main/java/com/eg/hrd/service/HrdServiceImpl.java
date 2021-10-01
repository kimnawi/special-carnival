package com.eg.hrd.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eg.commons.ServiceResult;
import com.eg.hrd.dao.HrdDAO;
import com.eg.vo.AttendeLvffcVO;
import com.eg.vo.PagingVO;

@Service
public class HrdServiceImpl implements HrdService {

	@Inject
	private HrdDAO dao;
	
	@Override
	public List<AttendeLvffcVO> retrieveAtvlCntList(String atvlMonth) {
		List<AttendeLvffcVO> atvlCntList = dao.selectAttendeLvffcCntList(atvlMonth); 
		return atvlCntList;
	}

	@Override
	public void retrieveAtvlList(PagingVO<AttendeLvffcVO> pagingVO) {
		int totalRecord = dao.selectAtvlTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<AttendeLvffcVO> dataList = dao.selectAttendeLvffcList(pagingVO);
		pagingVO.setDataList(dataList);
	}

	@Transactional
	@Override
	public ServiceResult insertAttende(String atvlEmpl) {
		ServiceResult result = null;
		int rowcnt = dao.insertAttende(atvlEmpl);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Transactional
	@Override
	public ServiceResult updateLvffc(String atvlEmpl) {
		ServiceResult result = null;
		int rowcnt = dao.updateLvffc(atvlEmpl);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public void retrieveAtvlStatus(PagingVO<AttendeLvffcVO> pagingVO) {
		List<AttendeLvffcVO> dataList = dao.selectHrdStatus(pagingVO);
		pagingVO.setDataList(dataList);
	}

}
