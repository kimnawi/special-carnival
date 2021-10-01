package com.eg.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CompanyVO implements Serializable{

	private String comNo;   // 사업자등록번호
	private String comNm;   // 회사명
	private String comStart;   // 출근기준시간
	private String comEnd;   // 퇴근기준시간
	private Integer comPay;   // 기본급여
	private String comRep;   // 대표자
	private String comEstablish;   // 설립일자
	private String comCycle;   // 결산주기
	private String comTel;   // 회사전화
	private String comEmail;   // 회사이메일
	private String comMobile;   // 모바일
	private String comAddress;   // 주소
	
}
