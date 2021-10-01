package com.eg.empl.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eg.commons.ServiceResult;
import com.eg.commons.UserNotFoundException;
import com.eg.empl.dao.EmplDAO;
import com.eg.vo.AdGroupAllVO;
import com.eg.vo.EmplFancyWrapperVO;
import com.eg.vo.EmplVO;
import com.eg.vo.OfficialOrderVO;
import com.eg.vo.PagingVO;
import com.eg.vo.QualificateListVO;
import com.eg.vo.QualificateVO;

@Service
public class EmplServiceImpl implements EmplService{

	@Inject	
	private EmplDAO employeeDAO;
	@Resource(name="authManager")
	private AuthenticationManager authManager;
	@Inject
	private PasswordEncoder passwordEncoder;
	
	@Transactional
	@Override
	public ServiceResult modifyEmplPw(EmplVO empl) {
		ServiceResult result = ServiceResult.FAIL;
		String plain = empl.getEmplPw();
		String encoded = passwordEncoder.encode(plain);
		empl.setEmplPw(encoded);
		int rowcnt = employeeDAO.updateEmplPassword(empl);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult createEmpl(EmplVO empl) {
		ServiceResult result = null;
		if(employeeDAO.selectEmplDetail(empl.getEmplNo())==null) {	
			String plain = empl.getEmplPw();
			String encoded = passwordEncoder.encode(plain);
			empl.setEmplPw(encoded);
			int rowcnt = employeeDAO.insertEmpl(empl);
			if(rowcnt > 0) {
				String acnutno = empl.getSalarybank().getSlryAcnutno();
				if(acnutno.length() > 0 && acnutno != null) {
					rowcnt += employeeDAO.insertSalaryBank(empl);
				}
				String abSchool = empl.getAcad().getAbSchool();
				if(abSchool.length() > 0 && abSchool != null) {
					rowcnt += employeeDAO.insertAcadBack(empl);
				}
				QualificateListVO qualVOList = empl.getQualVOList();
				QualificateVO[] qual = qualVOList.getQual();
				for(int i = 0; i < qual.length; i++) {
					if(qual[i].getQcNm() != null && qual[i].getQcNm().length() > 0) {
						rowcnt += employeeDAO.insertQual(qual[i]);
					}
				}
				rowcnt += employeeDAO.insertVacation(empl.getEmplNo());
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAIL;
			}// rowcnt>0 end
		}else {
			result = ServiceResult.PKDUPLICATED;
		}
		return result;
	}
	
	@Override
	public void retrieveEmplList(PagingVO<EmplVO> pagingVO) {
		int totalRecord = employeeDAO.selectTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<EmplVO> dataList = employeeDAO.selectEmplList(pagingVO);
		pagingVO.setDataList(dataList);
	}

	@Override
	public EmplVO retrieveEmpl(int emplNo) throws UserNotFoundException{
		EmplVO Empl = employeeDAO.selectEmplDetail(emplNo);
		if(Empl==null) {
			throw new UserNotFoundException(String.format("%s 회원 없음.", emplNo));
		}
		List<AdGroupAllVO> alGroup =  employeeDAO.selectAlGroup(emplNo);
		Empl.setAlGroup(alGroup);
		
		List<AdGroupAllVO> deGroup = employeeDAO.selectDeGroup(emplNo);
		Empl.setDeGroup(deGroup);
		
		List<AdGroupAllVO> fixAl =  employeeDAO.selectFixAl(emplNo);
		Empl.setFixAl(fixAl);
		
		List<AdGroupAllVO> monthDe = employeeDAO.selectMonthDe(emplNo);
		Empl.setMonthDe(monthDe);
		
		return Empl;
	}
	
	@Transactional
	@Override
	public ServiceResult modifyEmpl(EmplVO empl) {
		ServiceResult result = null;
		int rowcnt = employeeDAO.updateEmpl(empl);
//		processMemImage(empl);
		if(rowcnt > 0) {
			String acnutno = empl.getSalarybank().getSlryAcnutno();
			if(acnutno.length() > 0 && acnutno != null) {
				rowcnt += employeeDAO.insertSalaryBank(empl);
			}
			String abSchool = empl.getAcad().getAbSchool();
			if(abSchool.length() > 0 && abSchool != null) {
				rowcnt += employeeDAO.insertAcadBack(empl);
			}
			QualificateListVO qualVOList = empl.getQualVOList();
			QualificateVO[] qual = qualVOList.getQual();
			if(qual.length > 0) {
				rowcnt += employeeDAO.deleteQual(empl.getEmplNo());
				for(int i = 0; i < qual.length; i++) {
					if(qual[i].getQcNm() != null && qual[i].getQcNm().length() > 0) {
						rowcnt += employeeDAO.insertQual(qual[i]);
					}
				}
			}
			String emplRetire = empl.getRetire().getEmplRetire();
			if(emplRetire.length() > 0 && emplRetire != null) {
				rowcnt += employeeDAO.insertRetire(empl);
			}
			for(int i = 0; i < empl.getFixAl().size();i++) {
				AdGroupAllVO vo = empl.getFixAl().get(i);
				rowcnt += employeeDAO.updateFixAl(vo);
			}
			for(int i = 0; i < empl.getMonthDe().size();i++) {
				AdGroupAllVO vo = empl.getMonthDe().get(i);
				rowcnt += employeeDAO.updateMonthDe(vo);
			}
			
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	/**
	 * 마이페이지에서 사원이 직접 정보 수정 시
	 */
	/*@Transactional
	@Override
	public ServiceResult modifyEmplMypage(EmplVO empl) {
		ServiceResult result = null;
		try {
			// 인증 코드
			authManager.authenticate(new UsernamePasswordAuthenticationToken(empl.getEmplNo(), empl.getEmplPw()));
			int rowcnt = employeeDAO.updateEmpl(empl);
//			processMemImage(empl);
			if(rowcnt > 0) {
				result = ServiceResult.OK;
				// 인증된 이후에 변경된 계정 정보 조회
				Authentication newAuthentication = authManager.authenticate(new UsernamePasswordAuthenticationToken(empl.getEmplNo(), empl.getEmplPw()));
				SecurityContextHolder.getContext().setAuthentication(newAuthentication);
			} else {
				result = ServiceResult.FAIL;
			}
		} catch (Exception e) {
			result = ServiceResult.INVALIDPASSWORD;
		}
		return result;
	}*/
	
	@Transactional
	@Override
	public int countFailure(String username) {
		EmplVO empl = new EmplVO();
		empl.setEmplNo(Integer.parseInt(username));
		employeeDAO.increasePWCNT(empl);
		return empl.getEmplPwcnt();
	}

	@Override
	public void retrieveEmplNo(EmplVO empl) {
		try {
			EmplVO savedEmpl = employeeDAO.selectEmplNo(empl);
			empl.setEmplNo(savedEmpl.getEmplNo());
		}catch(NullPointerException e) {
			empl.setEmplNo(0);
		}
	}

	//팬시트리에 사용될 사원 리스트
	@Override
	public void retrieveEmplFancyList(PagingVO<EmplFancyWrapperVO> pagingVO) {
		pagingVO.setDataList(employeeDAO.selectEmplFancyVO(pagingVO));
	}

	@Transactional
	@Override
	public void modifySignImage(String path, Integer emplNo, Map<String, Object> result) {
		EmplVO savedEmpl = employeeDAO.selectEmplDetail(emplNo);
		if(savedEmpl == null) {
			result.put("result","해당사원 없음");
		}
		savedEmpl.setEmplNo(emplNo);
		savedEmpl.setEmplSignimage(path);
		int cnt = employeeDAO.updateSignImagePath(savedEmpl);
		if(cnt<1) {
			result.put("result","업데이트 실패");
		}
		result.put("result","업데이트 성공");
	}

	@Transactional
	@Override
	public ServiceResult modifyEmplDraftAfter(OfficialOrderVO gnfd) {
		ServiceResult result = ServiceResult.FAIL;
		int rowcnt = employeeDAO.updateEmplDraftAfter(gnfd);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult modifyEmplDraftReturn(int draftNo) {
		ServiceResult result = ServiceResult.FAIL;
		int rowcnt = employeeDAO.updateEmplDraftReturn(draftNo);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}
	
}
