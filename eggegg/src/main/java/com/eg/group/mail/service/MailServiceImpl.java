package com.eg.group.mail.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.vo.MailVO;
import com.eg.vo.PagingVO;

@Service
public class MailServiceImpl implements MailService {

	public int selectTotalReceiveMail(PagingVO<MailVO> pagingVO) {
		return 0;
		
	};
	public void selectReceiveMailList(PagingVO<MailVO> pagingVO) {
		
	};
	public ServiceResult insertReceiveMail(MailVO mailVO) {
		return null;
		
	};
	public ServiceResult updateReceiveMail(MailVO mailVO) {
		return null;
		
	};
	public ServiceResult deleteReceiveMail(MailVO mailVO) {
		return null;
		
	};

	
	public int selectTotalSendedMail(PagingVO<MailVO> pagingVO) {
		return 0;
	}
	public void selectSendedMailList(PagingVO<MailVO> pagingVO) {
	}
	public ServiceResult insertSendedMail(MailVO mailVO) {
		return null;
	}
	public ServiceResult updateSendedMail(MailVO mailVO) {
		return null;
	}
	public ServiceResult deleteSendedMail(MailVO mailVO) {
		return null;
	}
}
