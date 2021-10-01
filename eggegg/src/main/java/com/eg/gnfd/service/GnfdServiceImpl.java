package com.eg.gnfd.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eg.commons.ServiceResult;
import com.eg.gnfd.dao.GnfdDAO;
import com.eg.vo.OfficialOrderVO;
import com.eg.vo.PagingVO;
import com.eg.vo.gnfdListVO;

@Service(value="com.eg.gnfd.service.GnfdService")
public class GnfdServiceImpl implements GnfdService {

	@Inject
	private GnfdDAO dao;
	
	@Override
	public void retrieveGnfdList(PagingVO<OfficialOrderVO> pagingVO) {
		int totalRecord = dao.selectGnfdTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<OfficialOrderVO> dataList = dao.selectGnfdList(pagingVO);
		pagingVO.setDataList(dataList);
		
	}

	@Transactional
	@Override
	public ServiceResult modifyGnfd(OfficialOrderVO gnfd) {
		ServiceResult result = null;
		int rowcnt = dao.updateGnfd(gnfd);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Transactional
	@Override
	public ServiceResult removeGnfd(String gnfdStdrde) {
		ServiceResult result = null;
		int rowcnt = dao.deleteGnfd(gnfdStdrde);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Transactional
	@Override
	public ServiceResult createGnfd(gnfdListVO gnfdList) {
		ServiceResult result = null;
		int rowcnt = 0;
		OfficialOrderVO[] gnfd = gnfdList.getGnfd();
		for(int i = 0; i < gnfdList.getGnfd().length; i++) {
			rowcnt += dao.insertGnfd(gnfd[i]);
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
	public ServiceResult modifyDraftNo(Map<String, Object> paramMap) {
		ServiceResult result = ServiceResult.FAIL;
		int rowcnt = dao.updateDraftNo(paramMap);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public void retrieveGnfdStatus(PagingVO<OfficialOrderVO> pagingVO) {
		List<OfficialOrderVO> dataList = dao.selectGnfdStatus(pagingVO);
		pagingVO.setDataList(dataList);
		int totalRecord = dataList.size();
		pagingVO.setTotalRecord(totalRecord);
	}

}
