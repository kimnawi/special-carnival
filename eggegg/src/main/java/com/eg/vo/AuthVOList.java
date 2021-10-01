package com.eg.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AuthVOList {

	List<AuthVO> authList;
	
	private Integer lcbLineNo;           // 즐겨찾기 라인번호
	private String[] authTyCodes;  			 // 결재유형
	private String[] authorAuthTy;       // 결재유형명
	private String[] authOrder;       // 순서
	
	private String[] authNos;          // 결재자ID
	private String[] authNms;	         // 결재자 이름
	private String[] authPstNms;              // 직위/직급
	
	private String[] imagePath;          // 도장 이미지 경로
	
	public void setLcbLineNo(Integer lcbLineNo) {
		this.lcbLineNo = lcbLineNo;
		for(AuthVO auth : authList) {
			auth.setLcbLineNo(lcbLineNo);
		}
	}
	
	private AuthVOList(){};

	public AuthVOList(String[] authTys, String[] authorAuthTy,
			String[] authOrder, String[] authNos, String[] authorNms, String[] authPstNms) {
		super();
		this.authList = new ArrayList<AuthVO>();
		for(int i=0; i < authNos.length ; i++) {
			AuthVO auth = new AuthVO();
			auth.setLcbLineNo(lcbLineNo);
			auth.setAuthorId(Integer.parseInt(authNos[i]));
			auth.setAuthorNm(authorNms[i]);
			auth.setAuthorAuthTy(authorAuthTy[i]);
			auth.setAuthorAuthTyCode(authTys[i]);
			auth.setAuthorOrder(Integer.parseInt(authOrder[i]));
			auth.setPstNm(authPstNms[i]);
			authList.add(auth);
		}
		this.authTyCodes = authTys;
		this.authorAuthTy = authorAuthTy;
		this.authOrder = authOrder;
		this.authNos = authNos;
		this.authNms = authorNms;
		this.authPstNms = authPstNms;
	}
	
	
}
