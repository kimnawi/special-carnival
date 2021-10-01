package com.eg.group.drive.service.pool;

import java.io.IOException;
import java.util.Date;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.apache.commons.pool2.BasePooledObjectFactory;
import org.apache.commons.pool2.PooledObject;
import org.apache.commons.pool2.impl.DefaultPooledObject;

import com.eg.vo.PrintLogProtocolCommandListener;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.extern.slf4j.Slf4j;

/**
 * Pooling 대상이 되는 FTPClient 객체 생성을 전담할 객체.
 *
 */
@Data
@EqualsAndHashCode(callSuper=false)
@Slf4j
public class FTPClientFactory extends BasePooledObjectFactory<FTPClient> {
	private static final int DEFAULT_TIMEOUT = 1000 * 10;
	
	private String host;
	private int port;
	private String user;
	private String password;
	private boolean passiveMode;
	private String encoding;
	private int fileType;

	public FTPClientFactory(
			String host, 
			String user, 
			String password
	) {
		this(host, FTPClient.DEFAULT_PORT, user, password, 
			false, "UTF-8", FTPClient.ASCII_FILE_TYPE);
	}
	
	public FTPClientFactory(
			String host, int port, String user, String password, 
			boolean passiveMode, String encoding, int fileType
	){
		super();
		this.host = host;
		this.port = port;
		this.user = user;
		this.password = password;
		this.passiveMode = passiveMode;
		this.encoding = encoding;
		this.fileType = fileType;
	}
		
	
	@Override
	public PooledObject<FTPClient> wrap(FTPClient obj) {
		return new DefaultPooledObject<FTPClient>(obj);
	}
	
	@Override
	public FTPClient create() throws Exception {
//		1. FTPClient 생성
		FTPClient ftpClient = new FTPClient();
//		optional : 송수신 command 와 message 로깅을 위한 리스너 등록
		ftpClient.addProtocolCommandListener(new PrintLogProtocolCommandListener());
		try {
//			2. control encoding 설정
			ftpClient.setControlEncoding(encoding);
//			3. connection 수립
			ftpClient.connect(host, port);
			ftpClient.setSoTimeout(DEFAULT_TIMEOUT);
//			4. 로그인
			if(!ftpClient.login(user, password)) {
				log.error("[{}] account login failed", user);
				throw new IOException(String.format("[%s] account login failed", user));
			}	
//			5. 응답 코드 받기
			int replyCode = ftpClient.getReplyCode();
			String replyMessage = ftpClient.getReplyString();
			if(FTPReply.isNegativePermanent(replyCode) || FTPReply.isNegativeTransient(replyCode)) {
				throw new IOException(replyMessage);
			}
			if(passiveMode)
				ftpClient.enterLocalPassiveMode();
			else
				ftpClient.enterLocalActiveMode();
			ftpClient.setFileType(fileType);
		}catch (Exception e) {
			if(ftpClient.isConnected())
				ftpClient.disconnect();
			throw e;
		}
		log.info("{} 대상 FTPClient 생성", ftpClient.getPassiveHost());
		return ftpClient;
	}
	
	@Override
	public void destroyObject(PooledObject<FTPClient> p) throws Exception{
//		FTP client 객체 소멸시 수립된 연결을 종료함.
		FTPClient ftpClient = p.getObject();
		try {
			if(ftpClient.isConnected())
				 ftpClient.logout();
		}finally {
			if(ftpClient.isConnected())
				ftpClient.disconnect();
			log.info("FTPClient created at {} is disconnected ", new Date(p.getCreateTime()));
			p.invalidate();
		}
	}
	
	@Override
	public void activateObject(PooledObject<FTPClient> p) throws Exception {
		log.info("active Object call");
	}
	
	@Override
	public void passivateObject(PooledObject<FTPClient> p) throws Exception {
		log.info("passivate object call");
	}
	
	@Override
	public boolean validateObject(PooledObject<FTPClient> p){
		try {
			FTPClient ftpClient = (FTPClient)p.getObject();
			ftpClient.sendNoOp();
			return ftpClient.isConnected() && ftpClient.isAvailable();
		}catch (IOException e) {
			log.warn(e.getMessage(), e);
			return false;
		}
	}
	
}







