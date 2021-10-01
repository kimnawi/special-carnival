package com.eg.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class AbTypeVO implements Serializable {

	@NotBlank
	private String ctTable;
	private String ctNm;
	private String ctUse;
	
}
