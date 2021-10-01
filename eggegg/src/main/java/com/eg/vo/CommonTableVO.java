package com.eg.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommonTableVO implements Serializable{

	private String ctTable;   // 종류
	private String ctNm;   // 명칭
	private String ctUse;   // 사용구분
	private String ctNote1;   // 비고1
	private String ctNote2;   // 비고2
	private String ctNote3;   // 비고3
	
}
