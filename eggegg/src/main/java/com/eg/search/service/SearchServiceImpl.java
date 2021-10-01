package com.eg.search.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.eg.search.dao.SearchDAO;
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

@Service
public class SearchServiceImpl implements SearchService{

	@Inject
	private SearchDAO dao;
	
	@Override
	public void searchDeptList(PagingVO<DeptVO> pagingVO) {
		int totalRecord = dao.selectDeptTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<DeptVO> dataList = dao.selectDeptList(pagingVO);
		pagingVO.setDataList(dataList);
	}

	@Override
	public List<EntranceVO> searchEntranceList() {
		return dao.selectEntranceList();
	}
	
	@Override
	public void searchScheSortList(PagingVO<ScheSortVO> pagingVO) {
		int totalRecord = dao.selectScheSortTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ScheSortVO> dataList = dao.selectScheSortList(pagingVO);
		pagingVO.setDataList(dataList);
	}
 
	@Override
	public void searchProjectList(PagingVO<ProjectVO> pagingVO) {
		int totalRecord = dao.selectProjectTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ProjectVO> dataList = dao.selectProjectList(pagingVO);
		pagingVO.setDataList(dataList);
	}

	@Override
	public void searchPositionList(PagingVO<PositionVO> pagingVO) {
		List<PositionVO> dataList = dao.selectPositionList(pagingVO);
		pagingVO.setTotalRecord(8);
		pagingVO.setDataList(dataList);
	}

	@Override
	public void searchBankList(PagingVO<bankVO> pagingVO) {
		int totalRecord = dao.selectBankTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<bankVO> dataList = dao.selectBankList(pagingVO);
		pagingVO.setDataList(dataList);
	}

	@Override
	public void searchRolesList(PagingVO<RolesVO> pagingVO) {
		List<RolesVO> dataList = dao.selectRolesList(pagingVO);
		pagingVO.setTotalRecord(15);
		pagingVO.setDataList(dataList);
	}

	@Override
	public void searchEmplList(PagingVO<EmplVO> pagingVO) {
		int totalRecord = dao.selectEmplToTalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<EmplVO> dataList = dao.selectEmplList(pagingVO);
		pagingVO.setDataList(dataList);
	}

	@Override
	public void searchCommonTableList(PagingVO<CommonTableVO> pagingVO) {
		int totalRecord = dao.selectCommonTableTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<CommonTableVO> dataList = dao.selectCommonTableList(pagingVO);
		pagingVO.setDataList(dataList);
	}

	@Override
	public void searchMyLineList(PagingVO<LineBoxVO> pagingVO) {
		pagingVO.setDataList(dao.selectMyLineList(pagingVO));
	}
	
	@Override
	public LineBoxVO searchMyLine(Map<String,Object> param) {
		return dao.selectMyLine(param);
	}

	@Override
	public void searchVcatnList(PagingVO<VacationVO> pagingVO) {
		int totalRecord = dao.selectVcatnTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<VacationVO> dataList = dao.selectVcatnList(pagingVO);
		pagingVO.setDataList(dataList);
	}

}
