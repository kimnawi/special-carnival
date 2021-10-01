package com.eg.vacation.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.AutoAllowVO;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;
import com.eg.vo.VacHistoryVO;
import com.eg.vo.VacStatusVO;
import com.eg.vo.VacationVO;

@Mapper
public interface VacDAO {

	/**
	 * 총 휴가 수
	 * @param pagingVO
	 * @return
	 */
	public int selectTotalRecord(PagingVO<VacationVO> pagingVO);
	
	/**
	 * 휴가리스트
	 * @param pagingVO
	 * @return
	 */
	public List<VacationVO> selectVacationList(PagingVO<VacationVO> pagingVO);
	
	/**
	 * 사원별휴가일수 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<EmplVO> selectVacDayList(String vcatnCode);
	
	/**
	 * 사원별휴가일수 수정
	 * @param empl
	 * @return
	 */
	public int insertEmplVac(VacHistoryVO vacHistory);
	
	/**
	 * 사원별 휴가일수 삭제
	 * @param empl
	 * @return
	 */
	public int deleteEmplVac(VacHistoryVO vacHistory);
	
	/**
	 * 휴가코드 정보 출력
	 * @param vcatnCode
	 * @return
	 */
	public VacationVO selectVacDetail(String vcatnCode);
	
	/**
	 * 사원별휴가일수 계산
	 * @param vacHistory
	 * @return
	 */
	public List<VacHistoryVO> selectVacCalc(VacHistoryVO vacHistory);
	
	/**
	 * 사원 휴가 정보
	 * @param empl
	 * @return
	 */
	public EmplVO selectEmplVacInfo(int emplNo);
	
	/**
	 * 휴가신청이력 레코드 수
	 * @param pagingVO
	 * @return
	 */
	public int selectVacApplyTotalRecord(PagingVO<VacStatusVO> pagingVO);
	
	/**
	 * 휴가신청이력 조회
	 * @param empl
	 * @return
	 */
	public List<VacStatusVO> selectVacApplyList(PagingVO<VacStatusVO> pagingVO);
	
	/**
	 * 휴가신청 상세정보 조회
	 * @param emplNo
	 * @param draftNo
	 * @return
	 */
	public VacStatusVO selectVacApplyDetail(VacStatusVO vacStus);
	
	/**
	 * 휴일 제외
	 * @param vo
	 * @return
	 */
	public List<AutoAllowVO> selectWeekday(AutoAllowVO vo);
	
	/**
	 * 다음 휴가코드
	 * @return
	 */
	public String selectNextVacstusCode();
	
	/**
	 * 휴가신청
	 * @param vacStus
	 * @return
	 */
	public int insertVacStatus(VacStatusVO vacStus);
	
	/**
	 * 휴가신청삭제
	 * @param vacStus
	 * @return
	 */
	public int deleteVacStatus(VacStatusVO vacStus);
	
	/**
	 * 휴가리스트 총 레코드
	 * @param pagingVO
	 * @return
	 */
	public int selectVacStusTotalRecord(PagingVO<VacStatusVO> pagingVO);
	
	/**
	 * 휴가리스트 조회
	 * @param pagingVO
	 * @return
	 */
	public List<VacStatusVO> selectVacStusList(PagingVO<VacStatusVO> pagingVO);
	
	/**
	 * 휴가신청 기안서 번호(결재 전처리)
	 * @param paramMap draftNo, vacstusCode
	 * @return
	 */
	public int updateDraftNo(Map<String, Object> paramMap);
	
	/**
	 * 휴가현황
	 * @param pagingVO
	 * @return
	 */
	public List<VacStatusVO> selectVacStatus(PagingVO<VacStatusVO> pagingVO);
}
