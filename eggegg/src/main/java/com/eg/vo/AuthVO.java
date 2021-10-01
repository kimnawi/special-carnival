package com.eg.vo;

import org.apache.commons.codec.binary.Base64;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AuthVO {
	
	private Integer lcbLineNo;   // 즐겨찾기 라인번호
	private String authorAuthTyCode;   // 결재유형
	private String authorAuthTy;   // 결재유형명
	private Integer authorOrder;   // 순서
	
	private Integer authorId;   // 결재자ID
	private String authorNm;	// 결재자 이름
	private Integer pstCode;   // 직위/직급 코드
	private String pstNm;   // 직위/직급

	private String curSignImage; // 현재 기본 사인이미지(결재 시)
	
	private byte[] signImage;
	
	// 결재도장 보여줄 때
	public String getBase64Img() {
		if(signImage==null) return null;
		return Base64.encodeBase64String(signImage);
	}
	
	private AuthHistVO authHist; // 결재내역
	
	
}
