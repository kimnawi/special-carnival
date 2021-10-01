package com.eg.group.esign.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.commons.ServiceResult;
import com.eg.commons.exception.DataNotFoundException;
import com.eg.empl.service.EmplService;
import com.eg.group.drive.service.FTPFileService;
import com.eg.group.drive.service.FTPFileServiceImpl_WithPool;
import com.eg.group.esign.service.EsignService;
import com.eg.vo.AuthHistVO;
import com.eg.vo.AuthVO;
import com.eg.vo.AuthVOList;
import com.eg.vo.DraftFormVO;
import com.eg.vo.DraftVO;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.LineBoxVO;

@Controller
public class EsignUpdateController {
	@Inject
	private EsignService service;
	
	@Inject
	@Named("ftpPoolService")
	private FTPFileService ftpService;
	
	@Inject
	private EmplService emplService;

	@RequestMapping(value="/group/esign/draftFormUpdate.do")
	public String form() {
		return "/";
	}
	
	@RequestMapping(value="/group/esign/draftFormUpdate.do",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> updateDraftForm(
			DraftFormVO draftForm,
			@AuthenticationPrincipal EmplVOWrapper wrapper
			){
		Map<String,Object> result = new HashMap<>();
		try {
			Integer authEmpl = wrapper.getAdaptee().getEmplNo();
			Integer formEmpl = draftForm.getEmplNo();
			if(!authEmpl.equals(formEmpl)) {
				if(draftForm.getDfNo()==0) {
					draftForm.setEmplNo(authEmpl);
				}else {
					result.put("result","본인의 양식만 수정 가능합니다!");
					return result;
				}
			};
			ServiceResult sResult = service.modifyDraftForm(draftForm);
			result.put("result",sResult.toString());
		
		}catch(DataNotFoundException e) {
			result.put("result",draftForm.getDfNo()+"번 양식은 없습니다.");
		}
		return result;
	}
	
	
	// 즐겨찾기 라인 수정
	@RequestMapping(value="/esign/updateLine.do",method=RequestMethod.POST)
	@ResponseBody
	public ServiceResult updateLine(
			@AuthenticationPrincipal EmplVOWrapper wrapper, String lineNm,
			@RequestParam(required=false)Integer lcbLineNo, String[] authTyCodes, String[] authorAuthTy,
					String[] authOrder, String[] authNos, String[] authNms, String[] authPstNms
			) {
		AuthVOList list = new AuthVOList(authTyCodes, authorAuthTy, authOrder, authNos, authNms, authPstNms);
		LineBoxVO boxVO = new LineBoxVO();
		boxVO.setLcbEmpl(wrapper.getAdaptee().getEmplNo());
		boxVO.setLcbAuthlNm(lineNm);
		boxVO.setAuths(list.getAuthList());
		boxVO.setLcbLineNo(lcbLineNo);
		ServiceResult result = service.modifyLineBox(boxVO);
		return result;
	}
	
	// 기안문 임시저장 && 결재 상신
	@RequestMapping(value="/group/esign/draftUpdate.do",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> updateDraft(
			DraftVO draft,
			@AuthenticationPrincipal EmplVOWrapper wrapper,
			Integer[] authNos,
			Integer[] recCode,
			String command,
			String[] authorAuthTyCode,
			@RequestParam(required=false) String chit,
			@RequestParam(required=false) String code
			){
		Map<String,Object> result = new HashMap<>();
		Integer authEmpl = wrapper.getAdaptee().getEmplNo();
		Integer draftEmpl = draft.getDraftWriter();
		if(!authEmpl.equals(draftEmpl) && draftEmpl != null) {
			result.put("result","기안자만 접근할 수 있습니다.");
			return result;
		};
		if(draft.getDraftTitle().isEmpty()) {
			result.put("result","제목이 없습니다.");
			return result;
		}
		if(draft.getDraftType().isEmpty()) {
			result.put("result","기안 구분이 없습니다.");
			return result;
		}
		if(draft.getAuthNos() == null) {
			result.put("result","결재자가 없습니다.");
			return result;
		}
		if(draft.getRecCode() == null) {
			result.put("result","수신자가 없습니다.");
			return result;
		}
		List<AuthVO> authList = draft.getAuthls();
		for(int i = 0 ; i < authList.size(); i ++) {
			AuthVO auth = authList.get(i);
			auth.setAuthorAuthTyCode(authorAuthTyCode[i]);
		}
		ServiceResult updateRes = service.modifyDraft(draft);
		if(updateRes.equals(ServiceResult.OK)) {
			result.put("draftNo", draft.getDraftNo());
			result.put("result","OK");
		}
		return result;
	}

//	// 결재, 반려
//	@RequestMapping(value="/group/esign/draftSignUpdate.do",method=RequestMethod.POST)
//	@ResponseBody
//	public Map<String,String> updateDraftSign(
//			DraftVO draft,
//			@AuthenticationPrincipal EmplVOWrapper wrapper,
//			String command 
//			){
//		Map<String,String> result = new HashMap<>();
//		Integer authEmpl = wrapper.getAdaptee().getEmplNo();
//		Integer nextEmpl = Integer.parseInt(draft.getNextAuthor());
//		if(!authEmpl.equals(nextEmpl)) {
//			result.put("result","다음 결재자만 결재/반려 할 수 있습니다.");
//			return result;
//		};
//		return result;
//	}

	
	@RequestMapping("/group/esign/draftSignForm.do")
	public String draftSignForm(
			Integer draftNo,
			String command,
			Model model
			) {
		model.addAttribute("draft",service.retrieveDraft(draftNo));
		return "/esign/draftSignForm";
	}
	
	//기안문 회수
	@RequestMapping(value="/group/esign/draftSignReturn.do",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> draftReturn(
			@AuthenticationPrincipal EmplVOWrapper wrapper,
			Integer draftNo
			) {
		Map<String,Object> result = new HashMap<>();
		Integer authEmpl = wrapper.getAdaptee().getEmplNo();
		DraftVO draft = service.retrieveDraft(draftNo);
		Integer draftEmpl = draft.getDraftWriter();
		if(!authEmpl.equals(draftEmpl) && draftEmpl != null) {
			result.put("result","기안자만 접근할 수 있습니다.");
			return result;
		};
		draft.setDraftProgress("임시저장");
		AuthHistVO authHistVO = new AuthHistVO();
		authHistVO.setAhAuthorId(authEmpl);
		authHistVO.setDraftNo(draftNo);
		draft.setAuthHist(authHistVO);
		ServiceResult updateResult = service.updateDraft(draft);
		if(updateResult.equals(ServiceResult.OK)) {
			result.put("result","OK");
		}
		return result;
	}
			
	
	// 결재
	@RequestMapping(value="/group/esign/draftSignForm.do",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> draftSignInsert(
			@AuthenticationPrincipal EmplVOWrapper wrapper,
			AuthHistVO authHistVO
			) {
		Map<String,Object> result = new HashMap<>();
		result.put("result","결재 실패 개발자에게 문의해주세요.");
		DraftVO draft = service.retrieveDraft(authHistVO.getDraftNo());
		draft.setAuthHist(authHistVO);
		Integer authId = wrapper.getAdaptee().getEmplNo();
		Integer nextAuth = draft.getNextAuthorId();
		Integer lastAuth = draft.getLastAuthorId();
		draft.getAuthHist().setAhAuthorId(authId);
		if(!authId.equals(nextAuth)) {
			result.put("result","본인 결재 차례가 아닙니다.");
			return result;
		}
		if(authId.equals(lastAuth)) draft.setDraftProgress("결재완료");
		if((authHistVO.getAhAuthSe()).equals("반려")) draft.setDraftProgress("반려");
		
		ServiceResult sResult = service.updateDraft(draft);
		
		if(sResult == ServiceResult.OK) {
			result.put("result","OK");
		}
		return result;
	}
	
	// 임시저장 -> 결재시
	@RequestMapping(value="/group/esign/authHistCreate.do",method=RequestMethod.POST)
	@ResponseBody
	public void draftSignUpdate(
			@AuthenticationPrincipal EmplVOWrapper wrapper,
			AuthHistVO authHistVO
			) {
		authHistVO.setAhAuthorId(wrapper.getAdaptee().getEmplNo());
		service.createAuthHist(authHistVO);
	}
	
	
	/**
	 * 결재도장 이미지 변경
	 * @param path
	 * @param wrapper
	 * @return
	 */
	@PostMapping(value="/group/esign/updateSignImage.do")
	public Map<String,Object> updateSignImage(
				String path,
				@AuthenticationPrincipal EmplVOWrapper wrapper
			){
		Map<String,Object> result = new HashMap<>();
		emplService.modifySignImage(path,wrapper.getAdaptee().getEmplNo(),result);
		return result;
	}
}


