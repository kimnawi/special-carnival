package com.eg.group.drive.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eg.group.drive.dao.DriveDAO;
import com.eg.util.AES256Util;
import com.eg.vo.HistoryVO;
import com.eg.vo.PagingVO;

@Service
public class DriveServiceImpl implements DriveService {

	@Inject
	DriveDAO dao;
	
	@Inject
	AES256Util encoder;
	
	@Override
	public int totalHistoryList(PagingVO<HistoryVO> pagingVO) {
		int cnt = dao.selectTotalHistory(pagingVO);
		return cnt;
	}

	@Override
	public void retrieveHistoryList(PagingVO<HistoryVO> pagingVO) {
		pagingVO.setTotalRecord(totalHistoryList(pagingVO));
		List<HistoryVO> list = dao.selectHistoryList(pagingVO);
		try {
			for(HistoryVO hist : list) {
				String path = encoder.decrypt(hist.getHistPath());
				hist.setHistPath(path.substring(0,path.lastIndexOf(File.separator)-1));
				hist.setFileNm(path.substring(path.lastIndexOf(File.separator)+1));
			}
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		pagingVO.setDataList(list);
	}

	@Transactional
	@Override
	public void createHist(HistoryVO histVO) {
		dao.insertHistory(histVO);
	}

}
