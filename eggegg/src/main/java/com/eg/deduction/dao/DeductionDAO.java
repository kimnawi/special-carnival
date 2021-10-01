package com.eg.deduction.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.DeductionVO;

@Mapper
public interface DeductionDAO {

	public List<DeductionVO> selectDeList();
	
	public int updateDeList(DeductionVO vo);
	
	public int deleteDeduction(String deCode);
	
	public int stopDeduction(String deCode);
	
	public int continueDeduction(String deCode);
	
	
}
