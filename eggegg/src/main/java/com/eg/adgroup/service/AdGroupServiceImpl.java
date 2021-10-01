package com.eg.adgroup.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eg.adgroup.dao.AdGroupDAO;
import com.eg.commons.ServiceResult;
import com.eg.vo.AdGroupAllVO;
import com.eg.vo.AdGroupVO;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;

@Service
public class AdGroupServiceImpl implements AdGroupService {
	@Inject
	private AdGroupDAO DAO;
	
	@Override
	public int retrieveGroupCount(PagingVO<AdGroupVO> pagingVO) {
		return DAO.countGroupList(pagingVO);
	}

	@Override
	public List<AdGroupVO> retrieveGroupList(PagingVO<AdGroupVO> pagingVO) {
		int total = retrieveGroupCount(pagingVO);
		pagingVO.setTotalRecord(total);
		List<AdGroupVO> dataList = DAO.groupList(pagingVO);
		pagingVO.setDataList(dataList);
		return dataList;
	}

	@Override
	public List<AdGroupVO> retrieveGroupList() {
		return DAO.selectGroupList();
	}
	@Transactional
	@Override
	public ServiceResult createAdGroup(AdGroupAllVO vo) {
		ServiceResult result = ServiceResult.FAIL;
		int rowcnt = DAO.insertAdGroup(vo);
		if(rowcnt > 0) {
			if(vo.getAlGroup().size() > 0 && vo.getAlGroup() != null) {
				rowcnt += DAO.insertAlGroup(vo);
			}
			if(vo.getDeGroup().size() > 0 && vo.getDeGroup() != null) {
				rowcnt += DAO.insertDeGroup(vo);
			}
			result = ServiceResult.OK;
			
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public List<AdGroupAllVO> selectAlGroup(String code) {
		List<AdGroupAllVO> algroup = DAO.selectAlGroup(code);
		if(algroup ==null) {
			throw new UsernameNotFoundException(String.format("%s 데이터 없음.", code));
		}
		return algroup;
	}

	@Override
	public List<AdGroupAllVO> selectDeGroup(String code) {
		List<AdGroupAllVO> degroup = DAO.selectDeGroup(code);
		if(degroup == null) {
			throw new UsernameNotFoundException(String.format("%s 데이터 없음.", code));
		}
		return degroup;
	}

	@Override
	public AdGroupAllVO retrieveAdGroup(String code) {
		AdGroupAllVO vo = DAO.selectAdGroup(code);
		if(vo == null) {
			throw new UsernameNotFoundException(String.format("%S 데이터 없음.",code));
		}
		return vo;
	}
	@Transactional
	@Override
	public ServiceResult removeGroup(String code) {
		ServiceResult result = null;
		
		DAO.deleteAlGroup(code);
		DAO.deleteDeGroup(code);
		DAO.updateempl(code);
		int rowcnt = DAO.deleteGroup(code);
		
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	@Transactional
	@Override
	public ServiceResult modifyGroup(AdGroupAllVO group) {
		ServiceResult result = null;
		int rowcnt = DAO.updateAdGroup(group);
		
		if(rowcnt > 0) {
			for(int i=0;i<group.getAlGroup().size();i++) {
				if(group.getAlGroup().size() > 0 && group.getAlGroup().get(i) != null) {
					AdGroupAllVO vo = new AdGroupAllVO();
					vo = group.getAlGroup().get(i);
					rowcnt += DAO.updateAlGroup(vo);
				}
			}
			for(int i=0;i<group.getDeGroup().size();i++) {
				if(group.getDeGroup().size() > 0 && group.getDeGroup().get(i) != null) {
					AdGroupAllVO vo = new AdGroupAllVO();
					vo = group.getDeGroup().get(i);
					rowcnt += DAO.updateDeGroup(vo);
				}
			}
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	@Transactional
	@Override
	public ServiceResult modifyEmpl(AdGroupAllVO vo) {
		ServiceResult result = null;
		for(int i=0;i<vo.getEmpl().size();i++) {
			EmplVO empl = vo.getEmpl().get(i);
			if(empl.getEmplDel() != null) {
				DAO.deleteEmplAdg(empl);
			}else {
				
				if(empl.getEmplAdgper() == null) {
					empl.setEmplAdgper(0);
				}
				DAO.updateEmplAdg(empl);
			}
		}
		result = ServiceResult.OK;
		
		return result;
	}

}
