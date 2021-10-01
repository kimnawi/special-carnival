package com.eg.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of="smNo")
@Data
public class ScheVO {

	private String smNo;          // 일정번호
 	private String smTitle;       // 제목
	private String smType;        // 일정구분코드
	private String smLocation;    // 장소
	private String smStart;       // 시작일자
	private String smStartTm;     // 시작일시
	private String smEnd;         // 종료일시
	private String smReport;      // 알림내용
	private String smContent;     // 내용
	private Integer smRegisterId; // 등록자ID

	private EmplVO empl;
	
	private String smStartTmCal;
	private String smEndTmCal;
}