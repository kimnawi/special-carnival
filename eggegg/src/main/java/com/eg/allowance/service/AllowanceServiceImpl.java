package com.eg.allowance.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eg.allowance.dao.AllowanceDAO;
import com.eg.commons.ServiceResult;
import com.eg.vo.AllowanceVO;
import com.eg.vo.PagingVO;
import com.eg.vo.TaxFreeVO;
@Service
public class AllowanceServiceImpl implements AllowanceService {
	
	@Inject
	private AllowanceDAO AlDAO;
		
	@Override
	public List<AllowanceVO> retrieveAlList() {
		return AlDAO.selectAlList();
	}
	@Transactional
	@Override
	public ServiceResult modifyAllowance(List<AllowanceVO> alList) {
		ServiceResult result = null;
		int rowcnt = 0;
		for(int i = 0; i<alList.size();i++) {
			rowcnt += AlDAO.updateAlList(alList.get(i));
		}
		
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult removeAllowance(String alCode) {
		ServiceResult result = null;
		
		int rowcnt = AlDAO.deleteAllowance(alCode);
		
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult stopAllowance(String alCode) {
		ServiceResult result = null;
		
		int rowcnt = AlDAO.stopAllowance(alCode);
		
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	@Transactional
	@Override
	public ServiceResult continueAllowance(String alCode) {
		ServiceResult result = null;
		
		int rowcnt = AlDAO.continueAllowance(alCode);
		
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	@Override
	public List<TaxFreeVO> retrieveTaxFreeList(PagingVO<TaxFreeVO> pagingVO) {
		int total = AlDAO.countTaxFreeList(pagingVO);
		pagingVO.setTotalRecord(total);
		List<TaxFreeVO> dataList = AlDAO.selectTaxFreeList(pagingVO);
		pagingVO.setDataList(dataList);
		return dataList;
	}
	@Override
	public int retrieveTaxFreeCount(PagingVO<TaxFreeVO> pagingVO) {
		return AlDAO.countTaxFreeList(pagingVO);
	}

}
