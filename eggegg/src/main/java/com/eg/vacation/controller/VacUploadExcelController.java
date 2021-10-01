package com.eg.vacation.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.eg.vacation.service.VacService;

@Controller
public class VacUploadExcelController {
	
	@Inject
	private VacService service;
	
	@RequestMapping(value="/vac/uploadEmplExcel.do", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public void uploadExcel(
			MultipartHttpServletRequest request
			, MultipartFile fileInput
			, Model model
			, HttpServletResponse response
		) {
		response.setContentType("application/json; charset=utf-8");
		try {
			PrintWriter printWriter = response.getWriter();
			JSONObject jsonObject = new JSONObject();
			
			MultipartFile excelFile = null;
			Iterator<String> iterator = request.getFileNames();
			if(iterator.hasNext()) {
				excelFile = request.getFile(iterator.next());
			}
			List<Map<String, Object>> emplList = service.uploadExcel(excelFile);
			JSONArray jsonArray = new JSONArray();
			for(Map<String, Object> map: emplList) {
				jsonArray.add(map);
			}
			printWriter.print(jsonArray.toJSONString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
