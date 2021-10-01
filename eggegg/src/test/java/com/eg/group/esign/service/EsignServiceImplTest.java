package com.eg.group.esign.service;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringRunner;

import com.eg.TestWebAppConfiguration;
import com.eg.empl.dao.EmplDAO;
import com.eg.group.esign.dao.EsignDAO;
import com.eg.vo.DraftVO;
import com.eg.vo.EmplVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringRunner.class)
@TestWebAppConfiguration
public class EsignServiceImplTest {

	@Inject
	EsignDAO dao;
	
	@Inject
	EmplDAO emplDao;
	
	@Before
	public void setUp() throws Exception {

	}

	@Test
	public void retrieveDraft() {
		DraftVO savedDraft = dao.selectDraft(2);
		System.out.println(savedDraft);
		int draftOwner = savedDraft.getWriter().getEmplNo();
		EmplVO writer = emplDao.selectEmplDetail(draftOwner);
		savedDraft.setWriter(writer);
	}

}
