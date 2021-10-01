package com.eg.group.mail.service;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.vo.MailVO;
import com.eg.vo.PagingVO;

@Service
public interface MailService {

	public int selectTotalReceiveMail(PagingVO<MailVO> pagingVO);
	public void selectReceiveMailList(PagingVO<MailVO> pagingVO);
	public ServiceResult insertReceiveMail(MailVO mailVO);
	public ServiceResult updateReceiveMail(MailVO mailVO);
	public ServiceResult deleteReceiveMail(MailVO mailVO);

	public int selectTotalSendedMail(PagingVO<MailVO> pagingVO);
	public void selectSendedMailList(PagingVO<MailVO> pagingVO);
	public ServiceResult insertSendedMail(MailVO mailVO);
	public ServiceResult updateSendedMail(MailVO mailVO);
	public ServiceResult deleteSendedMail(MailVO mailVO);
}
