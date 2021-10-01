package com.eg.admin.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.eg.admin.dao.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	private AdminDAO dao;
	
}
