package com.eg.group.msg.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.eg.vo.MsgVO;
import com.eg.vo.PagingVO;

@Mapper
public interface MsgDAO {
	
	public int selectTotalRecord(PagingVO<MsgVO> pagingVO);

	public List<MsgVO> selectMsgList(PagingVO<MsgVO> pagingVO);
	
	public MsgVO selectMsgDetail(int msgNo);
	
	public int insertMsg(MsgVO msgVO);
	
	public int deleteMsg(String msgNo);
	
	public int updateMsgConfirm(String msgNo);
	
	public int updateMsgSave(String msgNo);
	
	public String selectName(String emplNo);
	
	public List<MsgVO> selectMainMsg(int no);
}
