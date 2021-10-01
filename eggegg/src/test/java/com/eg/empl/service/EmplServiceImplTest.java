package com.eg.empl.service;

import static org.junit.Assert.fail;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringRunner;

import com.eg.TestWebAppConfiguration;
import com.eg.vo.EmplVO;
import com.eg.vo.PagingVO;

@RunWith(SpringRunner.class)
@TestWebAppConfiguration
public class EmplServiceImplTest {

	@Inject
	private EmplService service;
	
	@Before
	public void setUp() throws Exception {
		
	}
	
	@Test
	public void testCreateEmpl() {
		fail("Not yet implemented");
	}

	@Test
	public void testRetrieveEmplList() {
		PagingVO<EmplVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(1);
		service.retrieveEmplList(pagingVO);
	}

	@Test
	public void testRetrieveEmpl() {
		fail("Not yet implemented");
	}

	@Test
	public void testModifyEmpl() {
		fail("Not yet implemented");
	}

	@Test
	public void testRemoveEmpl() {
		fail("Not yet implemented");
	}

}
