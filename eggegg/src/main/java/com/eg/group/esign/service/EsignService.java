package com.eg.group.esign.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.vo.AuthHistVO;
import com.eg.vo.AuthVO;
import com.eg.vo.DraftFormVO;
import com.eg.vo.DraftVO;
import com.eg.vo.LineBoxVO;
import com.eg.vo.PagingVO;

@Service
public interface EsignService {

	
	/**
	 * 전자결재 리스트
	 * @param pagingVO
	 */
	public void retrieveDraftList(PagingVO<DraftVO> pagingVO);
	
	
	/**
	 * 특정 기안서
	 * @param draftNo
	 * @return
	 */
	public DraftVO retrieveDraft(int draftNo);


	/**
	 * 기안서 양식 리스트를 가져오기 위함.
	 * @param emplNo 
	 * @param emplNo
	 * @return
	 */
	public PagingVO<DraftFormVO> retrieveDraftFormList(PagingVO<DraftFormVO> pagingVO, Integer emplNo);


	public DraftFormVO retrieveDraftForm(Integer draftFormNo);


	/**
	 * 전자결재 양식 수정
	 * @param draftForm
	 * @return 없는 값 =>DNFE 발생, 성공, 실패 
	 */
	public ServiceResult modifyDraftForm(DraftFormVO draftForm);


	/**
	 * 전자결재 양식 삭제
	 * @param draftForm
	 * @return
	 */
	public ServiceResult removeDraftForm(DraftFormVO draftForm);


	/**
	 * 양식 일괄 삭제
	 * @param deleteDfNo
	 * @return
	 */
	public void removeDraftFormAll(Map<String, Object> paramMap);


	/**
	 * 결재라인 업데이트(머지)
	 * @param box
	 * @return 
	 */
	public ServiceResult modifyLineBox(LineBoxVO box);


	/**
	 * 결재라인 삭제
	 * @param result
	 * @return
	 */
	public void removeLineBox(Map<String, Object> result);


	/**
	 * 결재 임시저장 or 결재상신
	 * @param draft
	 */
	public ServiceResult modifyDraft(DraftVO draft);

	/**
	 * 기안문 정보만 변경(반려시 사용)
	 * @param draft
	 * @return
	 */
	public ServiceResult updateDraft(DraftVO draft);

	/**
	 * 결재 이력 남기기
	 * @param authHist
	 * @return
	 */
	public ServiceResult createAuthHist(AuthHistVO authHist);


	/**
	 * dnd에 사용될 authVO
	 * 
	 * @param emplNo
	 * @return
	 */
	public AuthVO retrieveAuth(Integer emplNo);

}
