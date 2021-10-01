package com.eg.group.drive.service;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.eg.commons.ServiceResult;
import com.eg.vo.FTPFileWrapper;

public interface FTPFileService {
	
	public static enum CommandType {
		COPY,DELETE,MOVE,ARCHIVE,DOWNLOAD,CHANGENM,NFOLDER
	}
	
	public List<FTPFileWrapper> traversing(String base) throws Exception;
	public void uploadFile(MultipartFile sendFile, String paths, Map<String, Object> result) throws Exception;
	public ServiceResult fileManage(CommandType command, String src, String dest, String...histParam) throws Exception;
	public List<FTPFileWrapper> fileList(String base) throws Exception;
	public void downloadFile(String link, HttpServletResponse resp) throws Exception;
	public void compressFiles(OutputStream outputStream, String[] path) throws Exception;
	public void getImgFile(String link, HttpServletResponse resp) throws Exception;
	public void deleteAll(String[] selectedFile, Map<String, Object> result) throws Exception;
	public ServiceResult changeNm(String srcFile, String destFolder, Integer driveOper, String userIp) throws Exception;
	public ServiceResult newFolder(String srcFile, String destFolder) throws Exception;
}
