package com.eg.group.mail.service;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.Value;
import com.google.api.services.gmail.Gmail;
import com.google.api.services.gmail.model.ListMessagesResponse;
import com.google.api.services.gmail.model.Message;

/**
 * Gmail API 활용 로직
 */
@Service
public class GmailService {
	@Value("#{appInfo.applicationName}")
	private String applicationName;
	private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
	private NetHttpTransport HTTP_TRANSPORT;

	@PostConstruct
	public void init() throws GeneralSecurityException, IOException {
		HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
	}

	private Gmail createGmailService(Credential credential) {
		return new Gmail.Builder(HTTP_TRANSPORT, JSON_FACTORY, credential).setApplicationName(applicationName).build();
	}

	/**
	 * 메일 서버로부터의 동기화 주기 설정 및 배치 처리를 활용한 비동기 조회가 필요함.
	 * 
	 * @param credential
	 * @param userId
	 * @return
	 * @throws IOException
	 */
	public List<String> mailList(Credential credential, String userId) throws IOException {
		Gmail gmail = createGmailService(credential);
		// MetaData 만 조회
		ListMessagesResponse listMessageResponse = gmail.users().messages().list(userId).execute();
		List<String> simples = new ArrayList<>();
		for (Message mailMessage : listMessageResponse.getMessages()) {
			String snippets = gmail.users().messages().get(userId, mailMessage.getId()).execute().getSnippet();
			simples.add(snippets);
		}
		return simples;
	}
}