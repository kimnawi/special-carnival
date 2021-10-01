package com.eg.group.mail.service;

import java.io.IOException;
import java.security.GeneralSecurityException;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.Value;
import com.google.api.services.oauth2.Oauth2;

/**
 * OAuth 인증 대상자에 대한 정보 조회
 */
@Service
public class OAuthService {

	@Value("#{appInfo.applicationName}")
	private String applicationName;
	private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
	private NetHttpTransport HTTP_TRANSPORT;

	@PostConstruct
	public void init() throws GeneralSecurityException, IOException {
		HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
	}

	private Oauth2 createOauth2Service(Credential credential) {
		return new Oauth2.Builder(HTTP_TRANSPORT, JSON_FACTORY, credential).setApplicationName(applicationName).build();
	}

	/**
	 * 사용자 이메일 계정 주소
	 * 
	 * @param credential
	 * @return
	 * @throws IOException
	 */
	public String getUserEmail(Credential credential) throws IOException {
		return createOauth2Service(credential).userinfo().get().execute().getEmail();
	}
}
