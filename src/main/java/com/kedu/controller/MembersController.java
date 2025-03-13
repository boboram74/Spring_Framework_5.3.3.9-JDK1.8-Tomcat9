package com.kedu.controller;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.kedu.service.MembersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kedu.dao.FileDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dto.FileDTO;
import com.kedu.dto.MembersDTO;

@Controller
@RequestMapping("/members")
public class MembersController {

	@Autowired
	private MembersService membersService;

	@Autowired
	private HttpSession session;
	
	@GetMapping("/signupForm")
	public String toSignupForm() {
		return "/members/signupForm";
	}
	@PostMapping("/insert")
	public String insert(MembersDTO dto, @RequestParam("profile_file")MultipartFile file) throws Exception {
		String realPath = session.getServletContext().getRealPath("upload");
		int result = membersService.insert(dto,realPath,file);
		return "redirect:/";
	}
	@ResponseBody //Return 값을 viewResolver에게 안가고 클라이언트에게 바로 보낸다
	@GetMapping(value="/idcheck", produces = "text/html;charset=utf8")
	public String idcheck(String id) throws Exception {
		boolean result =  membersService.checkDuplicateId(id);
		return String.valueOf(result);
	}
	@PostMapping("/login")
	public String login(String id, String pw) {
		MembersDTO result = membersService.login(id,pw);
		if(result != null) {
			session.setAttribute("dto", result);
		}
		return "redirect:/";
	}
	@GetMapping("/logout")
	public String logout() {
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/out")
	public String out(String id) throws Exception {
		int result = membersService.deleteById(id);
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/toMypage")
	public String toMypage() {
		return "/members/mypage";
	}	
	
	@ResponseBody
	@GetMapping("/mypage")
	public MembersDTO mypage(HttpServletRequest request) throws Exception {
		MembersDTO id = (MembersDTO)session.getAttribute("dto");
		MembersDTO result = membersService.selectById(id.getId());
		return result;
	}
}