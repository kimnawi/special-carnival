package com.eg.work.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.AllowanceVO;
import com.eg.vo.AutoAllowVO;
import com.eg.vo.PagingVO;
import com.eg.vo.ProjectVO;
import com.eg.vo.WorkVO;

@Mapper
public interface WorkDAO {
	/**
	 * 팝업 수당리스트
	 * @return
	 */
	public List<AllowanceVO> alList();
	
	/**
	 * 팝업 프로젝트리스트
	 * @return
	 */
	public List<ProjectVO> projectList();
	
	/**
	 * 
	 * @return
	 */
	public List<AutoAllowVO> list(AutoAllowVO vo);
	
	
	/**
	 * 반차 여부
	 * @param vo
	 * @return
	 */
	public List<AutoAllowVO> pto(AutoAllowVO vo);
	
	
	public int insertWork(WorkVO work);
	
	
	public int countWorkList(PagingVO<WorkVO> pagingVO);
	
	public List<WorkVO> workList(PagingVO<WorkVO> pagingVO);
	
	public List<WorkVO> popWorkList(String stdate);
	
	public List<WorkVO> searchWorkList(WorkVO vo);
	
	public int deleteWork(WorkVO vo);
	
	public int deleteworkList(String stdate);
}
