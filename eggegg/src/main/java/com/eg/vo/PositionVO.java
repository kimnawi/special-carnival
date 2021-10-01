package com.eg.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PositionVO implements Serializable {

	@NotBlank
	private String pstCode;
	@NotBlank
	private String pstNm;
	private String pstParent;
	
}
