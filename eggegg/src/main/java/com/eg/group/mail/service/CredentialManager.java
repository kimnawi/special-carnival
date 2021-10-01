package com.eg.group.mail.service;

import java.io.IOException;
import java.io.InputStreamReader;
import java.security.GeneralSecurityException;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.auth.oauth2.CredentialRefreshListener;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets.Details;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.store.DataStoreFactory;
import com.google.api.client.util.store.MemoryDataStoreFactory;
import com.google.api.services.gmail.GmailScopes;
import com.google.api.services.oauth2.Oauth2Scopes;

import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
* Credential 관리 정책
* 1. Resource owner의 Credential은 Store에 저장되며, userId(key)를 통해 식별됨 ({@link #loadCredential(String)}).
* 2. 최초의 Credential 은 다음과 같은 절차로 생성됨.
*   1) Authorization Server 로부터 Authorization Code 를 발급받음. ({@link #sendAuthorizationCodeRequest()})
*   : resource owner 의 API 사용 동의 절차를 위해 google 에서 정의한 redirection url 을 사용함. *
*   2) Authorization server 로부터 만료시한이 제한된, access_token을 발급받음
*   ({@link #createAndStoreCredential(String, String)}}).
*      ① 1) 에서 발급된 authorization code 와 API client app 의 secret 정보를 파라미터로 전송함.
*      ② accessType을 offline 으로 설정하여, resource owner 가 client app을 사용중이지 않은 시점에도 access token 갱신이 가능하도록 함.
*      : access token 갱신 시에 사용할 refresh token 을 발급받기 위함.
*      ③ 발급받은 token information 을 바탕으로 Credential 을 생성하고, Credential store(DataStore) 를 이용해 저장함.
*      : 각 resource owner 의 Credential 을 식별하기 위한 userId(key) 정책이 필요함.
* 3. 만료시한이 제한된 access token의 유효성 여부를 확인하고, 유효하지 않은 경우, 갱신할 수 있음.
 * </pre>
 * 
 * @see GoogleAuthorizationCodeFlow
 */
@Slf4j
@Service
public class CredentialManager {

	private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
	// https://developers.google.com/identity/protocols/oauth2/scopes
	private static final Collection<String> SCOPES = Arrays.asList(GmailScopes.GMAIL_READONLY,
			Oauth2Scopes.USERINFO_EMAIL, Oauth2Scopes.OPENID, Oauth2Scopes.USERINFO_PROFILE);
	private NetHttpTransport HTTP_TRANSPORT;
	private GoogleClientSecrets googleClientSecrets;
	private Details details;
	private DataStoreFactory dataStoreFactory = MemoryDataStoreFactory.getDefaultInstance();
	private GoogleAuthorizationCodeFlow.Builder authorizationCodeFlowBuilder;
	private GoogleAuthorizationCodeFlow authorizationCodeFlow;
	@Value("classpath:client_secret.json")
	private Resource clientSecretFile;

	@PostConstruct
	public void init() throws GeneralSecurityException, IOException {
		log.info("client secret file : {} loading", clientSecretFile);
		HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
		googleClientSecrets = GoogleClientSecrets.load(JSON_FACTORY,
				new InputStreamReader(clientSecretFile.getInputStream()));
		details = googleClientSecrets.getDetails();
		log.info("client secret details : {}", details);
		authorizationCodeFlowBuilder = new GoogleAuthorizationCodeFlow.Builder(HTTP_TRANSPORT, JSON_FACTORY,
				googleClientSecrets, SCOPES).setApprovalPrompt("auto").setAccessType("offline")
						.setDataStoreFactory(dataStoreFactory);
		authorizationCodeFlow = authorizationCodeFlowBuilder.build();
	}

	/**
	 * Credential store 에 저장된 Credential 로드
	 * 
	 * @param userId resource owner 의 Credential 을 식별하기 위해 store 에서 사용하는 key
	 * @return
	 * @throws IOException
	 */
	public Credential loadCredential(String userId) throws IOException {
		return authorizationCodeFlow.loadCredential(userId);
	}

	/**
	 * <pre>
	 * Resource owner 의 자원에 대한 사용 승인이 이루어졌는지 여부(oAuth 동의)를 의미하는 authorization code 발급 절차.
	 * Authorization Server를 대상으로 로그인 및 API client app이 자원을 사용하도록 승인하기 위한 페이지로 이동함.
	 * 발급된 authorization code는 Google cloud project 에 등록한 client app의 redirect_url 핸들러를 이용하여 받을 수 있음.
	 * </pre>
	 * 
	 * @return 자원 사용 승인을 위해 사용될 authorization server의 페이지 주소 (oauth 동의 화면으로 redirect
	 *         주소로 사용함).
	 */
	public String sendAuthorizationCodeRequest() {
		return "redirect:"+authorizationCodeFlow.newAuthorizationUrl().setRedirectUri(details.getRedirectUris().get(0))
				.setResponseTypes(Collections.singleton("code")).build();
	}

	/**
	 * <pre>
	* 발급된 Authorization code를 다시 authorization server 로 보내 향후 자원 접근시에 사용할 token 정보들을 받아오기 위한 메소드.
	* Access toke 과 Refresh token 을 발급받아 Credential 을 생성하고, 생성된 Credential 은 DataStore 에 저장함.
	 * </pre>
	 * 
	 * @param authorizationCode
	 * @param userId
	 * @return
	 * @throws IOException
	 */
	public Credential createAndStoreCredential(String authorizationCode, String userId) throws IOException {
		GoogleTokenResponse response = authorizationCodeFlow.newTokenRequest(authorizationCode)
				.setRedirectUri(details.getRedirectUris().get(0)).setGrantType("authorization_code").execute();
		log.info("token response : \n{}", response.toPrettyString());
		Credential credential = authorizationCodeFlow.createAndStoreCredential(response, userId);
		log.info("발급받은 access token : {}", credential.getAccessToken());
		log.info("access token 잔여시한: {}", credential.getExpiresInSeconds());
		log.info("발급받은 refresh token : {}, {}", response.getRefreshToken(), credential.getRefreshToken());
		return credential;
	}

	/**
	 * Credential 의 만료 여부를 판단하고, 만료시한이 1분 미만인 경우 갱신함.
	 * 
	 * @param credential
	 * @return
	 * @throws IOException
	 */
	public boolean validateCredential(Credential credential) throws IOException {
		if (credential.getExpiresInSeconds() < 60) {
			return credential.refreshToken();
		} else {
			return true;
		}
	}

	/**
	 * access token 갱신시에 동작할 리스너 등록
	 * 
	 * @param listener
	 * @return
	 */
	public boolean addCredentialRefreshListener(CredentialRefreshListener listener) {
		log.info("Original Refresh Token Listeners : {}", authorizationCodeFlow.getRefreshListeners());
		return authorizationCodeFlow.getRefreshListeners().add(listener);
	}

	/**
	 * 저장된 Credential을 삭제함.
	 * 
	 * @param userId
	 * @throws IOException
	 */
	public void deleteCredential(String userId) throws IOException {
		authorizationCodeFlow.getCredentialDataStore().delete(userId);
	}

}
