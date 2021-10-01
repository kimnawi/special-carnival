package com.eg.dept.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.DeptVO;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;

@Mapper
public interface DeptDAO {

	public List<DeptVO> deptList(PagingVO<DeptVO> pagingVO);
	
	public int countDeptList(PagingVO<DeptVO> pagingVO);
	
	public int deleteDept(String deptCode);
	
	public int stopDept(String deptCode);
	
	public int continueDept(String deptCode);
	
	public List<DeptVO> deptListY(PagingVO<DeptVO> pagingVO);
	
	public int countDeptListY(PagingVO<DeptVO> pagingVO);
	
	public DeptVO selectDept(String deptCode);
	
	public int insertDept(DeptVO dept);
	
	public List<DeptVO> selectDeptList();
	
	/**
	 * 부서 팬시트리
	 * @return
	 */
	public List<DeptVO> selectDeptFancyList(Map<String, Object> map);
	
	/**
	 * 부서별 사원 레코드 수
	 * @param pagingVO
	 * @return
	 */
	public int selectDeptEmplTotalRecord(PagingVO<EmplVO> pagingVO);
	
	/**
	 * 부서별 사원리스트
	 * @param pagingVO
	 * @return
	 */
	public List<EmplVO> selectDeptEmplList(PagingVO<EmplVO> pagingVO);
	
	/**
	 * 부서장 지정
	 * @param dept
	 * @return
	 */
	public int updateDeptLeader(DeptVO dept);
	
	/**
	 * 부서 조직도
	 * @return
	 */
	public List<DeptVO> selectDeptOrganStatus();
}
