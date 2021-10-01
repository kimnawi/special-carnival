package com.eg.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DraftFormVO implements Serializable{

	private String dfUse;   // 사용여부
	private Integer dfNo;   // 양식번호
	private String dfContent;   // 양식내용
	private String dfTitle;   // 양식제목
	
	private ItemVO item;
	
	private Integer[] deleteDfNo; // 일괄삭제에 쓰일 프로퍼티
	
	private Integer emplNo; // 소유자 ID
}
