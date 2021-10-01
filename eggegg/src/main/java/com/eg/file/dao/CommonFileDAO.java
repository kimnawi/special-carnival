package com.eg.file.dao;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.CommonFileVO;

@Mapper
public interface CommonFileDAO {

	public CommonFileVO selectCommonFile(Integer commonNo);

	/**
	 * 경로 값으로 코드값 가져오기(이력 저장을 위함)
	 * @param commonPath
	 * @return
	 */
	public CommonFileVO selectCommonFileByPath(String commonPath);
	
	
	public void insertCommonFile(CommonFileVO fileVO);

	public void deleteCommonFileByPath(String commonPath);

	public void updateCommonFile(CommonFileVO commonFileVO);
	

}
