package com.eg.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(of="prjCode")
@NoArgsConstructor
public class ProjectVO {
	
	private String prjCode; //프로젝트코드
	private String prjNm; //프로젝트명
	private String prjSumry; //적요내용
	private String prjUse; //사용구분
	private String prjPeriod; //프로젝트기간
	
	private String start;
	private String end;
}
