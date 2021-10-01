package com.eg.empl.controller;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.empl.service.EmplService;
import com.eg.vo.EmplVO;
import com.eg.vo.EmplVOWrapper;

/**
 * HandlerAdapter 가 command handler 를 호출하는 순서
 * 핸들러 메소드 파라미터 준비 -> 핸들러 메소드 호출
 * 메소드 호출시 before weaving의 형태로, @PreAuthorize 동작(접근제어 단계)
 * ==> 접근제어 전에 파라미터 준비를 먼저 하기 때문에 AnonymousAuthenticationToken 이 사용되는 경우에
 * expression="adaptee" 먼저 파싱되면, 
 * 익명유저의 principal 인 "ANONYMOUS" 라는 텍스트를 대상으로 adaptee 프로퍼티를 찾는다.
 *
 */
@Controller
@RequestMapping("/mypage.do")
public class MyPageController{
	@Inject
	private EmplService service;
	
	@PreAuthorize("isFullyAuthenticated()")
	@GetMapping
	public String mypage(
		@AuthenticationPrincipal EmplVOWrapper wrapper, 
		Model model
	){
		EmplVO authEmpl = wrapper.getAdaptee();
		EmplVO savedEmpl = service.retrieveEmpl(authEmpl.getEmplNo());
		
		model.addAttribute("empl", savedEmpl);
		return "/mypage/mypage";
	}
}













