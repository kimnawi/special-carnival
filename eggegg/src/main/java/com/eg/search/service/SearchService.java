package com.eg.search.service;

import java.util.List;
import java.util.Map;

import com.eg.vo.CommonTableVO;
import com.eg.vo.DeptVO;
import com.eg.vo.EmplVO;
import com.eg.vo.EntranceVO;
import com.eg.vo.LineBoxVO;
import com.eg.vo.PagingVO;
import com.eg.vo.PositionVO;
import com.eg.vo.ProjectVO;
import com.eg.vo.RolesVO;
import com.eg.vo.ScheSortVO;
import com.eg.vo.VacationVO;
import com.eg.vo.bankVO;

public interface SearchService {

	/**
	 * 부서 검색 리스트
	 * @param pagingVO
	 */
	public void searchDeptList(PagingVO<DeptVO> pagingVO);
	
	/**
	 * 입사구분 검색 리스트
	 * @return
	 */
	public List<EntranceVO> searchEntranceList(); 
	
	public void searchScheSortList(PagingVO<ScheSortVO> pagingVO);
	
	/**
	 * 프로젝트 검색 리스트
	 * @param pagingVO
	 */
	public void searchProjectList(PagingVO<ProjectVO> pagingVO);
	
	/**
	 * 직위/직급 검색 리스트
	 * @return
	 */
	public void searchPositionList(PagingVO<PositionVO> pagingVO);

	/**
	 * 직책(권한) 검색 리스트
	 * @param pagingVO
	 */
	public void searchRolesList(PagingVO<RolesVO> pagingVO);
	
	/**
	 * 은행 검색 리스트
	 * @param pagingVO
	 */
	public void searchBankList(PagingVO<bankVO> pagingVO);
	
	/**
	 * 사원 검색 리스트
	 * @param pagingVO
	 */
	public void searchEmplList(PagingVO<EmplVO> pagingVO);

	/**
	 * 공통 테이블 검색 리스트
	 * @param pagingVO
	 */
	public void searchCommonTableList(PagingVO<CommonTableVO> pagingVO);


	public void searchMyLineList(PagingVO<LineBoxVO> pagingVO);
	public LineBoxVO searchMyLine(Map<String,Object> param);

	
	/**
	 * 휴가코드 검색 리스트
	 * @param pagingVO
	 */
	public void searchVcatnList(PagingVO<VacationVO> pagingVO);
	
}
