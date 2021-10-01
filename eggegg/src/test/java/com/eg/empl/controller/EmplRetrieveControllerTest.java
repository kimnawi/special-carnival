package com.eg.empl.controller;


import static org.junit.Assert.fail;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.eg.TestWebAppConfiguration;

@RunWith(SpringRunner.class)
@TestWebAppConfiguration
public class EmplRetrieveControllerTest {

	@Inject
	private WebApplicationContext container;
	private MockMvc mockMvc;
	
	@Before
	public void setUp() throws Exception {
		mockMvc = MockMvcBuilders.webAppContextSetup(container).build();
	}

	@Test
	public void testEmplList() throws Exception{
		mockMvc.perform(get("empl/emplList.do"))
	       .andExpect(status().isOk())
	       .andExpect(view().name("empl/emplList"))
	       .andDo(log())
	       .andReturn();
	}

	@Test
	public void testListForAjax() throws Exception{
		mockMvc.perform(get("empl/emplList.do").accept(MediaType.APPLICATION_JSON))
			   .andExpect(status().isOk())
	           .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
//	           .andExpect(model().attributeExists("pagingVO"))
	           .andDo(log())
	           .andReturn();
	}

	@Test
	public void testEmplStatus() {
		fail("Not yet implemented");
	}

	@Test
	public void testMyPage() {
		fail("Not yet implemented");
	}

}
