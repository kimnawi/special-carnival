package com.eg.group.drive.service;

import com.eg.vo.HistoryVO;
import com.eg.vo.PagingVO;

public interface DriveService {

	public void retrieveHistoryList(PagingVO<HistoryVO> pagingVO);
	public int totalHistoryList(PagingVO<HistoryVO> pagingVO);
	public void createHist(HistoryVO histVO);
}
