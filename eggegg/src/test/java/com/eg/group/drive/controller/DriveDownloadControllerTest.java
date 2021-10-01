package com.eg.group.drive.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.Map;
import java.util.regex.Pattern;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.context.WebApplicationContext;

import com.eg.TestWebAppConfiguration;
import com.eg.util.AES256Util;
import com.eg.vacation.service.VacService;
import com.eg.vacation.service.VacServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringRunner.class)
@TestWebAppConfiguration
public class DriveDownloadControllerTest {

	@Inject
	WebApplicationContext container;
	
	@Inject
	AES256Util encoder;
	
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void testDownload() throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException, ClassNotFoundException, NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		System.out.println(encoder.decrypt("MIo5GW5okAhq+RNObXFNTgZ+fsxhwa0X2J6hzk0VrEnbf4HknqaWneUTJSaizNOL3PoNaaWJ4GFYRyF/2IOud6VEijW3R5JQvMN6msiNH7k="));
//		System.out.println("뭔데");
		System.out.println(encoder.decrypt("MIo5GW5okAhq+RNObXFNTgZ+fsxhwa0X2J6hzk0VrEnbf4HknqaWneUTJSaizNOLWgpgCnPyc/oFB0AkeDh0V+reN0NTcx0nlnN81dhE00U="));
		
		
	}

}
