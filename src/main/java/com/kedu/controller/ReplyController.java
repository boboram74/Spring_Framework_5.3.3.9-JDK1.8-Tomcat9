package com.kedu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.ReplyDAO;
import com.kedu.dto.ReplyDTO;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	
	@Autowired
	private ReplyDAO replyDAO;
	
	@PostMapping("/insert")
	public String insert(ReplyDTO dto) {
		System.out.println(dto.getWriter() + ": " + dto.getContent());
		return "";
	}

}
