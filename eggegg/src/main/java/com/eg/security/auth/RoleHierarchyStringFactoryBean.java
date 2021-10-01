package com.eg.security.auth;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.FactoryBean;

import com.eg.security.auth.dao.AuthorityDAO;

public class RoleHierarchyStringFactoryBean implements FactoryBean<String>{
	private static final Logger LOGGER = LoggerFactory.getLogger(RoleHierarchyStringFactoryBean.class);
	@Inject
	private AuthorityDAO authorityDAO;

	@Override
	public String getObject() throws Exception {
		List<String> hierarchy = authorityDAO.roleHierarchy();
		String hierarchyString = hierarchy.stream().reduce((ele1, ele2)->{return ele1+"\n"+ele2;}).get();
		LOGGER.info("{}", hierarchyString);
		return hierarchyString;
	}

	@Override
	public Class<?> getObjectType() {
		return String.class;
	}

	@Override
	public boolean isSingleton() {
		return false;
	}
	
		
}
