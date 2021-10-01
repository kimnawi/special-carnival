package com.eg.vo;

import java.io.Serializable;

import lombok.Getter;

@Getter
public class DeptWrapperVO implements FancyTreeNode, Serializable {

	private DeptVO adaptee;
	
	public DeptWrapperVO(DeptVO adaptee) {
		super();
		this.adaptee = adaptee;
	}
	
	@Override
	public String getTitle() {
		return adaptee.getDeptNm();
	}

	@Override
	public String getKey() {
		return adaptee.getDeptCode();
	}
	
	@Override
	public boolean isFolder() {
		return !adaptee.getLeaf();
	}

	@Override
	public boolean isLazy() {
		return isFolder();
	}

}
