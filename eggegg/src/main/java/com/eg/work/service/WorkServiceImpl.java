package com.eg.work.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eg.commons.ServiceResult;
import com.eg.commons.exception.DataNotFoundException;
import com.eg.vo.PagingVO;
import com.eg.vo.WorkVO;
import com.eg.work.dao.WorkDAO;

@Service
public class WorkServiceImpl implements WorkService {

	@Inject
	private WorkDAO DAO;
	
	@Transactional
	@Override
	public ServiceResult createWork(List<WorkVO> list) {
		ServiceResult result = ServiceResult.FAIL;
		int rowcnt = 0;
		System.out.println(list);
		for(int i = 0; i<list.size();i++) {
			WorkVO work = list.get(i);
			if(work.getAlCode().length() > 0) {
				rowcnt += DAO.insertWork(work);
			}
		}
		if(rowcnt >0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public int retrieveListCount(PagingVO<WorkVO> pagingVO) {
		return DAO.countWorkList(pagingVO);
	}

	@Override
	public void retreiveWorkList(PagingVO<WorkVO> pagingVO) {
		int total = retrieveListCount(pagingVO);
		pagingVO.setTotalRecord(total);
		List<WorkVO> dataList = DAO.workList(pagingVO);
		pagingVO.setDataList(dataList);
	}

	@Override
	public List<WorkVO> popWorkList(String stdate) {
		List<WorkVO> workList = DAO.popWorkList(stdate);
		if(workList == null) {
			throw new DataNotFoundException(String.format("%s 데이터 없음.", stdate));
		}
		
		return workList;
	}

	@Override
	public List<WorkVO> searchWorkList(WorkVO vo) {
		List<WorkVO> workList = DAO.searchWorkList(vo);
		if(workList == null) {
			throw new DataNotFoundException(String.format("%s 데이터 없음.", vo));
		}
		
		return workList;
	}
	@Transactional
	@Override
	public ServiceResult modifyWorkList(WorkVO vo) {
		ServiceResult result = null;
		List<WorkVO> delList = vo.getDeleteList();
		if(delList != null) {
			for(int i =0; i<delList.size();i++) {
				WorkVO del = delList.get(i);
				DAO.deleteWork(del);
			}
		}
		List<WorkVO> updateList = vo.getUpdateList();
		for(int i = 0; i<updateList.size();i++) {
			WorkVO work = updateList.get(i);
			if(work.getAlCode().length() > 0) {
				DAO.insertWork(work);
			}
		}
		result =  ServiceResult.OK;
		
		return result;
	}
	@Transactional
	@Override
	public ServiceResult removeWork(String stdate) {
		ServiceResult result = null;
		String[] date = stdate.split(",");
		int rowcnt =0;
		for(int i=0; i<date.length; i++) {
			rowcnt += DAO.deleteworkList(date[i]);
		}
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

}
