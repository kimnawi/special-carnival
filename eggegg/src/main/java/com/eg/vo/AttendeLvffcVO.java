package com.eg.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.eg.validate.groups.InsertGroup;

import lombok.Data;

@Data
public class AttendeLvffcVO implements Serializable {

	@NotNull
	private String atvlEmpl;
	@NotBlank(groups=InsertGroup.class)
	private String atvlAttTm;
	private String atvlLvTm;
	private String atvlForm;
	private String atvlNote;
	private String atvlPlace;
	@NotBlank(groups=InsertGroup.class)
	private String dateCode;
	
	private int atvlWorkTm;	//근무시간
	private String dateDay;	//요일
	
	//검색
	private String atvlMonth;	//출/퇴근 월
	private String atvlStartDate;	//일자검색(시작일)
	private String atvlEndDate;		//일자검색(종료일)
	private String[] atvlEmplArray;	//사원배열
	private String atvlWorkAt;		//업무일/휴일구분
	
	//cnt
	private int emplWorkCnt;	//근무자 수
	private int emplInCnt;		//내부 근무자 수
	private int emplOutCnt;		//외부 근무자 수
	private int emplAbseCnt;	//결근자 수
	private int emplCnt;		//재직자 수
	
	//VO
	private EmplVO empl;
	private DeptVO dept;
}
