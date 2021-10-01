package com.eg.security.auth;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

import com.eg.security.auth.dao.ResourceDAO;
import com.eg.vo.AuthorityVO;
import com.eg.vo.ResourceVO;

public class RequestMapFactoryBean implements FactoryBean<LinkedHashMap<RequestMatcher, List<ConfigAttribute>>>{
	@Inject
	private ResourceDAO resDAO;
	
	@Override
	public LinkedHashMap<RequestMatcher, List<ConfigAttribute>> getObject() throws Exception {
		LinkedHashMap<RequestMatcher, List<ConfigAttribute>> requestMap = new LinkedHashMap<>();
		List<ResourceVO> securedResources = resDAO.selectAllSortedResources();
		securedResources.forEach((resource)->{
			String url = resource.getResourcePattern();
 			String method = resource.getHttpMethod();
			List<AuthorityVO> authorities = resource.getAuthorities();
			if(authorities==null || authorities.size()==0) return;
			
			AntPathRequestMatcher requestMatcher = null;
			if(StringUtils.isNotBlank(method)) {
				requestMatcher = new AntPathRequestMatcher(url, method);
			}else {
				requestMatcher = new AntPathRequestMatcher(url);
			}
			
			List<ConfigAttribute> configList = new ArrayList<>();
			authorities.forEach((authorityVO)->{
				if(StringUtils.isNotBlank(authorityVO.getAuthority())){
					configList.add(new SecurityConfig(authorityVO.getAuthority()));
				}
			});
			requestMap.put(requestMatcher, configList);
		});
		return requestMap;
	}

	@Override
	public Class<?> getObjectType() {
		return LinkedHashMap.class;
	}

	@Override
	public boolean isSingleton() {
		return false;
	}

}
