package com.eg.gnfd.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.GnfdTypeVO;
import com.eg.vo.OfficialOrderVO;
import com.eg.vo.PagingVO;

@Mapper
public interface GnfdDAO {

	/**
	 * 입사구분리스트
	 * @return
	 */
	public List<GnfdTypeVO> selectGnfdTypeList();
	
	/**
	 * 인사발령 총 레코드
	 * @param pagingVO
	 * @return
	 */
	public int selectGnfdTotalRecord(PagingVO<OfficialOrderVO> pagingVO);
	
	/**
	 * 인사발령 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<OfficialOrderVO> selectGnfdList(PagingVO<OfficialOrderVO> pagingVO);
	
	/**
	 * 인사발령 상세정보
	 * @param gnfdStdrde
	 * @return
	 */
	public OfficialOrderVO selectGnfdDetail(String gnfdStdrde);
	
	/**
	 * 인사발령 정보 수정
	 * @param gnfd
	 * @return
	 */
	public int updateGnfd(OfficialOrderVO gnfd);
	
	/**
	 * 인사발령정보 삭제
	 * @param gnfdStdrde
	 * @return
	 */
	public int deleteGnfd(String gnfdStdrde);
	
	/**
	 * 인사발령 등록
	 * @param gnfd
	 * @return
	 */
	public int insertGnfd(OfficialOrderVO gnfd);
	
	/**
	 * 기안번호 입력
	 * @param paramMap
	 * @return
	 */
	public int updateDraftNo(Map<String, Object> paramMap);
	
	/**
	 * 인사발령현황
	 * @param pagingVO
	 * @return
	 */
	public List<OfficialOrderVO> selectGnfdStatus(PagingVO<OfficialOrderVO> pagingVO);
	
	/**
	 * 인사발령리스트 엑셀 다운로드
	 * @param pagingVO
	 * @return
	 */
	public List<OfficialOrderVO> selectGnfdExcel();
	
	/**
	 * 후처리를 위한 인사발령결재정보
	 * @return
	 */
	public List<OfficialOrderVO> selectGnfdDraftAfter();
}
