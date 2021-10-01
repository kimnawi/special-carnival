package com.eg.vo;

import java.io.File;

public class FancyTreeNodeAdapter extends File implements FancyTreeNode {
	public FancyTreeNodeAdapter(File adaptee, String relativePath) {
		this(adaptee, relativePath, false);
	}
	
	public FancyTreeNodeAdapter(File adaptee, String relativePath, boolean nonDelete) {
		super(adaptee.getAbsolutePath());
		this.key = relativePath;
		this.nonDelete = nonDelete;
	}

	private String key;
	
	private boolean nonDelete;
	
	public boolean isNonDelete() {
		return nonDelete;
	}
	
	@Override
	public String getTitle() {
		return getName();
	}

	@Override
	public boolean isFolder() {
		return isDirectory();
	}

	@Override
	public String getKey() {
		return this.key;
	}
	
	@Override
	public boolean isLazy() {
		return isFolder();
	}
	
	@Override
	public int compareTo(File pathname) {
		boolean mine = isDirectory();
		boolean other = pathname.isDirectory();
		if(mine ^ other) {
			return mine? -1 : 1;
		}else {
			return super.compareTo(pathname);
		}
	}
}











