package com.eg.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import com.eg.validate.groups.InsertGroup;
import com.eg.validate.groups.UpdateGroup;

import lombok.Data;

@Data
public class OfficialOrderVO implements Serializable {

	@NotBlank(groups=InsertGroup.class)
	private String emplNo;
	private String gnfdStdrde;
	private String gnfdDe;
	private String gnfdSumry;
	private String deptBnm;
	private String deptAnm;
	private String gnfdBposition;
	private String gnfdAposition;
	@NotBlank(groups= {InsertGroup.class, UpdateGroup.class})
	private String gnfdType;
	private String gnfdEntrance;
	private Integer draftNo;
	
	//VO
	private EmplVO empl;
	private GnfdTypeVO gnfd;
	private DraftVO draft;
	private PositionVO position;
	private DeptVO dept;
	
	//검색
	private String gnfdStartDe;	//인사발령 검색 시작 발령일자
	private String gnfdEndDe;	//인사발령 검색 종료 발령일자
	private String[] emplNoArray;	//사원번호 배열
	
}
