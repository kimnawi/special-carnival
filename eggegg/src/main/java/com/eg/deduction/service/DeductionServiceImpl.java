package com.eg.deduction.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eg.commons.ServiceResult;
import com.eg.deduction.dao.DeductionDAO;
import com.eg.vo.DeductionVO;
@Service
public class DeductionServiceImpl implements DeductionService {
	@Inject
	private DeductionDAO deDAO;
	
	@Override
	public List<DeductionVO> retrieveDeList() {
		return deDAO.selectDeList();
	}
	@Transactional
	@Override
	public ServiceResult modifyDeduction(List<DeductionVO> deList) {
		ServiceResult result = null;
		int rowcnt = 0; 
		for(int i = 0; i<deList.size();i++) {
			rowcnt += deDAO.updateDeList(deList.get(i));
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
	public ServiceResult removeDeduction(String deCode) {
		ServiceResult result = null;
		
		int rowcnt = deDAO.deleteDeduction(deCode);
		
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	@Transactional
	@Override
	public ServiceResult stopDeduction(String deCode) {
		ServiceResult result = null;
		
		int rowcnt = deDAO.stopDeduction(deCode);
		
		if(rowcnt >0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

	@Override
	public ServiceResult continueDeduction(String deCode) {
		ServiceResult result = null;
		
		int rowcnt = deDAO.continueDeduction(deCode);
		
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

}
