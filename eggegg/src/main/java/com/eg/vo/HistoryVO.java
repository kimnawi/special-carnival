package com.eg.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class HistoryVO implements Serializable{

	private Integer histCode;   // 이력코드   // 자동입력
	
	private Integer commonNo;    // 파일번호 -- 입력해줘
	private String fileNm;  	// 파일명 xx
	
	private String histPath;  // 파일 경로 -- 입력해줘

	private String histDe;  	// 작업일자   // 자동입력
	private String histIo;  	// 작업코드  -- 입력해줘
	private String histNm;  	// 작업명 xx
	
	private long fileSize;   	// 파일크기 -- 입력해줘
	
	private Integer driveOper; 	// 작업자 -- 입력해줘
	private String emplNm;  	// 작업자 명 xx
	
	private String ip;   		// IP -- 입력해줘
	
}
