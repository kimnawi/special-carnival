package com.eg.employee.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;

import com.eg.TestWebAppConfiguration;
import com.eg.util.AES256Util;

import lombok.extern.slf4j.Slf4j;

@TestWebAppConfiguration
@Slf4j
public class EmployeeControllerTest {

	
	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {
		AES256Util aes = new AES256Util();
		String password = "테스트 패스워드";
		log.info("변경 전 : {}",password);
		String encoded = aes.encrypt(password);
		log.info("암호화 후 : {}",encoded);
		String decoded = aes.decrypt(encoded);
		log.info("복호화 후 : {}",decoded);
		
	}

}
