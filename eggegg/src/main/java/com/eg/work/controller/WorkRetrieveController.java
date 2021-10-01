package com.eg.work.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.vo.AllowanceVO;
import com.eg.vo.AutoAllowVO;
import com.eg.vo.HolidayVO;
import com.eg.vo.PagingVO;
import com.eg.vo.ProjectVO;
import com.eg.vo.WorkVO;
import com.eg.work.dao.WorkDAO;
import com.eg.work.service.WorkService;

@Controller
public class WorkRetrieveController {
	
	@Inject
	private WorkDAO DAO;
	
	@Inject
	private WorkService service;
	
	@RequestMapping("/sal/workList.do")
	public String workList(
			Model model
			) {
		model.addAttribute("selectedMenu","WorkCheck");
		return "sal/work/workCheckList";
	}
	
	@RequestMapping(value="/sal/workList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<WorkVO> listforAjax(
		@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
		@ModelAttribute("detailSearch") WorkVO detailSearch
	){
		PagingVO<WorkVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailSearch(detailSearch);
		service.retreiveWorkList(pagingVO);
		
		return pagingVO;
	}
	@RequestMapping(value="/sal/searchWorkList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<WorkVO> listforAjax2(
			@RequestParam(value="stdate") String stdate,
			@RequestParam(value="searchEmpl") String searchEmpl,
			@RequestParam(value="start") String start,
			@RequestParam(value="end") String end
			){
			WorkVO vo = new WorkVO();
			if(searchEmpl.length() >0) {
				vo.setSearchEmpl(searchEmpl);
			}
			if(start.length() >0) {
				vo.setStartDate(start);
			}
			if(end.length()>0) {
				vo.setLastDate(end);
			}
			vo.setWorkStdate(stdate);
			List<WorkVO> list =  service.searchWorkList(vo);
		
		
		return list;
	}
	
	
	
	@RequestMapping("/sal/popAllowanceList.do")
	public String allowanceList(
	Model model
	) {
		List<AllowanceVO> alList = DAO.alList();
		
		model.addAttribute("alList",alList);
		
		return "//sal/work/allowanceList";
	}
	
	@RequestMapping("/sal/popProjectList.do")
	public String projectList(
	Model model		
	) {
		List<ProjectVO> proList = DAO.projectList();
		
		model.addAttribute("projectList",proList);
		
		return "//sal/work/projectList";
	}
	
	@RequestMapping("/sal/workEmplList.do")
	@ResponseBody
	public AutoAllowVO ajax(
		@RequestParam(value="date") String date,
		@RequestParam(value="No") Integer No
	) throws IOException, Exception {
		String[] apidate = date.split("-");
		String apiYear = apidate[0];
		String apiMonth = apidate[1];
	     StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") 
	        + "=wMrVQ1pKk59%2FX%2BUYc8C9lcCluYVwE81IcgIgf5R2A8j63Qr9yUY%2FlNdHUda5qM3zhTX2K3tUgGUXSEO7XviDwg%3D%3D"); /*Service Key*/
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
	        List<HolidayVO> holidayList = new ArrayList<>();
	        for(int i=0;i<parse_itemlist.length();i++) {
	        	JSONObject data = (JSONObject) parse_itemlist.get(i);
	        	String name = (String) data.get("dateName");
	        	String locdate = String.valueOf(data.get("locdate"));
	        	HolidayVO vo = new HolidayVO();
	        	vo.setDateName(name);
	        	vo.setLocdate(locdate);
	        	holidayList.add(vo);
	        }
	        String[] day = date.split("-");
	        LocalDate initial = LocalDate.of(Integer.parseInt(day[0]),Integer.parseInt(day[1]),Integer.parseInt(day[2]));
	        LocalDate start = initial.withDayOfMonth(1);
	        LocalDate end = initial.withDayOfMonth(initial.lengthOfMonth());
	        
	        AutoAllowVO input = new AutoAllowVO();
	        input.setWorkTime(start.toString());
	        input.setFinishTime(end.toString());
	        input.setEmplNo(No);
	        List<AutoAllowVO> list= DAO.list(input);
	        AutoAllowVO auto = new AutoAllowVO();
	        for(int i=0;i<list.size();i++) {
	        	for(int j=0; j<holidayList.size();j++) {
	        		if(list.get(i).getDateCode().equals(holidayList.get(j).getLocdate())) {
	        			list.get(i).setHoliday("Y");
	        			break;
	        		}else {
	        			list.get(i).setHoliday("N");
	        		}
	        	}
	        }
	        List<AutoAllowVO> pto = DAO.pto(input);
	        for(int i=0; i<list.size();i++) {
	        	for(int j =0;j<pto.size();j++) {
	        		if(list.get(i).getDateCode().equals(pto.get(j).getPto())) {
	        			list.get(i).setPto("Y");
	        			break;
	        		}else {
	        			list.get(i).setPto("N");
	        		}
	        	}
	        }
	        auto.setAutoList(list);
	        return auto;
	}

}
