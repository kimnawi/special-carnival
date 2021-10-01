package com.eg.vo;

import lombok.Data;

@Data
public class ScheAttendeeVO {
	
	private String smNo;     //일정번호
	private Integer emplNo;  //사원번호
	private String smAuthor; //일정관리권한
}
