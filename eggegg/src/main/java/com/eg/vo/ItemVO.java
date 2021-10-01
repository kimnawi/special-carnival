package com.eg.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ItemVO {

	private Integer itemIemCode;   // 항목코드
	private String itemIemNm;   // 항목명
	private Integer dfNo;   // 양식번호
	
}
