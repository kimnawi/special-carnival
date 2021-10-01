package com.eg.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = {"abSchool", "abEmpl"})
public class AcademicVO implements Serializable {

	
	private String abAdmission;		//입학일자
	private String abGraduation;	//졸업일자
	@NotBlank
	private String abSchool;		//학교명
	private String abMajor;			//전공명
	private String abGrdtype;		//졸업구분
	@NotNull
	private Integer abEmpl;			//사원번호
	@NotBlank
	private String abType;			//학력구분
	
	private EmplVO empl;		//사원
	private AbTypeVO acaType;	//학력구분
	
}
