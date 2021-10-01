package com.eg.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of= {"qcEmpl", "qcNm"})
public class QualificateVO implements Serializable {

	private String qcExpire;	//만료일자
	private String qcDate;		//취득일자
	@NotNull
	private Integer qcEmpl;		//사원번호
	private String commonNo;	//파일번호
	@NotBlank
	private String qcNm;		//자격증명
	private String qcScore;		//점수/레벨
	
}
