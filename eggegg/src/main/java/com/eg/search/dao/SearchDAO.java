package com.eg.search.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

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

@Mapper
public interface SearchDAO {

	/**
	 * 부서 총 레코드
	 * @param pagingVO
	 * @return
	 */
	public int selectDeptTotalRecord(PagingVO<DeptVO> pagingVO);
	
	/**
	 * 부서검색리스트
	 * @return
	 */
	public List<DeptVO> selectDeptList(PagingVO<DeptVO> pagingVO);
	
	/**
	 * 입사구분 검색 리스트
	 * @return
	 */
	public List<EntranceVO> selectEntranceList();
	
	public int selectScheSortTotalRecord(PagingVO<ScheSortVO> pagingVO);
	public List<ScheSortVO> selectScheSortList(PagingVO<ScheSortVO> pagingVO);
	
	/**
	 * 프로젝트 총 레코드 수
	 * @param pagingVO
	 * @return
	 */
	public int selectProjectTotalRecord(PagingVO<ProjectVO> pagingVO);
	
	/**
	 * 프로젝트 검색 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ProjectVO> selectProjectList(PagingVO<ProjectVO> pagingVO);
	
	/**
	 * 직위/직급 검색 리스트
	 * @return
	 */
	public List<PositionVO> selectPositionList(PagingVO<PositionVO> pagingVO);

	/**
	 * 직책(권한 검색 리스트)
	 * @param pagingVO
	 * @return
	 */
	public List<RolesVO> selectRolesList(PagingVO<RolesVO> pagingVO);
	
	/**
	 * 은행 총 레코드 수
	 * @param pagingVO
	 * @return
	 */
	public int selectBankTotalRecord(PagingVO<bankVO> pagingVO);
	
	/**
	 * 은행 검색 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<bankVO> selectBankList(PagingVO<bankVO> pagingVO);
	
	/**
	 * 사원 총 레코드 수
	 * @param pagingVO
	 * @return
	 */
	public int selectEmplToTalRecord(PagingVO<EmplVO> pagingVO);
	
	/**
	 * 사원 검색 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<EmplVO> selectEmplList(PagingVO<EmplVO> pagingVO);

	public int selectCommonTableTotalRecord(PagingVO<CommonTableVO> pagingVO);
	public List<CommonTableVO> selectCommonTableList(PagingVO<CommonTableVO> pagingVO);

	public List<LineBoxVO> selectMyLineList(int emplNo);
	
	/**
	 * 휴가코드 총 레코드 수
	 * @param pagingVO
	 * @return
	 */
	public int selectVcatnTotalRecord(PagingVO<VacationVO> pagingVO);
	
	/**
	 * 휴가코드 검색 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<VacationVO> selectVcatnList(PagingVO<VacationVO> pagingVO);

	public List<LineBoxVO> selectMyLineList(PagingVO<LineBoxVO> pagingVO);

	public LineBoxVO selectMyLine(Map<String, Object> param);
	
}
