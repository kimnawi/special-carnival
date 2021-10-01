package com.eg.vo;

import lombok.Data;

@Data
public class DeHistoryVO {

	/**
	 * 공제항목코드
	 */
	private String dehCode;
	
	/**
	 * 금액
	 */
	private int dehAmount;
	
	/**
	 * 신고귀속
	 */
	private String pihStdate;
	
	/**
	 * 대상자ID
	 */
	private int pihEmpl;
	
}
