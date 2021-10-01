package com.eg.vo;

import java.util.List;

import lombok.Data;

@Data
public class WorkVO {

	private String emplNm;
	
	private String emplNo;
	
	private String alCode;
	
	private String prjCode;
	
	private String prjNm;
	
	private String workHour;
	
	private String workDate;
	
	private String workStdate;
	
	private Integer emplCount;
	
	private String alNm;
	
	private String alProvide;
	
	private String startDate;
	private String lastDate;
	
	private String searchEmpl;
	
	private String emplDel;
	
	private String dateDel;
	
	private String codeDel;
	
	private List<WorkVO> updateList;
	
	private List<WorkVO> deleteList;
	
	
}
