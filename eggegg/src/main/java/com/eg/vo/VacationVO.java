package com.eg.vo;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="vcatnCode")
public class VacationVO {

	@NotBlank
	private String vcatnCode;
	@NotBlank
	private String vcatnNm;
	@NotBlank
	private String vcatnStart;
	private String vcatnEnd;
	private String vcatnSumry;
	@NotBlank
	private String vcatnUse;
	
	private int emplCount;
	
	//검색용
	private String[] emplNoArray;
	
	//VO
	private VacationVO vcatn;	//휴가
	private EmplVO empl;		//사원
	
	
}
