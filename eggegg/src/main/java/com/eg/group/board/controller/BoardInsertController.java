package com.eg.group.board.controller;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.group.board.service.BoardService;

public class BoardInsertController {

	@Inject
	private BoardService service;
	
	@RequestMapping("/group/board/boardInsert.do")
	public String boardWrite() {
		return "board/BoardForm";
	}

	@RequestMapping("/group/board/replyInsert.do")
	public String replyInsert() {
		return "board/BoardView";
	}
	
	@RequestMapping("/group/board/answerInsert.do")
	public String answerInsert() {
		return "board/BoardView";
	}
	
	@RequestMapping("/group/board/surveyInsert.do")
	public String surveyInsert() {
		return "board/BoardForm";
	}
	
	@RequestMapping("/group/board/fileUpload.do")
	public String fileUpload() {
		return "board/BoardForm";
	}


	
	
	
}
