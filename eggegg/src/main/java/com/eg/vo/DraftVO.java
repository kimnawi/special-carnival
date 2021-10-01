package com.eg.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class DraftVO implements Serializable{

	private Integer draftNo;       // 기안서번호
	private String draftDate;      // 일자
	@NotBlank(message="제목을 입력해주세요.")
	private String draftTitle;     // 제목
	@NotBlank(message="구분을 선택해주세요")
	private String draftType;      // 구분
	private String draftTypeNm;    // 구분명
	private String draftSecurity;  // 문서보안등급
	private String draftContent;   // 내용
	private String draftProgress;  // 기안진행상태
	private String draftChitKnd;   // 전표종류
	
	private String chit; // 전표 서비스명
	private String code; // 전표 번호
	
	
	private List<AuthVO> authls;		// 결재자
	private List<AuthVO> references; 	// 참조자
	private List<AuthVO> receivers; 	// 수신자
	
	@Size(min=1,message="결재자는 한명 이상 선택하여야 합니다.")
	private Integer[] authNos;
	private Integer[] refCode;
	@Size(min=1,message="수신자는 한명 이상 선택하여야 합니다.")
	private Integer[] recCode; 
	
	public void setAuthNos(Integer[] authNos){
		this.authNos = authNos;
		if(authNos != null) {
			authls = new ArrayList<>();
			int order = 1;
			for(Integer authId : authNos) {
				AuthVO auth = new AuthVO();
				auth.setAuthorId(authId);
				auth.setLcbLineNo(draftNo);
				auth.setAuthorOrder(order);
				this.authls.add(auth);
				order++;
			}
		}
	}
	
	public void setRefCode(Integer[] refCode){
		this.refCode = refCode;
		if(refCode != null) {
			references = new ArrayList<>();
			int order = 1;
			for(Integer refId : refCode) {
				AuthVO ref = new AuthVO();
				ref.setAuthorId(refId);
				ref.setLcbLineNo(draftNo);
				ref.setAuthorOrder(order);
				this.references.add(ref);
				order++;
			}
		}
	}

	public void setRecCode(Integer[] recCode){
		this.recCode = recCode;
		if(recCode != null) {
			receivers = new ArrayList<>();
			int order = 1;
			for(Integer recId : recCode) {
				AuthVO rec = new AuthVO();
				rec.setAuthorId(recId);
				rec.setLcbLineNo(draftNo);
				rec.setAuthorOrder(order);
				this.receivers.add(rec);
				order++;
			}
		}
	}
	
	
	private Integer lastAuthorId;    // 마지막 결재자 아이디
	private Integer nextAuthorId;    // 다음 결재자 아이디
	private String nextAuthor;    // 다음 결재자 명
	private String nextAuthorTycd;    // 다음 결재자 권한
	
	private AuthHistVO authHist; // 결재내역(인서트를 위함)
	
	private Integer draftWriter;   //기안자코드
	private EmplVO writer;         // 기안자
	
}
