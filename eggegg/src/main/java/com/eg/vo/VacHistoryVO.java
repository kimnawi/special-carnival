package com.eg.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of= {"emplNo", "vcatnCode"})
public class VacHistoryVO implements Serializable {
	
	@NotNull
	private Integer emplNo;
	@NotBlank
	private String vcatnCode;
	private Integer vcatnAmount;
	private Integer vcatnAmountWr;
	private String vcatnReason;
	
	private String vcatnDay;	//총 휴가일수
	private String vcatnLeft;	//잔여 휴가일수
	private String vcatnUse;	//사용 휴가일수
	
	private String[] emplNoArray;
	private String[] vcatnCodeArray;
	
}
