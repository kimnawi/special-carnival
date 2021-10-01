package com.eg.security.auth.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.AuthorityVO;

@Mapper
public interface AuthorityDAO {
	/**
	 * 모든 역할 정보 조회
	 * @return
	 */
	public List<AuthorityVO> selectAllAuthorities();
	
	/**
	 * 역할 계층 구조 조회
	 * @return
	 */
	public List<String> roleHierarchy();
}
