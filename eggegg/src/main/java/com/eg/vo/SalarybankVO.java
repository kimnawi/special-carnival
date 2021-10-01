package com.eg.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="slryAcnutno")
public class SalarybankVO implements Serializable {

	@NotBlank
	private String slryAcnutno;
	@NotNull
	private Integer emplNo;
	@NotBlank
	private String slryDpstr;
	@NotBlank
	private String bankCode;
	
	private bankVO bank;
	
}
