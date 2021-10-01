package com.eg.security.auth.handler;

import java.io.IOException;
import java.util.Calendar;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.web.context.WebApplicationContext;

import com.eg.empl.dao.EmplDAO;
import com.eg.vo.EmplVO;
import com.eg.vo.EmplVOWrapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler {
    
	@Inject
	WebApplicationContext container;
	
	@Inject
	EmplDAO dao;

	@Inject
	PasswordEncoder passwordEncoder;
	
	private String defaultUrl;

	@Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
			HttpSession session = request.getSession();
    		EmplVO empl = ((EmplVOWrapper)authentication.getPrincipal()).getAdaptee();
    		Integer pwcnt = dao.selectEmplPWCNT(empl.getEmplNo());
    		Calendar calendar = Calendar.getInstance();
    		log.info("사원번호 : {} 로그인 {}년,{}월,{}일, {}시, {}분",empl.getEmplNo(),calendar.get(Calendar.YEAR),calendar.get(Calendar.MONTH)+1,calendar.get(Calendar.DATE),calendar.get(Calendar.HOUR),calendar.get(Calendar.MINUTE));
    
    		
    		if(pwcnt > 3) {
    			authentication.setAuthenticated(false);
    			session.setAttribute("errorMessage", "오류횟수 3회 초과 / 비밀번호 초기화를 해주세요");
    			response.sendRedirect(container.getServletContext().getContextPath());
    		}else {
    			if(passwordEncoder.matches("0000", empl.getEmplPw())) {
    				request.getSession().setAttribute("matched", "matched");
    			};
    			dao.initializePWCNT(empl.getEmplNo());
    			response.sendRedirect(container.getServletContext().getContextPath());
    		}
    }

	public String getDefaultUrl() {
		return defaultUrl;
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}
	
    
}

