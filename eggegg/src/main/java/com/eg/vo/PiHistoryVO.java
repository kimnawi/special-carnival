package com.eg.vo;

import lombok.Data;

@Data
public class PiHistoryVO {

	/**
	 * 신고귀속
	 */
	private String pihStdate;
	
	/**
	 * 대상자ID
	 */
	private int pihEmpl;
	
	/**
	 * 지금총액
	 */
	private int pihAl;
	
	/**
	 * 공제총액
	 */
	private int pihDe;
	
	/**
	 * 실지급액
	 */
	private int pihPay;
	
	/**
	 * 결재구분
	 */
	private String pihPayment;
	
	/**
	 * 기안서번호
	 */
	private int draftNo;
	
}
