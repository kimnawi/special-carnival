package com.eg.work.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.vo.PagingVO;
import com.eg.vo.WorkVO;

@Service
public interface WorkService {

	/**
	 * 근무 추가
	 * @param list
	 * @return
	 */
	public ServiceResult createWork(List<WorkVO> list);
	
	public int retrieveListCount(PagingVO<WorkVO> pagingVO);
	
	public void retreiveWorkList(PagingVO<WorkVO> pagingVO);
	
	
	public List<WorkVO> popWorkList(String stdate);
	
	public List<WorkVO> searchWorkList(WorkVO vo);
	
	public ServiceResult modifyWorkList(WorkVO vo);
	
	public ServiceResult removeWork(String stdate);
}


