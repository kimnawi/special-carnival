package com.eg.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@ EqualsAndHashCode(of="deCode")
@NoArgsConstructor
@Data
public class DeductionVO {

	private String deCode;
	private String deNm;
	private String deSeq;
	private String deUse;
	
}
