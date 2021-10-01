package com.eg.vacation.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.json.simple.parser.JSONParser;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eg.commons.ServiceResult;
import com.eg.empl.dao.EmplDAO;
import com.eg.vacation.dao.VacDAO;
import com.eg.vacation.service.VacService;
import com.eg.validate.groups.InsertGroup;
import com.eg.vo.AutoAllowVO;
import com.eg.vo.EmplVO;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.HolidayVO;
import com.eg.vo.VacStatusVO;

@Controller
public class VacApplyInsertController {
	
	@Inject
	private VacService service;
	@Inject
	private VacDAO dao;
	@Inject
	private EmplDAO emplDao;
	
	@ModelAttribute("empl")
	public EmplVO emplInfo(
			@AuthenticationPrincipal EmplVOWrapper wrapper
		) {
		Integer emplNo = wrapper.getAdaptee().getEmplNo();
		return emplDao.selectEmplDetail(emplNo);
	}
	
	@ModelAttribute("command")
	public String command() {
		return "INSERT";
	}
	
	@RequestMapping("/vac/vacApplyDraft.do")
	public String vacApplyDraft(
			@AuthenticationPrincipal EmplVOWrapper wrapper
			, @RequestParam("what") String vacstusCode
			, Model model
		) {
		Integer emplNo = wrapper.getAdaptee().getEmplNo();
		VacStatusVO vacStus = new VacStatusVO();
		vacStus.setEmplNo(emplNo);
		vacStus.setVacstusCode(vacstusCode);
		vacStus = dao.selectVacApplyDetail(vacStus);
		model.addAttribute("vacStus", vacStus);
		return "/vac/vacApplyDraft";
	}
	
	@RequestMapping(value="/vac/vacApplyInsert.do", method=RequestMethod.GET)
	public String vacApplyForm(Model model) {
		String vacstusCode = dao.selectNextVacstusCode();
		VacStatusVO vacStus = new VacStatusVO();
		vacStus.setVacstusCode(vacstusCode);
		model.addAttribute("vacStus", vacStus);
		return "/vac/vacApplyForm";
	}
	
	@RequestMapping(value="/vac/vacApplyInsert.do", method=RequestMethod.POST)
	public String createApplyForm(
			@Validated(InsertGroup.class) @ModelAttribute("vacApply") VacStatusVO vacStus
			, Errors errors
			, Model model
			, RedirectAttributes redirectAttributes
		) {
		String message = null;
		String success = null;
		
		String[] vacstusDeArray = vacStus.getVacstusDe().split(",");
		vacStus.setVacstusDeArray(vacstusDeArray);
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.createVacApply(vacStus);
			switch (result) {
			case OK:
				success = "SUCCESS";
				break;
			default:
				message = "서버 오류, 잠시 후에 다시 시도해주세요.";
				break;
			}
		}
		redirectAttributes.addFlashAttribute("message", message);
		model.addAttribute("success", success);
		model.addAttribute("vacApply", vacStus);
		
		return "/vac/vacApplyForm";
	}
	
	@RequestMapping("/vac/holiday.do")
	@ResponseBody
	public List<HolidayVO> weekday(
			@RequestParam(value="start") String start,
			@RequestParam(value="last") String last
	) throws Exception {
		String[] startdate = start.split("-");
		String stYear = startdate[0];
		String stMonth = startdate[1];
		
		String[] lastdate = last.split("-");
		String laYear = lastdate[0];
		String laMonth = lastdate[1];
		int ch = Integer.parseInt(lastdate[2])+1;
		String text = null;
		if(ch <10) {
			text = "0"+ch;
		}else {
			text = String.valueOf(ch);
		}
		String input = laYear+"-"+laMonth+"-"+(text);
		AutoAllowVO vo2 = new AutoAllowVO();
		vo2.setWorkTime(start);
		vo2.setFinishTime(input);
		List<AutoAllowVO> weekList = dao.selectWeekday(vo2);
		List<HolidayVO> holidayList = new ArrayList<>();
		for(int z=0;z<2;z++) {
			String apiYear = null;
			String apiMonth = null;
			if(z==0) {
				apiYear = stYear;
				apiMonth = stMonth;
			}else {
				apiYear = laYear;
				apiMonth = laMonth;
			}
	     StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=wMrVQ1pKk59%2FX%2BUYc8C9lcCluYVwE81IcgIgf5R2A8j63Qr9yUY%2FlNdHUda5qM3zhTX2K3tUgGUXSEO7XviDwg%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("solYear","UTF-8") + "=" + URLEncoder.encode(apiYear, "UTF-8")); /*연*/
	        urlBuilder.append("&" + URLEncoder.encode("solMonth","UTF-8") + "=" + URLEncoder.encode(apiMonth, "UTF-8")); /*월*/
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        JSONObject xmlJSONObj = XML.toJSONObject(sb.toString());
	        String json = xmlJSONObj.toString();
	        
	        JSONParser paser = new JSONParser();
	        JSONObject parse_response = (JSONObject) xmlJSONObj.get("response");
	        JSONObject parse_body = (JSONObject) parse_response.get("body");
	        JSONObject parse_items = parse_body.getJSONObject("items");
	        JSONArray parse_itemlist = (JSONArray) parse_items.get("item");
	        for(int i=0;i<parse_itemlist.length();i++) {
	        	JSONObject data = (JSONObject) parse_itemlist.get(i);
	        	String name = (String) data.get("dateName");
	        	String locdate = String.valueOf(data.get("locdate"));
	        	HolidayVO vo = new HolidayVO();
	        	vo.setDateName(name);
	        	vo.setLocdate(locdate);
	        	holidayList.add(vo);
	        }
	        
		}
		List<HolidayVO> list = new ArrayList<>();
		for(int i =0; i<weekList.size();i++) {
			String holi = null;
			for(int j=0;j<holidayList.size();j++) {
				if(weekList.get(i).getDateCode().equals(holidayList.get(j).getLocdate())) {
					holi = "Y";
					break;
				}else {
					holi = "N";
				}
			}
			HolidayVO vo = new HolidayVO();
			vo.setLocdate(weekList.get(i).getDateCode());
			vo.setDateName(holi);
			list.add(vo);
		}
		return list;
		
	}
}
