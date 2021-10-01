package com.eg.sal.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.vo.PagingVO;
import com.eg.vo.PayInfoVO;
import com.eg.vo.WorkHistoryVO;

import oracle.security.crypto.core.SREntropySource;

@Service
public interface SalService {

	public ServiceResult createSalary(PayInfoVO vo);
	
	public int retrieveSalCount(PagingVO<PayInfoVO> pagingVO);
	
	public void retrieveSalList(PagingVO<PayInfoVO> pagingVO);
	
	
	public ServiceResult modifySalary(PayInfoVO vo);
	
	public ServiceResult confirmWork(WorkHistoryVO vo);
	
	public ServiceResult calculate(String stDate);
	
}
