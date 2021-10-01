package com.eg.adgroup.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.AdGroupAllVO;
import com.eg.vo.AdGroupVO;
import com.eg.vo.AllowanceVO;
import com.eg.vo.DeductionVO;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;

@Mapper
public interface AdGroupDAO {
	
	public int countGroupList(PagingVO<AdGroupVO> pagingVO);
	
	public List<AdGroupVO> groupList(PagingVO<AdGroupVO> pagingVO);
	
	public List<AdGroupVO> selectGroupList();
	
	public String selectNextCode();
	
	public List<AllowanceVO> alList();
	
	public List<DeductionVO> deList();
	
	public int insertAdGroup(AdGroupAllVO vo);
	
	public int insertAlGroup(AdGroupAllVO vo);

	public int insertDeGroup(AdGroupAllVO vo);
	
	public List<AdGroupAllVO> selectAlGroup(String code);
	
	public List<AdGroupAllVO> selectDeGroup(String code);
	
	public int countAl(String code);
	
	public int countDe(String code);
	
	public AdGroupAllVO selectAdGroup(String code);
	
	public int deleteGroup(String code);
	
	public int updateGroup(AdGroupAllVO group);
	
	public int updateAdGroup(AdGroupAllVO vo);
	
	public int updateDeGroup(AdGroupAllVO vo);
	
	public int updateAlGroup(AdGroupAllVO vo);
	
	public List<EmplVO> selectGroup(String code);
	
	public int deleteAlGroup(String code);
	public int deleteDeGroup(String code);
	
	public int updateempl(String code);
	
	public int updateEmplAdg(EmplVO vo);
	
	public int deleteEmplAdg(EmplVO vo);
	
}
