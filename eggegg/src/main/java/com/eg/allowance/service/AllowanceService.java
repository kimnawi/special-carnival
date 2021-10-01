package com.eg.allowance.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.vo.AllowanceVO;
import com.eg.vo.PagingVO;
import com.eg.vo.TaxFreeVO;

@Service
public interface AllowanceService {

	
	public List<AllowanceVO> retrieveAlList();
	
	public ServiceResult modifyAllowance(List<AllowanceVO> alList);
	
	public ServiceResult removeAllowance(String alCode);
	
	public ServiceResult stopAllowance(String alCode);
	
	public ServiceResult continueAllowance(String alCode);
	
	public List<TaxFreeVO> retrieveTaxFreeList(PagingVO<TaxFreeVO> pagingVO);
	
	public int retrieveTaxFreeCount(PagingVO<TaxFreeVO> pagingVO);
}
