package com.eg.group.drive.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.pool2.ObjectPool;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import com.eg.commons.ServiceResult;
import com.eg.commons.exception.DataNotFoundException;
import com.eg.file.service.CommonFileService;
import com.eg.util.AES256Util;
import com.eg.vo.CommonFileVO;
import com.eg.vo.FTPFileWrapper;
import com.eg.vo.HistoryVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service("ftpPoolService")
@Lazy
public class FTPFileServiceImpl_WithPool implements FTPFileService {
	@Inject
	WebApplicationContext container;
	
	ServletContext application;
	
	@Inject
	DriveService driveService;
	
	@Inject
	CommonFileService fileService;
	
	@Inject
	AES256Util encoder;
	
	@PostConstruct
	public void init(){
		application = container.getServletContext();
	}
	
	
	@Resource(name="FTPClientPool")
	private ObjectPool<FTPClient> clientPool;
	
	@Override
	public List<FTPFileWrapper> fileList(String base) throws Exception {
		List<FTPFileWrapper> files = new ArrayList<>();
		FTPClient ftpClient = null;
		try {
			if(base.startsWith("first:")) {
				base = base.substring("first:".length());
				base = encoder.encrypt(base);
			}
			base = encoder.decrypt(base);
			ftpClient = clientPool.borrowObject();
			if(StringUtils.isNotBlank(base)) {
				String[] depths = base.split("\\\\");
				ftpClient.changeWorkingDirectory("/");
				if(depths.length > 0) {
					for(String depth:depths) {
						if(depth.isEmpty()) continue;
						ftpClient.changeWorkingDirectory(depth);
					}
				}
			}
			 FTPFile[] listFiles = ftpClient.listFiles();
			 if (listFiles != null) {
					for (FTPFile file : listFiles) {
						if (file == null) continue;
						
						if(StringUtils.isNotBlank(base)) { 
							if(file.isDirectory()) continue;
							else file.setLink(encoder.encrypt(base+File.separator+file.getName()));
						}
						else {
							if(file.isDirectory())	continue;
							else file.setLink(encoder.encrypt(File.separator+file.getName()));
						}
						
						files.add(new FTPFileWrapper(file));
					}
				 }else {
					 files = null;
				 }
			}finally {
				clientPool.returnObject(ftpClient);
			}
		    ftpClient.changeWorkingDirectory("/");
			 
		return files;
	}
	
	@Override
	public List<FTPFileWrapper> traversing(String base) throws Exception {
		 List<FTPFileWrapper> files = new ArrayList<>();
		 FTPClient ftpClient = null;
		 try {
			 ftpClient = clientPool.borrowObject();
			 if(StringUtils.isNotBlank(base)) {
				 if(base.startsWith("first:")) {
					 base = base.substring(base.indexOf(":")+1,base.length());
				 }else {
					 base = encoder.decrypt(base);
				 }
				 String[] depths = base.split("\\\\");
				 ftpClient.changeWorkingDirectory("/");
				 if(depths.length > 0) {
					 for(String depth:depths) {
						 if(depth.isEmpty()) continue;
						 ftpClient.changeWorkingDirectory(depth);
					 }
				 }
			 }
			 
			 FTPFile[] listFiles = ftpClient.listFiles();
			 if (listFiles != null) {
				for (FTPFile file : listFiles) {
					if (file == null) continue;
					
					if(StringUtils.isNotBlank(base)) 
						
					 if(file.isDirectory()) file.setLink(encoder.encrypt(base+file.getName()+File.separator));
					 else continue;
					else 
					 if(file.isDirectory())	file.setLink(encoder.encrypt(file.getName()+File.separator));
					 else continue;
					
					files.add(new FTPFileWrapper(file));
				}
			 }else {
				 files = null;
			 }
		}finally {
		}
		 clientPool.returnObject(ftpClient);
	    ftpClient.changeWorkingDirectory("/");
		return files;
	}
	
	@Transactional
	@Override
	public void uploadFile(MultipartFile sendFile, String pathStr, Map<String,Object> result) throws Exception {
		 result.put("result","실패");
		 FTPClient ftpClient = null;
		 pathStr = encoder.decrypt(pathStr);
		 System.out.println("pathStr"+pathStr);
		 String[] paths = (pathStr).split("\\\\");
		 try {
			 ftpClient = clientPool.borrowObject();
			ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
			for(int i = 0 ; i < paths.length; i++) {
				String path = paths[i];
				ftpClient.makeDirectory(path);
				ftpClient.changeWorkingDirectory(path);
			}
			FTPFile[] savedFile = ftpClient.listFiles(sendFile.getOriginalFilename());
			ftpClient.storeFile(sendFile.getOriginalFilename(), sendFile.getInputStream());
			if(savedFile.length > 0 ) result.put("result","파일 수정");
			else {
				result.put("result","업로드 성공");
			}
			String resultPath = encoder.encrypt(pathStr+File.separator+sendFile.getOriginalFilename());
			result.put("resultPath", resultPath);
			if("DRIVE".equals(result.get("command"))) {
				CommonFileVO fileVO = new CommonFileVO();
				HistoryVO histVO = new HistoryVO();
				if("파일 수정".equals(result.get("result"))) {
					histVO.setHistIo("Q200");
					fileVO = fileService.retrieveCommonFileByPath(encoder.encrypt(pathStr+File.separator+sendFile.getOriginalFilename()));
				}else if("업로드 성공".equals(result.get("result"))){
					histVO.setHistIo("Q100");
					fileVO.setCommonPath(resultPath);
					Integer fileNo = fileService.createCommonFile(fileVO);
					fileVO.setCommonNo(fileNo);
				}
				histVO.setCommonNo(fileVO.getCommonNo());
				histVO.setHistPath(resultPath);
				String userIp = (String) result.get("userIp");
				histVO.setIp(userIp);
				histVO.setFileSize(sendFile.getSize());
				Integer authEmpl = (Integer) result.get("authEmplNo");
				histVO.setDriveOper(authEmpl);
				driveService.createHist(histVO);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			clientPool.returnObject(ftpClient);
			ftpClient.changeWorkingDirectory("/");
		}
	}
	
	
	@Override
	public ServiceResult fileManage(CommandType command, String src, String dest, String...histParam) throws Exception {
		 FTPClient ftpClient = null;
		 File temp = null;
		 boolean result = false;
		 src = encoder.decrypt(src);
		 dest = encoder.decrypt(dest);
		 try {
			 ftpClient = clientPool.borrowObject();
			 
			 FTPFile srcFile = ftpClient.mlistFile(src);
			 if(srcFile == null) {
				 throw new DataNotFoundException();
			 }
			 String tempPathStr = application.getRealPath("/resources/ftpTemp")+File.separator;
			 File tempPath = new File(tempPathStr);
			 if(!tempPath.exists()) tempPath.mkdirs();
			 
			 if(srcFile.isFile()) result = commandFile(command,temp,src,tempPath,ftpClient,dest, histParam);
			 else result = commandDir(command,src,tempPathStr,ftpClient,dest);
		 }finally {
			 clientPool.returnObject(ftpClient);
			 ftpClient.changeWorkingDirectory("/");
		}
		 
		 
		return result ? ServiceResult.OK : ServiceResult.FAIL;
	}

	private boolean commandDir(CommandType command, String src, String tempPathStr, FTPClient ftpClient, String dest) throws IOException {
		String[] srcPath = src.split("\\\\");
		String realDest = dest+srcPath[srcPath.length-1];
		boolean result = false;
		
		for(String path:srcPath) {
			ftpClient.changeWorkingDirectory(path);
		}
		FTPFile[] list = ftpClient.listFiles();
		
		if(command.equals(CommandType.COPY)||command.equals(CommandType.MOVE)) {
			result = copyDir(ftpClient, list, tempPathStr+realDest); 
			ftpClient.changeWorkingDirectory("/");
			 if(command.equals(CommandType.MOVE)) {
				 for(String path:srcPath) {
						ftpClient.changeWorkingDirectory(path);
					}
				 cleanDir(ftpClient,list);
				 ftpClient.changeToParentDirectory();
				 result = ftpClient.removeDirectory(srcPath[srcPath.length-1]);
			 }
		 }else if(command.equals(CommandType.DELETE)) {
			cleanDir(ftpClient,list);
			ftpClient.changeToParentDirectory();
			result = ftpClient.removeDirectory(srcPath[srcPath.length-1]);
		 }
		
		return result;
	}

	private boolean copyDir(FTPClient ftpClient, FTPFile[] list, String tempPathStr) throws IOException {
		FileInputStream fis = null;
		FileOutputStream fos = null;
		File tempPath = new File(tempPathStr);
		boolean result = false;
		if(!tempPath.exists()) tempPath.mkdirs();
		try {
			for(int i = 0 ; i < list.length; i++) {
				FTPFile item = list[i];
				String itemName = item.getName();
				File temp = new File(tempPath,itemName);
				if(item.isFile()) {
					fos = new FileOutputStream(temp);
					ftpClient.retrieveFile(itemName, fos);
				}else {
					temp.mkdirs();
					ftpClient.changeWorkingDirectory(itemName);
					copyDir(ftpClient,ftpClient.listFiles(),tempPathStr+File.separator+itemName);
				}
				if(i==list.length-1) 
				ftpClient.changeToParentDirectory();
			}

			ftpClient.changeWorkingDirectory("/");
			String tempFilePath = tempPathStr.substring((tempPathStr.indexOf("ftpTemp")+"ftpTemp".length()+1));
			String[] tempFilePaths = tempFilePath.split("\\\\");
			for(int i = 0; i < tempFilePaths.length; i++) {
				String path = tempFilePaths[i];
				ftpClient.makeDirectory(path);
				ftpClient.changeWorkingDirectory(path);
			}
			File temp= new File(tempPathStr);
			if(temp!=null) {
			File[] savedFileList = temp.listFiles();
				result = copyFileToFTP(ftpClient,savedFileList);
			}
			
			return result;
		}finally {
			if(fis!=null)fis.close();
			if(fos!=null)fos.close();
			if(tempPath != null)tempPath.delete();
		}
	}
		

	private boolean copyFileToFTP(FTPClient ftpClient, File[] savedFileList) throws IOException {
		if(savedFileList==null||savedFileList.length==0) return true;
		boolean result= false;
		for(int i = 0 ; i < savedFileList.length; i++) {
			File saveFileForFTP = savedFileList[i];
			String fileName= saveFileForFTP.getName();
			if(saveFileForFTP.isFile()) {
				try (
						FileInputStream fis = new FileInputStream(saveFileForFTP);
				){
					result = ftpClient.storeFile(fileName, fis);
				}
			}else if(savedFileList.length==1){
				ftpClient.changeToParentDirectory();
				return true;
			}
			else {
				ftpClient.changeWorkingDirectory(fileName);
				result = copyFileToFTP(ftpClient, saveFileForFTP.listFiles());
			}
			if(i==savedFileList.length-1) {
				ftpClient.changeToParentDirectory();
			}
		}
		return result;
	}

	private void cleanDir(FTPClient ftpClient, FTPFile[] list) throws IOException {
		for(FTPFile item:list) {
			String itemName = item.getName();
			if(item.isFile()) {
				ftpClient.deleteFile(itemName);
			}else {
				ftpClient.changeWorkingDirectory(itemName);
				FTPFile[] innerList = ftpClient.listFiles();
				if(innerList.length>0) {
					cleanDir(ftpClient,innerList);
				}
				ftpClient.changeToParentDirectory();
				ftpClient.removeDirectory(itemName);
			}
		}
	}

	private boolean commandFile(CommandType command, File temp, String src, File tempPath, FTPClient ftpClient, String dest, String...histParam) throws Exception {
		String[] srcPath = src.split("\\\\");
		 String tempFileName = srcPath[srcPath.length-1];
		 boolean result = false;
		 HistoryVO historyVO = new HistoryVO();
//		 historyVO.setCommonNo(commonNo);
//		 historyVO.setHistPath(histPath);
//		 historyVO.setFileSize(fileSize);
//		 historyVO.setDriveOper();
//		 historyVO.setIp(ip);
		 
		 CommonFileVO fileVO = fileService.retrieveCommonFileByPath(encoder.encrypt(src));
		 
		 
		 temp = new File(tempPath,tempFileName);

			 try (
				 FileOutputStream fos = new FileOutputStream(temp);
				 FileInputStream fis = new FileInputStream(temp);
			 ){
				 ftpClient.retrieveFile(src, fos);
			 
				 if(command.equals(CommandType.COPY)||command.equals(CommandType.MOVE)) {
					 result = ftpClient.storeFile(dest+tempFileName, fis);
					 if(command.equals(CommandType.MOVE)) {
						 result = ftpClient.deleteFile(src);
					 }else {
						 
					 }
				 }else if(command.equals(CommandType.DELETE)) {
					 result = ftpClient.deleteFile(src);
				 }
			 return result;
			 } //try-with-resource end
			 finally {
				    if(temp.exists()) temp.delete();
			}
	}

	@Override
	public void downloadFile(String link, HttpServletResponse resp) throws Exception {
		 FTPClient ftpClient = null;
		 try {
		 ftpClient = clientPool.borrowObject();
			
		 String src = encoder.decrypt(link);
		 String fileName = src.substring(src.lastIndexOf(File.separator));

		 if(ftpClient.mlistFile(src)==null) {
			 throw new DataNotFoundException("파일 없음");
		 };
		 
		 byte[] bytes = fileName.getBytes();
		 fileName = new String(bytes, "ISO-8859-1");
		 
		 resp.setContentType("application/octet-stream");
		 resp.setHeader("Content-Disposition", "attatchment;filename=\""+fileName+"\"");
		 
		 ftpClient.retrieveFile(src, resp.getOutputStream());
		 
		 } finally {
			 clientPool.returnObject(ftpClient);
		 }
	}

	@Override
	public void getImgFile(String link, HttpServletResponse resp) throws Exception {
		FTPClient ftpClient = null;
		try {
			ftpClient = clientPool.borrowObject();
			link = link.replaceAll(" ", "+");
			String src = encoder.decrypt(link);
			String fileName = src.substring(src.lastIndexOf(File.separator));
			
			if(ftpClient.mlistFile(src)==null) {
				throw new DataNotFoundException("파일 없음");
			};
			
			byte[] bytes = fileName.getBytes();
			fileName = new String(bytes, "ISO-8859-1");
			
			resp.setContentType("application/octet-stream");
			resp.setHeader("Content-Disposition", "attatchment;filename=\""+fileName+"\"");
			
			ftpClient.retrieveFile(src, resp.getOutputStream());
			
		} finally {
			clientPool.returnObject(ftpClient);
		}
	}
	
	private static final long MAX_SIZE = 1024*1024*20;
	
	@Override
	public void compressFiles(OutputStream outputStream, String[] path) throws NoSuchElementException, IllegalStateException, Exception {
		for(int i = 0; i < path.length; i++) {
			System.out.println(path[i]);
			path[i] = encoder.decrypt(path[i].replaceAll(" ", "+"));
		}
		FTPClient ftpClient = null;
		ftpClient = clientPool.borrowObject();
		long size = 0;
		for(String file : path) {
			size += ftpClient.mlistFile(file).getSize();
		}
		
		if(path.length==0) throw new IOException("압축 대상 파일이 없음.");
		if(size > MAX_SIZE) {
			IOException e = new IOException("파일 크기가 너무 큼, 나눠서 압축하세요");
			log.error(e.getMessage(), e);
			throw e;
		}
		try(
			ZipOutputStream zos = new ZipOutputStream(outputStream);	
		){
			for(String file : path) {
				String fileName = file.substring(file.lastIndexOf(File.separator)+1);
				zos.putNextEntry(new ZipEntry(fileName));
				ftpClient.retrieveFile(file, zos);
				log.info("압축 파일에 {} 파일 추가함.", file);
			}
			zos.closeEntry();
		}finally {
			clientPool.returnObject(ftpClient);
		}
	}

	@Override
	public void deleteAll(String[] selectedFile, Map<String, Object> result) throws NoSuchElementException, IllegalStateException, Exception {
		FTPClient ftpClient = null;
		int sum = 0;
		try {
			ftpClient = clientPool.borrowObject();
			for(String path:selectedFile) {
				String filePath = encoder.decrypt(path);
				ftpClient.deleteFile(filePath);
				fileService.removeCommonFileByPath(path);
				sum ++;
			}
			result.put("count",sum);
			result.put("result","OK");
		}catch(Exception e) {
			e.printStackTrace();
			result.put("result","FAIL");
		}finally {
			clientPool.returnObject(ftpClient);
		}
	}


	// 파일 이름 바꾸기
	@Transactional
	@Override
	public ServiceResult changeNm(String fromPath, String toFileNm, Integer driveOper, String userIp) throws Exception {
		ServiceResult sResult = ServiceResult.FAIL;
		CommonFileVO savedFileVO = fileService.retrieveCommonFileByPath(fromPath);
		fromPath = encoder.decrypt(fromPath);
		String path = fromPath.substring(0,fromPath.lastIndexOf(File.separator)+1);
		String toPath = path+toFileNm;
		FTPClient ftpClient = null;
		File temp = new File("temp");
		try(
				FileOutputStream fos = new FileOutputStream(temp);
		){
			ftpClient = clientPool.borrowObject();
			ftpClient.rename(fromPath, toPath);
			
			ftpClient.retrieveFile(toPath, fos);
			savedFileVO.setCommonPath(encoder.encrypt(toPath));
			fileService.modifyCommonFile(savedFileVO);
			HistoryVO histVO = new HistoryVO();
			histVO.setCommonNo(savedFileVO.getCommonNo());
			histVO.setHistPath(savedFileVO.getCommonPath());
			histVO.setHistIo("Q600");
			histVO.setDriveOper(driveOper);
			histVO.setIp(userIp);
			histVO.setFileSize(temp.length());
			driveService.createHist(histVO);
			sResult=ServiceResult.OK;
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			clientPool.returnObject(ftpClient);
			if(temp != null) temp.delete();
		}
		return sResult;
	}

	@Override
	public ServiceResult newFolder(String srcFolder, String folderName) throws Exception {
		srcFolder = encoder.decrypt(srcFolder);
		FTPClient ftpClient = null;
		ServiceResult sResult = ServiceResult.FAIL;
		try{
			ftpClient = clientPool.borrowObject();
			createNewFolderPath(ftpClient, srcFolder, folderName, 0);
			sResult=ServiceResult.OK;
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			clientPool.returnObject(ftpClient);
		}
		return sResult;
	}
	
	private void createNewFolderPath(FTPClient ftpClient, String folderPath, String folderName, int number) throws IOException{
		FTPFile savedFolder = ftpClient.mlistFile(folderPath+folderName);
		if(savedFolder != null && savedFolder.isDirectory()) {
			int newNum = number+1;
			if(number == 0) {
				folderName = folderName + " (" + newNum + ")";
			}
			else {
				folderName = folderName.replace(String.valueOf(number), String.valueOf(newNum));
			}
			number++;
			createNewFolderPath(ftpClient, folderPath, folderName, number);
		}else {
			ftpClient.makeDirectory(folderPath+folderName);
		}
		
	}
	
}
