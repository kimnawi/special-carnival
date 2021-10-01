package com.eg.vo;

import java.io.Serializable;
import java.util.Objects;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EmplFancyWrapperVO implements FancyTreeNode, Serializable{
	private EmplVO adaptee;
	
	
	@Override
	public String getTitle() { // ui에 보여질 내용
		return adaptee.getEmplNm()+"("+adaptee.getEmplNo()+")";
	}

	@Override
	public boolean isFolder() {
		return !adaptee.getLeaf();
	}

	@Override
	public String getKey() { // 식별자
		return Objects.toString(adaptee.getEmplNo(),"");
	}

	@Override
	public boolean isLazy() {
		return isFolder();
	}
	
}
