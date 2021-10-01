package com.eg.group.schedule.service;

import org.springframework.stereotype.Service;

import com.eg.vo.PagingVO;
import com.eg.vo.ScheVO;

@Service
public interface ScheService {
	
	public void retrieveScheList(PagingVO<ScheVO> pagingVO);
	
	public ScheVO retrieveSche(String scheNo);
}
