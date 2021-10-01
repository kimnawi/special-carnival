package com.eg.vo;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.apache.commons.net.ftp.FTPFile;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(exclude="realRes")
public class FTPFileWrapper implements FancyTreeNode{
	private transient FTPFile realRes;
	
	private String name;
	private boolean directory;
	private String modified;
	private String link;
	private String fileNo;
	private long fileSize;
	private int fileType;
	
	
	//... specific properties

	public FTPFileWrapper(FTPFile realRes) {
		super();
		this.realRes = realRes;
		this.name = realRes.getName();
		this.directory = realRes.isDirectory();	
		SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.modified = sDate.format(realRes.getTimestamp().getTime());
		this.link = realRes.getLink();
		this.fileNo = realRes.getUser();
		this.fileSize = realRes.getSize();
		this.fileType = realRes.getType();
		
	}

	@Override
	public String getTitle() {
		return this.name;
	}

	@Override
	public boolean isFolder() {
		return this.directory;
	}

	@Override
	public String getKey() {
		return this.link;
	}

	@Override
	public boolean isLazy() {
		return isFolder();
	}
	
}
