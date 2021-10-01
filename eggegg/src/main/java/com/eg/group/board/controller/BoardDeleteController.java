package com.eg.group.board.controller;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.group.board.service.BoardService;

public class BoardDeleteController {

	@Inject
	private BoardService service;
	
	@RequestMapping("/group/board/boardDelete.do")
	public String boardDelete() {
		return "board/BoardView";
	}
	
    @RequestMapping("/group/board/replyDelete.do")
    public String replyDelete() {
	    return "board/BoardView";
}	
}
