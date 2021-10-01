package com.eg.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AdGroupAllVO implements Serializable{
	private String alCode;
	private String alNm;
	private Integer alSeq;
	private String alProvide;
	private String tfCode;
	private String alUse;
	
	private String deCode;
	private String deNm;
	private String deSeq;
	private String deUse;
	@NotNull
	private String adgCode;
	@NotBlank
	private String adgNm;
	
	private String algAmount;
	private String adgAmount;
	
	private List<AdGroupAllVO> alGroup;
	private List<AdGroupAllVO> deGroup;
	
	private List<EmplVO> empl;
	
	private String emplNo;
	private String emplAdgper;
	
	private String mdAmount;
	private String faAmount;
	private String emplDel;
	
	
}
