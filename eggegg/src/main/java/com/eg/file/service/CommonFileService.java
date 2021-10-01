package com.eg.file.service;

import com.eg.commons.ServiceResult;
import com.eg.vo.CommonFileVO;

public interface CommonFileService {

	public Integer createCommonFile(CommonFileVO commonFileVO);
	public CommonFileVO retrieveCommonFile(Integer integer);
	public void modifyCommonFile(CommonFileVO commonFileVO);
	
	/**
	 * 드라이브에서 경로로 pk값(code) 가져오기
	 * @param commonPath
	 * @return
	 */
	public CommonFileVO retrieveCommonFileByPath(String commonPath);
	
	
	/**
	 * 경로를 기준으로 해서 DB에서 삭제(어차피 pk와 1:1관계임)
	 * @param commonPath
	 */
	public void removeCommonFileByPath(String commonPath);
}
