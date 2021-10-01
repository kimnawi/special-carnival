package com.eg.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RolesVO implements Serializable{

	private String authority;   	// 권한코드
	private String roleName;   		// 권한명
	private String description;   	// 상세
	private String createDate;   	// 생성일자
	private String modifyDate;   	// 수정일자
	
}
