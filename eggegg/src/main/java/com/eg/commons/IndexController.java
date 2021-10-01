package com.eg.commons;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eg.empl.service.EmplService;
import com.eg.group.esign.dao.EsignDAO;
import com.eg.group.msg.dao.MsgDAO;
import com.eg.group.schedule.dao.ScheDAO;
import com.eg.hrd.dao.HrdDAO;
import com.eg.vo.AttendeLvffcVO;
import com.eg.vo.DraftVO;
import com.eg.vo.EmplVO;
import com.eg.vo.EmplVOWrapper;
import com.eg.vo.MsgVO;
import com.eg.vo.ScheVO;

@Controller
public class IndexController {
	@Inject
	private EsignDAO esignDao;
	@Inject 
	private MsgDAO msgDao;
	@Inject
	private HrdDAO hrdDao;
	@Inject
	private EmplService emplService;
	@Inject
	private ScheDAO scheDao;
	
	@RequestMapping("/")
	public String loginPage(
			Model model
			, @AuthenticationPrincipal EmplVOWrapper wrapper
		) {
		int emplNo = wrapper.getAdaptee().getEmplNo();
		String atvlEmpl = String.valueOf(emplNo);
		AttendeLvffcVO atvl = hrdDao.selectAtvl(atvlEmpl);
		EmplVO empl = emplService.retrieveEmpl(emplNo);
		model.addAttribute("atvl", atvl);
		model.addAttribute("empl", empl);
		return "main/mainPage";
	}
	
	@RequestMapping("/login")
	public String login() {
		return "redirect:login/loginForm.jsp";
	}
	
	@RequestMapping("/mainPage.do")
	public String mainPage(
			Model model
			, @AuthenticationPrincipal EmplVOWrapper wrapper
		) {
		int emplNo = wrapper.getAdaptee().getEmplNo();
		String atvlEmpl = String.valueOf(emplNo);
		AttendeLvffcVO atvl = hrdDao.selectAtvl(atvlEmpl);
		EmplVO empl = emplService.retrieveEmpl(emplNo);
		model.addAttribute("atvl", atvl);
		model.addAttribute("empl", empl);
		return "main/mainPage";
	}
	
	@RequestMapping(value="/draftMain.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<DraftVO> mainDraft(
		@AuthenticationPrincipal EmplVOWrapper wrapper
	){
		int emplNo = wrapper.getAdaptee().getEmplNo();
		List<DraftVO> list = esignDao.selectMainDraft(emplNo);
		
		return list;
	}
	
	@RequestMapping(value="/msgMain.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<MsgVO> mainMsg(
			@AuthenticationPrincipal EmplVOWrapper wrapper
	){
		int emplNo = wrapper.getAdaptee().getEmplNo();
		List<MsgVO> list = msgDao.selectMainMsg(emplNo);
		
		return list;
	}
	
	@RequestMapping(value="/scheMain.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ScheVO> mainSche(
			@AuthenticationPrincipal EmplVOWrapper wrapper
		){
		int emplNo = wrapper.getAdaptee().getEmplNo();
		List<ScheVO> list = scheDao.selectScheMain(emplNo);
		
		return list;
	}
	
}
