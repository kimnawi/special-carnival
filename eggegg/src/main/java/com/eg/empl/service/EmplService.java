package com.eg.empl.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.commons.UserNotFoundException;
import com.eg.vo.EmplFancyWrapperVO;
import com.eg.vo.EmplVO;
import com.eg.vo.OfficialOrderVO;
import com.eg.vo.PagingVO;

@Service
public interface EmplService {
	/**
	 * 사원등록
	 * @param empl
	 * @return PKDUPLICATED, OK, FAIL
	 */
	public ServiceResult createEmpl(EmplVO empl);
	
	/**
	 * 비밀번호 변경
	 * @param empl
	 * @return
	 */
	public ServiceResult modifyEmplPw(EmplVO empl);
	
	/**
	 * 사원리스트
	 * @param pagingVO
	 */
	public void retrieveEmplList(PagingVO<EmplVO> pagingVO);

	/**
	 * 사원리스트(팬시트리)
	 * @param pagingVO
	 */
	public void retrieveEmplFancyList(PagingVO<EmplFancyWrapperVO> pagingVO);
	
	/**
	 * @param emplNo
	 * @return 존재하지 않는 경우, {@link UserNotFoundException} 발생
	 */
	public EmplVO retrieveEmpl(int emplNo);
	
	/**
	 * @param empl
	 * @return 존재하지 않는 경우, {@link UserNotFoundExcep00tion} 발생
	 * 			INVALIDPASSWORD, OK, FAIL
	 */
	public ServiceResult modifyEmpl(EmplVO empl);

	/**
	 * 비밀번호 오류 횟수 증가
	 * @param username
	 * @return 오류횟수
	 */
	public int countFailure(String username);

	/**
	 * 사원번호 찾기
	 * @param empl emplNm, emplTel, emplDept, emplAuthority
	 * @return 찾은 사원VO
	 */
	public void retrieveEmplNo(EmplVO empl);

	/**
	 * 결재 도장 경로 변경
	 * @param path
	 * @param emplNo
	 * @param result
	 */
	public void modifySignImage(String path, Integer emplNo, Map<String, Object> result);
	
	/**
	 * 인사발령 결재 후처리
	 * @param draft
	 * @return
	 */
	public ServiceResult modifyEmplDraftAfter(OfficialOrderVO gnfd);

	/**
	 * 인사발령 결재 후처리
	 * @param draft
	 * @return
	 */
	public ServiceResult modifyEmplDraftReturn(int draftNo);
}
