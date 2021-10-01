package com.eg.group.msg.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eg.commons.ServiceResult;
import com.eg.commons.UserNotFoundException;
import com.eg.group.msg.dao.MsgDAO;
import com.eg.vo.MsgVO;
import com.eg.vo.PagingVO;

@Service
public class MsgServiceImpl implements MsgService{

	@Inject
	private SimpMessagingTemplate messagingTemplate;
	
	@Inject	
	private MsgDAO msgDAO;

	@Override
	public void retrieveMsgList(PagingVO<MsgVO> pagingVO) {
		int totalRecord = msgDAO.selectTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<MsgVO> dataList = msgDAO.selectMsgList(pagingVO);
		pagingVO.setDataList(dataList);
	}
	
	@Override
	public MsgVO retrieveMsg(int msgNo) {
		MsgVO msg = msgDAO.selectMsgDetail(msgNo);
		if(msg==null)
			throw new UserNotFoundException(String.format("%s 쪽지 없음.", msgNo));
		return msg;
	}

	@Transactional
	@Override
	public ServiceResult createMsg(MsgVO msgVO) {
		ServiceResult result = null;
		int rowcnt = msgDAO.insertMsg(msgVO);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		String name = msgDAO.selectName(msgVO.getMsgSender());
		messagingTemplate.convertAndSend("/topic/pushMsg/"+msgVO.getMsgReceiver(), name+"님이 쪽지를 보냈습니다.");
		
		return result;
	}

	@Transactional
	@Override
	public ServiceResult removeMsg(String[] msgNo) {
		ServiceResult result = null;
		
		int rowcnt = 0;
		
		for(int i = 0; i < msgNo.length; i++) {
						
			rowcnt = msgDAO.deleteMsg(msgNo[i]);
		}
		
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	
	public ServiceResult modifyMsgState(String[] msgNo) {
		ServiceResult result = null;
		
		int rowcnt = 0;
		
		for(int i = 0; i < msgNo.length; i++) {
						
			rowcnt = msgDAO.updateMsgConfirm(msgNo[i]);
		}
		
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	public ServiceResult modifyMsgSave(String[] msgNo) {
		ServiceResult result = null;
		
		int rowcnt = 0;
		
		for(int i = 0; i < msgNo.length; i++) {
						
			rowcnt = msgDAO.updateMsgSave(msgNo[i]);
		}
		
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
}
