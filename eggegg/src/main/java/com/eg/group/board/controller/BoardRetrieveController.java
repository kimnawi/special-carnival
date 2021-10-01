package com.eg.group.board.controller;

import java.io.UnsupportedEncodingException;

import javax.inject.Inject;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.group.board.service.BoardService;

@Controller
@EnableScheduling
public class BoardRetrieveController {

	@Inject
	private BoardService service;
	
	@RequestMapping("group/board/boardList.do")
	public void selectBoardList() {
	}
	
	
	@RequestMapping("/group/board/noticeDetail.do")
	public String selectBoardDetail() {
		
		return "board/BoardView";
	}
	
}
