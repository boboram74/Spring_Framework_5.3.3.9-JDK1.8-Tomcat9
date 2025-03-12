package com.kedu.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	private MembersDAO membersDAO;
	
	@Autowired
	private FileDAO fileDAO;
	
	@Autowired
	private BoardsDAO boardsDAO;
	
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
		int parent_seq = boardsDAO.getSeq();
		
		//글쓰기
		dto.setSeq(parent_seq);
		
		int result = boardsDAO.createById(dto);
		
		//파일업로드
		String realPath = session.getServletContext().getRealPath("upload"); 
		System.out.println(realPath); //임시파일 경로 확인
		File realPathFile = new File(realPath);
		//폴더가 없으면 폴더를 생성
		if(!realPathFile.exists()) realPathFile.mkdir(); 
		for(MultipartFile file : files) { //여러개의 경우
			if(!file.isEmpty()) { //파일의 내용이 있을경우만 실행
				String oriName = file.getOriginalFilename(); //업로드 한 이름
				String sysName = UUID.randomUUID() + "_"+ oriName; //서버에 저장될 이름
				file.transferTo(new File(realPath+"/"+sysName));
				int upload_result = fileDAO.insert(new FileDTO(0,oriName,sysName,parent_seq));
			}
		}
		return "redirect:/boards/toBoard";
	}
	
	@GetMapping("/detail") //게시글 상세보기
	public String detail(int id,Model model) {
		boardsDAO.viewCountUp(id);
		
		BoardsDTO dto = boardsDAO.selectById(id);
		model.addAttribute("boardDto",dto);
		
		return "/board/detail";
	}
	@PostMapping("/update") //게시글 수정하기
	public String update(BoardsDTO dto) throws Exception {
		int result = boardsDAO.updateById(dto);
		return "redirect:/boards/toBoard";
	}
	@GetMapping("/delete") //게시글 삭제
	public String delete(int id) throws Exception {
		int result = boardsDAO.deleteById(id);
		return "redirect:/boards/toBoard";
	}
	
	@ResponseBody //게시글 리스트 비동기 불러오기
	@GetMapping("/boardList")  // boardList?cpage=1
	public Map<String, Object> boardList(HttpServletRequest request) throws Exception {
		String scpage = (String) request.getParameter("cpage");
		if (scpage == null) {
			scpage = "1";
		}
		int cpage = Integer.parseInt(scpage);

		int recordTotalCount = boardsDAO.getRecordTotalCount();

		int pageTotalCount = 0;
		if (recordTotalCount % Statics.recordCountPerPage > 0) {
			pageTotalCount = recordTotalCount / Statics.recordCountPerPage + 1;
		} else {
			pageTotalCount = recordTotalCount / Statics.recordCountPerPage;
		}

		if (cpage < 1) {
			cpage = 1;
		} else if (cpage > pageTotalCount) {
			cpage = pageTotalCount;
		}
		int end = cpage * Statics.recordCountPerPage;
		int start = end - (Statics.recordCountPerPage - 1);
		int startNavi = (cpage - 1) / Statics.naaviCountPerPage * Statics.naaviCountPerPage + 1;
		int endNavi = startNavi + Statics.naaviCountPerPage - 1;
		
		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}

		boolean needPrev = true;
		boolean needNext = true;
		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}

		List<BoardsDTO> list = boardsDAO.selectFromto(start, end);
		Map<String, Object> dto = new HashMap<>();
		
		dto.put("startNavi", startNavi);
		dto.put("endNavi", endNavi);
		dto.put("needPrev", needPrev);
		dto.put("needNext", needNext);
		dto.put("list", list);
		
		return dto;
	}
}
