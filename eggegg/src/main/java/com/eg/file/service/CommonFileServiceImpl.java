package com.eg.file.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eg.commons.ServiceResult;
import com.eg.file.dao.CommonFileDAO;
import com.eg.vo.CommonFileVO;

@Service
public class CommonFileServiceImpl implements CommonFileService {

	@Inject
	CommonFileDAO dao;
	
	@Transactional
	@Override
	public Integer createCommonFile(CommonFileVO commonFileVO) {
		dao.insertCommonFile(commonFileVO);
		Integer commonNo = commonFileVO.getCommonNo(); 
		return commonNo;
	}

	@Override
	public CommonFileVO retrieveCommonFile(Integer commonNo) {
		return dao.selectCommonFile(commonNo);
	}

	@Override
	public CommonFileVO retrieveCommonFileByPath(String commonPath) {
		return dao.selectCommonFileByPath(commonPath);
	}

	@Override
	public void modifyCommonFile(CommonFileVO commonFileVO) {
		dao.updateCommonFile(commonFileVO);
	}

	@Override
	public void removeCommonFileByPath(String commonPath) {
		dao.deleteCommonFileByPath(commonPath);
	}

}
