package com.eg.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.vo.PagingVO;
import com.eg.vo.ProjectVO;

@Service
public interface ProjectService {

	public List<ProjectVO> retrieveProjectList(PagingVO<ProjectVO> pagingVO);
	
	public int retrieveProjectCount(PagingVO<ProjectVO> pagingVO);
	
	public ServiceResult removeProject(String prjCode);
	
	public ServiceResult stopProject(String prjCode);
	
	public ServiceResult continueProject(String prjCode);

	public List<ProjectVO> retrieveProjectListY(PagingVO<ProjectVO> pagingVO);
	
	public int retrieveProjectCountY(PagingVO<ProjectVO> pagingVO);
	
	public String createCode();
	
	public ProjectVO retrieveProject(String prjCode);
	
	public ServiceResult createProject(ProjectVO project);
	
	public List<ProjectVO> retrieveJsonProject();
} 
