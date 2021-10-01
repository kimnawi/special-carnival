package com.eg.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="adgCode")
public class AdGroupVO {
	
	private String adgCode;
	private String adgNm;
}
