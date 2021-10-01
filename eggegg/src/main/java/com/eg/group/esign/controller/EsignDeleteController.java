package com.eg.group.esign.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.commons.ServiceResult;
import com.eg.commons.exception.DataNotFoundException;
import com.eg.group.esign.service.EsignService;
import com.eg.vo.DraftFormVO;
import com.eg.vo.EmplVOWrapper;

@Controller
public class EsignDeleteController {
	
	@Inject
	private EsignService service;
	
	@RequestMapping(value="/group/esign/lineBoxDelete.do",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> lineBoxDelete(
				Integer[] delCodes
			) {
		Map<String,Object> result = new HashMap<>();
		result.put("result","FAIL");
		result.put("delCodes",delCodes);
		service.removeLineBox(result);
		return result;
	};
	
	
	@RequestMapping(value="/group/esign/draftFormDelete.do",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> draftDelete(
			DraftFormVO draftForm,
			Integer[] deleteDfNo,
			@AuthenticationPrincipal EmplVOWrapper wrapper
			) {
		draftForm.setDeleteDfNo(deleteDfNo);
		Map<String,Object> paramMap = new HashMap<>();
		Integer authEmpl = wrapper.getAdaptee().getEmplNo();
		if(draftForm.getDeleteDfNo() == null && draftForm.getDfNo() == null) {
			paramMap.put("result","삭제할 데이터를 넣어주세요");
			return paramMap;
		}else if(draftForm.getDeleteDfNo() != null && draftForm.getDfNo() == null) {
			draftForm.setEmplNo(authEmpl);
			paramMap.put("draftForm",draftForm);
			service.removeDraftFormAll(paramMap);
		}else {
			Integer formEmpl = draftForm.getEmplNo();
			if(!authEmpl.equals(formEmpl)) {
				paramMap.put("result","본인의 양식만 삭제 가능합니다!");
				return paramMap;
			};
			try {
				ServiceResult sResult = service.removeDraftForm(draftForm);
				paramMap.put("result",sResult.toString());
				
			}catch(DataNotFoundException e) {
				paramMap.put("result",draftForm.getDfNo()+"번 양식은 없습니다.");
			}
		}
		return paramMap;
	}

}
