package com.eg.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SearchVO implements Serializable {

	private String SearchType;
	private String SearchWord;
	
	
}
