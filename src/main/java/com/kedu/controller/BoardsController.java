package com.kedu.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.kedu.service.BoardsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kedu.dao.BoardsDAO;
import com.kedu.dao.FileDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dto.BoardsDTO;
import com.kedu.dto.FileDTO;

import utils.Statics;

@Controller
@RequestMapping("/boards")
public class BoardsController {

	@Autowired
	private BoardsService boardsService;

	@Autowired
	private HttpSession session;
	
	@GetMapping("/toBoard") //게시글 리스트
	public String toBoard(Model model, HttpServletRequest request) {
		return "/board/list";
	}
	
	@GetMapping("/writeForm") //게시글 작성폼
	public String writeForm() {
		return "/board/write";
	}

	@PostMapping("/insert") //게시글 작성처리
	public String insert(BoardsDTO dto, MultipartFile[] files) throws Exception {
		int result = boardsService.createById(dto);
		int parent_seq = dto.getSeq();
		String realPath = session.getServletContext().getRealPath("upload");
		int upload_result = boardsService.insert(dto,realPath,files,parent_seq);
		return "redirect:/boards/toBoard";
	}
	
	@GetMapping("/detail") //게시글 상세보기
	public String detail(int id,Model model) {
		boardsService.viewCountUp(id);
		
		BoardsDTO dto = boardsService.selectById(id);
		model.addAttribute("boardDto",dto);
		
		return "/board/detail";
	}
	@PostMapping("/update") //게시글 수정하기
	public String update(BoardsDTO dto) throws Exception {
		int result = boardsService.updateById(dto);
		return "redirect:/boards/toBoard";
	}
	@GetMapping("/delete") //게시글 삭제
	public String delete(int id) throws Exception {
		int result = boardsService.deleteById(id);
		return "redirect:/boards/toBoard";
	}

	@ResponseBody
	@GetMapping("/boardList")
	public Map<String, Object> boardList(HttpServletRequest request) throws Exception {
		String scpage = request.getParameter("cpage");
		int cpage = (scpage == null) ? 1 : Integer.parseInt(scpage);
		return boardsService.getPagedBoardList(cpage);
	}
}
