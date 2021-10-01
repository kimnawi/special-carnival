package com.eg.security.auth.handler;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.web.context.WebApplicationContext;

import com.eg.empl.service.EmplService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginFailureHandler implements AuthenticationFailureHandler {
	
	@Inject
	WebApplicationContext container;
	
	@Inject
	EmplService service;
	
    private String loginidname;
    private String loginpwdname;
	private String defaultFailureUrl;
    
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		String empl_no = request.getParameter(loginidname);
		request.setAttribute("emplNo", empl_no);

		if(exception instanceof UsernameNotFoundException) {
			request.getSession().setAttribute("errorMessage", "존재하지 않는 사원번호입니다.");
		}
		if(exception instanceof BadCredentialsException) {
			int failCnt = loginFailureCount(empl_no);
			request.getSession().setAttribute("failCnt", failCnt);
		}
		if(exception instanceof DisabledException) {
			request.getSession().setAttribute("errorMessage", "퇴사한 사원번호로는 접속할 수 없습니다.");
		}
		
		response.sendRedirect(container.getServletContext().getContextPath()+getDefaultFailureUrl());
	}
	
	protected int loginFailureCount(String empl_no) {
	    int countFailure = service.countFailure(empl_no);
	    log.info(empl_no + " / 비밀번호 오류 횟수 : " + countFailure);
	    return countFailure;
    }

	public String getLoginidname() {
		return loginidname;
	}

	public void setLoginidname(String loginidname) {
		this.loginidname = loginidname;
	}

	public String getLoginpwdname() {
		return loginpwdname;
	}

	public void setLoginpwdname(String loginpwdname) {
		this.loginpwdname = loginpwdname;
	}

	public String getDefaultFailureUrl() {
		return defaultFailureUrl;
	}

	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}

	
}
