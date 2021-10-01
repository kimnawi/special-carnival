package com.eg.adgroup.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.vo.AdGroupAllVO;
import com.eg.vo.AdGroupVO;
import com.eg.vo.PagingVO;

@Service
public interface AdGroupService {

	public int retrieveGroupCount(PagingVO<AdGroupVO> pagingVO);
	
	public List<AdGroupVO> retrieveGroupList(PagingVO<AdGroupVO> pagingVO);
	
	public List<AdGroupVO> retrieveGroupList();
	
	public ServiceResult createAdGroup(AdGroupAllVO vo);
	
	public List<AdGroupAllVO> selectAlGroup(String code);
	
	public List<AdGroupAllVO> selectDeGroup(String code);
	
	public AdGroupAllVO retrieveAdGroup(String code);
	
	public ServiceResult removeGroup(String code);
	
	public ServiceResult modifyGroup(AdGroupAllVO group);
	
	public ServiceResult modifyEmpl(AdGroupAllVO vo);
}
