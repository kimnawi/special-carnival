package com.eg.group.mail.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.MailVO;
import com.eg.vo.PagingVO;

@Mapper
public interface MailDAO {

	public int selectTotalReceiveMail(PagingVO<MailVO> pagingVO);
	public List<MailVO> selectReceiveMailList(PagingVO<MailVO> pagingVO);
	public int insertReceiveMail(MailVO mailVO);
	public int updateReceiveMail(MailVO mailVO);
	public int deleteReceiveMail(MailVO mailVO);

	public int selectTotalSendedMail(PagingVO<MailVO> pagingVO);
	public List<MailVO> selectSendedMailList(PagingVO<MailVO> pagingVO);
	public int insertSendedMail(MailVO mailVO);
	public int updateSendedMail(MailVO mailVO);
	public int deleteSendedMail(MailVO mailVO);
	
}
