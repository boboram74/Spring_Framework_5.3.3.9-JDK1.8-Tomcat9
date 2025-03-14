package com.kedu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class HomeController {
	@GetMapping("/")
	public String home() {
		return "home";
	}

	@GetMapping("/chat/toChat")
	public String toChat() {
		return "chat/chat";
	}

}
