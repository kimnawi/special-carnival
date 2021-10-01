package com.eg.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AuthHistVO {

	private Integer draftNo;   // 기안서번호
	private String ahAuthSe;   // 결재구분
	private String ahAuthTm;   // 결재일시
	private Integer ahAuthorId;   // 결재자ID
	private String ahReturnCn;   // 반려내용
	
}
