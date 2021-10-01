package com.eg.group.schedule.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.PagingVO;
import com.eg.vo.ScheVO;

@Mapper
public interface ScheDAO {

	public int selectTotalRecord(PagingVO<ScheVO> pagingVO);
	
	public List<ScheVO> selectScheList(PagingVO<ScheVO> pagingVO);
	
	public ScheVO selectScheDetail(String scheNo);
	
	/**
	 * 메인화면 일정리스트
	 * @param emplNo
	 * @return
	 */
	public List<ScheVO> selectScheMain(int emplNo);
}
