package com.eg.group.drive.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.HistoryVO;
import com.eg.vo.PagingVO;

@Mapper
public interface DriveDAO {

	
	public int selectTotalHistory(PagingVO<HistoryVO> pagingVO);
	public List<HistoryVO> selectHistoryList(PagingVO<HistoryVO> pagingVO);
	public int insertHistory(HistoryVO history);
	
}
