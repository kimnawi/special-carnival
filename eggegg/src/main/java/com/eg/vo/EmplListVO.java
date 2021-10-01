package com.eg.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class EmplListVO implements Serializable{

	List<EmplVO> emplList;
	
}
