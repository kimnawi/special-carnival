package com.eg.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.PagingVO;
import com.eg.vo.ProjectVO;

@Mapper
public interface ProjectDAO {

	public List<ProjectVO> projectList(PagingVO<ProjectVO> pagingVO);
	
	public int countProjectList(PagingVO<ProjectVO> pagingVO);
	
	public int deleteProject(String prjCode);
	
	public int stopProject(String projCode);
	
	public int continueProject(String projCode);
	
	
	public List<ProjectVO> projectListY(PagingVO<ProjectVO> pagingVO);
	
	public int countProjectListY(PagingVO<ProjectVO> pagingVO);
	
	public String createCode();
	
	public ProjectVO selectproject(String prjCode);
	
	public int insertProject(ProjectVO project);
	
	public List<ProjectVO> selectProjectList(); 
}
