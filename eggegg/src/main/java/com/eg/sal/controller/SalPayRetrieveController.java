package com.eg.sal.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.commons.ServiceResult;
import com.eg.sal.dao.SalDAO;
import com.eg.sal.service.SalService;
import com.eg.vo.AlHistoryVO;
import com.eg.vo.AllowanceVO;
import com.eg.vo.DeHistoryVO;
import com.eg.vo.DeductionVO;
import com.eg.vo.EmplVO;

@Controller
public class SalPayRetrieveController {

	@Inject
	private SalService service;	
	
	@Inject
	private SalDAO DAO;
	
	@RequestMapping(value="/sal/payInfo.do")
	public String form(
		@RequestParam(value="stdate") String stDate,
		Model model
	) {
		String[] z = stDate.split("-");
		String mix = z[0] +"-"+ z[1] + " -"+z[2];
		List<EmplVO> emplList = DAO.workConfirmEmpl(mix);
		List<AllowanceVO> alList = DAO.alList();
		List<DeductionVO> deList = DAO.deList();
		List<AlHistoryVO> sumAl = new ArrayList<>();
		List<DeHistoryVO> sumDe = new ArrayList<>();
		int sumA = 0;
		int sumD = 0;
		
		Map<String, Integer> alSum = new HashMap<>();
		Map<String, Integer> deSum = new HashMap<>();
		for(int i =0; i<emplList.size();i++) {
			EmplVO empl = emplList.get(i);
			AlHistoryVO vo = new AlHistoryVO();
			vo.setPihEmpl(empl.getEmplNo());
			vo.setPihStdate(mix);
			List<AlHistoryVO> list = DAO.selectAlHistory(vo);
			empl.setAlHistory(list);
			List<DeHistoryVO> list2 = DAO.selectDeHistory(vo);
			empl.setDeHistory(list2);
			for(int j=0; j<list.size();j++) {
				AlHistoryVO alhvo = list.get(j);
				String code = alhvo.getAlhCode();
				int mount = alhvo.getAlhAmount();
				if(alSum.get(code) != null) {
					int money = alSum.get(code);
					int sum = mount + money;
					alSum.put(code, sum);
				}else {
					alSum.put(code, mount);
				}
			}
			for(int j=0; j<list2.size();j++) {
				DeHistoryVO dehvo = list2.get(j);
				String code = dehvo.getDehCode();
				int mount = dehvo.getDehAmount();
				if(deSum.get(code) != null) {
					int money = deSum.get(code);
					int sum = mount + money;
					deSum.put(code, sum);
				}else {
					deSum.put(code, mount);
				}
			}
		}
		for(int j = 1; j <= alSum.size(); j++) {
			AlHistoryVO alVo = new AlHistoryVO();
			if(j < 10) {
			    int money = alSum.get("0"+String.valueOf(j));
			    alVo.setAlhAmount(money);
			    alVo.setAlhCode("0"+String.valueOf(j));
			}else {
				int money = alSum.get(String.valueOf(j));
				alVo.setAlhAmount(money);
				alVo.setAlhCode(String.valueOf(j));
			}
			sumAl.add(alVo);
			sumA += alVo.getAlhAmount();
		}
		for(int j = 1; j <= deSum.size(); j++) {
			DeHistoryVO deVo = new DeHistoryVO();
			if(j < 10) {
				int money = deSum.get("0"+String.valueOf(j));
				deVo.setDehAmount(money);
				deVo.setDehCode("0"+String.valueOf(j));
			}else {
				int money = deSum.get(String.valueOf(j));
				deVo.setDehAmount(money);
				deVo.setDehCode(String.valueOf(j));
			}
			sumDe.add(deVo);
			sumD += deVo.getDehAmount();
		}
		long sumT = (long) sumA - (long)sumD;
		model.addAttribute("sumT",sumT);
		model.addAttribute("sumD",sumD);
		model.addAttribute("sumDe",sumDe);
		model.addAttribute("sumA",sumA);
		model.addAttribute("sumAl",sumAl);
		model.addAttribute("empl",emplList);
		model.addAttribute("alList",alList);
		model.addAttribute("deList",deList);
	
		
		return "//sal/salWork/payInfo";
	}
	
	
	@RequestMapping(value="/sal/calculate.do",method=RequestMethod.POST)
	public String calculate(
	@RequestParam(value="stdate") String stDate,
	Model model
		) {
		String[] z = stDate.split("-");
		String mix = z[0] +"-"+ z[1] + " -"+z[2];
		ServiceResult result = service.calculate(mix);
		
		
		return "sal/salWork/salWorkList";
	}
	
	
	
	
}
