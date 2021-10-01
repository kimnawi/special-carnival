package com.eg.hrd.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.AttendeLvffcVO;
import com.eg.vo.PagingVO;

@Mapper
public interface HrdDAO {

	/**
	 * 일별 출/퇴인원 출력
	 * @param atvlMonth
	 * @return
	 */
	public List<AttendeLvffcVO> selectAttendeLvffcCntList(String atvlMonth);
	
	/**
	 * 출/퇴근기록 총 레코드
	 * @param atvl
	 * @return
	 */
	public int selectAtvlTotalRecord(PagingVO<AttendeLvffcVO> pagingVO);
	
	/**
	 * 출/퇴근기록 리스트
	 * @return
	 */
	public List<AttendeLvffcVO> selectAttendeLvffcList(PagingVO<AttendeLvffcVO> pagingVO);
	
	/**
	 * QR인증을 한 사원의 출근여부 확인
	 * @param atvlEmpl
	 * @return
	 */
	public String selectAtvlConfirm(String atvlEmpl);
	
	/**
	 * 출근인증
	 * @param atvlEmpl
	 * @return
	 */
	public int insertAttende(String atvlEmpl);
	
	/**
	 * 퇴근인증
	 * @param atvlEmpl
	 * @return
	 */
	public int updateLvffc(String atvlEmpl);
	
	/**
	 * 메인화면 출퇴관리
	 * @param atvlEmpl
	 * @return
	 */
	public AttendeLvffcVO selectAtvl(String atvlEmpl);
	
	/**
	 * 출/퇴근현황
	 * @param pagingVO
	 * @return
	 */
	public List<AttendeLvffcVO> selectHrdStatus(PagingVO<AttendeLvffcVO> pagingVO);
}
