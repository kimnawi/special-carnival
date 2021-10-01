package com.eg.group.board.controller;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.group.board.service.BoardService;

public class BoardUpdateController {

	@Inject
	private BoardService service;
	
	@RequestMapping("/group/board/boardUpdate.do")
	public String boardUpdate() {
		return "board/BoardForm";
	}
	
	@RequestMapping("/group/board/replyUpdate.do")
	public String replyUpdate() {
		return "board/BoardView";
	}
	
}
