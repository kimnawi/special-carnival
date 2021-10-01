package com.eg.sal.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.AdGroupAllVO;
import com.eg.vo.AlHistoryVO;
import com.eg.vo.AllowanceVO;
import com.eg.vo.DeHistoryVO;
import com.eg.vo.DeductionVO;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;
import com.eg.vo.PayInfoVO;
import com.eg.vo.PiHistoryVO;
import com.eg.vo.WorkHistoryVO;
import com.eg.vo.WorkVO;

@Mapper
public interface SalDAO {

	public List<EmplVO> selectEmplNo();
	
	public int insertSalary(PayInfoVO vo);
	
	public int countPayInfo(String stdate);
	
	public int countSalList(PagingVO<PayInfoVO> pagingVO);
	
	public List<PayInfoVO> SalList(PagingVO<PayInfoVO> pagingVO);

	public PayInfoVO selectSal(String stDate);
	
	public int updateSalary(PayInfoVO vo);
	
	public List<PayInfoVO> selectEmplUp(String stdate);
	
	public List<EmplVO> workConfirmEmpl(String stdate);
	
	public List<AllowanceVO> workConfirmAl();
	
	public PayInfoVO checkDay(String stdate);
	
	public List<WorkVO> workList(PayInfoVO vo);
	
	public int createWorkConfirm(WorkHistoryVO vo);
	
	public List<WorkHistoryVO> workHistory(String stDate);
	
	public List<AllowanceVO> alList();
	
	public List<DeductionVO> deList();
	
	public List<AdGroupAllVO> alGroup(String adgCode);
	
	public List<AdGroupAllVO> deGroup(String adgCode);
	
	public List<AdGroupAllVO> fixAl(int emplNo);

	public List<AdGroupAllVO> monthDe(int emplNo);
	
	public List<WorkHistoryVO> work(WorkHistoryVO vo);
	
	public int createAlHistory(AlHistoryVO vo);
	
	public int createDeHistory(DeHistoryVO vo);

	public int Tax(Integer money);
	
	public int updatePiHistory(PiHistoryVO vo);
	
	public List<AlHistoryVO> selectAlHistory(AlHistoryVO vo);
	
	public List<DeHistoryVO> selectDeHistory(AlHistoryVO vo);
	
	public int updateTotal(PayInfoVO vo);
}
