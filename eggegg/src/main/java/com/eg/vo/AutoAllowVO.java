package com.eg.vo;

import java.util.List;

import lombok.Data;

@Data
public class AutoAllowVO {
	private Integer work;
	private String workTime;
	private String finishTime;
	private Integer emplNo;
	private String dateCode;
	private String day;
	private String holiday;
	private String pto;
	
	
	private List<HolidayVO> holidayList;
	private List<AutoAllowVO> autoList;
}
