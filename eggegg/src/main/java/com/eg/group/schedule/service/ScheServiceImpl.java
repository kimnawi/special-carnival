package com.eg.group.schedule.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.eg.commons.UserNotFoundException;
import com.eg.group.schedule.dao.ScheDAO;
import com.eg.vo.PagingVO;
import com.eg.vo.ScheVO;

@Service
public class ScheServiceImpl implements ScheService {
	
	@Inject
	private ScheDAO scheDAO;
	
	@Override
	public void retrieveScheList(PagingVO<ScheVO> pagingVO) {
		int totalRecord = scheDAO.selectTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ScheVO> dataList = scheDAO.selectScheList(pagingVO);
		pagingVO.setDataList(dataList);
		
	}

	@Override
	public ScheVO retrieveSche(String scheNo) {
		ScheVO sche = scheDAO.selectScheDetail(scheNo);
		if(sche==null)
			throw new UserNotFoundException(String.format("%s 일정 없음.", scheNo));
		return sche;
	}
}
