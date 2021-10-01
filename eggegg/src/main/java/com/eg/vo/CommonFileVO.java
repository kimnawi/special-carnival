package com.eg.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class CommonFileVO implements Serializable{
	
	private Integer commonNo; // 공통파일 코드
	private String commonPath; // 파일 경로
	
	List<HistoryVO> histList; // 파일 이력
	
}
