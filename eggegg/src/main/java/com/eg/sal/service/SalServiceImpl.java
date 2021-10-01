package com.eg.sal.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eg.commons.ServiceResult;
import com.eg.sal.dao.SalDAO;
import com.eg.vo.AdGroupAllVO;
import com.eg.vo.AlHistoryVO;
import com.eg.vo.AllowanceVO;
import com.eg.vo.DeHistoryVO;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;
import com.eg.vo.PayInfoVO;
import com.eg.vo.PiHistoryVO;
import com.eg.vo.WorkHistoryVO;
import com.eg.vo.WorkVO;

@Service
public class SalServiceImpl implements SalService {
	@Inject
	private SalDAO DAO;
	
	@Transactional
	@Override
	public ServiceResult createSalary(PayInfoVO vo) {
		ServiceResult result = null;
		List<EmplVO> list = DAO.selectEmplNo();
		int cnt = DAO.countPayInfo(vo.getPiStdate());
		String piStdate = vo.getPiStdate()+" -"+cnt;
		vo.setPiStdate(piStdate);
		int rowcnt = 0;
		for(int i=0;i<list.size();i++) {
			vo.setPiEmpl(String.valueOf(list.get(i).getEmplNo()));
			rowcnt += DAO.insertSalary(vo);
		}
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public int retrieveSalCount(PagingVO<PayInfoVO> pagingVO) {
		return DAO.countSalList(pagingVO);
	}

	@Override
	public void retrieveSalList(PagingVO<PayInfoVO> pagingVO) {
		int totalRecord = retrieveSalCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<PayInfoVO> dataList = DAO.SalList(pagingVO);
		pagingVO.setDataList(dataList);
	}
	@Transactional
	@Override
	public ServiceResult modifySalary(PayInfoVO vo) {
		ServiceResult result = null;
		int rowcnt = 0;
		List<PayInfoVO> list = DAO.selectEmplUp(vo.getPiStdate());
		System.out.println(list);
		for(int i =0; i<list.size();i++) {
			vo.setPiEmpl(String.valueOf(list.get(i).getPiEmpl()));
			rowcnt += DAO.updateSalary(vo);
		}
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	@Transactional
	@Override
	public ServiceResult confirmWork(WorkHistoryVO vo) {
		ServiceResult result = null;
		String[] empl = vo.getPihEmpl().split(",");
		String[] code = vo.getWhAlcode().split(",");
		String[] hour = vo.getWhHour().split(",");
		int cnt = vo.getAlCnt();
		int rowcnt = 0;
		for(int i =0; i<empl.length;i++) {
			WorkHistoryVO whvo = new WorkHistoryVO();
			whvo.setPihStdate(vo.getPihStdate());
			whvo.setPihEmpl(empl[i]);
			for(int j = 0; j<cnt; j++) {
				int k = i *3;
				whvo.setWhAlcode(code[j+k]);
				whvo.setWhHour(hour[j+k]);
				rowcnt += DAO.createWorkConfirm(whvo);
			}
		}
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}
	/* (non-Javadoc)
	 * @see com.eg.sal.service.SalService#calculate(java.lang.String)
	 */
	@Transactional
	@Override
	public ServiceResult calculate(String stDate) {
		ServiceResult result = null;
		List<EmplVO> emplList = DAO.workConfirmEmpl(stDate);
		PayInfoVO info = DAO.checkDay(stDate);
		List<WorkVO> work =  DAO.workList(info);
		List<AdGroupAllVO> alGroup = null;
		List<AdGroupAllVO> deGroup = null;
		long Total = 0;
		PayInfoVO tovo = new PayInfoVO();
		
		List<AllowanceVO> list = DAO.workConfirmAl();
		for(int i =0; i<emplList.size();i++) {
			int total = 0;
			int deduction = 0;
			int real = 0;
			EmplVO vo = emplList.get(i);
			WorkHistoryVO history = new WorkHistoryVO();
			history.setPihEmpl(String.valueOf(vo.getEmplNo()));
			history.setPihStdate(stDate);
			//근무확정리스트
			List<WorkHistoryVO> workHistory =  DAO.work(history);
			
			//고정수당
			List<AdGroupAllVO> fixAl = DAO.fixAl(vo.getEmplNo());
			Map<String, Integer> alMap = new HashMap<>();
			Map<String, Integer> deMap = new HashMap<>();
			for(int j =0; j<fixAl.size();j++) {
				AdGroupAllVO fix = fixAl.get(j);
				alMap.put(fix.getAlCode(), Integer.parseInt(fix.getFaAmount()));
			}
			
			//월정공제
			List<AdGroupAllVO> monthDe = DAO.monthDe(vo.getEmplNo());
			for(int j =0; j<monthDe.size();j++) {
				AdGroupAllVO month = monthDe.get(j);
				deMap.put(month.getDeCode(), Integer.parseInt(month.getMdAmount()));
			}
			
			if(vo.getAdgCode() != null) {
				//수당,공제그룹 있을 시 수당 과 공제
				alGroup = DAO.alGroup(vo.getAdgCode()); 
				deGroup = DAO.deGroup(vo.getAdgCode());
				if(alGroup != null) {
					for(int j=0; j<alGroup.size();j++) {
						AdGroupAllVO alg = alGroup.get(j);
						if(Integer.parseInt(alg.getAlgAmount()) > 0) {
							int algAmount = Integer.parseInt(alg.getAlgAmount());
							int per = vo.getEmplAdgper();
							int money = algAmount * per / 100;
							alMap.put(alg.getAlCode(), money);
						}
					}
				}
				if(deGroup != null) {
					for(int j =0; j < deGroup.size();j++) {
						AdGroupAllVO meg = deGroup.get(j);
						if(Integer.parseInt(meg.getAdgAmount()) > 0 ) {
							deMap.put(meg.getDeCode(), Integer.parseInt(meg.getAdgAmount()));
						}
					}
				}
			}
			if(workHistory.size() > 0) {
				for(int j = 0; j<workHistory.size(); j++) {
					WorkHistoryVO his = workHistory.get(j);
					if(Integer.parseInt(his.getWhHour()) > 0) {
						int original = alMap.get(his.getWhAlcode());
						int sum = original * Integer.parseInt(his.getWhHour());
						alMap.put(his.getWhAlcode(), sum);
					}else {
							alMap.put(list.get(j).getAlCode(), 0);
					}
				}
			}else {
				for(int j =0; j<list.size();j++) {
					alMap.put(list.get(j).getAlCode(), 0);
				}
			}
			//수당이력 생성 및 수정
			for(String key : alMap.keySet()) {
				AlHistoryVO alhVO = new AlHistoryVO();
				alhVO.setPihEmpl(vo.getEmplNo());
				alhVO.setPihStdate(stDate);
				alhVO.setAlhCode(key);
				alhVO.setAlhAmount(alMap.get(key));
				DAO.createAlHistory(alhVO);
				total += alhVO.getAlhAmount();
			}
			Total += total;
			//소득세
			if(total!= 0) {
				int tax = DAO.Tax(total);
			//주민세(소득세 * 0.1)
			double tax2 = (double) (tax * 0.1); 
			//국민연금(총액 * 9% /2)
			double tax3 = total * 0.09 / 2;
			//건강보험(총액 * 6.86% / 2)
			double tax4 = total * 0.0686 / 2;
			//고용보험(총액 * 0.8%)
			double tax5 = total * 0.008;
			//장기요양(총액 *0.79% /2)
			double tax6 = total * 0.0079 / 2;
			deMap.put("01", tax);
			deMap.put("02", (int)tax2);
			deMap.put("03", (int)tax3);
			deMap.put("04", (int)tax4);
			deMap.put("05", (int)tax5);
			deMap.put("06", (int)tax6);
			}
			
			for(String key : deMap.keySet()) {
				DeHistoryVO dehVO = new DeHistoryVO();
				dehVO.setPihEmpl(vo.getEmplNo());
				dehVO.setPihStdate(stDate);
				dehVO.setDehCode(key);
				dehVO.setDehAmount(deMap.get(key));
				DAO.createDeHistory(dehVO);
				deduction += dehVO.getDehAmount();
			}
			real = total - deduction;
			PiHistoryVO pvo = new PiHistoryVO();
			pvo.setPihStdate(stDate);
			pvo.setPihEmpl(vo.getEmplNo());
			pvo.setPihAl(total);
			pvo.setPihDe(deduction);
			pvo.setPihPay(real);
			DAO.updatePiHistory(pvo);
		}
		tovo.setPiSum(Total);
		tovo.setPiStdate(stDate);
		DAO.updateTotal(tovo);
		result = ServiceResult.OK;
		return result;
	}

}
