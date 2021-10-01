package com.eg.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MailVO implements Serializable{

	private Integer inboxNo;         // 메일번호
	private String inboxTitle;       // 제목
	private String inboxContent;     // 내용
	private Integer inboxSempl;      // 송신자ID
	private Integer inboxRempl;      // 수신자ID
	List<EmplVO> receiverList;		 // 수신자 리스트
	
	private String inboxSdate;       // 송신일자

	private String sendStartDe;      // 송신시작일자(검색)
	private String sendEndDe;        // 송신종료일자(검색)
	
	
	private String inboxRdate;       // 수신일자

	private String RecieveStartDe;   // 수신시작일자(검색)
	private String RecieveEndDe;     // 수신종료일자(검색)
	
	
	private String inboxDelete;      // 삭제여부
	private String inboxImportant;   // 중요표시
	
}
