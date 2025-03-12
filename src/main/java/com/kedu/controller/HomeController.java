package com.kedu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	//추가합니다.
	@GetMapping("/")
	public String home() {
		return "home";
	}

	
}
