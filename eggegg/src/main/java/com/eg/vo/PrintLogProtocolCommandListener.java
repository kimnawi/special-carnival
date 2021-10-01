package com.eg.vo;

import org.apache.commons.net.ProtocolCommandEvent;
import org.apache.commons.net.ProtocolCommandListener;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * FTP server로 전송되는 명령과 수신 메시지를 로깅하기 위한 리스너
 *
 */
public class PrintLogProtocolCommandListener implements ProtocolCommandListener{
	private static final Logger logger = LoggerFactory.getLogger(PrintLogProtocolCommandListener.class);
	
	@Override
	public void protocolCommandSent(ProtocolCommandEvent event) {
		FTPClient ftpClient = (FTPClient) event.getSource();
		if(event.isCommand()) {
			String command = event.getCommand();
			String host = ftpClient.getRemoteAddress().getHostAddress();
			logger.info("send command[{}] to {}", command, host);
		}
	}
	
	@Override
	public void protocolReplyReceived(ProtocolCommandEvent event) {
		FTPClient ftpClient = (FTPClient) event.getSource();
		if(event.isReply()) {
			String message = event.getMessage();
			String host = ftpClient.getRemoteAddress().getHostAddress();
			int replyCode = event.getReplyCode();
			
			if(FTPReply.isPositiveCompletion(replyCode)) {
				logger.info("receive complete message from {} : {}", host, message);
			}else if(FTPReply.isPositiveIntermediate(replyCode)){
				logger.info("receive intermediate message from {} : {}", host, message);
			}else if(FTPReply.isPositivePreliminary(replyCode)) {
				logger.info("receive temporary message from {} : {}", host, message);
			}else{
				logger.error("receive reply code {} from {} : {}", host, replyCode, message);
			}
		}
		
	}
}

