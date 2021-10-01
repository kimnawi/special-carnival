package com.eg.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
/**
 * 인사발령구분테이블
 * @author PC-22
 *
 */
@Data
public class GnfdTypeVO implements Serializable {
	
	@NotBlank
	private String ctTable;
	private String ctNm;
}
