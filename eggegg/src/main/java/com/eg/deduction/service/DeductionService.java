package com.eg.deduction.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.vo.AllowanceVO;
import com.eg.vo.DeductionVO;


@Service
public interface DeductionService {

	
	public List<DeductionVO> retrieveDeList();
	
	public ServiceResult modifyDeduction(List<DeductionVO> deList);
	
	public ServiceResult removeDeduction(String deCode);
	
	public ServiceResult stopDeduction(String deCode);
	
	public ServiceResult continueDeduction(String deCode);
}
