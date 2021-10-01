package com.eg.dept.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eg.commons.ServiceResult;
import com.eg.commons.exception.DataNotFoundException;
import com.eg.dept.dao.DeptDAO;
import com.eg.empl.dao.EmplDAO;
import com.eg.vo.DeptVO;
import com.eg.vo.DeptWrapperVO;
import com.eg.vo.EmplFancyWrapperVO;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;

@Service
public class DeptServiceImpl implements DeptService {
	@Inject
	private DeptDAO DAO;
	@Inject
	private EmplDAO emplDao;
	
	@Override
	public List<DeptVO> retrieveDeptList(PagingVO<DeptVO> pagingVO) {
		int total = DAO.countDeptList(pagingVO);
		pagingVO.setTotalRecord(total);
		List<DeptVO> dataList = DAO.deptList(pagingVO);
		pagingVO.setDataList(dataList);
		return dataList;
	}

	@Override
	public int retrieveDeptCount(PagingVO<DeptVO> pagingVO) {
		return DAO.countDeptList(pagingVO);
	}
	
	@Transactional
	@Override
	public ServiceResult removeDept(String deptCode) {
		ServiceResult result = null;
		
		int rowcnt = DAO.deleteDept(deptCode);
		
		if(rowcnt > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult stopDept(String deptCode) {
		ServiceResult result = null;
		
		int rowcnt = DAO.stopDept(deptCode);
		
		if(rowcnt > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult continueDept(String deptCode) {
		ServiceResult result = null;
		
		int rowcnt = DAO.continueDept(deptCode);
		
		if(rowcnt > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public List<DeptVO> retrieveDeptListY(PagingVO<DeptVO> pagingVO) {
		int total = DAO.countDeptListY(pagingVO);
		pagingVO.setTotalRecord(total);
		List<DeptVO> dataList = DAO.deptListY(pagingVO);
		pagingVO.setDataList(dataList);
		return dataList;
	}

	@Override
	public int retrieveDeptCountY(PagingVO<DeptVO> pagingVO) {
		return DAO.countDeptListY(pagingVO);
	}

	@Override
	public DeptVO retrieveDept(String deptCode) {
		DeptVO dept = DAO.selectDept(deptCode);
		if(dept == null) throw new DataNotFoundException(deptCode +"");
		return dept;
	}
	@Transactional
	@Override
	public ServiceResult createDept(DeptVO dept) {
		ServiceResult result = ServiceResult.FAIL;
		int rowcnt = DAO.insertDept(dept);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	
	@Override
	public List<DeptVO> retrieveDept() {
		return DAO.selectDeptList();
	}

	@Override
	public List<DeptWrapperVO> retrieveDeptFancyList(Map<String, Object> map) {
		List<DeptVO> deptList = DAO.selectDeptFancyList(map);
		List<DeptWrapperVO> deptWrapperList = new ArrayList<>();
		if((map.get("forAuthl") != null) && (Boolean)map.get("forAuthl")) {
			deptList.forEach((dept)->{ 
				dept.setLeaf(false);
				deptWrapperList.add(new DeptWrapperVO(dept)); });
		}else {
			deptList.forEach((dept)->{ deptWrapperList.add(new DeptWrapperVO(dept)); });
		}
		return deptWrapperList;
	}

	@Override
	public void retrieveDeptEmplList(PagingVO<EmplVO> pagingVO) {
		int totalRecord = DAO.selectDeptEmplTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<EmplVO> dataList = DAO.selectDeptEmplList(pagingVO);
		pagingVO.setDataList(dataList);
	}

	
	// 팬시트리(searchAutl)
	@Override
	public void retrieveEmplFancyList(PagingVO<EmplFancyWrapperVO> pagingVO) {
		List<EmplFancyWrapperVO> dataList = emplDao.selectEmplFancyVO(pagingVO); 
		pagingVO.setDataList(dataList);
	}

	@Override
	public ServiceResult updateDeptLeader(DeptVO dept) {
		ServiceResult result = null;
		int rowcnt = DAO.updateDeptLeader(dept);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

}
