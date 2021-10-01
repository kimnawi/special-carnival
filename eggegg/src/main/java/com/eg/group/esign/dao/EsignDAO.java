package com.eg.group.esign.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.AuthHistVO;
import com.eg.vo.AuthVO;
import com.eg.vo.DraftFormVO;
import com.eg.vo.DraftVO;
import com.eg.vo.LineBoxVO;
import com.eg.vo.PagingVO;

@Mapper
public interface EsignDAO {

   public int selectTotalRecord(PagingVO<DraftVO> pagingVO);
	  
   public List<DraftVO> selectDraftList(PagingVO<DraftVO> pagingVO);

   public DraftVO selectDraft(int draftNo);

   public Integer selectTotalDraftFormList(PagingVO<DraftFormVO> pagingVO);
   public List<DraftFormVO> selectDraftFormList(PagingVO<DraftFormVO> pagingVO);

   public DraftFormVO selectDraftForm(Integer draftFormNo);

   public int updateDraftForm(DraftFormVO draftForm);

   public int deleteDraftForm(DraftFormVO draftForm);

   public int deleteDraftFormAll(DraftFormVO draftForm);

   /**
    * 양식삭제시 본인 소유인지 확인 
	* @param param
	* @return
	*/
   public DraftFormVO validForm(Map<String, Integer> param);

   /**
    * 라인넘버 있는 경우 : 업데이트 / 없는경우 : 인서트 
	* @param box
	* @return
	*/
	public int updateLineBox(LineBoxVO box);

	/**
	 * 즐겨찾기에 속해있는 결재자 삭제
	 * @param box
	 */
	public int deleteAuth(LineBoxVO list);

	/**
	 * 즐겨찾기 최대번호
	 * @return
	 */
	public Integer selectMaxNo();

	/**
	 * 즐겨찾기에 속해있는 결재자 인서트
	 * @param box
	 * @return 
	 */
	public int insertAuth(LineBoxVO box);

	/**
	 * 결재라인 삭제
	 * @param object
	 */
	public int deleteLineBox(LineBoxVO box);

	/**
	 * 기안문 임시저장 or 결재상신
	 * @param draft
	 * @return
	 */
	public int insertDraft(DraftVO draft);
	public int updateDraft(DraftVO draft);

	/**
	 * 비어 있을 시 맥스 값으로 넣어주기
	 * @return
	 */
	public Integer selectMaxDraftNo();

	/**
	 * 드래프트 폼 넘버 0(빈양식)일 때 새로운 번호 주기
	 * @return
	 */
	public Integer selectMaxDraftFormNo();

	/**
	 * 기안문에 해당하는 결재자, 참조자, 수신자 딜리트
	 * @param draftNo
	 */
	public void deleteAuthl(Integer draftNo);
	public void deleteRef(Integer draftNo);
	public void deleteRec(Integer draftNo);
	

	/**
	 * 기안문에 해당하는 결재자, 참조자, 수신자 인서트
	 * @param draft
	 */
	public void insertAllAuthl(DraftVO draft);
	public void insertAllRef(DraftVO draft);
	public void insertAllRec(DraftVO draft);

	/**
	 * 결재이력 작성
	 * @return
	 */
	public int insertAuthHist(AuthHistVO authHist);


	/**
	 * dnd에서 사용될 결재자 정보(이름, 직책)
	 * @param emplNo
	 * @return
	 */
	public AuthVO selectAuthByEmplNo(Integer emplNo);

	public int updateAuthHist(AuthHistVO authHist);

	public String selectSignImagePath(Integer authorId);

	public int insertDraftForm(DraftFormVO draftForm);

	public List<DraftVO> selectMainDraft(int emplNo);
	
}
