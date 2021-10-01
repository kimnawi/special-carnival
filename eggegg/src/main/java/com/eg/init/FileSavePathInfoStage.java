package com.eg.init;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.web.context.WebApplicationContext;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Data
@Slf4j
public class FileSavePathInfoStage implements FileSavePathInfo, ApplicationContextAware{
	private WebApplicationContext container;
	private ServletContext application;
	
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		this.container = (WebApplicationContext) applicationContext;
		this.application = container.getServletContext();
	}
	
	@PostConstruct
	public void init() throws IOException {
		emplSaveFolder = new File( application.getRealPath(emplImagesUrl) );
		if(!emplSaveFolder.exists()) emplSaveFolder.mkdirs();
		log.info("회원이미지 경로(url) : {}, \n실제 경로(path) : {}", emplImagesUrl, emplSaveFolder.getCanonicalPath());
	}
	
	@Value("#{appInfo.emplImagesUrl}")
	private String emplImagesUrl;
	private File emplSaveFolder;

}
