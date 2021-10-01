package com.eg.group.esign.service;

import java.io.File;
import java.io.FileOutputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.pool2.ObjectPool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import com.eg.commons.ServiceResult;
import com.eg.commons.exception.DataNotFoundException;
import com.eg.empl.dao.EmplDAO;
import com.eg.group.esign.dao.EsignDAO;
import com.eg.util.AES256Util;
import com.eg.vacation.service.VacServiceImpl;
import com.eg.vo.AuthHistVO;
import com.eg.vo.AuthVO;
import com.eg.vo.DraftFormVO;
import com.eg.vo.DraftVO;
import com.eg.vo.EmplVO;
import com.eg.vo.ExtendSearchVO;
import com.eg.vo.LineBoxVO;
import com.eg.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class EsignServiceImpl implements EsignService {
	@Inject
	private SimpMessagingTemplate messagingTemplate;
	
	@Inject
	EsignDAO dao;
	@Inject
	EmplDAO emplDao;
	@Inject
	AES256Util encoder;
	@Resource(name="FTPClientPool")
	private ObjectPool<FTPClient> clientPool;
	
	
	@Override
	public void retrieveDraftList(PagingVO<DraftVO> pagingVO) {
		pagingVO.setTotalRecord(dao.selectTotalRecord(pagingVO));
		pagingVO.setDataList(dao.selectDraftList(pagingVO)); 
	}

	@Override
	public DraftVO retrieveDraft(int draftNo) {
		DraftVO savedDraft = dao.selectDraft(draftNo);
		int draftOwner = savedDraft.getWriter().getEmplNo();
		EmplVO writer = emplDao.selectEmplDetail(draftOwner);
		savedDraft.setWriter(writer);
		return savedDraft;
	}

	@Override
	public PagingVO<DraftFormVO> retrieveDraftFormList(PagingVO<DraftFormVO> pagingVO, Integer emplNo) {
		pagingVO.setSimpleSearch(new ExtendSearchVO("emplNo", String.valueOf(emplNo)));
		pagingVO.setTotalRecord(dao.selectTotalDraftFormList(pagingVO));
		pagingVO.setDataList(dao.selectDraftFormList(pagingVO));
		return pagingVO;
	}

	@Override
	public DraftFormVO retrieveDraftForm(Integer draftFormNo) {
		return dao.selectDraftForm(draftFormNo);
	}

	@Override
	public ServiceResult modifyDraftForm(DraftFormVO draftForm) {
		ServiceResult result = ServiceResult.FAIL;
		DraftFormVO saved = dao.selectDraftForm(draftForm.getDfNo());
		if(saved == null) throw new DataNotFoundException();
		int cnt = 0;
		if(draftForm.getDfNo()==0) {
			draftForm.setDfNo(dao.selectMaxDraftFormNo());
			cnt = dao.insertDraftForm(draftForm);
		}else {
			cnt = dao.updateDraftForm(draftForm);
		}
		if(cnt > 0) result = ServiceResult.OK;
		return result;
	}

	@Override
	public ServiceResult removeDraftForm(DraftFormVO draftForm) {
		ServiceResult result = ServiceResult.FAIL;
		DraftFormVO saved = dao.selectDraftForm(draftForm.getDfNo());
		if(saved == null) throw new DataNotFoundException();
		int cnt = dao.deleteDraftForm(draftForm);
		if(cnt > 0) result = ServiceResult.OK;
		return result;
	}

	@Override
	public void removeDraftFormAll(Map<String,Object> paramMap) {
		DraftFormVO draftForm = (DraftFormVO)paramMap.get("draftForm");
		Integer[] list = draftForm.getDeleteDfNo();
		Integer authId = draftForm.getEmplNo();
		List<Integer> failDfNo = new ArrayList<>();
		paramMap.put("failDfNo",failDfNo);
		for(Integer dfNo:list) {
			boolean result = validateFormUser(authId, dfNo);
			if(result) {
				failDfNo.add(dfNo);
				paramMap.put("result","FAIL");
			}
		}
		int cnt = dao.deleteDraftFormAll(draftForm);
		if(cnt>0) {
			paramMap.put("result","OK");
			paramMap.put("deleteCnt",cnt);
		}
	}
	
	public boolean validateFormUser(Integer authId, Integer draftNo) {
		Map<String,Integer> param = new HashMap<>();
		param.put("emplNo",authId);
		param.put("dfNo",draftNo);
		DraftFormVO draft = dao.validForm(param);
		return (draft == null);
	}

	@Override
	@Transactional
	public ServiceResult modifyLineBox(LineBoxVO box) {
		int cnt = 0;
		ServiceResult result = ServiceResult.FAIL;
		if(box.getLcbLineNo() == null) {
			Integer maxNo = dao.selectMaxNo();
			box.setLcbLineNo(maxNo);
			dao.updateLineBox(box);
			cnt = dao.insertAuth(box);
		}else {
			dao.updateLineBox(box);
			cnt = dao.deleteAuth(box);
			cnt = dao.insertAuth(box);
		}
		if(cnt>0) result=ServiceResult.OK;
		return result;
	}

	
	@Override
	public void removeLineBox(Map<String, Object> result) {
		LineBoxVO box = new LineBoxVO();
		box.setDelCodes((Integer[])result.get("delCodes"));
		int cnt = dao.deleteLineBox(box);
		if(cnt>0) {
			result.put("result","OK");
			result.put("cnt",cnt);
		}
	}

	@Transactional
	@Override
	public ServiceResult updateDraft(DraftVO draft) {
		createAuthHist(draft.getAuthHist());
		int cnt = dao.updateDraft(draft);
		String title = draft.getDraftTitle(); // 기안문 제목
		String message = ""; 
		if("결재완료".equals(draft.getDraftProgress())) {
//			푸시알림 주기
			
//			결재완료
			List<AuthVO> list = draft.getReceivers(); // => 수신자 list
			for(AuthVO auth: list) {
				Integer id = auth.getAuthorId(); // 수신자의 아이디
				// 멘트 : 
				message = "결재문서 :" + title + "의 결재가 완료 되었습니다.";
				messagingTemplate.convertAndSend("/topic/pushMsg/"+id, message);

			}
			
			
		}
		if("반려".equals(draft.getDraftProgress())) {
//			반려일때
			Integer id = draft.getDraftWriter(); // => 기안자
			message = "결재문서 :" + title + "의 결재가 반려 되었습니다.";
			messagingTemplate.convertAndSend("/topic/pushMsg/"+id, message);
		}
				
		if(cnt > 0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}
	
	@Autowired
	WebApplicationContext context; 
		
	@Transactional
	@Override
	public ServiceResult modifyDraft(DraftVO draft) {

		ServiceResult result = ServiceResult.FAIL;
		int cnt = -1;
		if(draft.getDraftNo() == null) {
			draft.setDraftNo(dao.selectMaxDraftNo());
			cnt = dao.insertDraft(draft);
		}else {
			cnt = dao.updateDraft(draft);
		}
		dao.deleteAuthl(draft.getDraftNo());
		dao.deleteRef(draft.getDraftNo());
		dao.deleteRec(draft.getDraftNo());
		
		// 전표서비스가 있을 경우 해당 서비스 호출해서 드래프트 넘버 넣어주기
		if(StringUtils.isNotBlank(draft.getChit())) {
			String chitService = draft.getChit();
			String code = draft.getCode();
			Integer draftNo = draft.getDraftNo();
			Map<String,Object> paramMap = new HashMap<>();
			paramMap.put("draftNo",draftNo);
			paramMap.put("code",code);
			try {
				Class<?> service = Class.forName(chitService);
				Object obj = context.getBean(chitService);	
				Method method = service.getDeclaredMethod("modifyDraftNo", Map.class);
				
				method.invoke(obj, paramMap);
				
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
				log.info("relection error : 클래스를 찾을 수 없음.");
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
				log.info("relection error : 메서드를 찾을 수 없음.");
			} catch (SecurityException e) {
				e.printStackTrace();
				log.info("relection error : 시큐리티 예외.");
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
				log.info("", e.getCause());
			}
			
		}
		
		// 결재 도장 이미지 넣기
		List<AuthVO> authl = draft.getAuthls();
		FTPClient ftpClient = null;
		FileOutputStream fos = null;
		try {
			ftpClient = clientPool.borrowObject();
			for(AuthVO auth : authl) {
				String curSignImage = dao.selectSignImagePath(auth.getAuthorId());
				if(StringUtils.isEmpty(curSignImage)) continue;
					String filePath = encoder.decrypt(curSignImage);
					File imgFile = new File("temp");
					fos = new FileOutputStream(imgFile);
					ftpClient.retrieveFile(filePath, fos);
					auth.setSignImage(Files.readAllBytes(imgFile.toPath()));
					imgFile.delete();
			} // for end;
			clientPool.returnObject(ftpClient);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(fos!=null)try{fos.close();}catch(Exception e) {};
		}
		draft.setAuthls(authl);
		
		dao.insertAllAuthl(draft);
		if(draft.getReferences()!=null) {
			dao.insertAllRef(draft);
		}
		if(draft.getReceivers()!=null) {
			dao.insertAllRec(draft);
		}
		
		if(cnt > 0) {
			result=ServiceResult.OK;
		}
		return result;
	}

	@Transactional
	@Override
	public ServiceResult createAuthHist(AuthHistVO authHist) {
		int cnt = dao.insertAuthHist(authHist);
		if(cnt>0)return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}

	@Override
	public AuthVO retrieveAuth(Integer emplNo) {
		return dao.selectAuthByEmplNo(emplNo);
	}
	
}
