package com.eg.dept.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.vo.DeptVO;
import com.eg.vo.DeptWrapperVO;
import com.eg.vo.EmplFancyWrapperVO;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;

@Service
public interface DeptService {
	
	public List<DeptVO> retrieveDeptList(PagingVO<DeptVO> pagingVO);
	
	public int retrieveDeptCount(PagingVO<DeptVO> pagingVO);
	
	public ServiceResult removeDept(String deptCode);
	
	public ServiceResult stopDept(String deptCode);
	
	public ServiceResult continueDept(String deptCode);
	
	public List<DeptVO> retrieveDeptListY(PagingVO<DeptVO> pagingVO);
	
	public int retrieveDeptCountY(PagingVO<DeptVO> pagingVO);
	
	public DeptVO retrieveDept(String deptCode);
	
	public ServiceResult createDept(DeptVO dept);
	
	public List<DeptVO> retrieveDept();
	
	/**
	 * 부서 팬시트리
	 * @param map
	 * @return
	 */
	public List<DeptWrapperVO> retrieveDeptFancyList(Map<String, Object> map);
	
	/**
	 * 부서별 사원리스트
	 * @param pagingVO
	 */
	public void retrieveDeptEmplList(PagingVO<EmplVO> pagingVO);
	
	/**
	 * 부서장 지정
	 * @param dept
	 * @return
	 */
	public ServiceResult updateDeptLeader(DeptVO dept);

	/**
	 * 부서에 속해있는 사원 팬시트리
	 * @param pagingVO
	 */
	void retrieveEmplFancyList(PagingVO<EmplFancyWrapperVO> pagingVO);
}
