package com.eg.admin.dao;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.CompanyVO;

@Mapper
public interface AdminDAO {

	public CompanyVO selectCompany();
	
}
