package com.eg.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of="msgNo")
@Data
public class MsgVO {
	private String msgNo;        // 쪽지번호
	private String msgContent;   // 내용
	private String msgSender;   // 발신자ID
	private String msgReceiver;  // 수신자ID
	private String msgSdate;     // 발송일자
	private String msgRdate;     // 확인일자
	private String msgSave;      // 보관여부
	
	//검색
	private String msgSdateStart;    // 발송 기간(start)
	private String msgSdateEnd;      // 발송 기간(end)
	private String msgState;         // 확인 여부
	private String authEmpl;         // 로그인 한 사원
	private String authEmplSender;   // 로그인 한 사원이 보낸 쪽지
	private String msgSelf;          // 내게쓴쪽지함
	private String[] msgSenderArr;   // 보낸 사람
	private String[] msgReceiverArr; // 받는 사람
	
	private EmplVO empl;
	private EmplVO pmpl;
 }