package com.eg.vo;

import java.io.Serializable;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 개인의 즐겨찾기 결재라인을 위한 VO (AuthLineVO와 혼동 주의)
 * @author 이기정
 * since 2021. 8. 30.
 * version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일		수정자		수정내용
 * ---------------------------------------
 * 2021. 8. 30.   admin     최초작성
 * Copyright(c) 2021 by DDIT ALL right reserved
 * </pre>
 * 
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LineBoxVO implements Serializable{

	private Integer lcbLineNo;   // 라인번호
	private String lcbAuthlNm;   // 결재라인명칭
	private Integer lcbEmpl;     // 소유자ID
	private EmplVO lcbEmployee;  // 소유자
	
	private Integer[] delCodes;   // 라인번호(일괄 삭제)
	private List<AuthVO> auths; // 라인에 속한 결재자들의 정보
	
}
