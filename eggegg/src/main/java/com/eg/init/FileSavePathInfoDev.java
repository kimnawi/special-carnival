package com.eg.init;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Data
@Slf4j
public class FileSavePathInfoDev implements FileSavePathInfo{
	@PostConstruct
	public void init() throws IOException {
		if(!emplSaveFolder.exists()) emplSaveFolder.mkdirs();
		log.info(emplSaveFolder.getPath());
		log.info("Dev사원이미지 경로(url) : {}, \n실제 경로(path) : {}", emplImagesUrl, emplSaveFolder.getCanonicalPath());
	}
	
	@Value("#{appInfo.emplImagesUrl}")
	private String emplImagesUrl;
	@Value("#{appInfo.emplImagesPath}")
	private File emplSaveFolder;
	
}
