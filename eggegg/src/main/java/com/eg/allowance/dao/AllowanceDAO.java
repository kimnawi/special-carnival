package com.eg.allowance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.AllowanceVO;
import com.eg.vo.PagingVO;
import com.eg.vo.TaxFreeVO;

@Mapper
public interface AllowanceDAO {
 
	public List<AllowanceVO> selectAlList();
	
	public int updateAlList(AllowanceVO vo);
	
	public int deleteAllowance(String alCode);
	
	public int stopAllowance(String alCode);
	
	public int continueAllowance(String alCode);
	
	
	public List<TaxFreeVO> selectTaxFreeList(PagingVO<TaxFreeVO> pagingVO);
	
	public int countTaxFreeList(PagingVO<TaxFreeVO> pagingVO);
}
