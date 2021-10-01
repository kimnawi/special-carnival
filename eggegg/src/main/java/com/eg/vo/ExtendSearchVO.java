package com.eg.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class ExtendSearchVO extends SearchVO{
	public ExtendSearchVO(String searchType, String searchWord) {
		super(searchType, searchWord);
	}
	private String startDate;
	private String endDate;
	private String startDate2;
	private String endDate2;
	private String typePrefix;
}
