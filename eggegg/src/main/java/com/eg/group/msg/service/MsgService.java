package com.eg.group.msg.service;

import org.springframework.stereotype.Service;

import com.eg.commons.ServiceResult;
import com.eg.vo.MsgVO;
import com.eg.vo.PagingVO;

@Service
public interface MsgService {
	
	public void retrieveMsgList(PagingVO<MsgVO> pagingVO);
	
	public MsgVO retrieveMsg(int msgNo);
	
	public ServiceResult createMsg(MsgVO msgVO);
	
	public ServiceResult removeMsg(String[] msgNo);
	
	public ServiceResult modifyMsgState(String[] msgNo);
	
	public ServiceResult modifyMsgSave(String[] msgNo);
}
