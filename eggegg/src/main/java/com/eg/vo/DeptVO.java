package com.eg.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class DeptVO implements Serializable {

	@NotBlank
	private String deptCode;
	private String deptNm;
	private String deptAuthor;
	private String deptUse;
	private String deptParent;
	private String deptLeader;
	
	private Boolean leaf;
	
	private String deptPnm;
	
	//VO
	private List<EmplVO> emplList;
//	private List<EmplVOWrapper> emplWrapperList;
}
