package com.eg.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@EqualsAndHashCode(of="alCode")
@NoArgsConstructor
@Data
public class AllowanceVO {

	private String alCode;
	private String alNm;
	private Integer alSeq;
	private String alProvide;
	private String tfCode;
	private String alUse;
	
	private String tfNm;
	
	private List<AllowanceVO> alList;
}
