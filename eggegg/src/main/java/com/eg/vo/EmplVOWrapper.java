package com.eg.vo;

import java.io.Serializable;
import java.util.Collection;
import java.util.Objects;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
public class EmplVOWrapper extends User{
	private EmplVO adaptee;
	
	public EmplVOWrapper(EmplVO adaptee) {
		this(adaptee.getEmplNo().toString(), adaptee.getEmplPw(), AuthorityUtils.createAuthorityList(adaptee.getEmplAuthority()));
		this.adaptee = adaptee;
	}

	
	
	public EmplVOWrapper(String username, String password, boolean enabled, boolean accountNonExpired,
			boolean credentialsNonExpired, boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		// TODO Auto-generated constructor stub
	}

	public EmplVOWrapper(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean isEnabled() {
		if(adaptee.getRetire() != null) {
			return ((adaptee.getRetire().getEmplRetire())==null);
		}else {
			return true;
		}
		
	}
	
}
