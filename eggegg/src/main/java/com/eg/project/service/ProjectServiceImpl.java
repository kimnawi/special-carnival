package com.eg.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eg.commons.ServiceResult;
import com.eg.commons.exception.DataNotFoundException;
import com.eg.project.dao.ProjectDAO;
import com.eg.vo.PagingVO;
import com.eg.vo.ProjectVO;

@Service
public class ProjectServiceImpl implements ProjectService {
	
	@Inject
	private ProjectDAO DAO;
	
	@Override
	public List<ProjectVO> retrieveProjectList(PagingVO<ProjectVO> pagingVO) {
		int total = DAO.countProjectList(pagingVO);
		pagingVO.setTotalRecord(total);
		List<ProjectVO> dataList = DAO.projectList(pagingVO);
		pagingVO.setDataList(dataList);
		return dataList;
	}
	
	
	@Override
	public int retrieveProjectCount(PagingVO<ProjectVO> pagingVO) {
		return DAO.countProjectList(pagingVO);
	}
	
	@Transactional
	@Override
	public ServiceResult removeProject(String prjCode) {
		ServiceResult result = null;
		
		int rowcnt = DAO.deleteProject(prjCode);
		
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
			
		}
		return result;
	}

	@Transactional
	@Override
	public ServiceResult stopProject(String prjCode) {
		ServiceResult result = null;
		
		int rowcnt = DAO.stopProject(prjCode);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

	@Override
	public ServiceResult continueProject(String prjCode) {
		ServiceResult result = null;
		
		int rowcnt = DAO.continueProject(prjCode);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}


	@Override
	public List<ProjectVO> retrieveProjectListY(PagingVO<ProjectVO> pagingVO) {
		int total = DAO.countProjectListY(pagingVO);
		pagingVO.setTotalRecord(total);
		List<ProjectVO> dataList = DAO.projectListY(pagingVO);
		pagingVO.setDataList(dataList);
		return dataList;
	}


	@Override
	public int retrieveProjectCountY(PagingVO<ProjectVO> pagingVO) {
		return DAO.countProjectListY(pagingVO);
	}


	@Override
	public String createCode() {
		return DAO.createCode();
	}


	@Override
	public ProjectVO retrieveProject(String prjCode) {
		ProjectVO project = DAO.selectproject(prjCode);
		if(project == null) throw new DataNotFoundException(prjCode+"");
		
		return project;
	}

	@Transactional
	@Override
	public ServiceResult createProject(ProjectVO project) {
		ServiceResult result = ServiceResult.FAIL;
		int rowcnt = DAO.insertProject(project);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}
		
		return result;
	}


	@Override
	public List<ProjectVO> retrieveJsonProject() {
		return DAO.selectProjectList();
	}



}
