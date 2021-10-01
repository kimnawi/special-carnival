package com.eg.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.eg.validate.groups.InsertGroup;
import com.eg.validate.groups.UpdateGroup;

import lombok.Data;

@Data
public class VacStatusVO {

	@NotBlank
	private String vacstusCode;
	@NotBlank(groups={InsertGroup.class, UpdateGroup.class})
	private String vacstusDe;
	@NotNull
	private Integer emplNo;
	@NotBlank
	private String vacstusSumry;
	private String vacstusPayment;
	private String vcatnCode;
	private Integer draftNo;
	@NotBlank
	private String vacstusHalfAt;
	
	private String vacstusPeriod;	//휴가기간
	private String vacstusStart;	//휴가시작일
	private String vacstusEnd;		//휴가종료일
	private String vacstusCount;	//휴가일수
	
	private String[] vacstusDeArray;	//휴가날짜 배열
	
	private VacationVO vacation;
	private DraftVO draft;
	private EmplVO empl;
}
