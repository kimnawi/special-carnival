package com.eg.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@EqualsAndHashCode(of="tfCode")
@NoArgsConstructor
@Data
public class TaxFreeVO {
	
	private String tfCode;
	private String tfNm;
	private String tfIncome;
	private String tfLaw;
	private String tfWrite;
	private String tfSumry;
	

}
