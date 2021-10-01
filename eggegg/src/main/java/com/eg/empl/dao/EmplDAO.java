package com.eg.empl.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eg.commons.exception.DataNotFoundException;
import com.eg.vo.AbTypeVO;
import com.eg.vo.AcademicVO;
import com.eg.vo.AdGroupAllVO;
import com.eg.vo.DraftVO;
import com.eg.vo.EmplFancyWrapperVO;
import com.eg.vo.EmplVO;
import com.eg.vo.OfficialOrderVO;
import com.eg.vo.PagingVO;
import com.eg.vo.QualificateVO;

@Mapper
public interface EmplDAO {

   /**
    * 사원 번호로 사원을 검색  => security에서 처리해주기 위함.
    * @param username
    * @return 사원 번호에 해당하는 사원이 없을 시 0
    */
   public EmplVO selectEmplById(int username);
   
   /**
    * 비밀번호 변경
    * @param emplNo
    * @return
    */
   public int updateEmplPassword(EmplVO empl);

   /**
    * 페이징처리를 위한 총 사원 수
    * @param pagingVO
    * @return 사원 수
    */
   public int selectTotalRecord(PagingVO<EmplVO> pagingVO);

   /**
    * 사원 상세정보
    * @param emplNo
    * @return 존재하지 않을 시 {@link DataNotFoundException}
    */
   public EmplVO selectEmplDetail(int emplNo);

   /**
    * 사원 등록(인사카드등록)
    * @param empl
    * @return 등록실패시 FAIL, 성공 시 OK
    */
   public int insertEmpl(EmplVO empl);
   
   /**
    * 사원 계좌 등록
    * @param bank
    * @return
    */
   public int insertSalaryBank(EmplVO empl);
   
   /**
    * 최종학력 등록
    * @param acad
    * @return
    */
   public int insertAcadBack(EmplVO empl);
   
   /**
    * 학력구분리스트
    * @return
    */
   public List<AbTypeVO> abTypeList();

   /**
    * 사원리스트
    * @param pagingVO
    * @return
    */
   public List<EmplVO> selectEmplList(PagingVO<EmplVO> pagingVO);

   /**
    * 사원리스트 (팬시트리)
    * @param pagingVO
    * @return
    */
   public List<EmplFancyWrapperVO> selectEmplFancyVO(PagingVO<EmplFancyWrapperVO> pagingVO);

   /**
    * 사원 최종학력 보기
    * @param emplNo
    * @return
    */
   public AcademicVO selectEmplAcademic(int abEmpl);
   
   /**
    * 사원 정보 수정
    * @param empl
    * @return
    */
   public int updateEmpl(EmplVO empl);

   /**
    * 사원 자격증 보기
    * @param qcEmpl
    * @return
    */
   public List<QualificateVO> selectEmplQualificate(int qcEmpl);
   
   /**
    * 사원 자격증 등록
    * @param qual
    * @return
    */
   public int insertQual(QualificateVO qual);
   
   /**
    * 사원 등록시 VAC_HISTORY에도 자동 입력
    * @param emplNo
    * @return
    */
   public int insertVacation(int emplNo);
   
   /**
    * 사원자격증 삭제
    * @param qual
    * @return
    */
   public int deleteQual(int emplNo);

   /**
    * 사원퇴사
    * @param empl
    * @return
    */
   public int insertRetire(EmplVO empl);
   
   /**
    * 사원리스트 엑셀다운로드
    * @return
    */
   public List<EmplVO> selectEmplExcelList();
   
   /**
    * 오류횟수 증가 후 조회
    * @param username
    * @return
    */
   public void increasePWCNT(EmplVO empl);

   /**
    * 다음 사원번호 등록
    * @return
    */
   public int selectNextEmplNo();

   public Integer selectEmplPWCNT(Integer emplNo);

   public int initializePWCNT(Integer emplNo);

   /**
     * 사원 정보와 일치하는 사원번호 출력 	
	 * @param empl
	 */
   public EmplVO selectEmplNo(EmplVO empl);
   
   /**
     * 사원 수당그룹 조회
	 * @param No
	 * @return
	 */
	public List<AdGroupAllVO> selectAlGroup(Integer No);
   
	/**
	 * 사원 공제그룹 조회
	 * @param No
	 * @return
	 */
   public List<AdGroupAllVO> selectDeGroup(Integer No);
   
   /**
    * 사원 고정수당 조회
    * @param No
    * @return
    */
   public List<AdGroupAllVO> selectFixAl(Integer No);
   /**
    * 사원 월정공제 조회
    * @param No
    * @return
    */
   public List<AdGroupAllVO> selectMonthDe(Integer No);
   
   /**
    * 사원 고정수당 수정
    * @param vo
    * @return
    */
   public int updateFixAl(AdGroupAllVO vo);
   
   /**
    * 사원 월정공제 수정
    * @param vo
    * @return
    */
   public int updateMonthDe(AdGroupAllVO vo);

   /**
    * 사원 도장 경로 변경
	* @param emplVO
	* @return 
	*/
	public int updateSignImagePath(EmplVO emplVO);
   
	/**
	 * 인사카드 출력
	 * @param emplNo
	 * @return
	 */
	public EmplVO selectEmplCard(int emplNo);
	
	/**
	 * 결재완료 후 사원정보 업데이트
	 * 부서, 직급
	 * @param empl
	 * @return
	 */
	public int updateEmplDraftAfter(OfficialOrderVO gnfd);
	
	/**
	 * 발령일자 초과 시 반려
	 * @param draftNo
	 * @return
	 */
	public int updateEmplDraftReturn(int draftNo);
}