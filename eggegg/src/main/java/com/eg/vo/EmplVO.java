package com.eg.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.springframework.security.oauth2.client.test.OAuth2ContextConfiguration.Password;

import com.eg.validate.groups.InsertGroup;
import com.eg.validate.groups.PasswordGroup;
import com.eg.validate.groups.UpdateGroup;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@EqualsAndHashCode(of="emplNo")
@AllArgsConstructor(access=AccessLevel.PRIVATE)
@NoArgsConstructor
@Data
@ToString
public class EmplVO implements Serializable {
	@NotNull
	private Integer emplNo;   // 사원번호
	@NotBlank
	private String emplNm;   // 성명
	private String emplFornm;   // 제2외국어성명
	@NotBlank
	private String emplEngnm;   // 영문성명
	private String emplHshAt;   // 세대주여부
	private String emplTel;   // 전화
	@NotBlank
	private String emplMobile;   // 모바일
	private String emplPassport;   // 여권번호
	@NotBlank
	private String emplEmail;   // 이메일
	@NotBlank
	private String emplEcny;   // 입사일자
	@NotBlank
	private String emplAdres;   // 주소
	private String emplDetAdres;   // 상세주소
	private String emplSumry;   // 적요내용
	@NotBlank
	private String emplZip;   // 우편번호
	private String deptCode;   // 부서코드
	@Pattern(regexp="[a-zA-Z0-9!@#$%^&*]{4,8}",groups=PasswordGroup.class)
	private String emplPw;   // 비밀번호
	private Integer emplPwcnt;   // 비밀번호 오류횟수
	private String emplFrgnrAt;   // 외국인여부
	private Integer commonNo;   // 이미지파일
	private String emplAuthority;   // 직책코드
	private RolesVO roles;			// 권한
	private String emplSignimage; // 도장이미지경로
	
	@NotBlank
	private String emplEntrance;   // 입사구분
	private String emplPayment;   // 급여구분
	private String pstCode;   // 직위/직급코드
	private String adgCode;   // 수당/공제그룹코드
	private Integer emplAdgper;   // 지급률

	//검색
	private String emplEcnyStart;	//입사일자 기간 (start)
	private String emplEcnyEnd;		//입사입자 기간(end)
	private String emplRetireStart;	//퇴사일자기간(start)
	private String emplRetireEnd; 	//퇴사일자기간(end)
	private String prjCode; 		//프로젝트코드
	private String tenureAtt;		//재직구분
	
	private String deptLeaderAt;		//부서장 여부
	private String emplPst;				//사원직책(부서장 + 직위/직급)
	
	//VO
	private DeptVO dept;				//부서
	private PositionVO position;		//직위/직책
	private SalarybankVO salarybank;	//급여통장
	private bankVO bank;				//은행
	private RetireVO retire;			//퇴사
	private EntranceVO entrance;		//입사구분
	private ProjectVO project;			//프로젝트
	private AcademicVO acad;			//학력
	private QualificateListVO qualVOList;	//자격VO 리스트
	private VacationVO vcatn;				//휴가코드
	private VacHistoryVO vacHistory;		//휴가이력
	private PiHistoryVO piHistory; 
	private CommonFileVO file;			//공통파일
	
	private List<AdGroupAllVO> alGroup; //수당그룹조회 
	private List<AdGroupAllVO> fixAl;   //고정수당조회
	private List<AdGroupAllVO> deGroup; //고정그룹조회
	private List<AdGroupAllVO> monthDe; //월정공제조회
	private List<AlHistoryVO>  alHistory;
	private List<DeHistoryVO>  deHistory;
	
	private List<AlHistoryVO> alSum; 
	
	
	private String alCode; //수당코드
	private String faAmount; //수당금액
	private String deCode; //공제코드
	private String mdAmount; //공제금액
	
	
	private Integer emplDel;
	
	private Integer emplVacDay;
	private String vcatnCode;
	
	private List<LineBoxVO> myAuthLine; // 내 결재라인 리스트 (has many)
	
	private Boolean leaf = true; // 팬시트리에서 사용할 프로퍼티
	private Boolean enabled; // 퇴사한 사원은 막기 위함.
	
	public void setEnabled(){
		if(retire==null || retire.getEmplRetire() == null) {
			this.enabled=true;
		}else {
			this.enabled=false;
		}
	}
}
