package com.eg.empl.service;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;

import com.eg.empl.dao.EmplDAO;
import com.eg.vo.EmplVO;
import com.eg.vo.EmplVOWrapper;

@Service("authService")
public class AuthenticateServiceImpl implements UserDetailsService {
	
	@Inject
	private EmplDAO emplDAO;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Integer emplNo = null;
		if(StringUtils.isNumeric(username)) {
			emplNo = Integer.parseInt(username);
		}else {
			throw new UsernameNotFoundException("UNFE");
		}
		EmplVO savedEmpl = emplDAO.selectEmplById(emplNo);
		if(savedEmpl==null) {
			throw new UsernameNotFoundException("UNFE");
		}
		return new EmplVOWrapper(savedEmpl);
	}
	
}






