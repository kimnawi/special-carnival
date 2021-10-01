package com.eg.listener;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;

import com.eg.admin.dao.AdminDAO;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class CustomEventListener {
	
	@Inject
	AdminDAO dao;
	
	@EventListener(ContextRefreshedEvent.class)
	public void eventHandler(ContextRefreshedEvent event) {
		WebApplicationContext container = (WebApplicationContext) event.getApplicationContext();
		ServletContext application = container.getServletContext();
		if(application.getAttribute("companyVO") == null)
			application.setAttribute("companyVO",dao.selectCompany()); 
		
		if(application.getAttribute("cPath") == null)
			application.setAttribute("cPath", application.getContextPath());
		
		
		
		
//		if(application.getAttribute("userCount") == null) {
//			container.getServletContext().setAttribute("userCount", new Integer(0));
//		}
//		if(application.getAttribute("currentUserCount") == null) {
//			container.getServletContext().setAttribute("currentUserCount", new Integer(0));
//		}
//		if(application.getAttribute("currentUserList") == null) {
//			container.getServletContext().setAttribute("currentUserList", new LinkedHashMap<String,MemberVO>());
//		}
		
		log.info("시작된 컨테이너 : {}" , container);
	}
	
}
